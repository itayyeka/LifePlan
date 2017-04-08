function [Db,Position,Contributors] = LpSimulate(Db,EndDate)
%{
This Function is the simulator. It will call all sub functions
and sub simulators (contributors) until a give date.
After each Db change, This function will automatically run and
create a new Db for the end of simulation.
%}
if true
    %% StandAlone
    if ~exist('Db','var')
        Db=AUX.LpDefaultDbConstructor;
    end
    if ~exist('EndDate','var')
        EndDate.Units='Months';
        EndDate.Val=24;
    end
    %% Duration
    SimDurMonths=AUX.LpConvertTimeToMonths(EndDate);
    %% Simulation
    if true        
        %% Dynamic simulation
        if ~isfield(Db.Data,'InitPosition')
            NullPosition=AUX.LpNullPositionConstructor;
        else
            NullPosition=Db.Data.InitPosition;
        end
        NullPosition.Market.InterestCalcType=Db.MarketCfg.InterestCalcType;
        CurContributors=AUX.LpFetchContributors(Db,NullPosition,0);
        Contributors{1}=CurContributors;
        Position{1}=AUX.LpCalcNextPosition(NullPosition,Contributors{1},Db);
        for MonthId=2:SimDurMonths
            Db=AUX.LpCollectReports(Db,CurContributors,MonthId);
            CurContributors=...
                AUX.LpFetchContributors( ...
                Db ...
                ,Position{MonthId-1} ...
                ,MonthId-1);
            Contributors{MonthId}= ...
                CurContributors;
            Position{MonthId}= ...
                AUX.LpCalcNextPosition( ...
                Position{MonthId-1} ...
                ,Contributors{MonthId} ...
                ,Db);            
        end
    end
    sprintf('%s\n',Position{end}.Log{:})
end
end


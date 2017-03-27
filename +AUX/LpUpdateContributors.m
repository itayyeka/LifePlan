function [Contributors,Position] = ...
    LpUpdateContributors(Position,Contributors,DscStr,Data,Month)
%% description
%{
This function is actually a redirector to the various ContributorUpdates.
Each kind of elements has it unique events and simulation needs to able to
identify them on the fly.
%}
%% StandAlone
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
end
if ~exist('Contributors','var')
    Contributors=AUX.LpNullContributorsConstructor;
end
if ~exist('DscStr','var')
    DscStr='Income';
end
if ~exist('Data','var')
    Data=AUX.LpDefaultIncomeCfgConstructor;
end
if ~exist('Month','var')
    Month=1;
end
%% Init

%% Body
if strcmpi(DscStr,'Income')
    %% Check for special events
    StartDate=AUX.LpConvertTimeToMonths(Data.Dates.Start);
    Duration=AUX.LpConvertTimeToMonths(Data.Dates.Duration);
    EndDate=StartDate+Duration;
    %% Dynamics
    if ((Month>=StartDate) && (Month<=EndDate))
        Contributors= ...
            AUX.LpUpdateContributors_IncomeDynamics(Position,Contributors,Data);
    end
elseif strcmpi(DscStr,'Asset')
    %% Check for special events
    PurchaseDate=AUX.LpConvertTimeToMonths(Data.Dates.Purchase);
    SellDate=AUX.LpConvertTimeToMonths(Data.Dates.Sell);
    if Month==PurchaseDate
        Contributors=AUX.LpUpdateContributors_PurchaseAsset(...
            Position,Contributors,Data);
    elseif Month==SellDate
        Contributors=AUX.LpUpdateContributors_SellAsset(...
            Contributors,Data);
    end
    %% Dynamics
    if ((Month>PurchaseDate) && (Month<SellDate))
        Contributors=AUX.LpUpdateContributors_AssetDynamics(...
            Position,Contributors,Data);
    end
elseif strcmpi(DscStr,'Saving')
    %% Check for special events
    StartDate=AUX.LpConvertTimeToMonths(Data.Dates.Start);
    EndDate=AUX.LpConvertTimeToMonths(Data.Dates.End);
    if Month==StartDate
        Contributors=AUX.LpUpdateContributors_EnterSaving(...
            Position,Contributors,Data);
    elseif Month==EndDate
        Contributors=AUX.LpUpdateContributors_ExitSaving(...
            Position,Contributors,Data);
    end
    %% Dynamics
    if ((Month>StartDate) && (Month<EndDate))
        SavingFieldName=AUX.LpConvertStringToValidFieldName(Data.DscStr);        
        if ~isfield(Position.Holdings.ActiveSavings,SavingFieldName)
            Contributors.Holdings.Savings=...
                Contributors.Holdings.Savings + ...
                Data.StartAmount;
            ActiveSavingCfg.Worth=...
                Data.StartAmount;
            ActiveSavingCfg.CurInterest=...
                Data.Interest.Val;
            ActiveSavingCfg.LinkToIndex= ...
                Data.Interest.LinkToIndex;
            Position.Holdings.ActiveSavings.(SavingFieldName)=...
                ActiveSavingCfg;
        end
        Contributors=AUX.LpUpdateContributors_SavingDynamics(...
            Position,Contributors,Data);
    end
elseif strcmpi(DscStr,'Loan')
    %% Check if Loan is "Alive"
    if ~ismember(...
            AUX.LpConvertStringToValidFieldName(Data.DscStr)...
            ,Position.Info.FinishedLoans.Names)
        %% Check for special events
        if true
            %% Entering
            StartDate=AUX.LpConvertTimeToMonths(Data.Dates.Start);
            if (Month==StartDate)
                Contributors= ...
                    AUX.LpUpdateContributors_EnterLoan( ...
                    Position,Contributors,Data);
            end
            %% Exiting
            Duration=AUX.LpConvertTimeToMonths(Data.Dates.Duration);
            EndDate=StartDate+Duration;
            if ~isempty(EndDate)
                %% Exiting before the planned time.
                if Month == EndDate
                    Contributors= ...
                        AUX.LpUpdateContributors_ExitLoan( ...
                        Position,Contributors,Data);
                end
            end
        end
        %% Dynamics
        if (Month>StartDate)
            [Contributors,Position]= ...
                AUX.LpUpdateContributors_LoanDynamics( ...
                Position,Contributors,Data);
        end
    end
elseif strcmpi(DscStr,'Expense')
    %% Check for special events
    StartDate=AUX.LpConvertTimeToMonths(Data.Dates.Start);
    Duration=AUX.LpConvertTimeToMonths(Data.Dates.Duration);
    EndDate=StartDate+Duration-1;
    %% Dynamics
    if ((Month>=StartDate) && (Month<=EndDate))
        Contributors= ...
            AUX.LpUpdateContributors_ExpenseDynamics(...
            Position,Contributors,Data);
    end
end
end


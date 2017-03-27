function [Contributors] = ...
    LpUpdateContributors_SavingDynamics(Position,Contributors,SavingCfg)
%% Description
%{
Here we update the contributors in dynamics of saving.
%}
%% StandAlone
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
end
if ~exist('Contributors','var')
    Contributors = AUX.LpNullContributorsConstructor();
end
if ~exist('SavingCfg','var')
    SavingCfg = AUX.LpDefaultSavingCfgConstructor;
    SavingFieldName=AUX.LpConvertStringToValidFieldName(SavingCfg.DscStr);
    Position.Holdings.ActiveSavings.(SavingFieldName).Worth=...
        SavingCfg.StartAmount;
    Position.Holdings.ActiveSavings.(SavingFieldName).CurInterest=...
        SavingCfg.Interest.Val;
    Position.Holdings.ActiveSavings.(SavingFieldName).LinkToIndex= ...
        SavingCfg.Interest.LinkToIndex;
    StartDate=AUX.LpConvertTimeToMonths(SavingCfg.Dates.Start);
    Position.CurDate.Val=StartDate+35;
    Position.Market.InterestCalcType='Nominal';
end
%% Body
if true
    %% Cash
    Contributors.Expense=Contributors.Expense+SavingCfg.StandingOrder.Val;
    %% Aux
    [ManagmentFee,SavingGrowth] = AUX.LpProcessSaving(Position,SavingCfg);
    %% Savings
    StartDate=...
        AUX.LpConvertTimeToMonths(...
        SavingCfg.Dates.Start ...
        );
    MonthsPassed=Position.CurDate.Val-StartDate;
    if MonthsPassed<...
            AUX.LpConvertTimeToMonths(...
            SavingCfg.Dates.StopInsert)
        if mod(MonthsPassed,...
                SavingCfg.StandingOrder.Frequency) ...
                ==0
            Contributors.Expense= ...
                Contributors.Expense ...
                +SavingCfg.StandingOrder.Val ...
                +ManagmentFee;
            Contributors.Holdings.Savings=...
                Contributors.Holdings.Savings ...
                +SavingCfg.StandingOrder.Val ...
                +SavingGrowth;
        end
    end
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Saving:"' SavingCfg.DscStr '":Dynamics']};
end


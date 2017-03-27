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
    Contributors.Expense= ...
        Contributors.Expense ...
        +ManagmentFee;
    Contributors.Holdings.Savings=...
        Contributors.Holdings.Savings ...
        +SavingGrowth;    
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Saving:"' SavingCfg.DscStr '":Dynamics']};
end


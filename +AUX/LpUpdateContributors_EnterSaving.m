function [Contributors] = ...
    LpUpdateContributors_EnterSaving(Position,Contributors,SavingCfg)
%% Description
%{
Here we update the contributors in event of entering to saving
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
end
%% Body
if true
    %% Cash
    TmpTax=SavingCfg.Tax.Purchase.CalcFuncHndl(SavingCfg,Position);
    Contributors.Expense= ...
        Contributors.Expense ...
        +SavingCfg.StartAmount ...
        ... %+SavingCfg.StandingOrder.Val ...
        +TmpTax;
    %% Savings
    SavingFieldName=AUX.LpConvertStringToValidFieldName(SavingCfg.DscStr);
    if ~isfield(Position.Holdings.ActiveSavings,SavingFieldName)
        Contributors.Holdings.Savings=...
            Contributors.Holdings.Savings + ...
            SavingCfg.StartAmount;
        ActiveSavingCfg.Worth=...
            SavingCfg.StartAmount ...
            +SavingCfg.StandingOrder.Val;
        ActiveSavingCfg.CurInterest=...
            SavingCfg.Interest.Val;
        ActiveSavingCfg.LinkToIndex= ...
            SavingCfg.Interest.LinkToIndex;
        ActiveSavingCfg.Cfg=SavingCfg;
        Contributors.Holdings.ActiveSavings.(SavingFieldName)=ActiveSavingCfg;
    else
        error(['You have two saving with similar name :"' SavingCfg.DscStr '"']);
    end
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Saving:"' SavingCfg.DscStr '":Enter']};
end


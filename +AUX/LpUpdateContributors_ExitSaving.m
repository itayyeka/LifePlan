function [Contributors] = ...
    LpUpdateContributors_ExitSaving(Position,Contributors,SavingCfg)
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
%% Aux
SavingFieldName=AUX.LpConvertStringToValidFieldName(SavingCfg.DscStr);
CurValue=Position.Holdings.ActiveSavings.(SavingFieldName).Worth;
%% Body
if true
    %% Cash
    TmpTax=SavingCfg.Tax.Sell.CalcFuncHndl(SavingCfg,Position);    
    Contributors.Income=Contributors.Income+CurValue;
    Contributors.Expense=Contributors.Expense+TmpTax;
    %% Savings    
    Contributors.Holdings.Savings=...
        Contributors.Holdings.Savings ...
        -CurValue;    
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Saving:"' SavingCfg.DscStr '":Exit']};
end


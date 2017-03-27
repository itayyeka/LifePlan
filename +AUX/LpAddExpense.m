function [Db] = LpAddExpense(Db,ExpenseCfg)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('ExpenseCfg','var')
    ExpenseCfg=AUX.LpDefaultExpenseCfgConstructor;
end
%% FunctionBody
ExpensesExistFlg=0;
if isfield(Db,'Data')
    if isfield(Db.Data,'Expenses')
        ExpensesExistFlg=1;
    end
end
if ~ExpensesExistFlg
    Db.Data.Expenses={};
end
if true
    Db.Data.Expenses{end+1}=ExpenseCfg;
end
end


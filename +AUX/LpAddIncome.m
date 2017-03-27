function [Db] = LpAddIncome(Db,IncomeCfg)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('IncomeCfg','var')
    IncomeCfg=AUX.LpDefaultIncomeCfgConstructor;
end
%% FunctionBody
IncomesExistFlg=0;
if isfield(Db,'Data')
    if isfield(Db.Data,'Incomes')
        IncomesExistFlg=1;
    end
end
if ~IncomesExistFlg
    Db.Data.Incomes={};
end
if true
    Db.Data.Incomes{end+1}=IncomeCfg;
end
end


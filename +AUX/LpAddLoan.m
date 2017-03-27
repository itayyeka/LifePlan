function [Db] = LpAddLoan(Db,LoanCfg)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('LoanCfg','var')
    LoanCfg=AUX.LpDefaultLoanCfgConstructor;
end
%% FunctionBody
LoansExistFlg=0;
if isfield(Db,'Data')
    if isfield(Db.Data,'Loans')
        LoansExistFlg=1;
    end
end
if ~LoansExistFlg
    Db.Data.Loans={};
end
if true
    Db.Data.Loans{end+1}=LoanCfg;
end
end


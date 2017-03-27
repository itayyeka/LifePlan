function [Db] = LpAddSaving(Db,SavingCfg)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('SavingCfg','var')
    SavingCfg=AUX.LpDefaultSavingCfgConstructor;
end
%% FunctionBody
SavingsExistFlg=0;
if isfield(Db,'Data')
    if isfield(Db.Data,'Savings')
        SavingsExistFlg=1;
    end
end
if ~SavingsExistFlg
    Db.Data.Savings={};
end
if true
    Db.Data.Savings{end+1}=SavingCfg;
end
end


function [Db] = LpInsertRaise(Db,RaiseCfg)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('RaiseCfg','var')
    RaiseCfg=AUX.LpDefaultRaiseCfgConstructor;
end
%% Scheme
%{

%}
%% Function body
if true
    %% Fetch income index
    BaseIncomeIndex=AUX.LpFetchElemetIndexByString(...
        Db.Data.Incomes, ...
        RaiseCfg.TargetIncomeDscStr);
    %% Fetch relevant income
    if BaseIncomeIndex
        %% Fetch basic cfg
        Db.Data.Incomes{BaseIncomeIndex}.Raises{end+1}=RaiseCfg;
    else
        % TODO : Error (No income with matching DscStr found
    end
end
end


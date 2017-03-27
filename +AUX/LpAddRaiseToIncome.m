function [NewIncome] = LpAddRaiseToIncome(Income,RaiseCfg)
%% Body
if strcmpi(RaiseCfg.Units,'PrecentOfIncome')
    NewIncome=Income*(RaiseCfg.Val+100)/100;
elseif strcmpi(RaiseCfg.Units,'ActualAmount')
    NewIncome=Income+RaiseCfg.Val;
end
end


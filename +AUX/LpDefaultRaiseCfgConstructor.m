function [RaiseCfg] = LpDefaultRaiseCfgConstructor()
PeriodicRaiseCfg=[];
if true
    %% TargetIncome
    RaiseCfg.TargetIncomeDscStr='Default income';
    %% Start
    RaiseCfg.Dates.Start.Val=1;
    RaiseCfg.Dates.Start.Units='Years'; ...
        % Can be {'Years','Months'}
    %% Amount
    RaiseCfg.Val=10;
    %% Units
    RaiseCfg.Units='PrecentOfIncome'; ...
        %Can be {'PrecentOfValue','ActualAmount'}
    %% Frequency
    RaiseCfg.Frequency=inf; % in months (inf is one time)
end
end


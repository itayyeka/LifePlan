function [ExpenseCfg] = LpDefaultExpenseCfgConstructor()
ExpenseCfg=[];
if true
    %% Descriptive string
    ExpenseCfg.DscStr='Default expense';
    %% Amount
    ExpenseCfg.Amount=5000;
    %% Frequency
    ExpenseCfg.Frequency=12; %in months
    %% Start date
    ExpenseCfg.Dates.Start.Val=1;
    ExpenseCfg.Dates.Start.Units='Years'; % Can be {'Years','Months'}
    %% Duration
    ExpenseCfg.Dates.Duration.Val=[]; % if empty - forever
    ExpenseCfg.Dates.Duration.Units='Years'; % Can be {'Years','Months'}      
end
end


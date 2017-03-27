function [IncomeCfg] = LpDefaultIncomeCfgConstructor()
IncomeCfg=[];
if true
    %% Descriptive string
    IncomeCfg.DscStr='Default income';
    %% Amount
    IncomeCfg.Amount=0;
    %% Frequency
    IncomeCfg.Frequency=1; %in months
    %% Start
    IncomeCfg.Dates.Start.Val=0;
    IncomeCfg.Dates.Start.Units='Years'; ...
        % Can be {'Years','Months'}
    %% Duration
    IncomeCfg.Dates.Duration.Val=[]; ...
        % if empty - forever
    IncomeCfg.Dates.Duration.Units='Years'; ...
        % Can be {'Years','Months'}
    %% Tax
    IncomeCfg.Tax.Val=10;
    IncomeCfg.Tax.Units='PrecentOfIncome'; ...
        %Can be {'PrecentOfIncome','ActualAmount'}
    IncomeCfg.Tax.CalcFuncHndl=[]; ...
        % if this is not empty the tax is calculated by the function handle (FinalTax=fun(IncomeCfg))
    %% Raise estimation    
    IncomeCfg.Raises={};% AUX.LpDefaultRaiseCfgConstructor();
end
end
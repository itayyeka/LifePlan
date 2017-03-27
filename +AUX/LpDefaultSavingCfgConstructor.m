function [SavingCfg] = LpDefaultSavingCfgConstructor()
SavingCfg=[];
if true
    %% Descriptive string
    SavingCfg.DscStr='Default saving';
    %% Amount
    SavingCfg.StartAmount=100000;
    %% ManagementFee
    SavingCfg.ManagementFee.Val=1;
    SavingCfg.ManagementFee.Units='PrecentOfCurrentWorth'; ...
        % Can be {'PrecentOfInitialAmount','PrecentOfCurrentWorth','ActualAmount'}
    SavingCfg.ManagementFee.Frequency=12; %in months
    %TODO: LpChangeManagementFee
    %% StandingOrder
    SavingCfg.StandingOrder.Val=4000; ...
        % if empty, no standing order is applied
    %TODO: LpChangeStandingOrder
    %% Date of Start
    SavingCfg.Dates.Start.Val=1;
    SavingCfg.Dates.Start.Units='Years'; ...
        % Can be {'Years','Months'}
    %% Date of end
    SavingCfg.Dates.End.Val=[];
    SavingCfg.Dates.End.Units='Years'; ...
        % Can be {'Years','Months'}
    %% Interest
    SavingCfg.Interest.Val=6;
    SavingCfg.Interest.LinkToIndex=1;
    SavingCfg.Interest.Units='PrecentOfCurrentWorth'; ...
        % Can be {'PrecentOfInitialAmount','PrecentOfCurrentWorth' (interest of interest),'ActualAmount'}
    SavingCfg.Interest.Frequency=12; %in months
    %TODO: LpCahngeInterest
    %% Tax
    if true
        %% Enter
        SavingCfg.Tax.Purchase.CalcFuncHndl=AUX.LpDefaultSavingEnterTaxFcnConstructor;
        %% Exit
        SavingCfg.Tax.Sell.CalcFuncHndl=AUX.LpDefaultSavingExitTaxFcnConstructor;
    end
end
end


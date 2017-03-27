function [LoanCfg] = LpDefaultLoanCfgConstructor()
LoanCfg=[];
if true
    %% Descriptive string
    LoanCfg.DscStr='Default loan';
    %% Amount
    LoanCfg.Amount=0;
    LoanCfg.PrincipalLinkedToIndex=0;
    %% Date of start
    LoanCfg.Dates.Start.Val=0;
    LoanCfg.Dates.Start.Units='Years'; % Can be {'Years','Months'}    
    %% Duration
    LoanCfg.Dates.Duration.Val=0;
    LoanCfg.Dates.Duration.Units='Years'; % Can be {'Years','Months'}   
    %% Interest
    LoanCfg.Interest.LinkedToIndex=0;
    LoanCfg.Interest.InitVal=0; 
    %% Payback
    LoanCfg.Payback.Type='Shpitzer';
        % Can be {'Shpitzer','EqualPrincipal','Balloon'}
    LoanCfg.Payback.Frequency=1; %in months
    %% Exit
    LoanCfg.ExitFcnHndl=AUX.LpDefaultLoanExitFcnConstructor;
end
end


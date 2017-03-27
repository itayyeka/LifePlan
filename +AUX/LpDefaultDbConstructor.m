function [Db] = LpDefaultDbConstructor()
Db=[];
%% Data
if true
    %% General
    if true
        %% Name
        Db.General.Name='HadasAndItay';
        %% History
        if true
            %% Number of sold assets
            Db.General.NumOfSoldAssets=0;
        end
    end
    %% Init
    if true
        %% Incomes
        Db.Data.Incomes={};%AUX.LpDefaultIncomeCfgConstructor;
        %% Assets
        Db.Data.Assets={};%AUX.LpDefaultAssetCfgConstructor;
        %% Loans
        Db.Data.Loans={};%AUX.LpDefaultLoanCfgConstructor;
        %% Expenses
        Db.Data.Expenses={};%AUX.LpDefaultExpenseCfgConstructor;
        %% Savings
        Db.Data.Savings={};%AUX.LpDefaultSavingCfgConstructor;
    end
    %% Market
    Db.MarketCfg.StochasticBhvEn=0;    
    Db.MarketCfg.InterestCalcType='Adjusted'; % 'Adjusted' or 'Nominal'    
    Db.MarketCfg.Trend.Val=0.1;%[precent]
    Db.MarketCfg.Trend.Period=12;% in months
    Db.MarketCfg.Variance=0.2;%[precent^2]    
    Db.MarketCfg.IndexSimulationFunctionHandle=...
        AUX.LpDefaultIndexSimulationFcnConstructor;
end
end


function [AssetCfg] = LpDefaultAssetCfgConstructor()
AssetCfg=[];
if true
    %% Descriptive string
    AssetCfg.DscStr='Default asset';
    %% Value
    AssetCfg.PurchaseValue=0;
    %% Date of purchase
    AssetCfg.Dates.Purchase.Val=0;
    AssetCfg.Dates.Purchase.Units='Years'; % Can be {'Years','Months'}
    %% SellValue
    AssetCfg.SellValue=[]; % If "AssetCfg.Dates.Sell.Val" is empty then value isnt relevant
    %% Date of purchase
    AssetCfg.Dates.Sell.Val=[]; % If empty then no sell date is defined
    AssetCfg.Dates.Sell.Units='Years'; % Can be {'Years','Months'}
    %% Tax
    if true
        %% Purchase
        AssetCfg.Tax.Purchase.CalcFuncHndl=AUX.LpDefaultAssetPurchaseTaxFcnConstructor;
        %% Sell
        AssetCfg.Tax.Sell.CalcFuncHndl=AUX.LpDefaultAssetSellTaxFcnConstructor;
    end    
    %% Gentrification estimation
    % Addition to the asset value with time. 
    AssetCfg.GentrificationEst.Val=0;
    AssetCfg.GentrificationEst.Units='PrecentOfValue'; %Can be {'PrecentOfValue','ActualAmount'}
    AssetCfg.GentrificationEst.Frequency=12; %in months
    %% Yield
    % Could be considered as rent. How much money does the owner get from
    % The users of the asset.
    AssetCfg.Yield.Val=0;
    AssetCfg.Yield.Units='PrecentOfValue'; ...
        %Can be {'PrecentOfInitValue','PrecentOfValue','ActualAmount'}    
    AssetCfg.Yield.Frequency=1;%In months
    AssetCfg.Yield.Delay.Val=0;
    AssetCfg.Yield.Delay.Units='Months'; % Can be {'Years','Months'}  
    % The delay enables the user to set a time of asset preperation 
    % (Building, renovating, adjusting to special needs etc.)
end
end


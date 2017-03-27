function [FcnHndl] = LpDefaultAssetSellTaxFcnConstructor()
FcnHndl = @(AssetCfg,Position) AssetSellTaxFcn(AssetCfg,Position);
end

function [Tax] = AssetSellTaxFcn(AssetCfg,Position)
Tax=(AssetCfg.SellValue>AssetCfg.PurchaseValue)...
    *(AssetCfg.SellValue-AssetCfg.PurchaseValue)*0.25;
end
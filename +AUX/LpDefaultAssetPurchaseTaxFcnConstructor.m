function [FcnHndl] = LpDefaultAssetPurchaseTaxFcnConstructor()
FcnHndl = @(AssetCfg,Position) AssetPurchaseTaxFcn(AssetCfg,Position);
end

function [Tax] = AssetPurchaseTaxFcn(AssetCfg,Position)
Tax=AssetCfg.PurchaseValue*0;
end
function [Contributors] = ...
    LpUpdateContributors_PurchaseAsset(Position,Contributors,AssetCfg)
%% Description
%{
Here we update the contributors in event of asset purchase.
%}
%% StandAlone
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
end
if ~exist('Contributors','var')
    Contributors = AUX.LpNullContributorsConstructor();
end
if ~exist('AssetCfg','var')
    AssetCfg = AUX.LpDefaultAssetCfgConstructor();
end
%% Body
if true
    %% Cash
    TmpTax=AssetCfg.Tax.Purchase.CalcFuncHndl(AssetCfg,Position);
    Contributors.Expense=Contributors.Expense...
        +AssetCfg.PurchaseValue ...
        +TmpTax;   
    %% Assets
    Contributors.Holdings.Assets= ...
        Contributors.Holdings.Assets ...
        +AssetCfg.PurchaseValue;
end
%% LOG
Contributors.Log={Contributors.Log{:} ,...
    ['Asset:"' AssetCfg.DscStr '":Purchase']};
end


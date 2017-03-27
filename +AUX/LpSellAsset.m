function [Db] = LpSellAsset(Db,AssetId,SellPrm)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('AssetId','var')
    AssetId=1;
end
if ~exist('SellPrm','var')
    SellPrm.TimeFromPurchase.Val=23;
    SellPrm.TimeFromPurchase.Units='Months'; ...
        % Can be {'Months','Years'}
end
%% Function body
if true
    %% FindIndex
    if ischar(AssetId)
        AssetIndex=AUX.LpFetchElemetIndexByString(Db.Data.Assets,AssetId);
    else
        AssetIndex=AssetId;
    end
    %% Add sell date       
    PurchaseTimeMonths=AUX.LpConvertTimeToMonths(Db.Data.Assets{AssetIndex}.Dates.Purchase);
    AssetHoldDurationMonths=AUX.LpConvertTimeToMonths(SellPrm.TimeFromPurchase);
    Db.Data.Assets{AssetIndex}.Dates.Sell.Val=PurchaseTimeMonths+AssetHoldDurationMonths;
    Db.Data.Assets{AssetIndex}.Dates.Sell.Units='Months';
end

function [Value,Gentrification] = LpCalculateAssetValue(AssetCfg,Position)
%% StandAlone
if ~exist('AssetCfg','var')
    AssetCfg = AUX.LpDefaultAssetCfgConstructor();
end
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
    Position.CurDate=AUX.LpConvertTimeToMonths(AssetCfg.Dates.Purchase)+36;
end
%% Body
Gentrification=0;
if Position.CurDate.Val<AUX.LpConvertTimeToMonths(AssetCfg.Dates.Purchase)
    error(['This asset : "' AssetCfg.DscStr '" is not purchased yet. illegal.']);
else
    %% Month since purchase
    MonthSincePurchase=Position.CurDate.Val-AUX.LpConvertTimeToMonths(AssetCfg.Dates.Purchase);
    %% Calculate gentrification val
    if strcmpi(AssetCfg.GentrificationEst.Units,'PrecentOfValue')
        %% Precentage growth        
        GentrificationFactor=...
            (1+AssetCfg.GentrificationEst.Val/100) ...
            ^(1/AssetCfg.GentrificationEst.Frequency);
        %% Calculate value
        LastValue=AssetCfg.PurchaseValue*GentrificationFactor^(MonthSincePurchase-1);
        Value=AssetCfg.PurchaseValue*GentrificationFactor^MonthSincePurchase;
    elseif strcmpi(AssetCfg.GentrificationEst.Units,'ActualAmount')
        %% Actual amount growth        
        GentrificationFactor=...
            AssetCfg.GentrificationEst.Val ...
            /AssetCfg.GentrificationEst.Frequency;
        %% Calculate value
        LastValue=AssetCfg.PurchaseValue+GentrificationFactor*(MonthSincePurchase-1);
        Value=AssetCfg.PurchaseValue+GentrificationFactor*MonthSincePurchase;
    end    
    Gentrification=Value-LastValue;
end
end


function [Yield] = LpCalculateAssetYield(AssetCfg,Position)
%% StandAlone
if ~exist('AssetCfg','var')
    AssetCfg = AUX.LpDefaultAssetCfgConstructor();
end
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
    Position.CurDate=AUX.LpConvertTimeToMonths(AssetCfg.Dates.Purchase)+36;
end
%% Init
Yield=0;
%% Body
YieldMonthDelay=AUX.LpConvertTimeToMonths(AssetCfg.Yield.Delay);
MonthsPassed= ...
    Position.CurDate.Val ...
    -AUX.LpConvertTimeToMonths(AssetCfg.Dates.Purchase);
EffectiveMonths=MonthsPassed-YieldMonthDelay;
if EffectiveMonths>0
    %% Yield is valid    
    if strcmpi(AssetCfg.Yield.Units,'ActualAmount')        
        if mod(EffectiveMonths,AssetCfg.Yield.Frequency)==0
            Yield=AssetCfg.Yield.Val;
        end
    else       
        YieldFactor=(1+AssetCfg.Yield.Val/100)^(1/AssetCfg.Yield.Frequency)-1;
        if strcmpi(AssetCfg.Yield.Units,'PrecentOfInitValue')
            Yield=AssetCfg.PurchaseValue*YieldFactor;
        elseif strcmpi(AssetCfg.Yield.Units,'PrecentOfValue')
            CurValue=AUX.LpCalculateAssetValue(AssetCfg,Position);
            Yield=CurValue*YieldFactor;
        end
    end
end
end


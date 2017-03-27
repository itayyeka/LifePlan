function [FcnHndl] = LpDefaultIndexSimulationFcnConstructor()
FcnHndl = @(MarketCfg,Position) IndexSimulationFcn(MarketCfg,Position);
end

function [Index] = IndexSimulationFcn(MarketCfg,Position)
if MarketCfg.StochasticBhvEn
    StochasticeAddition=sqrt(MarketCfg.Variance)*2*(rand(1)-0.5);
else
    StochasticeAddition=0;
end
CurTrend=MarketCfg.Trend.Val/MarketCfg.Trend.Period;
Index=Position.Market.CurIndex ...
    +CurTrend ...
    +StochasticeAddition;
if Index<=0
    error('Index is zero or below. Not realistic case');
end
end
function [Db] = LpProcessXlsData_market(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    InitRowId=5;
    Map.Market.StochasticBhv=1;
    Map.Market.Index.Trend.Val=2;
    Map.Market.Index.Trend.Period=3;
    Map.Market.Index.Variance=4;
    %% Fetch values
    if true
        %% Map.Market.StochasticBhv
        Db.MarketCfg.StochasticBhvEn=...
            strcmpi(...
            XlsData{InitRowId,Map.Market.StochasticBhv} ...
            ,'ON');
        %% Map.Market.Index.Trend.Val=2;
        Db.MarketCfg.Trend.Val=...
            XlsData{InitRowId,Map.Market.Index.Trend.Val};
        %% Map.Market.Index.Period=3;
        Db.MarketCfg.Trend.Period=...
            XlsData{InitRowId,Map.Market.Index.Trend.Period};
        %% Map.Market.Index.Variance=4;
        Db.MarketCfg.Variance=...
            XlsData{InitRowId,Map.Market.Index.Variance};
    end
end
end


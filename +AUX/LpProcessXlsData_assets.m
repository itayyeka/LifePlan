function [Db] = LpProcessXlsData_assets(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    if true
        InitRowId=5;
        Map.Data.Assets.Active=1;
        Map.Data.Assets.Name=2;
        Map.Data.Assets.Purchase.Value=3;
        Map.Data.Assets.Purchase.Date.Val=4;
        Map.Data.Assets.Purchase.Date.Units=5;
        Map.Data.Assets.Sell.Value=6;
        Map.Data.Assets.Sell.Date.Val=7;
        Map.Data.Assets.Sell.Date.Units=8;
        Map.Data.Assets.Gentrification.Value=9;
        Map.Data.Assets.Gentrification.Units=10;
        Map.Data.Assets.Gentrification.Frequency=11;
        Map.Data.Assets.Yield.Value=12;
        Map.Data.Assets.Yield.Units=13;
        Map.Data.Assets.Yield.Frequency=14;
        Map.Data.Assets.Yield.Delay.Value=15;
        Map.Data.Assets.Yield.Delay.Units=16;
    end
    %% Fetch values
    RowId=InitRowId;
    FoundActivatedAsset=0;
    while RowId<=size(XlsData,1)
        %% Search for new income
        TmpCell=XlsData{RowId,Map.Data.Assets.Active};
        if ~isnan(XlsData{RowId,Map.Data.Assets.Name})
            % Got to a new income. reset the FoundActivatedAsset
            FoundActivatedAsset=0;
        end
        if strcmpi(TmpCell,'ON')
            FoundActivatedAsset=1;
            CurAsset=AUX.LpDefaultAssetCfgConstructor;
            %% Map.Data.Assets.Name=1;
            CurAsset.DscStr=...
                XlsData{RowId,Map.Data.Assets.Name};
            %% Map.Data.Assets.Purchase.Value=3;
            CurAsset.PurchaseValue=...
                XlsData{RowId,Map.Data.Assets.Purchase.Value};
            %% Map.Data.Assets.Purchase.Date.Val=4;
            CurAsset.Dates.Purchase.Val=...
                XlsData{RowId,Map.Data.Assets.Purchase.Date.Val};
            %% Map.Data.Assets.Purchase.Date.Units=5;
            CurAsset.Dates.Purchase.Units=...
                XlsData{RowId,Map.Data.Assets.Purchase.Date.Units};
            %% Map.Data.Assets.Sell.Value=6;
            CurAsset.SellValue=...
                XlsData{RowId,Map.Data.Assets.Sell.Value};
            if isnan(CurAsset.SellValue)
                CurAsset.SellValue=[];
            end
            %% Map.Data.Assets.Sell.Date.Val=7;
            CurAsset.Dates.Sell.Val=...
                XlsData{RowId,Map.Data.Assets.Sell.Date.Val};
            %% Map.Data.Assets.Sell.Date.Units=8;
            CurAsset.Dates.Sell.Units=...
                XlsData{RowId,Map.Data.Assets.Sell.Date.Units};
            if strcmpi(CurAsset.Dates.Sell.Units,'inf')
                CurAsset.Dates.Sell.Val=inf;
            end
            %% Map.Data.Assets.Gentrification.Value=9;
            CurAsset.GentrificationEst.Val=...
                XlsData{RowId,Map.Data.Assets.Gentrification.Value};
            %% Map.Data.Assets.Gentrification.Units=10;
            CurAsset.GentrificationEst.Units=...
                XlsData{RowId,Map.Data.Assets.Gentrification.Units};
            %% Map.Data.Assets.Gentrification.Frequency=11;
            CurAsset.GentrificationEst.Frequency=...
                XlsData{RowId,Map.Data.Assets.Gentrification.Frequency};
            %% Map.Data.Assets.Yield.Value=12;
            CurAsset.Yield.Val=...
                XlsData{RowId,Map.Data.Assets.Yield.Value};
            %% Map.Data.Assets.Yield.Units=13;
            CurAsset.Yield.Units=...
                XlsData{RowId,Map.Data.Assets.Yield.Units};
            %% Map.Data.Assets.Yield.Frequency=14;
            CurAsset.Yield.Frequency=...
                XlsData{RowId,Map.Data.Assets.Yield.Frequency};
            %% Map.Data.Assets.Yield.Delay.Value=15;
            CurAsset.Yield.Delay.Val=...
                XlsData{RowId,Map.Data.Assets.Yield.Delay.Value};
            %% Map.Data.Assets.Yield.Delay.Units=16;
            CurAsset.Yield.Delay.Units=...
                XlsData{RowId,Map.Data.Assets.Yield.Delay.Units};
            %% Assign new asset
            Db.Data.Assets{end+1}=CurAsset;
        end
        RowId=RowId+1;
    end
end
end
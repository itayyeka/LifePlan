function [Db] = LpProcessXlsData_savings(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    if true
        InitRowId=5;
        Map.Data.Savings.Active=1;
        Map.Data.Savings.Name=2;
        Map.Data.Savings.StartAmount=3;
        Map.Data.Savings.ManagmentFee.Value=4;
        Map.Data.Savings.ManagmentFee.Units=5;
        Map.Data.Savings.ManagmentFee.Frequency=6;
        Map.Data.Savings.StandingOrder=7;
        Map.Data.Savings.Dates.Start.Value=8;
        Map.Data.Savings.Dates.Start.Units=9;
        Map.Data.Savings.Dates.End.Value=10;
        Map.Data.Savings.Dates.End.Units=11;
        Map.Data.Savings.Interest.Value=12;
        Map.Data.Savings.Interest.Units=13;
        Map.Data.Savings.Interest.Frequency=14;
        Map.Data.Savings.Interest.LinkedToIndex=15;
    end
    %% Fetch values
    RowId=InitRowId;
    FoundActivatedSaving=0;
    while RowId<=size(XlsData,1)
        %% Search for new income
        TmpCell=XlsData{RowId,Map.Data.Savings.Active};
        if ~isnan(XlsData{RowId,Map.Data.Savings.Name})
            % Got to a new income. reset the FoundActivatedSaving
            FoundActivatedSaving=0;
        end
        if strcmpi(TmpCell,'ON')
            FoundActivatedSaving=1;
            CurSaving=AUX.LpDefaultSavingCfgConstructor;
            %% Map.Data.Savings.Name=2;
            CurSaving.DscStr=...
                XlsData{RowId,Map.Data.Savings.Name};
            %% Map.Data.Savings.StartAmount=3;
            CurSaving.StartAmount=...
                XlsData{RowId,Map.Data.Savings.StartAmount};
            %% Map.Data.Savings.ManagmentFee.Value=4;
            CurSaving.ManagementFee.Val=...
                XlsData{RowId,Map.Data.Savings.ManagmentFee.Value};
            %% Map.Data.Savings.ManagmentFee.Units=5;
            CurSaving.ManagementFee.Units=...
                XlsData{RowId,Map.Data.Savings.ManagmentFee.Units};
            %% Map.Data.Savings.ManagmentFee.Frequency=6;
            CurSaving.ManagementFee.Frequency=...
                XlsData{RowId,Map.Data.Savings.ManagmentFee.Frequency};
            %% Map.Data.Savings.StandingOrder=7;
            CurSaving.StandingOrder.Val=...
                XlsData{RowId,Map.Data.Savings.StandingOrder};
            %% Map.Data.Savings.Dates.Start.Value=8;
            CurSaving.Dates.Start.Val=...
                XlsData{RowId,Map.Data.Savings.Dates.Start.Value};
            %% Map.Data.Savings.Dates.Start.Units=9;
            CurSaving.Dates.Start.Units=...
                XlsData{RowId,Map.Data.Savings.Dates.Start.Units};
            %% Map.Data.Savings.Dates.End.Value=10;
            CurSaving.Dates.End.Val=...
                XlsData{RowId,Map.Data.Savings.Dates.End.Value};
            %% Map.Data.Savings.Dates.End.Units=11;
            CurSaving.Dates.End.Units=...
                XlsData{RowId,Map.Data.Savings.Dates.End.Units};
            %% Map.Data.Savings.Interest.Value=12;
            CurSaving.Interest.Val=...
                XlsData{RowId,Map.Data.Savings.Interest.Value};
            %% Map.Data.Savings.Interest.Units=13;
            CurSaving.Interest.Units=...
                XlsData{RowId,Map.Data.Savings.Interest.Units};
            %% Map.Data.Savings.Interest.Frequency=14;
            CurSaving.Interest.Frequency=...
                XlsData{RowId,Map.Data.Savings.Interest.Frequency};
            %% Map.Data.Savings.Interest.LinkedToIndex=15;
            CurSaving.Interest.LinkToIndex=...
                XlsData{RowId,Map.Data.Savings.Interest.LinkedToIndex};
            %% Assign new saving
            Db.Data.Savings{end+1}=CurSaving;
        end
        RowId=RowId+1;
    end
end
end
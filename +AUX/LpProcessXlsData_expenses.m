function [Db] = LpProcessXlsData_expenses(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    if true
        InitRowId=5;
        Map.Data.Expenses.Active=1;
        Map.Data.Expenses.Name=2;
        Map.Data.Expenses.Amount=3;
        Map.Data.Expenses.Frequency=4;
        Map.Data.Expenses.Dates.Start.Value=5;
        Map.Data.Expenses.Dates.Start.Units=6;
        Map.Data.Expenses.Dates.Duration.Value=7;
        Map.Data.Expenses.Dates.Duration.Units=8;
        Map.Data.Expenses.Report=9;
    end
    %% Fetch values
    RowId=InitRowId;
    FoundActivatedExpense=0;
    while RowId<=size(XlsData,1)
        %% Search for new income
        TmpCell=XlsData{RowId,Map.Data.Expenses.Active};
        if ~isnan(XlsData{RowId,Map.Data.Expenses.Name})
            % Got to a new income. reset the FoundActivatedExpense
            FoundActivatedExpense=0;
        end
        if strcmpi(TmpCell,'ON')
            FoundActivatedExpense=1;
            CurExpense=AUX.LpDefaultExpenseCfgConstructor;
            %% Map.Data.Expenses.Name=1;
            CurExpense.DscStr=...
                XlsData{RowId,Map.Data.Expenses.Name};
            %% Map.Data.Expenses.Amount=3;
            CurExpense.Amount=...
                XlsData{RowId,Map.Data.Expenses.Amount};
            %% Map.Data.Expenses.Frequency=4;
            CurExpense.Frequency=...
                XlsData{RowId,Map.Data.Expenses.Frequency};
            %% Map.Data.Expenses.Dates.Start.Value=5;
            CurExpense.Dates.Start.Val=...
                XlsData{RowId,Map.Data.Expenses.Dates.Start.Value};
            %% Map.Data.Expenses.Dates.Start.Units=6;
            CurExpense.Dates.Start.Units=...
                XlsData{RowId,Map.Data.Expenses.Dates.Start.Units};
            %% Map.Data.Expenses.Dates.Duration.Value=7;
            CurExpense.Dates.Duration.Val=...
                XlsData{RowId,Map.Data.Expenses.Dates.Duration.Value};
            %% Map.Data.Expenses.Dates.Duration.Units=8;
            CurExpense.Dates.Duration.Units=...
                XlsData{RowId,Map.Data.Expenses.Dates.Duration.Units};
            %% Map.Data.Expenses.Report=9;
            CurExpense.Report=...
                XlsData{RowId,Map.Data.Expenses.Report};
            %% Assign new expense
            Db.Data.Expenses{end+1}=CurExpense;
        end
        RowId=RowId+1;
    end
end
end
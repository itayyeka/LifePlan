function [Db] = LpProcessXlsData_incomes(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    if true
        InitRowId=5;
        Map.Data.Incomes.Active=1;
        Map.Data.Incomes.Name=2;
        Map.Data.Incomes.Amount=3;
        Map.Data.Incomes.Frequency=4;
        Map.Data.Incomes.Dates.Start.Value=5;
        Map.Data.Incomes.Dates.Start.Units=6;
        Map.Data.Incomes.Dates.Duration.Value=7;
        Map.Data.Incomes.Dates.Duration.Units=8;
        Map.Data.Incomes.Tax.Value=9;
        Map.Data.Incomes.Tax.Units=10;
        Map.Data.Incomes.Raises.Active=11;
        Map.Data.Incomes.Raises.Value=12;
        Map.Data.Incomes.Raises.Units=13;
        Map.Data.Incomes.Raises.Frequency=14;
        Map.Data.Incomes.Raises.Date.Val=15;
        Map.Data.Incomes.Raises.Date.Units=16;
        Map.Data.Incomes.Report=17;
    end
    %% Fetch values
    RowId=InitRowId;
    FoundActivatedIncome=0;
    while RowId<=size(XlsData,1)
        %% Search for new income
        TmpCell=XlsData{RowId,Map.Data.Incomes.Active};
        if ~isnan(XlsData{RowId,Map.Data.Incomes.Name})
            % Got to a new income. reset the FoundActivatedIncome
            FoundActivatedIncome=0;
        end
        if strcmpi(TmpCell,'ON')
            FoundActivatedIncome=1;
            CurIncome=AUX.LpDefaultIncomeCfgConstructor;
            %% Map.Data.Incomes.Name;
            CurIncome.DscStr=...
                XlsData{RowId,Map.Data.Incomes.Name};
            %% Map.Data.Incomes.Amount;
            CurIncome.Amount=...
                XlsData{RowId,Map.Data.Incomes.Amount};
            %% Map.Data.Incomes.Frequency;
            CurIncome.Frequency=...
                XlsData{RowId,Map.Data.Incomes.Frequency};
            %% Map.Data.Incomes.Dates.Start.Value;
            CurIncome.Dates.Start.Val=...
                XlsData{RowId,Map.Data.Incomes.Dates.Start.Value};
            %% Map.Data.Incomes.Dates.Start.Units;
            CurIncome.Dates.Start.Units=...
                XlsData{RowId,Map.Data.Incomes.Dates.Start.Units};
            %% Map.Data.Incomes.Dates.Duration.Value;
            CurIncome.Dates.Duration.Val=...
                XlsData{RowId,Map.Data.Incomes.Dates.Duration.Value};
            %% Map.Data.Incomes.Dates.Duration.Units;
            CurIncome.Dates.Duration.Units=...
                XlsData{RowId,Map.Data.Incomes.Dates.Duration.Units};
            %% Map.Data.Incomes.Tax.Value;
            CurIncome.Tax.Val=...
                XlsData{RowId,Map.Data.Incomes.Tax.Value};
            %% Map.Data.Incomes.Tax.Units;
            CurIncome.Tax.Units=...
                XlsData{RowId,Map.Data.Incomes.Tax.Units};
            %% Map.Data.Incomes.Report;
            try
                CurIncome.Report=...
                    XlsData{RowId,Map.Data.Incomes.Report};
            catch
                CurIncome.Report='';
            end
            %% Assign new income
            Db.Data.Incomes{end+1}=CurIncome;
        end
        %% Map.Data.Incomes.Raises.Active=11;
        TmpCell=...
            XlsData{RowId,Map.Data.Incomes.Raises.Active};
        %% process activated raises
        if strcmpi(TmpCell,'ON') && FoundActivatedIncome
            CurRaise=AUX.LpDefaultRaiseCfgConstructor();
            CurRaise.TargetIncomeDscStr=CurIncome.DscStr;
            %% Map.Data.Incomes.Raises.Value=12;
            CurRaise.Val=...
                XlsData{RowId,Map.Data.Incomes.Raises.Value};
            %% Map.Data.Incomes.Raises.Units=13;
            CurRaise.Units=...
                regexprep( ...
                XlsData{RowId,Map.Data.Incomes.Raises.Units} ...
                ,' ','');
            %% Map.Data.Incomes.Raises.Frequency=14;
            CurRaise.Frequency=...
                XlsData{RowId,Map.Data.Incomes.Raises.Frequency};
            %% Map.Data.Incomes.Raises.Date.Val=15;
            CurRaise.Dates.Start.Val=...
                XlsData{RowId,Map.Data.Incomes.Raises.Date.Val};
            %% Map.Data.Incomes.Raises.Date.Units=16;
            CurRaise.Dates.Start.Units=...
                XlsData{RowId,Map.Data.Incomes.Raises.Date.Units};
            Db.Data.Incomes{end}.Raises{end+1}=CurRaise;
        end
        RowId=RowId+1;
    end
end
end
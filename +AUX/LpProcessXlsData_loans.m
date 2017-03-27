function [Db] = LpProcessXlsData_loans(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    if true
        InitRowId=5;
        Map.Data.Loans.Active=1;
        Map.Data.Loans.Name=2;
        Map.Data.Loans.Amount=3;
        Map.Data.Loans.Dates.Start.Value=4;
        Map.Data.Loans.Dates.Start.Units=5;
        Map.Data.Loans.Dates.Duration.Value=6;
        Map.Data.Loans.Dates.Duration.Units=7;
        Map.Data.Loans.Dates.Exit.Value=8;
        Map.Data.Loans.Dates.Exit.Units=9;
        Map.Data.Loans.Principal.LinkToIndex=10;
        Map.Data.Loans.Interest.LinkToIndex=11;
        Map.Data.Loans.Interest.InitValue=12;
        Map.Data.Loans.Report=13;
    end
    %% Fetch values
    RowId=InitRowId;
    FoundActivatedLoan=0;
    while RowId<=size(XlsData,1)
        %% Search for new income
        TmpCell=XlsData{RowId,Map.Data.Loans.Active};
        if ~isnan(XlsData{RowId,Map.Data.Loans.Name})
            % Got to a new income. reset the FoundActivatedLoan
            FoundActivatedLoan=0;
        end
        if strcmpi(TmpCell,'ON')
            FoundActivatedLoan=1;
            CurLoan=AUX.LpDefaultLoanCfgConstructor;
            %% Map.Data.Loans.Name=2;
            CurLoan.DscStr=...
                XlsData{RowId,Map.Data.Loans.Name};
            %% Map.Data.Loans.Amount=3;
            CurLoan.Amount=...
                XlsData{RowId,Map.Data.Loans.Amount};
            %% Map.Data.Loans.Dates.Start.Value=4;
            CurLoan.Dates.Start.Val=...
                XlsData{RowId,Map.Data.Loans.Dates.Start.Value};
            %% Map.Data.Loans.Dates.Start.Units=5;
            CurLoan.Dates.Start.Units=...
                XlsData{RowId,Map.Data.Loans.Dates.Start.Units};
            %% Map.Data.Loans.Dates.Duration.Value=6;
            CurLoan.Dates.Duration.Val=...
                XlsData{RowId,Map.Data.Loans.Dates.Duration.Value};
            %% Map.Data.Loans.Dates.Duration.Units=7;
            CurLoan.Dates.Duration.Units=...
                XlsData{RowId,Map.Data.Loans.Dates.Duration.Units};
            %% Map.Data.Loans.Dates.Exit.Value=8;
            CurLoan.Dates.Exit.Val=...
                XlsData{RowId,Map.Data.Loans.Dates.Exit.Value};
            %% Map.Data.Loans.Dates.Exit.Units=9;
            CurLoan.Dates.Exit.Units=...
                XlsData{RowId,Map.Data.Loans.Dates.Exit.Units};
            %% Map.Data.Loans.Principal.LinkToIndex=10;
            CurLoan.PrincipalLinkedToIndex=...
                strcmpi(...
                XlsData{RowId,Map.Data.Loans.Principal.LinkToIndex} ...
                ,'ON');
            %% Map.Data.Loans.Interest.LinkToIndex=11;
            CurLoan.Interest.LinkedToIndex=...
                strcmpi(...
                XlsData{RowId,Map.Data.Loans.Interest.LinkToIndex} ...
                ,'ON');
            %% Map.Data.Loans.Interest.InitValue=12;
            CurLoan.Interest.InitVal=...
                XlsData{RowId,Map.Data.Loans.Interest.InitValue};
            %% Map.Data.Loans.Report=13;
            CurLoan.Report=...
                XlsData{RowId,Map.Data.Loans.Report};
            %% Assign new loan
            Db.Data.Loans{end+1}=CurLoan;
        end
        RowId=RowId+1;
    end
end
end
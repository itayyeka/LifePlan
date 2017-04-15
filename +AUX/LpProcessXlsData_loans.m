function [Db] = LpProcessXlsData_loans(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    if true
        InitRowId=5;
        Map.Data.Loans.Active=1;
        Map.Data.Loans.Type=2;
        Map.Data.Loans.VariationFrequency=3;
        Map.Data.Loans.Name=4;
        Map.Data.Loans.Amount=5;
        Map.Data.Loans.Dates.Start.Value=6;
        Map.Data.Loans.Dates.Start.Units=7;
        Map.Data.Loans.Dates.Duration.Value=8;
        Map.Data.Loans.Dates.Duration.Units=9;
        Map.Data.Loans.Dates.Exit.Value=10;
        Map.Data.Loans.Dates.Exit.Units=11;
        Map.Data.Loans.Principal.LinkToIndex=12;
        Map.Data.Loans.Interest.LinkToIndex=13;
        Map.Data.Loans.Interest.InitValue=14;
        Map.Data.Loans.Report=15;
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
            %% Map.Data.Loans.Name;
            CurLoan.DscStr=...
                XlsData{RowId,Map.Data.Loans.Name};
            %% Map.Data.Loans.Type
            CurLoan.LoanType=...
                XlsData{RowId,Map.Data.Loans.Type};
            %% Map.Data.Loans.VariationFrequency
            CurLoan.VariationFrequency=...
                XlsData{RowId,Map.Data.Loans.VariationFrequency};
            %% Map.Data.Loans.Amount;
            CurLoan.Amount=...
                XlsData{RowId,Map.Data.Loans.Amount};
            %% Map.Data.Loans.Dates.Start.Value;
            CurLoan.Dates.Start.Val=...
                XlsData{RowId,Map.Data.Loans.Dates.Start.Value};
            %% Map.Data.Loans.Dates.Start.Units;
            CurLoan.Dates.Start.Units=...
                XlsData{RowId,Map.Data.Loans.Dates.Start.Units};
            %% Map.Data.Loans.Dates.Duration.Value;
            CurLoan.Dates.Duration.Val=...
                XlsData{RowId,Map.Data.Loans.Dates.Duration.Value};
            %% Map.Data.Loans.Dates.Duration.Units;
            CurLoan.Dates.Duration.Units=...
                XlsData{RowId,Map.Data.Loans.Dates.Duration.Units};
            %% Map.Data.Loans.Dates.Exit.Value;
            CurLoan.Dates.Exit.Val=...
                XlsData{RowId,Map.Data.Loans.Dates.Exit.Value};
            %% Map.Data.Loans.Dates.Exit.Units;
            CurLoan.Dates.Exit.Units=...
                XlsData{RowId,Map.Data.Loans.Dates.Exit.Units};
            %% Map.Data.Loans.Principal.LinkToIndex;
            CurLoan.PrincipalLinkedToIndex=...
                strcmpi(...
                XlsData{RowId,Map.Data.Loans.Principal.LinkToIndex} ...
                ,'ON');
            %% Map.Data.Loans.Interest.LinkToIndex;
            CurLoan.Interest.LinkedToIndex=...
                strcmpi(...
                XlsData{RowId,Map.Data.Loans.Interest.LinkToIndex} ...
                ,'ON');
            %% Map.Data.Loans.Interest.InitValue;
            CurLoan.Interest.InitVal=...
                XlsData{RowId,Map.Data.Loans.Interest.InitValue};
            %% Map.Data.Loans.Report;
            CurLoan.Report=...
                XlsData{RowId,Map.Data.Loans.Report};
            %% Assign new loan
            Db.Data.Loans{end+1}=CurLoan;
        end
        RowId=RowId+1;
    end
end
end
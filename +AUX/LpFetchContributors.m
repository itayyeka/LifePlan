function [Contributors] = LpFetchContributors(Db,Position,Month)
%% Description
%{
This function searches the entire Db for elements that affect the
position from Month-1 to Month.
%}
%% StanAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
end
if ~exist('Month','var')
    Month=1;
end
%% Body
if true
    %% Init
    Contributors=AUX.LpNullContributorsConstructor;
    %% Incomes
    for IncomeId=1:numel(Db.Data.Incomes)
        StartDate=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Incomes{IncomeId}.Dates.Start);
        Duration=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Incomes{IncomeId}.Dates.Duration);
        if ((Month>=StartDate) && (Month<=(StartDate+Duration)))
            %% This income is a contributor
            Contributors=AUX.LpUpdateContributors( ...
                Position ...
                ,Contributors...
                ,'Income' ...
                ,Db.Data.Incomes{IncomeId} ...
                ,Month);
        end
    end
    %% Assets
    for AssetId=1:numel(Db.Data.Assets)
        PurchaseDate=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Assets{AssetId}.Dates.Purchase);
        SellDate=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Assets{AssetId}.Dates.Sell);
        if ((Month>=PurchaseDate) && (Month<=SellDate))
            Contributors=AUX.LpUpdateContributors( ...
                Position ...
                ,Contributors...
                ,'Asset' ...
                ,Db.Data.Assets{AssetId} ...
                ,Month);
        end
    end
    %% Savings
    for SavingId=1:numel(Db.Data.Savings)
        if ~ismember(...
                AUX.LpConvertStringToValidFieldName(Db.Data.Savings{SavingId}.DscStr) ...
                ,Position.Info.FinishedSavings.Names)
            StartDate=...
                AUX.LpConvertTimeToMonths(...
                Db.Data.Savings{SavingId}.Dates.Start);
            EndDate=...
                AUX.LpConvertTimeToMonths(...
                Db.Data.Savings{SavingId}.Dates.End);
            if ((Month>=StartDate) && (Month<=EndDate))
                Contributors=AUX.LpUpdateContributors( ...
                    Position ...
                    ,Contributors...
                    ,'Saving' ...
                    ,Db.Data.Savings{SavingId} ...
                    ,Month);
            end
        end
    end
    %% Loans
    for LoanId=1:numel(Db.Data.Loans)
        StartDate=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Loans{LoanId}.Dates.Start);
        if ~ismember(...
                AUX.LpConvertStringToValidFieldName(Db.Data.Loans{LoanId}.DscStr) ...
                ,Position.Info.FinishedLoans.Names)
            %{
The loan doesnt have a pre-determined or configurable end date, therefore,
to avoid excessive calculations, we store info about closed loans in the
position.
The position is dynamic and will reset whenever new action is inserted so
if the loan end time is changed it will imapct immidiatly on the position
because is will re-simulate all.
                %}
                if (Month>=StartDate)
                    Contributors=AUX.LpUpdateContributors( ...
                        Position ...
                        ,Contributors...
                        ,'Loan' ...
                        ,Db.Data.Loans{LoanId} ...
                        ,Month);
                end
        end
    end
    %% Expenses
    for ExpenseId=1:numel(Db.Data.Expenses)
        StartDate=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Expenses{ExpenseId}.Dates.Start);
        Duration=...
            AUX.LpConvertTimeToMonths(...
            Db.Data.Expenses{ExpenseId}.Dates.Duration);
        if ((Month>=StartDate) && (Month<=StartDate+Duration))
            Contributors=AUX.LpUpdateContributors( ...
                Position ...
                ,Contributors...
                ,'Expense' ...
                ,Db.Data.Expenses{ExpenseId} ...
                ,Month);
        end
    end
end
%Contributors
end


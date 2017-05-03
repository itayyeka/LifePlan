function [] = LpPlot(Db,Position,Contributors)
%% Gather info
for MonthId=1:numel(Position)
    Income(MonthId)=Contributors{MonthId}.Income;
    Expense(MonthId)=Contributors{MonthId}.Expense;
    Cash(MonthId)=Position{MonthId}.Holdings.Cash;
    Assets(MonthId)=Position{MonthId}.Holdings.Assets;
    Savings(MonthId)=Position{MonthId}.Holdings.Savings;
    Worth(MonthId)=...
        Cash(MonthId) ...
        +Assets(MonthId) ...
        +Savings(MonthId);
end
%% Plot
if true
    %% plot cash
    nRows=3;
    nCols=3;
    figure;
    if true
        %% Cash
        subplot(nRows,nCols,1);
        Data=Cash;
        Title=['Cash Init value=' num2str(Cash(1)) ...
            ' And final value :' num2str(Cash(end)) ...
            '. Diff is:' num2str(Cash(end)-Cash(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Income
        subplot(nRows,nCols,2);
        Data=Income;
        RepCell=AUX.LpGenReport(Position{end}.Report.Incomes);
        Title={'Income' ...
            RepCell{:} ...
            };
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Expense
        subplot(nRows,nCols,3);
        Data=Expense;
        RepCell=AUX.LpGenReport(Position{end}.Report.Expenses);
        Title={'Expense' ...
            RepCell{:} ...
            };
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Assets
        subplot(nRows,nCols,4);
        Data=Assets;
        Title=['Assets Init value=' num2str(Assets(1)) ...
            ' And final value :' num2str(Assets(end)) ...
            '. Diff is:' num2str(Assets(end)-Assets(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Savings
        subplot(nRows,nCols,5);
        Data=Savings;
        Title=['Savings Init value=' num2str(Savings(1)) ...
            ' And final value :' num2str(Savings(end)) ...
            '. Diff is:' num2str(Savings(end)-Savings(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Worth
        subplot(nRows,nCols,6);
        Data=Worth;
        Title='Worth';
        Title=['Worth Init value=' num2str(Worth(1)) ...
            ' And final value :' num2str(Worth(end)) ...
            '. Diff is:' num2str(Worth(end)-Worth(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Balance
        subplot(nRows,nCols,[7 8 9]);
        Data=Income-Expense;
        Title='Balance';        
        Loose=0.1;
        AUX.LpLoosePlotScript;
    end
end


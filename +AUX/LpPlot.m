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
    figure;
    if true
        %% Cash
        subplot(2,3,1);
        Data=Cash;
        Title=['Cash Init value=' num2str(Cash(1)) ...
            ' And final value :' num2str(Cash(end)) ...
            '. Diff is:' num2str(Cash(end)-Cash(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Income
        subplot(2,3,2);
        Data=Income;
        RepCell=AUX.LpGenReport(Position{end}.Report.Incomes);
        Title={'Income' ...
            RepCell{:} ...
            };
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Expense
        subplot(2,3,3);
        Data=Expense;
        RepCell=AUX.LpGenReport(Position{end}.Report.Expenses);
        Title={'Expense' ...
            RepCell{:} ...
            };
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Assets
        subplot(2,3,4);
        Data=Assets;
        Title=['Assets Init value=' num2str(Assets(1)) ...
            ' And final value :' num2str(Assets(end)) ...
            '. Diff is:' num2str(Assets(end)-Assets(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Savings
        subplot(2,3,5);
        Data=Savings;
        Title=['Savings Init value=' num2str(Savings(1)) ...
            ' And final value :' num2str(Savings(end)) ...
            '. Diff is:' num2str(Savings(end)-Savings(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Worth
        subplot(2,3,6);
        Data=Worth;
        Title='Worth';
        Title=['Worth Init value=' num2str(Worth(1)) ...
            ' And final value :' num2str(Worth(end)) ...
            '. Diff is:' num2str(Worth(end)-Worth(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
    end
end


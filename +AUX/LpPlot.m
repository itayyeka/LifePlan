function [] = LpPlot(Db,Position,Contributors)
%% Init
Incomes=zeros(1,numel(Position));
Cash=zeros(1,numel(Position));
%% Gather info
for MonthId=1:numel(Position)
    Income(MonthId)=Contributors{MonthId}.Income;
    Expense(MonthId)=Contributors{MonthId}.Expense;
    Cash(MonthId)=Position{MonthId}.Holdings.Cash;
end
%% Plot
if true
    %% plot cash
    figure;
    if true
        %% Cash
        subplot(1,3,1);
        Data=Cash;
        Title=['Cash Init value=' num2str(Cash(1)) ...
            ' And final value :' num2str(Cash(end)) ...
            '. Diff is:' num2str(Cash(end)-Cash(1))];
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Income
        subplot(1,3,2);
        Data=Income;
        Title='Income';
        Loose=0.1;
        AUX.LpLoosePlotScript;
        %% Expense
        subplot(1,3,3);
        Data=Expense;
        Title='Expense';
        Loose=0.1;
        AUX.LpLoosePlotScript;
    end
end


function [Contributors,Postition] = ...
    LpUpdateContributors_ExpenseDynamics(Position,Contributors,ExpenseCfg)
%% Description
%{
Here we update the contributors in event of entering to saving
%}
%% StandAlone
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
    Position.CurDate.Val=12+36;
end
if ~exist('Contributors','var')
    Contributors = AUX.LpNullContributorsConstructor();
end
if ~exist('ExpenseCfg','var')
    ExpenseCfg = AUX.LpDefaultExpenseCfgConstructor;
end
%% Body
StartMonth=AUX.LpConvertTimeToMonths(ExpenseCfg.Dates.Start);
MonthsDur=AUX.LpConvertTimeToMonths(ExpenseCfg.Dates.Duration);
MonthsPassed=Position.CurDate.Val-StartMonth;
ExecuteExpense=0;
if MonthsPassed>=0
    if mod(MonthsPassed,ExpenseCfg.Frequency)==0
        ExecuteExpense=1;
    end
end
if MonthsPassed==0
    if isnan(ExpenseCfg.Frequency)
        ExecuteExpense=1;
    end
end
if ExecuteExpense
    Contributors.Expense= ...
        Contributors.Expense ...
        + ExpenseCfg.Amount;
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Expense:"' ExpenseCfg.DscStr '":Dynamics']};
end


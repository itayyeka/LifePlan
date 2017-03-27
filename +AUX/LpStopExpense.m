function [Db] = LpStopExpense(Db,ExpenseId,StopDate)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('ExpenseId','var')
    ExpenseId=1;
end
if ~exist('StopDate','var')
    StopDate.Val=100;
    StopDate.Units='Months'; ...
        % can be {'Months' , 'Years'}  
end
%% Function body
if true
    %% FindIndex
    if ischar(ExpenseId)
        ExpenseIndex=AUX.LpFetchElemetIndexByString(Db.Data.Expenses,ElementDscStr);
    else
        ExpenseIndex=ExpenseId;
    end
    %% Add sell date
    StartTimeVal=Db.Data.Expenses{ExpenseIndex}.Dates.Start.Val;
    StartTimeUnits=Db.Data.Expenses{ExpenseIndex}.Dates.Start.Units;
    if strcmpi(StartTimeUnits,'Years')
        StartTimeMonths=12*StartTimeVal;
    else
        StartTimeMonths=StartTimeVal;
    end    
    if strcmpi(StopDate.Units,'Years')
        StopTimeMonths=12*StopDate.Val;
    else
        StopTimeMonths=StopDate.Val;
    end
    if StopTimeMonths<StartTimeMonths
        errordlg('Cant stop expense before start of expense')
    else
        Db.Data.Expenses{ExpenseIndex}.Dates.Duration.Val=StopTimeMonths-StartTimeMonths;
        Db.Data.Expenses{ExpenseIndex}.Dates.Duration.Units='Months';
    end    
end

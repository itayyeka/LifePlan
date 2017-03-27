function [Map] = LpMapExpensesXlsData(ExpensesXlsData)
%% StandAlone
if ~exist('ExpensesXlsData','var')
    clear;
    load('ExampleExpensesXLSData.mat');
end
%% Map Data
%% NeededFields
NeededFields={...
    'Name', ...
    'Amount', ...
    'Frequency', ...
    'Dates_Start_Val' ...
    'Dates_Start_Units' ...
    'Dates_Duration_Val' ...
    'Dates_Duration_Units' ...
    };
Map=[];
for RowId=1:size(ExpensesXlsData,1)
    for ColId=1:size(ExpensesXlsData,2)
        CurrData=ExpensesXlsData{RowId,ColId};
        if ischar(CurrData)
            %% ExpenseDef
            if strcmpi(CurrData,'Expense') && ~isfield('ExpenseDef',Map)
                Map.ExpenseDef=RowId;
                Map.DataStartCol=ColId+2;
            end
            %% Active
            if strcmpi(CurrData,'Active?')
                if ~isfield(Map,'ExpenseActive')
                    Map.ExpenseActive=RowId;
                elseif ~isfield(Map,'RaiseActive')
                    Map.RaiseActive=RowId;
                end
            end
            %% Name
            if strcmpi(CurrData,'Name')
                Map.Name=RowId;
            end
            %% Amount
            if strcmpi(CurrData,'Amount')
                Map.Amount=RowId;
            end
            %% Frequency
            if strcmpi(CurrData,'Frequency') && ~isfield(Map,'Frequency')
                Map.Frequency=RowId;
            end
            %% StartDate
            if strcmpi(regexprep(CurrData,' ',''),'StartDate')
                %% Date
                Map.StartDate.Date=RowId;
                %% Units
                Map.StartDate.Units=RowId+1;
            end
            %% Duration
            if strcmpi(CurrData,'Duration')
                %% Duration
                Map.Duration.Duration=RowId;
                %% Units
                Map.Duration.Units=RowId+1;
            end
            %% Tax
            if strcmpi(CurrData,'Tax')
                %% Value
                Map.Tax.Value=RowId;
                %% Units
                Map.Tax.Units=RowId;
            end
            %% Raises
            if strcmpi(CurrData,'Raises')
                %% Val
                Map.Raises.Val=RowId;
                %% Units
                Map.Raises.Units=RowId+1;
                %% Frequency
                Map.Raises.Frequency=RowId+2;
            end        
        end
    end
    if isfield(Map,'ExpenseDef')
        break;
    end
end
if ~isfield(Map,'ExpenseDef')
    error('Wrong format');
end
end


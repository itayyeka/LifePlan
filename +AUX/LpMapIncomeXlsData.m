function [Map] = LpMapIncomeXlsData(IncomesXlsData)
%% StandAlone
if ~exist('IncomesXlsData','var')
    clear;
    load('ExampleIncomesXLSData.mat');
end
%% Map Data
Map=[];
for ColId=1:size(IncomesXlsData,2)
    for RowId=1:size(IncomesXlsData,1)
        CurrData=IncomesXlsData{RowId,ColId};
        if ischar(CurrData)
            %% IncomeDef
            if strcmpi(CurrData,'Income') && ~isfield('IncomeDef',Map)
                Map.IncomeDef=RowId;
                Map.DataStartCol=ColId+2;
            end
            %% Active
            if strcmpi(CurrData,'Active?')
                if ~isfield(Map,'IncomeActive')
                    Map.IncomeActive=RowId;
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
                Map.Dates.Start.Val=RowId;
                %% Units
                Map.Dates.Start.Units=RowId+1;
            end
            %% Duration
            if strcmpi(CurrData,'Duration')
                %% Duration
                Map.Dates.Duration.Val=RowId;
                %% Units
                Map.Dates.Duration.Units=RowId+1;
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
    if isfield(Map,'IncomeDef')
        break;
    end
end
if ~isfield(Map,'IncomeDef')
    error('Wrong format');
end
end


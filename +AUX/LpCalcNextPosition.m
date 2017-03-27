function [Position] = LpCalcNextPosition(Position,Contributors,Db)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('Position','var')
    Position=AUX.LpPositionConstructor;
    SavingCfg = AUX.LpDefaultSavingCfgConstructor;
    SavingFieldName=AUX.LpConvertStringToValidFieldName(SavingCfg.DscStr);
    Position.Holdings.ActiveSavings.(SavingFieldName).Worth=...
        SavingCfg.StartAmount;
    Position.Holdings.ActiveSavings.(SavingFieldName).CurInterest=...
        SavingCfg.Interest.Val;
    Position.Holdings.ActiveSavings.(SavingFieldName).LinkToIndex= ...
        SavingCfg.Interest.LinkToIndex;
end
if ~exist('Contributors','var')
    Contributors=AUX.LpNullContributorsConstructor();
end
%% Body
if true
    %% Market
    NewIndex=Db.MarketCfg.IndexSimulationFunctionHandle(Db.MarketCfg,Position);
    OldIndex=Position.Market.CurIndex;
    IndexChangeRate=NewIndex/OldIndex;
    Position.Market.CurIndex=NewIndex; %[precent]
    OldInterest=Position.Market.CurInterest;
    Position.Market.CurInterest=OldInterest*IndexChangeRate; %[precent]
    Position.Market.LastIndexPrecentChange=(IndexChangeRate-1)*100; %[precent]
    %% Holdings
    if true
        %% Cash
        Position.Holdings.Cash=...
            Position.Holdings.Cash ...
            + Contributors.Income ...
            - Contributors.Expense;
        %% Assets
        Position.Holdings.Assets= ...
            Position.Holdings.Assets ...
            +Contributors.Holdings.Assets;
        %% Savings
        Position.Holdings.Savings= ...
            Position.Holdings.Savings ...
            +Contributors.Holdings.Savings;
        if isstruct(Position.Holdings.ActiveSavings)
            ActiveSavings=fieldnames(Position.Holdings.ActiveSavings);
            for ActiveSavingId=1:numel(ActiveSavings)
                CurSavingName=ActiveSavings{ActiveSavingId};
                if Position.Holdings.ActiveSavings.(CurSavingName).LinkToIndex
                    Position.Holdings.ActiveSavings.(CurSavingName).CurInterest=...
                        Position.Holdings.ActiveSavings.(CurSavingName).CurInterest ...
                        *IndexChangeRate;
                end
            end
        end
        %% Enter Savings
        if isstruct(Contributors.Holdings.ActiveSavings)
            ActiveSavingsFieldNames=fieldnames(Contributors.Holdings.ActiveSavings);
            for ActiveSavingIdId=1:numel(ActiveSavingsFieldNames)
                CurActiveSavingFieldName=ActiveSavingsFieldNames{ActiveSavingIdId};
                Position.Holdings.ActiveSavings.(CurActiveSavingFieldName)= ...
                    Contributors.Holdings.ActiveSavings.(CurActiveSavingFieldName);
            end
        end
        %% Close Savings
        for ClosedSavingId=1:numel(Contributors.Holdings.ClosedSavings)
            CurClosedSavingFieldName= ...
                AUX.LpConvertStringToValidFieldName(...
                Contributors.Holdings.ClosedSavings{ClosedSavingId});
            Position.Holdings.ActiveSavings=rmfield(...
                Position.Holdings.ActiveSavings,CurClosedSavingFieldName);
            Position.Info.FinishedSavings.Names= ...
                {Position.Info.FinishedSavings.Names{:} ...
                SavingCfg.DscStr};
        end
    end
    %% Duties
    if true
        %% Loans
        Position.Duties.Loans= ...
            Position.Duties.Loans ...
            + Contributors.Duties.Loans;
        %% Enter loans
        if isstruct(Contributors.Duties.ActiveLoans)
            ActiveLoansFieldNames=fieldnames(Contributors.Duties.ActiveLoans);
            for ActiveLoanIdId=1:numel(ActiveLoansFieldNames)
                CurActiveLoanFieldName=ActiveLoansFieldNames{ActiveLoanIdId};
                Position.Duties.ActiveLoans.(CurActiveLoanFieldName)= ...
                    Contributors.Duties.ActiveLoans.(CurActiveLoanFieldName);
            end
        end
        %% Update principal
        if isfield(Contributors.Duties,'LoanPayment')
            UpdatedLoansFieldNames=fieldnames(Contributors.Duties.LoanPayment);
            ActiveLoansFieldNames=fieldnames(Position.Duties.ActiveLoans);
            [~,MemberInd]=ismember(UpdatedLoansFieldNames,ActiveLoansFieldNames);
            for ActiveLoanId=1:numel(MemberInd)
                Position.Duties.ActiveLoans.(ActiveLoansFieldNames{ActiveLoanId}).Principal=...
                    Position.Duties.ActiveLoans.(ActiveLoansFieldNames{ActiveLoanId}).Principal ...
                    - ...
                    Contributors.Duties.LoanPayment.(ActiveLoansFieldNames{ActiveLoanId});
            end
        end
        %% Close loans
        for ClosedLoanId=1:numel(Contributors.Duties.ClosedLoans)
            CurClosedLoanFieldName= ...
                AUX.LpConvertStringToValidFieldName(...
                Contributors.Duties.ClosedLoans{ClosedLoanId});
            Position.Duties.ActiveLoans=rmfield(...
                Position.Duties.ActiveLoans,CurClosedLoanFieldName);
            Position.Info.FinishedLoans.Names= ...
                {Position.Info.FinishedLoans.Names{:} ...
                CurClosedLoanFieldName};
        end
        % The active loans field enables the loan dynamics to keep track of
        % the loan's history.
    end
    %% Info
    Position.CurDate.Val=Position.CurDate.Val+1;   
    LogAddition={...
        ['Moving to month#' num2str(Position.CurDate.Val)] ...
        ['Current Index is:' num2str(NewIndex)] ...
        };
    Position.Log={ ...
        Position.Log{:} ...
        LogAddition{:} ...
        Contributors.Log{:}};
end
end


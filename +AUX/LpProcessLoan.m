function [InterestPayment,PrincipalPayment] = LpProcessLoan(Position,LoanCfg,StandAloneFlg)
%% Description
%{
This function's goal is to enable simulation of loans.
User have to configure the loan as is in reality.
For each given position, the function will determine how much was payed,
how much left to pay and what is the current payment
(The sum of them is the total return on the loan, which means that the
current payment is NOT included in the "how much was payed" and the "how
much left to pay"
%}
%% StandAlone
StandAloneFlg=0;
if ~exist('LoanCfg','var')
    StandAloneFlg=1;
    LoanCfg = AUX.LpDefaultLoanCfgConstructor;
end
if ~exist('Position','var')
    StandAloneFlg=1;
    Position=AUX.LpNullPositionConstructor;
    LoanFieldName=AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr);
    Position.Duties.ActiveLoans.(LoanFieldName).Principal=LoanCfg.Amount;
    Position.Duties.ActiveLoans.(LoanFieldName).LastInterest=...
        LoanCfg.Interest.InitVal;
    Position.Market.InterestCalcType='Nominal';
    Position.CurDate.Val=AUX.LpConvertTimeToMonths(LoanCfg.Dates.Start);
end

%% Body
if strcmpi(LoanCfg.Payback.Type,'Shpitzer')
    %% Shpitzer
    if true
        %% IndexChangeFactor
        IndexChangeFactor=1+Position.Market.LastIndexPrecentChange/100;
        %% Principal update
        LoanFieldName=AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr);
        CurPrincipal=...
            Position.Duties.ActiveLoans.(LoanFieldName).Principal;
        if LoanCfg.PrincipalLinkedToIndex
            CurPrincipal=CurPrincipal*IndexChangeFactor;
        end
        %% Interest update
        CurInterest=...
            Position.Duties.ActiveLoans.(LoanFieldName).LastInterest;
        if LoanCfg.Interest.LinkedToIndex
            CurInterest=CurInterest*Position.Market.CurIndex/100;
        end
        %% PeriodicInterest(R)
        if strcmpi(Position.Market.InterestCalcType,'Nominal')
            MonthlyInterest=CurInterest/12;
        elseif strcmpi(Position.Market.InterestCalcType,'Adjusted')
            MonthlyInterest=100*((1+CurInterest/100)^(1/12)-1);
        else
            error('User must configure a valid interest calculation type');
        end
        % NOTE: In banks webite, the interest is nominal! not adjusted.
        %              The real calculation need to be adjusted.
        %% Months left
        LoanDuration=...
            AUX.LpConvertTimeToMonths(LoanCfg.Dates.Start) ...
            + AUX.LpConvertTimeToMonths(LoanCfg.Dates.Duration) ...
            - Position.CurDate.Val ...
            +1 ...
            ;
        %% CurPayment
        R=MonthlyInterest/100;
        CurPayment= ...
            CurPrincipal*R/ ...
            (1-1/((1+R)^LoanDuration));
        %% InterestPayment
        InterestPayment=CurPrincipal*R;
        %% PrincipalPayment
        PrincipalPayment=CurPayment-InterestPayment;
    end
else
    error('Currently supports only Shpitzer loans');
end
%% StandAlone
if StandAloneFlg
    Position.CurDate.Val=Position.CurDate.Val+1;
    Position.Duties.ActiveLoans.(LoanFieldName).Principal=...
        Position.Duties.ActiveLoans.(LoanFieldName).Principal ...
        -PrincipalPayment;
    if LoanDuration>1
        [InterestPayment,PrincipalPayment] = AUX.LpProcessLoan(Position,LoanCfg);
    end
end
end


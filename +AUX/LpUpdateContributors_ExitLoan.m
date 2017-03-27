function [Contributors] = ...
    LpUpdateContributors_ExitLoan(Position,Contributors,LoanCfg)
%% Description
%{
Here we update the contributors in event of entering to saving
%}
%% StandAlone
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
end
if ~exist('Contributors','var')
    Contributors = AUX.LpNullContributorsConstructor();
end
if ~exist('LoanCfg','var')
    LoanCfg = AUX.LpDefaultLoanCfgConstructor;
    LoanFieldName=AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr);
    Position.Duties.ActiveLoans.(LoanFieldName).Principal=LoanCfg.Amount;
    Position.Duties.ActiveLoans.(LoanFieldName).LastInterest=...
        LoanCfg.Interest.InitVal;
end
%% Aux
if true
    %% LoanFieldName
    LoanFieldName=AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr);
end
%% Body
if true
    %% Duties
    if true
        %% ClosedLoans
        Contributors.Duties.ClosedLoans={...
            Contributors.Duties.ClosedLoans{:} ...
            LoanCfg.DscStr};
    end
    %% Cash
    Penalty=LoanCfg.ExitFcnHndl(LoanCfg,Position);
    Contributors.Expense=Contributors.Expense ...
        +Position.Duties.ActiveLoans.(LoanFieldName).Principal ...
        +Penalty;
    %% Loans
    Contributors.Duties.Loans= ...
        Contributors.Duties.Loans ...
        -Position.Duties.ActiveLoans.(LoanFieldName).Principal;
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Loan:"' LoanCfg.DscStr '":Exit']};
end


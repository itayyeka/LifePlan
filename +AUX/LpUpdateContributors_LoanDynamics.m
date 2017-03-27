function [Contributors,Position] = ...
    LpUpdateContributors_LoanDynamics(Position,Contributors,LoanCfg)
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
end
%% Aux
FinishLoanThreshold=1;
[InterestPayment,PrincipalPayment]=...
    AUX.LpProcessLoan(Position,LoanCfg);
Contributors.Duties.LoanPayment.(...
    AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr)...
    )=PrincipalPayment;    
CurPayment=InterestPayment+PrincipalPayment;
ClosedLoanFlg=0;
%% Body
if true
    %% Cash    
    Contributors.Expense= ...
        Contributors.Expense ...
        +CurPayment;
    %% Loans
    Contributors.Duties.Loans=...
        Contributors.Duties.Loans ...
        -PrincipalPayment;    
    %% Finished
    LoanFieldName=AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr);
    PreviousPrincipal=...
        Position.Duties.ActiveLoans.(LoanFieldName).Principal;
    if (PreviousPrincipal-PrincipalPayment)<FinishLoanThreshold
        Contributors.Duties.ClosedLoans=...
            {Contributors.Duties.ClosedLoans{:} ...
            LoanCfg.DscStr};    
        ClosedLoanFlg=1;
    end
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Loan:"' LoanCfg.DscStr '":Dynamics']};
if ClosedLoanFlg
    Contributors.Log={Contributors.Log{:} , ...
    ['Loan:"' LoanCfg.DscStr '":Finished(Not existed)']};
end
end


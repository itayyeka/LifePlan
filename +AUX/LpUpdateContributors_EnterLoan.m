function [Contributors] = ...
    LpUpdateContributors_EnterLoan(Position,Contributors,LoanCfg)
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
%% Body
if true
    %% Cash    
    Contributors.Income=...
        Contributors.Income ...
        + LoanCfg.Amount;
    %% Loans
    Contributors.Duties.Loans=...
        Contributors.Duties.Loans + ...
        LoanCfg.Amount;
    LoanFieldName=AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr);
    if ~isfield(Position.Duties.ActiveLoans,LoanFieldName)
        Contributors.Duties.ActiveLoans.(LoanFieldName).Principal= ...
            LoanCfg.Amount;
        Contributors.Duties.ActiveLoans.(LoanFieldName).LastInterest=...
        LoanCfg.Interest.InitVal;
    else
        error(['You have two loans with similar name :"' LoanCfg.DscStr '"']);
    end
end
%% LOG
Contributors.Log={Contributors.Log{:} , ...
    ['Loan:"' LoanCfg.DscStr '":Enter']};
end


function [FcnHndl] = LpDefaultLoanExitFcnConstructor()
FcnHndl = @(LoanCfg,Position) LoanExitFcn(LoanCfg,Position);
end

function [Tax] = LoanExitFcn(LoanCfg,Position)
LoanFieldName=...
    AUX.LpConvertStringToValidFieldName(...
    LoanCfg.DscStr ...
    );
Tax=Position.Duties.ActiveLoans.(LoanFieldName).Principal*0.05;
end
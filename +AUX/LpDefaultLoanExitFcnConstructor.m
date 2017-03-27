function [FcnHndl] = LpDefaultLoanExitFcnConstructor()
FcnHndl = @(LoanCfg,Position) LoanExitFcn(LoanCfg,Position);
end

function [Tax] = LoanExitFcn(LoanCfg,Position)
Tax=LoanCfg.Amount*0.001;
end
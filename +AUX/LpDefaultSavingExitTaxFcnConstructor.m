function [FcnHndl] = LpDefaultSavingExitTaxFcnConstructor()
FcnHndl = @(SavingCfg,Position) SavingExitTaxFcn(SavingCfg,Position);
end

function [Tax] = SavingExitTaxFcn(SavingCfg,Position)
Tax=0;
end
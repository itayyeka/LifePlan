function [FcnHndl] = LpDefaultSavingEnterTaxFcnConstructor()
FcnHndl = @(SavingCfg,Position) SavingEnterTaxFcn(SavingCfg,Position);
end

function [Tax] = SavingEnterTaxFcn(SavingCfg,Position)
Tax=0;
end
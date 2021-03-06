function [Db] = LpCollectReports(Db,Contributors,MonthId)
%% Loans
LoanNames=cellfun( ...
    @(LoanCfg) ...
    AUX.LpConvertStringToValidFieldName(LoanCfg.DscStr),  ...
    Db.Data.Loans,...
    'UniformOutput',false);
for LoanNameID=1:numel(LoanNames)
    LoanName=LoanNames{LoanNameID};
    try
        Db.Report.Loans.(LoanName).Payment=...
            Db.Report.Loans.(LoanName).Payment ...
            + ...
            Contributors.Report.Loans.(LoanName).Payment;
        Db.Report.Loans.(LoanName).PrincipalPayment=...
            Db.Report.Loans.(LoanName).PrincipalPayment ...
            + ...
            Contributors.Report.Loans.(LoanName).PrincipalPayment;
        Db.Report.Loans.(LoanName).InterestPayment=...
            Db.Report.Loans.(LoanName).InterestPayment ...
            + ...
            Contributors.Report.Loans.(LoanName).InterestPayment;
        Db.Report.Loans.(LoanName).MonthlyPayments(end+1)=...
            Contributors.Report.Loans.(LoanName).Payment;
    catch
        try
            Db.Report.Loans.(LoanName).Payment=...
                Contributors.Report.Loans.(LoanName).Payment;
            Db.Report.Loans.(LoanName).PrincipalPayment=...
                Contributors.Report.Loans.(LoanName).PrincipalPayment;
            Db.Report.Loans.(LoanName).InterestPayment=...
                Contributors.Report.Loans.(LoanName).InterestPayment;
            Db.Report.Loans.(LoanName).MonthlyPayments(1)=...
                Contributors.Report.Loans.(LoanName).Payment;
        catch
            try
                Db.Report.Loans.(LoanName).Payment;
            catch
                Db.Report.Loans.(LoanName).Payment=0;
                Db.Report.Loans.(LoanName).PrincipalPayment=0;
                Db.Report.Loans.(LoanName).InterestPayment=0;
            end
        end
    end
    try
        Db.Report.Loans_TOTAL.Payment=Db.Report.Loans_TOTAL.Payment+Db.Report.Loans.(LoanName).Payment;
        Db.Report.Loans_TOTAL.InterestPayment=Db.Report.Loans_TOTAL.InterestPayment+Db.Report.Loans.(LoanName).InterestPayment;
        Db.Report.Loans_TOTAL.PrincipalPayment=Db.Report.Loans_TOTAL.PrincipalPayment+Db.Report.Loans.(LoanName).PrincipalPayment;
    catch
        Db.Report.Loans_TOTAL.Payment=Db.Report.Loans.(LoanName).Payment;
        Db.Report.Loans_TOTAL.InterestPayment=Db.Report.Loans.(LoanName).InterestPayment;
        Db.Report.Loans_TOTAL.PrincipalPayment=Db.Report.Loans.(LoanName).PrincipalPayment;
    end
end
end
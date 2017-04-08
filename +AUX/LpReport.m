function [Report] = LpReport(Db,Position,Contributors)
Report={};
Report{end+1}='########################################';
Report{end+1}=['##### REPORT (after ' num2str(numel(Contributors)) ' months) #####'];
Report{end+1}='########################################';
Report{end+1}='';
%% Loans
Report{end+1}='##### LOANS #####';
LoanNames=fieldnames(Db.Report.Loans);
MonthlyAcummulator=0;
for LoanID=1:numel(LoanNames)
    LoanName=LoanNames{LoanID};
    Report{end+1}=[LoanName ':'];
    Report{end+1}=sprintf(['\tPrincipal         : ' num2str(round(Db.Report.Loans.(LoanName).PrincipalPayment))]);
    Report{end+1}=sprintf(['\tInterest          : ' num2str(round(Db.Report.Loans.(LoanName).InterestPayment))]);
    Report{end+1}=sprintf(['\tTotal             : ' num2str(round(Db.Report.Loans.(LoanName).Payment))]);
    Report{end+1}=sprintf(['\tMonthly(Initial)  : ' num2str(round(Db.Report.Loans.(LoanName).MonthlyPayments(1)))]);
    MonthlyAcummulator=MonthlyAcummulator+Db.Report.Loans.(LoanName).MonthlyPayments(1);
end
Report{end+1}='TOTAL:';
Report{end+1}=sprintf(['\tPrincipal         : ' num2str(round(Db.Report.Loans_TOTAL.PrincipalPayment))]);
Report{end+1}=sprintf(['\tInterest          : ' num2str(round(Db.Report.Loans_TOTAL.InterestPayment))]);
Report{end+1}=sprintf(['\tTotal             : ' num2str(round(Db.Report.Loans_TOTAL.Payment))]);
Report{end+1}=sprintf(['\tMonthly(Initial)  : ' num2str(round(MonthlyAcummulator))]);
%% print
sprintf('%s\n',Report{:})
end
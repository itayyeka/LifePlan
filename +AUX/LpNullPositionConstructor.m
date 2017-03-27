function [NullPosition] = LpNullPositionConstructor()
%% Description
%{
This constructor actually defines which parameters are important
enough to be simulated.
Each one of those parameters will be affected from the various actions
that will be simulated.
%}
%% Body
if true
    %% Holdings
    if true
        %% Cash
        NullPosition.Holdings.Cash=0;
        %% Assets
        NullPosition.Holdings.Assets=0;
        %% Savings
        NullPosition.Holdings.Savings=0;
        NullPosition.Holdings.ActiveSavings=[];
        %% Total
        NullPosition.Holdings.Total=0;
    end
    %% Duties
    if true        
        %% Loans
        NullPosition.Duties.Loans=0;
        NullPosition.Duties.ActiveLoans=[];
    end
    %% Info
    if true
        %% Log
        NullPosition.Log={};
        %% Balance
        if true
            %% Monthly
            NullPosition.Info.Balance.Monthly=0;
            %% Yearly
            NullPosition.Info.Balance.Yearly=0;
        end
        %% FinishedLoans
        NullPosition.Info.FinishedLoans.Names={};
        % Cell array of the DscStr of the finished loans
        %% FinishedSavings
        NullPosition.Info.FinishedSavings.Names={};
        %% CurDate
        NullPosition.CurDate.Val=0;        
    end
    %% Market    
    NullPosition.Market.CurInterest=0.25; %[precent]
    NullPosition.Market.CurIndex=100; %[precent]
    NullPosition.Market.LastIndexPrecentChange=0; %[precent]
    NullPosition.Market.InterestCalcType=[];
    %% Report
    NullPosition.Report.Incomes=[];
    NullPosition.Report.Expenses=[];
end
end


function [NullContributors] = LpNullContributorsConstructor()
%% Description
%{
Construct an empty contributors struct
%}
%% Body
if true
    %% Dynamics
    NullContributors.Income=0;
    NullContributors.Expense=0;
    %% Holdings
    if true        
        %% Assets
        NullContributors.Holdings.Assets=0;
        %% Savings
        NullContributors.Holdings.Savings=0;
        NullContributors.Holdings.ActiveSavings={};
        NullContributors.Holdings.ClosedSavings={};
    end
    %% Duties
    if true        
        %% Loans
        NullContributors.Duties.Loans=0;
        NullContributors.Duties.ActiveLoans={};
        NullContributors.Duties.ClosedLoans={};
    end 
    %% Info
    if true
        %% FinisihedLoan
        NullContributors.Info.FinisihedLoan=0;
    end
    %% LOG
    NullContributors.Log={};
end
end


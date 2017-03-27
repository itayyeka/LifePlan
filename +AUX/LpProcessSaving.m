function [ManagmentFee,SavingGrowth] = LpProcessSaving(Position,SavingCfg)
%% StandAlone
if ~exist('SavingCfg','var')
    SavingCfg = AUX.LpDefaultSavingCfgConstructor;
end
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
    SavingFieldName=AUX.LpConvertStringToValidFieldName(SavingCfg.DscStr);
    Position.Holdings.ActiveSavings.(SavingFieldName).Worth=...
        SavingCfg.StartAmount;
    Position.Holdings.ActiveSavings.(SavingFieldName).CurInterest=...
        SavingCfg.Interest.Val;
    Position.Holdings.ActiveSavings.(SavingFieldName).LinkToIndex= ...
        SavingCfg.Interest.LinkToIndex;
    StartDate=AUX.LpConvertTimeToMonths(SavingCfg.Dates.Start);
    Position.CurDate.Val=StartDate+36;
    Position.Market.InterestCalcType='Nominal';
end
%% Body
if true
    SavingFieldName=AUX.LpConvertStringToValidFieldName(SavingCfg.DscStr);
    %% Managment fee
    ManagmentFee=0;
    PayManagmentFee=0;
    CurDate=Position.CurDate.Val;
    StartDate=AUX.LpConvertTimeToMonths(SavingCfg.Dates.Start);
    MonthsPassed=CurDate-StartDate;
    CurWorth=Position.Holdings.ActiveSavings.(SavingFieldName).Worth;    
    if mod(MonthsPassed,SavingCfg.ManagementFee.Frequency)==0
        PayManagmentFee=1;
    end
    if PayManagmentFee
        TmpVal=SavingCfg.ManagementFee.Val;
        if strcmpi(SavingCfg.ManagementFee.Units,'PrecentOfInitialAmount')
            ManagmentFee=SavingCfg.StartAmount*TmpVal/100;
        elseif strcmpi(SavingCfg.ManagementFee.Units,'PrecentOfCurrentWorth')
            ManagmentFee=CurWorth*TmpVal/100;
        elseif strcmpi(SavingCfg.ManagementFee.Units,'ActualAmount')
            ManagmentFee=TmpVal;
        end
    end
    %% SavingGrowth
    CurInterest=...
        Position.Holdings.ActiveSavings.(SavingFieldName).CurInterest;    
    MonthlyInterest=(1+CurInterest)^(1/SavingCfg.Interest.Frequency)-1;
    SavingGrowth=CurWorth*MonthlyInterest/100;
end
end


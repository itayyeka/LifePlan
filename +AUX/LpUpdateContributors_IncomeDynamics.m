function [Contributors] = LpUpdateContributors_IncomeDynamics(Position,Contributors,IncomeCfg)
%% Description
%{
This function calculates a specific income in a specific month,
icluding raises, taxes etc.
%}
%% StandAlone
if ~exist('Contributors','var')
    Contributors = AUX.LpNullContributorsConstructor();
end
if ~exist('IncomeCfg','var')
    IncomeCfg = AUX.LpDefaultIncomeCfgConstructor();
end
if ~exist('Position','var')
    Position=LpNullPositionConstructor();
end
%% Body
CurMonth=Position.CurDate.Val;
if true
    AuxIndVec=[];
    StartDates=[];
    for RaiseId=1:numel(IncomeCfg.Raises)
        %% First raise
        CurRaiseCfg=IncomeCfg.Raises{RaiseId};
        TmpDate=...
            AUX.LpConvertTimeToMonths(...
            CurRaiseCfg.Dates.Start);
        if TmpDate<=CurMonth
            StartDates(end+1)=TmpDate;
            AuxIndVec(end+1)=RaiseId;
            %% Check for reocurance
            AddedUpdates=StartDates(end):CurRaiseCfg.Frequency:CurMonth;
            AddedUpdates(1)=[];            
            StartDates=[StartDates AddedUpdates];
            AuxIndVec=[AuxIndVec RaiseId*ones(1,length(AddedUpdates))];
        end
    end
    [~,SortedRaiseIdVec]=sort(StartDates);
    CurIncome=IncomeCfg.Amount;
    for SortedRaiseId=1:length(SortedRaiseIdVec)
        CurRaiseId=AuxIndVec(SortedRaiseIdVec(SortedRaiseId));
        CurRaiseCfg=IncomeCfg.Raises{CurRaiseId};
        PreviousIncome=CurIncome;
        CurIncome=AUX.LpAddRaiseToIncome(PreviousIncome,CurRaiseCfg);
    end
    AddIncomeFlg=0;    
    if mod( ...
            CurMonth ...
            -AUX.LpConvertTimeToMonths(IncomeCfg.Dates.Start) ...
            ,IncomeCfg.Frequency)==0            
        AddIncomeFlg=1;
    end
    if CurMonth==AUX.LpConvertTimeToMonths(IncomeCfg.Dates.Start)
            AddIncomeFlg=1;
    end      
    CurTax=0;
    if isfield(IncomeCfg,'Tax')
        if strcmpi(regexprep(IncomeCfg.Tax.Units,' ',''),'PrecentOfIncome')
            CurTax=CurIncome*IncomeCfg.Tax.Val/100;
        elseif strcmpi(regexprep(IncomeCfg.Tax.Units,' ',''),'ActualAmount')
            CurTax=IncomeCfg.Tax.Val;
        end
    end
    Contributors.Income=Contributors.Income ...
        +AddIncomeFlg*(CurIncome-CurTax);
end
%% LOG
Contributors.Log={Contributors.Log{:} ,...
    ['Income:"' IncomeCfg.DscStr '":Dynamics']};
end


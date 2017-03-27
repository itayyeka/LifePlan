function [TimeMonths] = LpConvertTimeToMonths(Time)
if isempty(Time.Val)
    TimeMonths=inf;
else
    if strcmpi(Time.Units,'Years')
        TimeMonths=round(12*Time.Val);
    elseif strcmpi(Time.Units,'Months')
        if round(Time.Val)==Time.Val
            TimeMonths=Time.Val;
        else
            error('If time is months, it should be integer');
        end
    elseif strcmpi(Time.Units,'INF')
        TimeMonths=inf;
    end
end
end


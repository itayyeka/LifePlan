function [IndStr] = LpVectorToIndexStr(Vec)
IndStr=[...
    num2str(Vec(1:end-1),'%d,') ...
    num2str(Vec(end)) ...
    ];
end


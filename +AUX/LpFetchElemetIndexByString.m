function [Index] = LpFetchElemetIndexByString(ElementSet,DscStr)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
    ElementSet=Db.Data.Incomes;
    DscStr=Db.Data.Incomes{end}.DscStr;
end
%% FunctionBody
if true
    %% DefaultVal for "NotExist"
    Index=0;
    %% Run through all sets
    for CurIndex=1:numel(ElementSet)
        if strcmpi(DscStr,ElementSet{CurIndex})
            Index=CurIndex;
            break;
        end
    end
end
end


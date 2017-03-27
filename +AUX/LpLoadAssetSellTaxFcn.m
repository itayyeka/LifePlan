function [Db] = LpLoadAssetSellTaxFcn(Db,AssetId,FunctionHndl)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('DscStr','var')
    AssetId=Db.Data.Assets{end}.DscStr;
end
%% Function body
if true
    %% FindIndex
    if ischar(AssetId)
        AssetIndex=AUX.LpFetchElemetIndexByString(Db.Data.Assets,AssetId);
    else
        AssetIndex=AssetId;
    end
    %% Add sell date    
    Db.Data.Assets{AssetIndex}.Tax.CalcFuncHndl=FunctionHndl;
end


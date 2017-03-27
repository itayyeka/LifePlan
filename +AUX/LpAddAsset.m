function [Db] = LpAddAsset(Db,AssetCfg)
%% StandAlone
if ~exist('Db','var')
    Db=AUX.LpDefaultDbConstructor;
end
if ~exist('AssetCfg','var')
    AssetCfg=AUX.LpDefaultAssetCfgConstructor;
end
%% FunctionBody
AssetsExistFlg=0;
if isfield(Db,'Data')
    if isfield(Db.Data,'Assets')
        AssetsExistFlg=1;
    end
end
if ~AssetsExistFlg
    Db.Data.Assets={};
end
if true
    Db.Data.Assets{end+1}=AssetCfg;
end
end


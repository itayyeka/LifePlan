function  [Contributors] = LpUpdateContributors_AssetDynamics(Position,Contributors,AssetCfg)
%% Description
%{
Here we update the contributors about an asset (dynamics)
%}
%% StandAlone
if ~exist('Position','var')
    Position=AUX.LpNullPositionConstructor;
end
if ~exist('Contributors','var')
    Contributors = AUX.LpNullContributorsConstructor();
end
if ~exist('AssetCfg','var')
    AssetCfg = AUX.LpDefaultAssetCfgConstructor();
end
%% Body
if true
    %% Assets
    Contributors.Holdings.Assets=...
        Contributors.Holdings.Assets ...
        +AUX.LpCalculateAssetValue(AssetCfg,Position);
    %% Yield (cash)
    CurYield=AUX.LpCalculateAssetYield(AssetCfg,Position);    
    Contributors.Income= ...
        Contributors.Income ...
        +CurYield;
end
%% LOG
Contributors.Log={Contributors.Log{:} ,...
    ['Asset:"' AssetCfg.DscStr '":Dynamics']};
end


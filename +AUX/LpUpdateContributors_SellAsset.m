function [Contributors] = ...
    LpUpdateContributors_SellAsset(Position,Contributors,AssetCfg)
%% Description
%{
Here we update the contributors in event of asset sell.
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
    %% Cash
    if true
        %% Determine sell value (can be overriden with the SellValue field)
        if isempty(AssetCfg.SellValue)
            %% SellValue is empty so we calculate it
            FinalSellValue=AUX.LpCalculateAssetValue(AssetCfg,Position);
        else
            %% Value override
            FinalSellValue=AssetCfg.SellValue;
        end
        %% Get cash        
        Contributors.Income=Contributors.Income+FinalSellValue;
        %% Pay tax
        Contributors.Expense=Contributors.Expense ...
            +AssetCfg.Tax.Sell.CalcFuncHndl(AssetCfg,Position);        
        % TODO: think about adding AssetType field to the AssetCfg.
        % this wasy, one can make different tax functions for each
        % type of asset.
    end    
end
%% LOG
Contributors.Log={Contributors.Log{:} ,...
    ['Asset:"' AssetCfg.DscStr '":Sell']};
end


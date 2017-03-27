function [Db] = LpProcessXlsData_initialposition(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Init
    Db.Data.InitPosition=AUX.LpNullPositionConstructor;
    %% Process
    if true
        %% Map data
        if true
            InitRowId=3;
            Map.Data.InitPosition.Holdings.Cash=1;
            Map.General.NumOfSoldAssets=1;
        end
        %% Fetch values
        if true
            %% Cash            
            Db.Data.InitPosition.Holdings.Cash=...
                XlsData{InitRowId,Map.Data.InitPosition.Holdings.Cash};
            if isnan(Db.Data.InitPosition.Holdings.Cash)
                Db.Data.InitPosition.Holdings.Cash=0;
            end
            %% NumOfSoldAssets            
            Db.General.NumOfSoldAssets=...
                XlsData{InitRowId,Map.General.NumOfSoldAssets};
        end
    end
end
end


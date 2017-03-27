function [Db] = LpProcessXlsData_mydetails(Db,XlsData)
%% StandAlone
%% Body
if true
    %% Map data
    InitRowId=2;
    Map.General.Name=1;
    Map.General.SimDur=2;
    %% Fetch values
    Db.General.Name=XlsData{InitRowId,Map.General.Name};
    Db.General.SimDur=XlsData{InitRowId,Map.General.SimDur};
end
end


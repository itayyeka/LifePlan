function [] = LifePlanMain(Input)
%% Check input type & fetch Db
close all;
if ~exist('Input','var')
    clear variables;
    clc;
    Scenario=1;
    Input.XLS.Path=fileparts(mfilename('fullpath'));
    Input.XLS.Name=['LpUserInput' num2str(Scenario) '.xlsm'];
end
if isfield(Input,'XLS')
    Input.XLS.FullPath=fullfile(Input.XLS.Path,Input.XLS.Name);
    Db=AUX.LpGetUserInput_XLS(Input.XLS.FullPath);
end
%% Simulate
EndDate.Val=Db.General.SimDur;
EndDate.Units='Months';
[Db,Position,Contributors]=AUX.LpSimulate(Db,EndDate);
%% plot
AUX.LpPlot(Db,Position,Contributors);
end


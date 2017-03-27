function [] = LifePlanMain(Input)
%% Check input type & fetch Db
close all;
if ~exist('Input','var')
    clear variables;
    clc;
    Input.XLS.Path=fileparts(mfilename('fullpath'));
    Input.XLS.Name='LpUserInput.xlsm';
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


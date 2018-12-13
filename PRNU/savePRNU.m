clear; close all;

dimY=1500;
dimX=2000;

% Get Directories
cameraPath  = uigetdir();
dirInfo     = dir(cameraPath);
isDir       = [dirInfo.isdir];
dirNames    = {dirInfo(isDir).name};
dirNames(1:2)  = [];
[~, noCameras] = size(dirNames);

% Calculate PRNUs
PRNUs = [];
for i = 1:noCameras
    disp(['Calculating PRNU of ' dirNames{i}]);
    K=[cameraPath filesep dirNames{i}];
    PRNUs(:, :, i) = calculatePRNU([cameraPath filesep dirNames{i}], dimY, dimX);
end
save("PRNUs.mat", "PRNUs");
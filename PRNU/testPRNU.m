clear; close all;
dim = 512;

% Get Directories
cameraPath  = uigetdir();
dirInfo     = dir(cameraPath);
isDir       = [dirInfo.isdir];
dirNames    = {dirInfo(isDir).name};
dirNames(1:2)  = [];
[~, noCameras] = size(dirNames);

% Calculate PRNUs
PRNUs = zeros(dim, dim, noCameras);
for i = 1:noCameras
    disp(['Calculating PRNU of ' dirNames{i}]);
    K=[cameraPath filesep dirNames{i}];
    PRNUs(:, :, i) = calculatePRNU([cameraPath filesep dirNames{i}]);
end

% Load testing images
imagePath       = uigetdir();
dirInfo         = dir([imagePath filesep '*.jpg']);
[noOfImages, ~] = size(dirInfo);

% Testing process
for i = 1:noOfImages
    top=0;
    topN="";
    disp(['Processing image ' dirInfo(i).name]);
    tempImage = imread([imagePath filesep dirInfo(i).name]);
    
    % preprocessing
    % HERE SOME CODE IS MISSING
    tempImage=double(rgb2gray(tempImage(1:dim,1:dim,:)));
    % display the correlation of the current tested image with the PRNUs 
    for j = 1:noCameras
        correlation = corr2(tempImage.*PRNUs(:,:,j),tempImage-wiener2(tempImage,[2 2]));
        disp(['- ', dirNames{j}, ': ', num2str(correlation)]);
        if(correlation>top)
            top=correlation;
            topN=dirNames{j};
        end
    end
    disp(topN);
end

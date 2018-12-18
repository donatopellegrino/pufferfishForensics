clear;
addpath("F-measure-computation");

cameraPath  = uigetdir();

list = dir(cameraPath);
list=list(3:size(list));

list = {list.name};


%truth images
truthPath  = strcat(cameraPath,filesep,"..",filesep,"dev-dataset-maps");

truthList = dir(truthPath);
truthList=truthList(3:size(truthList));

truthList = {truthList.name};


for i = 1:20
    temp1 = getTamperingMap(strcat(cameraPath, filesep, list{i}));
    temp2 = getTamperingMap2(strcat(cameraPath, filesep, list{i}));
    temp=bitand(temp1,temp2);
    
    %imshow(temp,[]);
    %imwrite(temp, strcat("outputMaps", filesep, extractBefore(list{i},"."), ".bmp"));
    
    %F-measure computation
    disp("exxx");
    truthI = double(imread(strcat(truthPath, filesep, truthList{i})));
    disp(f_measure(truthI,temp));
    disp(f_measure(truthI,temp1));
    disp(f_measure(truthI,temp2));
end

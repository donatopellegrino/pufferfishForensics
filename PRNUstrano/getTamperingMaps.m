cameraPath  = '/home/donato/Projects/multimedia/dev-dataset/dev-dataset-forged';%uigetdir();
mapsPath = '/home/donato/Projects/multimedia/dev-dataset/dev-dataset-maps';
list = dir(cameraPath);

list = {list.name};
list = list(3:end);

[a,b] = size(list);

fMeasures = zeros(1,20);

for i = 1:100
    disp(i);
    temp = getTamperingMap(strcat(cameraPath, "/", list{i}));
    %imshow(temp);
    imwrite(temp, strcat("./outputMaps/", extractBefore(list{i},"."), ".bmp"));
    trueMap = imread(strcat(mapsPath, filesep, extractBefore(list{i},"."), ".bmp"));
    fMeasures(i)=f_measure(trueMap,temp);
    disp(fMeasures(i));
end

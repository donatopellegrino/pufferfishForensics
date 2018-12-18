cameraPath  = '/home/donato/Projects/multimedia/dev-dataset/dev-dataset-forged';%uigetdir();

list = dir(cameraPath);

list = {list.name};
list = list(3:end);

[a,b] = size(list);

for i = 1:20
    disp(i);
    temp = getTamperingMap(strcat(cameraPath, "/", list{i}));
    %imshow(temp);
    imwrite(temp, strcat("./outputMaps/", extractBefore(list{i},"."), ".bmp"));
end

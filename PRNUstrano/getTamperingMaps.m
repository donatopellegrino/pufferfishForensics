cameraPath  = uigetdir();

list = dir(cameraPath);

list = {list.name};

[a,b] = size(list);

for i = 13:13
    disp(i);
    temp = getTamperingMap(strcat(cameraPath, "/", list{i}));
    %imshow(temp);
    imwrite(temp, strcat("./outputMaps/", extractBefore(list{i},"."), ".bmp"));
end

cameraPath  = uigetdir();

list = dir(cameraPath);

list = {list.name};
list = list(3:end);

[a,b] = size(list);

for i = 11:11
    disp(i);
    temp = getTamperingMap(strcat(cameraPath, "/", list{i}));
    %imshow(temp);
    imwrite(temp, strcat("./outputMaps/", extractBefore(list{i},"."), ".bmp"));
end

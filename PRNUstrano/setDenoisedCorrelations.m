
dirPath = "./correlations";
list = dir(dirPath);
list = {list.name};
list = list(3:end);
for i = list
    disp(i);
    I = load(strcat(dirPath, filesep, i));
    map = I.map;
    %map = imgaussfilt(map, power);
    map = wiener2(map,[10 10]);

    toWrite.dim = I.dim;
    toWrite.map = map;
    save(strcat("./denoiseds/", i), "-struct", "toWrite");

    map = toImage(map);
    map = uint8(map);
    imwrite(map, strcat("./denoisedImages", filesep, extractBefore(i,"."), ".tif"));
end
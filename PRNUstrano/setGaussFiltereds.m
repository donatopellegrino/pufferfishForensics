function setGaussFiltereds(power)
    dirPath = "./correlations";
    list = dir(dirPath);
    list = {list.name};
    list = list(3:end);
    for i = list
        I = load(strcat(dirPath, filesep, i));
        map = I.map;
        map = imgaussfilt(map, power);
        
        toWrite.dim = I.dim;
        toWrite.map = map;
        save(strcat("./gaussFiltereds/", i), "-struct", "toWrite");
        
        map = toImage(map);
        map = uint8(map);
        imwrite(map, strcat("./gaussFilteredImages", filesep, extractBefore(i,"."), ".tif"));
    end
end



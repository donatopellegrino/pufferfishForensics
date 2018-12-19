dirPath = "./gaussFiltereds";
list = dir(dirPath);
list = {list.name};
list = list(3:end);
for i = list
    disp(i);
    I = load(strcat(dirPath, filesep, i));
    dim = I.dim;
    map = I.map;

    maxVal = max(map(:));
    minVal = min(map(:));

    limit = (maxVal-minVal)*0.5;
    threshold = minVal+limit;
    tempMap = map < threshold;
    [blob,blobSize] = cleanClose(tempMap);

    [a,b]=size(map);

    while blobSize > (a*b)*0.4
        limit = limit * 0.9;
        threshold = minVal+limit;
        tempMap = map < threshold;
        [blob,blobSize] = cleanClose(tempMap);
    end

    map = blob;

    %map = fillHoles(map);
    map = imclose(map,strel('disk',2)); %dilation ==> erotion
    %    map = imdilate(map,strel('disk',4));
    %    map = imerode(map,strel('disk',10));
    map = imopen(map,strel('disk',6)); %erotion ==> dilation
    %    map = imerode(map,strel('disk',2));
    %    map = imdilate(map,strel('disk',4));

    map = fillHoles(map);

    map = vectorZoom(map,dim);

    imwrite(map, strcat("./outputMaps/", extractBefore(i,"."), ".bmp"));
end

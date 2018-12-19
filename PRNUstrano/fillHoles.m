function outputI = fillHoles(inputI)
    tempI = ~inputI;
    [blobs, blobsNum] = bwlabel(tempI);
    max = -1;
    out = -1;
    for i = 1:blobsNum
        temp = sum(blobs(:)==i);
        if temp > max
            max = temp;
            out = i;
        end
    end
    outputI = blobs ~= out;
end
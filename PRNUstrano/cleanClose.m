function [outputI,max] = cleanClose(inputI)
    [blobs, blobsNum] = bwlabel(inputI);
    max = -1;
    out = -1;
    for i = 1:blobsNum
        temp = sum(blobs(:)==i);
        if temp > max
            max = temp;
            out = i;
        end
    end
    
    outputI = blobs == out;
end
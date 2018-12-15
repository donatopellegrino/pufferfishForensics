function [correlation] = getCorrelation(PRNU, tempImage, x, y, dimX, dimY)
    den=tempImage-wiener2(tempImage(:,:,2),[5 5]);
    correlation = corr2(tempImage(y:y+dimY-1,x:x+dimX-1,2).*PRNU(y:y+dimY-1,x:x+dimX-1),den(y:y+dimY-1,x:x+dimX-1));
end


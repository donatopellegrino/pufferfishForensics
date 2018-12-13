function[PRNU] = calculatePRNU(path, dimY, dimX)
    
%     dimY=1500;
%     dimX=2000;

    % Read Images from Folder
    imageList = dir([path filesep '*.*']);
    imageList=imageList(3:size(imageList));
    [noOfImages, ~] = size(imageList); % get number of images

    I = []; % input images
    D = []; % differences
    
    
    n=zeros(dimY,dimX);
    d=zeros(dimY,dimX);
    for i = 1:noOfImages
        tempImage = imread([path filesep imageList(i).name]);
        [y, x]=size(tempImage(1:dimY,1:dimX,2));
        if(x==dimX && y==dimY)
            I=im2double(tempImage(1:dimY,1:dimX,2));
            D=I-wiener2(I,[5 5]);
            n = n+(D.*I);
            d = d+(I.*I);
        else
            disp("NOPE");
        end
        %HERE SOME CODE IS MISSING
    end

    PRNU = n./d;
end
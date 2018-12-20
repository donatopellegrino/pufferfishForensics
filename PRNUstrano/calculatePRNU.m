function[PRNU] = calculatePRNU(path, dimY, dimX)
    
%     dimY=1500;
%     dimX=2000;

    % Read Images from Folder
    imageList = dir([path filesep '*.*']);
    imageList=imageList(3:size(imageList));
    [noOfImages, ~] = size(imageList); % get number of images

    n=zeros(dimY,dimX);
    d=zeros(dimY,dimX);
    
    
    for i = 1:noOfImages
        tempImage = imread([path filesep imageList(i).name]);
        tempImage = tempImage(:,:,2);
        [y, x]=size(tempImage);
        if(x==dimX && y==dimY)
            I=double(tempImage);
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
function[PRNU] = calculatePRNU(path)
    
    dim=512;

    % Read Images from Folder
    imageList = dir([path filesep '*.jpg']);
    [noOfImages, ~] = size(imageList); % get number of images

    I = zeros(dim, dim, noOfImages); % input images
    D = zeros(dim, dim, noOfImages); % differences
    
    

    for i = 1:noOfImages
        tempImage = imread([path filesep imageList(i).name]);
        I(:,:,i)=double(rgb2gray(tempImage(1:dim,1:dim,:)));
        D(:,:,i)=I(:,:,i)-wiener2(I(:,:,i),[2 2]);
        %HERE SOME CODE IS MISSING
    end

    PRNU = sum(D.*I,3)./sum(I.*I,3);
end
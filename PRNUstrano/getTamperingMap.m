function[out] = getTamperingMap(path)
    I = double(imread(path));
    I = I(:,:,2);
    den = I-wiener2(I,[5 5]);
    [imageY, imageX] = size(I);
    dim = 5;


    PRNUs = load("PRNUs.mat");
    PRNUs = PRNUs.PRNUs;

    [~,~,noPRNUs] = size(PRNUs);
    maxVal = -100000;
    winnerPRNU = 1;
    for i = 1:noPRNUs
        tempPRNU = corr2(I(1:imageY-1,1:imageX-1).*PRNUs(1:imageY-1,1:imageX-1,i),den(1:imageY-1,1:imageX-1));
        if tempPRNU > maxVal
            maxVal = tempPRNU;
            winnerPRNU = i;
        end
    end

    PRNU = PRNUs(:,:,winnerPRNU);

    out = zeros(imageY/dim,imageX/dim);
    
    for i = 0:imageY/dim-1
        for j = 0:imageX/dim-1
            y1 = i*dim+1;
            x1 = j*dim+1;
            y2 = y1+dim-1;
            x2 = x1+dim-1;
            out(i+1,j+1) = corr2(I(y1:y2,x1:x2).*PRNU(y1:y2,x1:x2),den(y1:y2,x1:x2));
        end
    end
    
    out = imgaussfilt(out,5);
    
    %imshow(toImage(out));
    
    maxVal = max(out(:));
    minVal = min(out(:));
    threshold = minVal+(maxVal-minVal)*0.4;
    [a,b] = size(out);
    for i = 1:a
        for j = 1:b
            if out(i,j)<threshold
                out(i,j) = 1;
            else
                out(i,j) = 0;
            end
        end
    end
    
    %figure,imshow(uint8(out));
    

%    out = uint8(medfilt2(out,[7 7]));

%    out = imopen(out,strel('disk',3));

    out = imerode(out,strel('disk', 10));

%    out = imdilate(out,strel('disk', 5));

    out = imclose(out,strel('disk',5));

%    figure,imshow(out);
    out = vectorZoom(out,dim);
end
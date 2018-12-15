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
    maxVal = -1000000;
    minVal = 1000000;
    for i = 0:imageY/dim-1
        for j = 0:imageX/dim-1
            y1 = i*dim+1;
            x1 = j*dim+1;
            y2 = y1+dim-1;
            x2 = x1+dim-1;
            temp = corr2(I(y1:y2,x1:x2).*PRNU(y1:y2,x1:x2),den(y1:y2,x1:x2));
            out(i+1,j+1) = temp;
            if temp > maxVal
                maxVal = temp;
            end
            if temp < minVal
                minVal = temp;
            end
        end
    end


    out = imgaussfilt(out,1);
    maxVal = max(out(:));
    minVal = min(out(:));
    threshold = minVal+(maxVal-minVal)*0.5;
    [a,b] = size(out);
    for i = 1:a
        for j = 1:b
            
%            out(i,j) = (out(i,j)-minVal)*toMul;
            if out(i,j)<threshold
                out(i,j) = 0;
            else
                out(i,j) = 255;
            end
        end
    end
%     for i = 1:a
%         for j = 1:b
%             y1 = max([i-2,1]);
%             x1 = max([j-2,1]);
%             y2 = min([i+2,i]);
%             x2 = min([j+2,j]);
%             val = sum(sum(out(y1:y2, x1:x2)))/25;%((x2-x1+1)*(y2-y1+1));
%             if val < 175
%                 out(i,j) = 0;%nero
%             else
%                 out(i,j) = 255;%bianco
%             end
%         end
%     end
    
    out = uint8(out);
%    out = uint8(imgaussfilt(out,1));
    
    %surf(out);
end
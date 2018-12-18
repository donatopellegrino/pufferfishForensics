function [map_est] = getTamperingMap2(path)

dimY=1500;
dimX=2000;

PRNUs = load("PRNUs.mat");
PRNUs = PRNUs.PRNUs;
[~,~,noCameras] = size(PRNUs);

tempImage = imread(path);
% preprocessing
% HERE SOME CODE IS MISSING
tempImage=im2double(tempImage(1:dimY,1:dimX,2));

% display the correlation of the current tested image with the PRNUs
MAAA=[];
blockDim=100;
blockX=dimX/blockDim;
blockY=dimY/blockDim;
maxDen=0;
j=0;
MAP=zeros(blockY,blockX);
map_est=zeros(dimY,dimX);
for k = 1:noCameras
    den=tempImage-wiener2(tempImage,[5 5]);
    correlation = corr2(tempImage.*PRNUs(:,:,k),den);
    if(correlation>maxDen)
        maxDen=correlation;
        j=k;
    end
end
den=tempImage-wiener2(tempImage,[5 5]);
%for j = 1:noCameras
for cy=1:blockY
    for cx=1:blockX
        realX=(cx-1)*blockDim+1;
        realY=(cy-1)*blockDim+1;
        corrCorrelation=corr2(tempImage(realY:realY+blockDim-1,realX:realX+blockDim-1).*PRNUs(realY:realY+blockDim-1,realX:realX+blockDim-1,j),den(realY:realY+blockDim-1,realX:realX+blockDim-1));
        flag=0;
        for dy=1:blockY
            for dx=1:blockX
                newX=(dx-1)*blockDim+1;
                newY=(dy-1)*blockDim+1;                        
                correlation = corr2(tempImage(newY:newY+blockDim-1,newX:newX+blockDim-1).*PRNUs(newY:newY+blockDim-1,newX:newX+blockDim-1,j),den(realY:realY+blockDim-1,realX:realX+blockDim-1));
                if(correlation>corrCorrelation)
                    MAP(cy, cx)=1;
                    map_est(realY:realY+blockDim-1,realX:realX+blockDim-1)=1;
                    flag=1;
                    break;
                end
                %MAAA((dy-1)*blockX+dx)=correlation;
            end
            if(flag==1)
                break;
            end
        end
    end
end

map_est=imgaussfilt(map_est,100);
for cy=1:dimY
    for cx=1:dimX
        if(map_est(cy,cx)<0.001)
            map_est(cy,cx)=0;
        else
            map_est(cy,cx)=1;
        end
    end
end

map_est = map_est;
end


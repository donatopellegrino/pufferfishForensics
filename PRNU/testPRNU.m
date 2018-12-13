clear; close all;
%dim = 512;
dimY=1500;
dimX=2000;

PRNUs=load("PRNUs.mat");
PRNUs=PRNUs.PRNUs;
noCameras=size(PRNUs);
noCameras=noCameras(3);
% Load testing images
imagePath       = uigetdir();
dirInfo         = dir([imagePath filesep '*.*']);
dirInfo=dirInfo(3:size(dirInfo));
[noOfImages, ~] = size(dirInfo);

% Testing process
for i = 1:noOfImages
    top=0;
    topN="";
    disp(['Processing image ' dirInfo(i).name]);
    tempImage = imread([imagePath filesep dirInfo(i).name]);
    [y, x]=size(tempImage(1:dimY,1:dimX,2));
    if(x==dimX && y==dimY)
        % preprocessing
        % HERE SOME CODE IS MISSING
        tempImage=im2double(tempImage(1:dimY,1:dimX,2));

        % display the correlation of the current tested image with the PRNUs
        MAAA=[];
        blockDim=500;
        blockX=dimX/blockDim;
        blockY=dimY/blockDim;
        maxDen=0;
        j=0;
        MAP=zeros(blockY,blockX);
        for k = 1:noCameras
            den=tempImage-wiener2(tempImage,[5 5]);
            correlation = corr2(tempImage.*PRNUs(:,:,k),den);
            if(correlation>maxDen)
                maxDen=correlation;
                j=k;
            end
        end
    %for j = 1:noCameras
        for cy=1:blockY
            for cx=1:blockX
                for dy=1:blockY
                    for dx=1:blockX
                        realX=(cx-1)*blockDim+1;
                        realY=(cy-1)*blockDim+1;
                        newX=(dx-1)*blockDim+1;
                        newY=(dy-1)*blockDim+1;
                        den=tempImage-wiener2(tempImage,[5 5]);
                        papa=(fft(den(realY:realY+blockDim-1,realX:realX+blockDim-1)).*conj(fft(tempImage(newY:newY+blockDim-1,newX:newX+blockDim-1).*PRNUs(newY:newY+blockDim-1,newX:newX+blockDim-1,j))));
                        papa=real(ifft(papa./abs(papa)));
                        su=sum(papa);
                        su2=0;
                        for i=1:blockDim
                            if(~isnan(su(i)))
                                su2=su2+su(i);
                            end
                        end
                        

                        %correlationPic=ifft2((fft(tempImage(1:30,1:30)).*conj(fft(tempImage(1:30,1:30).*PRNUs(1:30,1:30,j))))./abs(fft(tempImage(1:30,1:30)).*conj(fft(tempImage(1:30,1:30).*PRNUs(1:30,1:30,j)))));
                        %correlationPic = imregcorr(tempImage(1:30,1:30)-wiener2(tempImage(1:30,1:30),[5 5]),tempImage.*PRNUs(:,:,j));
                        
                        %correlation = corr2(tempImage(newY:newY+blockDim-1,newX:newX+blockDim-1).*PRNUs(newY:newY+blockDim-1,newX:newX+blockDim-1,noCameras),den(realY:realY+blockDim-1,realX:realX+blockDim-1));
                        %disp(['- ', dirNames{j}, ': ', num2str(correlation)]);
                        %if(correlation>top)
                            %top=correlation;
                            %topN=dirNames{j};
                        %end
                        MAAA((dy-1)*blockX+dx)=su2;
                        %MAAA((dy-1)*blockX+dx)=correlation;
                    end
                end
                tmpInx=[];
                tmpInx2=[];
                myInx=[cy, cx];
                max=0;
                max2=0;
                i=1;
                i2=1;
                for a=1:blockY
                    for b=1:blockX
                        if(MAAA((a-1)*blockX+b)>max)
                           % i2=i;
                            i=1;
                           % tmpInx2=tmpInx;
                            tmpInx=[];
                           % max2=max;
                            max=MAAA((a-1)*blockX+b);
                            tmpInx(i,:)=[a, b];
                        elseif(MAAA((a-1)*blockX+b)==max)
                            i=i+1;
                            tmpInx(i,:)=[a, b];
                        %elseif(MAAA((a-1)*blockX+b)>max2)
                         %   i2=1;
                          %  tmpInx2=[];
                           % max2=MAAA((a-1)*blockX+b);
                            %tmpInx2(i2,:)=[a, b];
                        %elseif(MAAA((a-1)*blockX+b)==max2)
                         %   i2=i2+1;
                          %  tmpInx2(i2,:)=[a, b];
                        end
                    end
                end
                if(ismember(myInx,tmpInx))
                    disp("true!!!!!!!!!!!!!!");
                    
                %elseif(ismember(myInx,tmpInx2))
                 %   disp("true!!!!!!!!!!!!!!");
                else
                    disp("false");
                    MAP(cy, cx)=255;
                end
            end
        end
        disp("STOOOOOOOOOOOOOOOP");
    %end
    else
        disp("NOPE");
    end
    imshow(uint8(MAP));
    pause;
    %disp(topN);
end

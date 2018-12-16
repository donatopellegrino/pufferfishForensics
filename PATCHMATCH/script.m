blockDim = 7;
input = imread('lena.bmp');

[dimx,dimy] = size(input);
input = input(1:(floor(dimx/blockDim))*blockDim,1:(floor(dimy/blockDim))*blockDim);
[blocksX,blocksY] = size(input);
blocksX = floor(dimx/blockDim);
blocksY = floor(dimy/blockDim);

bestBlockX = zeros(blocksX,blocksY);
bestBlockY = zeros(blocksX,blocksY);
bestMse = zeros(blocksX,blocksY);
distance = zeros(blocksX,blocksY);
for i = 1:blocksX
    for j = 1:blocksY
        bestMse(i,j) = 100000;
        for k = 1:blocksX
            for l = 1:blocksY
                if(i ~= k || j ~= l)
                   mse = immse(input(i*blockDim-(blockDim-1):i*blockDim,j*blockDim-(blockDim-1):j*blockDim),input(k*blockDim-(blockDim-1):k*blockDim,l*(blockDim)-(blockDim-1):l*blockDim));
                   if (mse < bestMse(i,j)) 
                       bestBlockX(i,j) = k;
                       bestBlockY(i,j) = l;
                       bestMse(i,j) = mse;
                       distance(i,j) = sqrt((i-k)^2+(j-l)^2);
                   end
                end                
            end
        end
    end
end
found = 0;
count = 1;
edited = zeros(blocksX,blocksY);
for i = 1:(blocksX-1)
       for j = 1:(blocksY-1)
           if (edited(i,j) == 0)
               if (distance(i,j) == distance(i+1,j))
                   edited(i,j) = 255;
                   edited(i+1,j) = 255;
               end
               if (distance(i,j) == distance(i,j+1))
                   edited(i,j) = 255;
                   edited(i,j+1) = 255;
               end
               count = count+1;
           else 
               if (distance(i,j) == distance(i+1,j))
                   edited(i+1,j) = 255;
               end
               if (distance(i,j) == distance(i,j+1))
                   edited(i,j+1) = 255;
               end
           end
       end
end
figure;
imshow(uint8(edited),[0 255]);

%TODO: riportare l'immagine finale a dimx,dimy
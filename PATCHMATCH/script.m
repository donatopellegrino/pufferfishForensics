
input = imread('lena.bmp');

[dimx,dimy] = size(input);
input = input(1:(floor(dimx/7))*7,1:(floor(dimy/7))*7);
[blocksX,blocksY] = size(input);
blocksX = floor(dimx/7);
blocksY = floor(dimy/7);

bestBlockX = zeros(blocksX,blocksY);
bestBlockY = zeros(blocksX,blocksY);

for i = 1:blocksX
    for j = 1:blocksY
        for k = 1:blocksX
            for l = 1:blocksY
                if(i ~= k || j ~= l)
                   mse = immse(input(i*7-6:i*7,j*7-6:j*7),input(k*7-6:k*7,l*7-6:l*7));
                   if (mse < bestBlock(i,j) || bestBlockX(i,j) == 0) 
                       bestBlockX(i,j) = k;
                       bestBlockY(i,j) = l;
                   end
                end                
            end
        end
    end
end
       

%TODO: riportare l'immagine finale a dimx,dimy
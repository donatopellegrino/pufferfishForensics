function vectorOut = vectorZoom(vectorIn, dim)
    [a,b] = size(vectorIn);
    vectorOut = zeros(a*dim,b*dim);
    for i = 0:a-1
        for j = 0:b-1
            x1 = i*dim+1;
            x2 = i*dim+dim;
            y1 = j*dim+1;
            y2 = j*dim+dim;
            vectorOut(x1:x2,y1:y2) = vectorIn(i+1,j+1);
        end
    end
end


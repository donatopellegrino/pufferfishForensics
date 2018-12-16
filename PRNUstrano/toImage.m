function [output] = toImage(input)
    maxVal = max(input(:));
    minVal = min(input(:));
    toMul = 255/(maxVal-minVal);
    [a,b] = size(input);
    output = zeros(a,b);
    for i = 1:a
        for j = 1:b
            output(i,j) = (input(i,j)-minVal)*toMul;
        end
    end
    output = uint8(output);
end

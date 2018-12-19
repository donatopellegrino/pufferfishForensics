function output = toImage(input)
    minVal = min(input(:));
    toMul = 255/(max(input(:))-minVal);
    output = (input-minVal)*toMul;
end

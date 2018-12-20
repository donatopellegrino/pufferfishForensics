dirPath = '/home/donato/Projects/multimedia/dev-dataset/dev-dataset-forged';
dim = 5;
n = 800;

list = dir(dirPath);
list = {list.name};
list = list(3:end);

PRNUs = load("PRNUs.mat");
PRNUs = PRNUs.PRNUs;
[~,~,noPRNUs] = size(PRNUs);

for i = 1:n
    disp(i);
    I = double(imread(strcat(dirPath, filesep, list{i})));
    I = I(:,:,2);
    den = I-wiener2(I,[5 5]);
    [imageY, imageX] = size(I);

    maxVal = -100000;
    winnerPRNU = 1;
    for j = 1:noPRNUs
        tempPRNU = corr2(I.*PRNUs(:,:,j),den);
        if tempPRNU > maxVal
            maxVal = tempPRNU;
            winnerPRNU = j;
        end
    end
    PRNU = PRNUs(:,:,winnerPRNU);

    out = zeros(imageY/dim,imageX/dim);
    for y = 0:imageY/dim-1
        for x = 0:imageX/dim-1
            y1 = y*dim+1;
            x1 = x*dim+1;
            y2 = y1+dim-1;
            x2 = x1+dim-1;
            out(y+1,x+1) = corr2(I(y1:y2,x1:x2).*PRNU(y1:y2,x1:x2),den(y1:y2,x1:x2));
        end
    end

    toWrite.dim = dim;
    toWrite.map = out;

    save(strcat("./correlations/",extractBefore(list{i},"."),".mat"), "-struct", "toWrite");
end
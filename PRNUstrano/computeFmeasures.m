trueMapsPath  = '/home/donato/Projects/multimedia/dev-dataset/dev-dataset-maps';%uigetdir();

maybeMapsPath  = '/home/donato/Projects/multimedia/pufferfishForensics/PRNUstrano/outputMaps';%uigetdir();
maybeList = dir(maybeMapsPath);
maybeList = {maybeList.name};
maybeList = maybeList(3:end);
[c,d] = size(maybeList);

out = zeros(c,d);
for i = 1:d
    disp(i);
    trueI = imread(strcat(trueMapsPath, "/", maybeList{i}));
    maybeI = logical(imread(strcat(maybeMapsPath, "/", maybeList{i})));
    out(i) = f_measure(trueI,maybeI);
end


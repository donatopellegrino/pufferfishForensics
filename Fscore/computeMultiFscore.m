trueMapsPath  = uigetdir();
trueList = dir(trueMapsPath);
trueList = {trueList.name};
trueList = trueList(3:end);
[a,b] = size(trueList);

maybeMapsPath  = uigetdir();
maybeList = dir(maybeMapsPath);
maybeList = {maybeList.name};
maybeList = maybeList(3:end);
[c,d] = size(maybeList);

out = zeros(c,d);
for i = 1:10
    disp(i);
    maybeI = double(imread(strcat(maybeMapsPath, "/", maybeList{i})));
    trueI = double(imread(strcat(trueMapsPath, "/", trueList{i})));
    out(i) = f_measure(trueI,maybeI);
end

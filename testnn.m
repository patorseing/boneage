tic
srcFiles = dir('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/*.png');  % the folder in which ur images exists
csvFiles = dir('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/*.csv');
csv = strcat('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/',csvFiles(1).name);
opts = detectImportOptions(csv,'NumHeaderLines',1); % number of header lines which are to be ignored
opts.VariableNamesLine = 1; % row number which has variable names
opts.DataLine = 2; % row number from which the actual data starts
data = readtable(csv,opts);
input = [];
target = [];
for i = 1 : length(srcFiles)
    filename = strcat('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/',srcFiles(i).name);
    id = split(srcFiles(i).name, '.');
    rows = data.Var1==str2double(id{1});
    match = data(rows,:)
    I = imread(filename);
    I = imadjust(I);
    I = imresize(I,.25);
    featuresI = extractLBPFeatures(I,'Upright',false)
    input = [input; featuresI]
    target = [target; de2bi(ceil(match.Var2/12),5)]
end
toc
%%
target2 = bi2de(target);
%%
target3 = [];
for i = 1: length(target2)
    switch target2(i)
    case 1
        p = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 2
        p = [0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 3
        p = [0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 4
        p = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 5
        p = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 6
        p = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 7
        p = [0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 8
        p = [0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 9
        p = [0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 10
        p = [0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 11
        p = [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 12
        p = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0];
        target3 = [target3;p];
    case 13
        p = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0];
        target3 = [target3;p];
    case 14
        p = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0];
        target3 = [target3;p];
    case 15
        p = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0];
        target3 = [target3;p];
    case 16
        p = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0];
        target3 = [target3;p];
    case 17
        p = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0];
        target3 = [target3;p];
    case 18
        p = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0];
        target3 = [target3;p];
    case 19
        p = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
        target3 = [target3;p];
    otherwise
        disp(target2(i));
        break;
    end
end
%%
nnstart
%%
K = imread('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/1902.png');
K = imresize(K,0.25);
K = imadjust(K);
featuresK = extractLBPFeatures(K,'Upright',false);
sim(net,featuresK')
sim(net1,featuresK')
%%
L = imread('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/3933.png');
L = imresize(L,0.25);
L = imadjust(L);
featuresL = extractLBPFeatures(L,'Upright',false);
sim(net,featuresL')
a = sim(net1,featuresL')
%%
model = net1;
save model;
load model;
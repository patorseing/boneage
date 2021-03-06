% read image
%I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
%K = imread('/Users/yok/Downloads/boneage-training-dataset/1379.png');
%L = imread('/Users/yok/Downloads/boneage-training-dataset/1396.png');
I = imread('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/3806.png');
K = imread('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/1902.png');
L = imread('/Users/patorseing/Downloads/rsna-bone-age/boneage-training-dataset/4199.png');
%I = imread('4360.png');
L = imresize(L,0.5);
K = imresize(K,0.5);
I = imresize(I,0.5);
L = imadjust(L);
K = imadjust(K);
I = imadjust(I);
figure;imshow(I);
figure;imshow(K);
figure;imshow(L);

%% adjust contrast
J = histeq(I, 64);
% figure; imshow(J);

J = imadjust(I);
% figure; imshow(J);

K = imadjust(K);
%%
% convert to bw

img = im2bw(J, 0.6);
figure; imshow(img);

% mask
se = strel('disk',10);
mask = imopen(img,se);
%mask = imresize(mask, 0.25);
%J = imresize(J, 0.25);
figure; imshow(J);
figure; imshow(mask);

 [row,column,numchannel] = size(mask);
 
for i = 1:row
    for j = 1: column
        if mask(i,j) == 0
            J(i,j) = 0;
        end
    end
end

figure; imshow(J);

% close all
% pwd
% mkdir newdir
% cd newdir
% imwrite(J, 'a.png');

%% Active contour
% mask = zeros(size(I));
% mask(25:end-25,25:end-25) = 1;
% figure
% imshow(mask);
% 
% bw = activecontour(I,mask,1500);
% figure
% imshow(bw);

%% Texture Segmentation using texture filter
% E = entropyfilt(J);
% Eim = rescale(E);
% % figure; imshow(Eim); 
% BW1 = imbinarize(Eim, .8);
% figure; imshow(BW1); title('BW1');

%% Edge detection
% [~, threshold] = edge(img, 'sobel');
% fudgeFactor = .5;
% BWs = edge(img,'sobel', threshold * fudgeFactor);
% figure, imshow(BWs), title('binary gradient mask');
% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 0);
% BWsdil = imdilate(BWs, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');
% Kmedian = medfilt2(BWsdil);
% figure; imshow(Kmedian); title('Kmedian');
%%
% a = [4360 180 true;4360 180 false];
% dlmwrite('myFile.csv',a,'-append','delimiter',',','roffset',0)
%%
% Get a list of all files and folders in this folder.
% files = dir(pwd);
% % Get a logical vector that tells which is a directory.
% dirFlags = [files.isdir];
% % Extract only those that are directories.
% subFolders = files(dirFlags);
% % Print folder names to command window.
% for k = 1 : length(subFolders)
%   fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
% end

%% VisionRecovert
P = imread('/Users/yok/Downloads/boneage-training-dataset/1387.png');
ptsI = detectSURFFeatures(I);
ptsP = detectSURFFeatures(P);
[featuresI, validPtsI] = extractFeatures(I, ptsI);
[featuresP, validPtsP] = extractFeatures(P, ptsP);
indexPairs = matchFeatures(featuresI, featuresP);
matchI = validPtsI(indexPairs(:,1));
matchP = validPtsP(indexPairs(:,2));
figure; showMatchedFeatures(I,P,matchI,matchP);
title('Putatively matched points (including outliers)');
[tform, inlierP, inlierI] = estimateGeometricTransform(...
    matchP, matchI, 'similarity');
figure; showMatchedFeatures(I,P,inlierI,inlierP);
title('Matching points (inliers only)');
legend('ptsOriginal', 'ptsDistorted');

%% colormap
% I = imread('/Users/yok/Downloads/boneage-training-dataset/1378.png');
% I = imread('/Users/yok/Documents/MATLAB/DigitalImageProcessing/boneage/dataset3/4365.png');
% I = imread('/Users/yok/Downloads/boneage-test-dataset/4365.png');
I = histeq(J, 64);
y = colormap(parula(250));
imwrite(I, y, 'rgb.jpg', 'jpg');
imshow('rgb.jpg');
% J = histeq(I, 64);
% figure; imshow(J);

%% I1
I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
se = strel('disk', 15);
background = imopen(I,se);
imshow(background);
I = I - background;
imshow(I);
I = imadjust(I);
imshow(I);
bw1 = imbinarize(I);
bw1 = bwareaopen(bw1,50);
imshow(bw1);
% Identify objects
cc1 = bwconncomp(bw1,26);
bone1 = false(size(bw1));
% area
bonedata1 = regionprops(cc1,'basic');
bone_area1 = [bonedata1.Area];
figure; 
h1 = histogram(bone_area1);
title('histogram of bone area ---- 1');
% figure; 
% for i = 1:cc.NumObjects
%     bone(cc.PixelIdxList{i}) = true;
%     imshow(bone);
% end
% I2
K = imread('/Users/yok/Downloads/boneage-training-dataset/1378.png');
background = imopen(K,se);
figure; imshow(background);
K = K - background;
imshow(K);
K = imadjust(K);
imshow(K);
bw2 = imbinarize(K);
bw2 = bwareaopen(bw2,50);
imshow(bw2);
% Identify objects
cc2 = bwconncomp(bw2,26);
bone2 = false(size(bw2));
%I3
L = imread('/Users/yok/Downloads/boneage-training-dataset/1396.png');
se = strel('disk', 15);
background = imopen(L,se);
imshow(background);
L = L - background;
imshow(L);
L = imadjust(L);
imshow(L);
bw3 = imbinarize(L);
bw3 = bwareaopen(bw3,50);
imshow(bw3);
% Identify objects
cc3 = bwconncomp(bw3,26);
bone3 = false(size(bw3));
% area
bonedata3 = regionprops(cc3,'basic');
bone_area3 = [bonedata3.Area];
figure; 
h3 = histogram(bone_area3);
title('histogram of bone area ---- 1');
%%%
bonedata2 = regionprops(cc2,'basic');
bone_area2 = [bonedata2.Area];
figure; 
h2 = histogram(bone_area2);
title('histogram of bone area ---- 2');
% similarity = 1 - norm();
I3 = imadjust(J);
imshow(I3);
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
imshow(bw);
figure; imhist(bw);
files = dir(pwd);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
% Print folder names to command window.
for k = 1 : length(subFolders)
  fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
end
%%
point1 = detectSURFFeatures(J);
point2 = detectSURFFeatures(K);
[feature1, valid_point1] = extractFeatures(J, point1); 
[feature2, valid_point2] = extractFeatures(K, point2); 
% figure; imshow(J); title('1'); hold on;
% plot(valid_points.selectStrongest(10),'showOrientation',true);
% points = detectHarrisFeatures(J);
% [features, valid_corners] = extractFeatures(I, points); 
% figure; imshow(J); title('2'); hold on;
% plot(valid_corners);
% points = detectHarrisFeatures(J);
% [features, valid_corners] = extractFeatures(I, points); 
figure; imshow(J); title('J'); hold on;
plot(valid_point1,'showOrientation',true);
figure; imshow(K); title('K'); hold on;
plot(valid_point2,'showOrientation',true);
%% match
indexpairs = matchFeatures(feature1, feature2);
matchedPoints1 = valid_point1(indexpairs(:,1));
matchedPoints2 = valid_point2(indexpairs(:,2));
figure; showMatchedFeatures(J,K,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');
%%
I = imread('4360.png');
se = strel(eye(5));
nhood = getnhood(se);

%% LBP
featuresI = extractLBPFeatures(I,'Upright',false);
featuresK = extractLBPFeatures(K,'Upright',false);
featuresL = extractLBPFeatures(L,'Upright',false);

compare1 = (featuresI-featuresK).^2;
compare2 = (featuresI-featuresL).^2;
figure;
bar([compare1;compare2]','grouped');
title('Squared error');
xlabel('# Bins');
legend('compare1','compare2');

%% Euclidien Distance
[row,column] = size(featuresI);
d1 = 0; d2 = 0; d3 = 0; d4 = 0;d5 = 0;
for i=1:column
    d1 = d1 + ((featuresI(i) - featuresK(i))^2);
    d2 = d2 + ((featuresK(i) - featuresI(i))^2);
    d3 = d3 + ((featuresI(i) - featuresL(i))^2);
    d4 = d4 + ((featuresL(i) - featuresI(i))^2);
    d5 = d5 + ((featuresL(i) - featuresL(i))^2);
end
d1 = sqrt(d1);
d2 = sqrt(d2);
d3 = sqrt(d3);
d4 = sqrt(d4);
d5 = sqrt(d5);

%% CNN
path = '/Users/yok/Downloads/boneage-training-dataset/';
categories = {1:228};
imds = imageDatastore(fullfile(path,categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds);

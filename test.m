% read image
% I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
%I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
I = imread('4360.png');
% I = imresize(I,0.5);
imshow(I);

% adjust contrast
J = histeq(I, 64);
figure; imshow(J);

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

% %% Edge detection
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

%%
I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
se = strel('disk', 15);
background = imopen(I,se);
imshow(background);
I2 = I - background;
imshow(I2);
I3 = imadjust(I2);
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
points = detectSURFFeatures(J);
[features, valid_points] = extractFeatures(I, points); 
figure; imshow(J); hold on;
plot(valid_points.selectStrongest(10),'showOrientation',true);
points = detectHarrisFeatures(J);
[features, valid_corners] = extractFeatures(I, points); 
figure; imshow(J); hold on;
plot(valid_corners);
points = detectHarrisFeatures(J);
[features, valid_corners] = extractFeatures(I, points); 
figure; imshow(J); hold on;
plot(valid_points,'showOrientation',true);
%%
I = imread('4360.png');
se = strel(eye(5));
nhood = getnhood(se);
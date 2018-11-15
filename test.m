I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
% imshow(I);

J = imadjust(I);
% figure; imshow(J);

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
E = entropyfilt(J);
Eim = rescale(E);
% figure; imshow(Eim); 
BW1 = imbinarize(Eim, .8);
figure; imshow(BW1); title('BW1');

% %% Edge detection
% [~, threshold] = edge(J, 'sobel');
% fudgeFactor = .5;
% BWs = edge(I,'sobel', threshold * fudgeFactor);
% figure, imshow(BWs), title('binary gradient mask');
% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 0);
% BWsdil = imdilate(BWs, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');
% Kmedian = medfilt2(BWsdil);
% figure; imshow(Kmedian);

%% graythresh
% level = graythresh(I);
% BW = imbinarize(I,level);
% figure; imshowpair(I,BW,'montage');

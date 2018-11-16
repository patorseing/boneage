% read image
%I = imread('/Users/yok/Downloads/boneage-training-dataset/1377.png');
I = imread('.png');
% I = imresize(I,0.5);
imshow(I);

% adjust contrast
J = histeq(I, 64);
figure; imshow(J);

% convert to bw
img = im2bw(J, 0.6);
figure; imshow(img);

% mask
se = strel('disk',10);
mask = imopen(img,se);
mask = imresize(mask, 0.25);
J = imresize(J, 0.25);
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

close all
pwd
mkdir newdir
cd newdir
imwrite(J, 'a.png');

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
a = [4360 180 true;4360 180 false];
dlmwrite('myFile.csv',a,'-append','delimiter',',','roffset',0)
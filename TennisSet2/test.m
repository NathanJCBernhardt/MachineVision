
clc
clear all
close all
bThreshold = 0.92;
dThreshold = 0.38;

A = imread('stennis.82.ppm');

figure
imshow(A)
set(gca, 'visible', 'on')

new = rgb2gray(A);
figure
imshow(new)

dnew = im2double(new);
figure
imshow(dnew)

gaussianImg = imgaussfilt(dnew, 1.2);

BrightBlobs = gaussianImg > bThreshold;
for i = 1:240
    for j = 1:110
        BrightBlobs(i,j) = 0; 
    end
end
labeledBright = bwlabel(BrightBlobs);
brightMeasurements = regionprops(labeledBright, 'Area', 'Perimeter');
DarkBlobs =  gaussianImg < dThreshold; 
labeledDark = bwlabel(DarkBlobs);
darkMeasurements = regionprops(labeledDark, 'Area', 'Perimeter');

[r,c] = find(labeledDark==2);
rc = [r c];

bat = gaussianImg;
bat = zeros(size(bat));
for i = 1:size(rc)
    bat(rc(i,1),rc(i,2)) = 1;
end

ball = gaussianImg;
ball = zeros(size(ball));
[r,c] = find(labeledBright==1);
rc = [r c];
for i = 1:size(rc)
    ball(rc(i,1),rc(i,2)) = 1;
end

figure
imshow(ball)

binaryBat = imbinarize(bat,0.6);
binaryBall = imbinarize(ball, 0.6);

figure
imshowpair(BrightBlobs, binaryBall, 'montage')

ballAreaAndPerim = brightMeasurements(1);
batAreaAndPerim = darkMeasurements(2);




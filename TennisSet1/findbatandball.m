function batandball = findbatandball(img)
bThreshold = 0.9;
dThreshold = 0.42;

A = img;
%figure
%imshow(A);
new = rgb2gray(A);

dnew = im2double(new);

gaussianImg = imgaussfilt(dnew, 2);

BrightBlobs = gaussianImg > bThreshold;
labeledBright = bwlabel(BrightBlobs);
brightMeasurements = regionprops(labeledBright, 'Area', 'centroid');
DarkBlobs =  gaussianImg < dThreshold; 
labeledDark = bwlabel(DarkBlobs);
darkMeasurements = regionprops(labeledDark, 'Area', 'centroid');

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

binaryBat = imbinarize(bat,0.6);
binaryBall = imbinarize(ball, 0.6);

%figure
imshow(binaryBat);

ballAreaAndCent = brightMeasurements(1);
batAreaAndCent = darkMeasurements(2);

batandball = struct('ball',{binaryBall}, 'bat',{binaryBat}, 'ballCentroid',{ballAreaAndCent}, 'batCentroid',{batAreaAndCent});

end


function batandball = findbatandball(img, count)
bThreshold = 0.86;
dThreshold = 0.4;

A = img;
%imshow(A);
%set(gca, 'visible', 'on')

new = rgb2gray(A);

dnew = im2double(new);


if (count < 78)
gaussianImg = imgaussfilt(dnew, 1.2);
BrightBlobs = gaussianImg > bThreshold;
    for i = 1:240
        for j = 1:110
            BrightBlobs(i,j) = 0;
        end
    end
else
bThreshold = 0.7;
gaussianImg = imgaussfilt(dnew, 0.1);
BrightBlobs = gaussianImg > bThreshold;

     for i = 1:126
        for j = 1:352
            BrightBlobs(i,j) = 0;
        end
     end
      for i = 175:240
        for j = 1:352
            BrightBlobs(i,j) = 0;
        end
      end
     for i = 1:240
        for j = 190:352
            BrightBlobs(i,j) = 0;
        end
     end

   

end

labeledBright = bwlabel(BrightBlobs);
brightMeasurements = regionprops(labeledBright, 'Area', 'centroid');
tcount = 0;

if (count < 78)
for i = 1:length(brightMeasurements)
    tcount = tcount + 1;
    if(brightMeasurements(tcount,1).Area > 195)
       brightMeasurements(tcount) = [];
       tcount = tcount - 1;
       
    end
end
else
   
    for i = 1:length(brightMeasurements)
    tcount = tcount + 1;
    if(brightMeasurements(tcount,1).Area > 100)
       brightMeasurements(tcount) = [];
       tcount = tcount - 1;
       
    end
    end
end

%disp(brightMeasurements);
if (count < 32)
    gaussianImg = imgaussfilt(dnew, 2);
    gaussianImg = medfilt2(gaussianImg);
else
    gaussianImg = imgaussfilt(dnew, 2);
    gaussianImg = medfilt2(gaussianImg);
    dThreshold = 0.25;
    
end
DarkBlobs =  gaussianImg < dThreshold; 

for i = 1:240
    for j = 1:116
        DarkBlobs(i,j) = 0;
    end
end

for i = 1:240
    for j = 228:352
        DarkBlobs(i,j) = 0;
    end
end

for i = 175:240
    for j = 1:352
        DarkBlobs(i,j) = 0;
    end
end


labeledDark = bwlabel(DarkBlobs);
darkMeasurements = regionprops(labeledDark, 'Area', 'centroid');

kcount = 0;
x =1;
while (x == 1)
    kcount = kcount + 1;
    [r,c] = find(labeledDark==kcount);
    rc = [r c];
    if (darkMeasurements(kcount).Area < 800)
        
        x = 2;
    end
end

bat = gaussianImg;
bat = zeros(size(bat));
for i = 1:size(rc)
    bat(rc(i,1),rc(i,2)) = 1;
    
end

ball = gaussianImg;
ball = zeros(size(ball));
l = 1;
vcount = 0;
if(count < 78)
while l==1
vcount = vcount + 1;
[r,c] = find(labeledBright==vcount);
rc = [r c];
if brightMeasurements(vcount).Centroid(1,1) > 130 && brightMeasurements(vcount).Centroid(1,2) > 10
    l = 2;
end
end
else
    [r,c] = find(labeledBright==2);
    rc = [r c];
    
end


for i = 1:size(rc)
    ball(rc(i,1),rc(i,2)) = 1;
end

binaryBat = imbinarize(bat,0.6);
binaryBall = imbinarize(ball, 0.6);

imshowpair(A, DarkBlobs);
set(gca, 'visible', 'on')

ballAreaAndCent = brightMeasurements(vcount);
batAreaAndCent = darkMeasurements(kcount);
%disp(batAreaAndCent.Area);


batandball = struct('ball',{binaryBall}, 'bat',{binaryBat}, 'ballCentroid',{ballAreaAndCent}, 'batCentroid',{batAreaAndCent});

end


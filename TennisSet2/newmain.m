clc
clear all
close all
count = 20;
scount = 0;
for i = 21:87
    count = count + 1;
    scount = scount + 1;

    filename = "stennis." + i + ".ppm";
    file = imread(filename);
    k =  findbatandball(file, scount);
    images(scount) = k;
    centroids(scount) = images(scount).ballCentroid;
    batcentroids(scount) = images(scount).batCentroid;
end

for i = 1:67
   % hold on
    %plot(batCentroids(i).Centroid(1), batCentroids(i).Centroid(2), 'o')
    %hold off
end

count = 0;
for i = 1:66
    count = count + 1;
if(centroids(i).Centroid(2) > 235 || centroids(i).Centroid(2) < 35)
    total = 1 + 2;
else
    diffx = centroids(i).Centroid(1) -  centroids(i+1).Centroid(1);
    diffy = centroids(i).Centroid(2) -  centroids(i+1).Centroid(2);
    total = abs(diffx) + abs(diffy);
end
totals(count) = total;
individualVelocities(count) = total/0.0925757575758;
end

newcount = 0;
for i = 1:66
    newcount = newcount + 1;
    diffx = batcentroids(i).Centroid(1) -  batcentroids(i+1).Centroid(1);
    diffy = batcentroids(i).Centroid(2) -  batcentroids(i+1).Centroid(2);
    total = abs(diffx) + abs(diffy);
   
    battotals(i) = total;
    BatVelocities(i) = total / 0.0925757575758;
end

BatVelocities = transpose(BatVelocities);
disp(BatVelocities);
disp(mean(BatVelocities));
summ = sum(total);
vel = summ / 6.11;
disp(vel);

figure
for i = 1:67

    hold on
    plot(batcentroids(i).Centroid(1), batcentroids(i).Centroid(2), 'o');
    if (i < 67)
    text(batcentroids(i).Centroid(1), batcentroids(i).Centroid(2), string(BatVelocities(i)));
    end
    hold off
end



%disp(totals);
tot = sum(totals);
individualVelocities = transpose(individualVelocities);
%disp(tot);

velocity = tot / 6.11;
%disp(individualVelocities);
%disp(mean(individualVelocities));
%disp(velocity);
%figure
dcount = 0;
for i = 1:67
    dcount = dcount + 1;
if(centroids(i).Centroid(2) > 235)
    %do nothing
else
    %hold on
    %plot(centroids(i).Centroid(1), centroids(i).Centroid(2), 'o');
    %if (i < 67)
    %text(centroids(i).Centroid(1), centroids(i).Centroid(2), string(individualVelocities(dcount)));
    %end
    %hold off
end

end

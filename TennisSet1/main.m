clc
clear all
close all



for i = 1:21
    count = i - 1;
    filename = "stennis." + count + ".ppm";
    file = imread(filename);
    k =  findbatandball(file);
    images(i) = k;
    centroids(i) = images(i).ballCentroid;
    batcentroids(i) = images(i).batCentroid;
end


for i = 1:20
diffx = centroids(i).Centroid(1) -  centroids(i+1).Centroid(1);
diffy = centroids(i).Centroid(2) -  centroids(i+1).Centroid(2);

total = abs(diffx) + abs(diffy);
totals(i) = total;
individualVelocities(i) = total/0.0604761904762;
end

figure
for i = 1:21
%disp(centroids(i).Centroid);
hold on
plot(centroids(i).Centroid(1), centroids(i).Centroid(2), 'o');
if (i < 21)
text(centroids(i).Centroid(1), centroids(i).Centroid(2), string(individualVelocities(i)));
end
hold off
end


tot = sum(totals);
%disp(tot);
velocity = tot / 1.27;

%disp(mean(individualVelocities));
%disp(velocity);

%disp(individualVelocities);
%disp(batcentroids);

for i = 1:20
diffx = batcentroids(i).Centroid(1) -  batcentroids(i+1).Centroid(1);
diffy = batcentroids(i).Centroid(2) -  batcentroids(i+1).Centroid(2);

battotal = abs(diffx) + abs(diffy);
%disp(battotal);
battotals(i) = battotal;
batindividualVelocities(i) = battotal/0.0604761904762;
end

figure
for i = 1:21
disp(batcentroids(i).Centroid);
hold on
plot(batcentroids(i).Centroid(1), batcentroids(i).Centroid(2), 'o');
if (i < 21)
text(batcentroids(i).Centroid(1), batcentroids(i).Centroid(2), string(batindividualVelocities(i)));
end
hold off
end
%disp(battotals);
tot = sum(battotals);
%disp(tot);
velocity = tot / 1.27;

disp(batindividualVelocities);
%disp(mean(batindividualVelocities));
%disp(velocity)



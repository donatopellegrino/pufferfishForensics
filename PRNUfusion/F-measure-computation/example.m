clear all; close all;


% Open the example ground truth tampering map
map_gt=double(imread('map.BMP'));
subplot(1,2,1); imshow(map_gt);

% Simulate an estimated tampering map
map_est = rem(map_gt+round(rand(size(map_gt))-0.4),2);
subplot(1,2,2); imshow(map_est);

% Compute F-measure

[F] = f_measure(map_gt,map_est);





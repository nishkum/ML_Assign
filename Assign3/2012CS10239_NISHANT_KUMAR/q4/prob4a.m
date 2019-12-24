clear;
clc;

m = 2429;

aver = zeros(19,19);
for i=1:m
    temp = double(imread(strcat('./q5_data/face',sprintf('%05d',i) ,'.pgm')));
    aver = aver + temp;
end
aver = aver/2429;

imshow(uint8(aver));
imwrite(uint8(aver),'./output/average.pgm');
imwrite(uint8(aver),'./output/average.jpg');
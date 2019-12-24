function visualize(var,exn)
% var is the whole struct digitdata .. find the pixel values and pixel
% number from this struct ... 
% Example usage - visualize(data{the whole struct}, 10)

% First find the pixel numbers present in the data
pixelStr = var.textdata{1};
pixelNum = str2double(regexp(pixelStr, '[0-9]+', 'match'));

pdata = var.data(exn,:);
pfdata = zeros(1,784);

assert(size(pdata,2) == 157);
assert(size(pixelNum,2) == 157);

% Now just fill pfdata with pdata with indices specified in pixelNum
for i=1:157
    pfdata(pixelNum(i)) = pdata(i);
end

% Convert the pixel data into a matrix of dim - 28*28
pixels = reshape(pfdata,[28,28])';
% Show the image
imshow(pixels)

end
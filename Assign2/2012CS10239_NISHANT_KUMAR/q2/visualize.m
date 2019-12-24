function visualize(var,exn)
% The input is the variable and the example number
% Example usage: visualize(test0,44)

data = var(exn,:);

% Assert that the linear data provided is infact a 1*784 vector
assert(size(data,1)==1);
assert(size(data,2)==784);
% Convert the pixel data into a matrix of dim - 28*28
pixels = reshape(data,[28,28])';
% Show the image
imshow(pixels)

end
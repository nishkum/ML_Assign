function [th1, th2] = stoc_grd(thInit1, thInit2, eps, datanew)
% thInit1 and thInit2 - the initial thetas for the 2 layers - the input and
% the hidden layer
% eps - the value of eps to break the loop
% datanew - the data from which to choose the examples

[~, ~] = size(thInit1);
[s3, ~] = size(thInit2);
numOutp = s3;
[m,~] = size(datanew);

thIter1 = thInit1;
thIter2 = thInit2;
curJth = 0;
prevJth = -100;
iterationNum = 1;

while(abs(curJth - prevJth)>=eps)
% while(iterationNum<=15*m)
    for exampleNum=1:m
        lRate = 1/(iterationNum^0.5);

        % Select a training example - assume its in datanew
        dataEx = datanew(exampleNum,:);
        trainY = (dataEx(1:numOutp)');
        trainX = ([1 dataEx(numOutp+1:size(dataEx,2))]');

        [out1, out2, out3] = findOutput(thIter1, thIter2, trainX);

        % Now use backpropagation to find all the gradients
        % Assume its grdth1, grdth2
        del3 = (trainY - out3).*out3.*(1-out3);
        del2Temp = out2.*(1-out2).*(del3'*thIter2)';
        del2 = del2Temp(2:size(del2Temp,1));
        grdth1 = (-del2)*(out1');
        grdth2 = (-del3)*(out2');

        % Update thetas, update curJth, prevJth, iterationNum
        thIter1 = thIter1 - lRate.*grdth1;
        thIter2 = thIter2 - lRate.*grdth2;
        iterationNum = iterationNum + 1;
    end
    prevJth = curJth;
    curJth = 0;
    for exampleNum=1:m
        % Select a training example - assume its in datanew
        dataEx = datanew(exampleNum,:);
        trainY = (dataEx(1:numOutp)');
        trainX = ([1 dataEx(numOutp+1:size(dataEx,2))]');
        
        [~, ~, out3] = findOutput(thIter1, thIter2, trainX);
        temp = trainY-out3;
        curJth = curJth + 0.5*(temp'*temp);
    end
    curJth = curJth/m;
end

th1 = thIter1;
th2 = thIter2;

end
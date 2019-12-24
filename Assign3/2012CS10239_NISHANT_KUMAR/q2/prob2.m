clear;
clc;

digitdata = importdata('digitdata.txt');
digitlabels = importdata('digitlabels.txt');
xdata = digitdata.data;
xlabels = digitlabels.data;
[m,n] = size(xdata);
k = 4;

% Implement k-means on xdata with k=4
centroids = zeros(k,n);
assign = zeros(m,1);
prevS = -100;
curS = 0;
eps = 1e-4;

% Initialize the centroids randomly
for i=1:k
    centroids(i,:) = xdata(randi(m),:);
end

plotx = [];
plotSy = [];
plotErry = [];

% Start k-means algo
iter = 1;
while((iter<=30) && (abs(curS-prevS)>=eps))
    % Calculate the assignments
    for i=1:m
        minInd = -1;
        minVal = Inf;
        for j=1:k
            temp = xdata(i,:)-centroids(j,:);
            temp = temp*temp'; % temp is a row vector
            if (minVal > temp)
                minVal = temp;
                minInd = j;
            end
        end
        assert(~(minInd == -1));
        assign(i) = minInd;
    end
    
    % All assigments done - recalculate the centroids
    for j=1:k
        cdata = xdata(assign == j,:);
        centroids(j,:) = sum(cdata)/size(cdata,1);
    end
    
    % Find the currentS
    prevS = curS;
    curS = 0;
    for i=1:m
        temp = (xdata(i,:) - centroids(assign(i),:));
        curS = curS + temp*temp';
    end
    
    if iter<=20
        plotx = [plotx iter];
        plotSy = [plotSy log(curS)];
        % Now calculate plotErry
        ptemp = 0;
        for j=1:k
            clabels = xlabels(assign==j);
            % Now find the most occuring cluster
            temp = [1 3 5 7];
            maxFreq = -1;
            maxFreqLab = -1;
            for lab=1:4
                temp1 = sum(clabels == temp(lab));
                if (temp1 > maxFreq)
                    maxFreq = temp1;
                    maxFreqLab = temp(lab);
                end
            end
            ptemp = ptemp + sum(~(clabels==maxFreqLab));
        end
        plotErry = [plotErry ptemp/m];
    end
    iter = iter+1;
end

if iter==31
    fprintf('Number of iterations = %d\n', 30);
else
    fprintf('Number of iterations = %d\n', iter);
end
fprintf('Current Value of log(S) = %.5f\n', log(curS));

plot(plotx, plotSy);
xlabel('Iteration Number');
ylabel('log of current S');

figure;
plot(plotx, plotErry);
xlabel('Iteration Number');
ylabel('Mis-classified Examples/TotalExamples');

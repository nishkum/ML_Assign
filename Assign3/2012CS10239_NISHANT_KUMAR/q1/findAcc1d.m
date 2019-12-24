function testacc = findAcc1d(phiClass, phiMult, testdata, numclasses)

   testDim = size(testdata);

   % Now predict on testdata
   testSize = size(testdata,1);
   testActualLabels = testdata(:,1);
   toTestData = testdata(:,2:testDim(2));
   
   predictMatrix = zeros(testSize,1);
   for i=1:testSize
       curTestData = toTestData(i,:);
       tillNowMaxInd = -1;
       tillNowMaxValue = Inf; % Since using -log()
       for j=1:numclasses
            % Find log(p(y==j|i))
            curEstimate = 0;
            for k=1:testDim(2)-1
                if curTestData(k)==0
                    break
                end
                % add log(P(x_j|y==j))
                curEstimate = curEstimate + phiMult(j, curTestData(k));
            end
            curEstimate = curEstimate + phiClass(j);
            % Since using -log()
            if (curEstimate < tillNowMaxValue)
                tillNowMaxValue = curEstimate;
                tillNowMaxInd = j;
            end
       end
       predictMatrix(i) = tillNowMaxInd;
   end
   
   testacc = sum(predictMatrix == testActualLabels)/testSize;


end
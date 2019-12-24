function [trainacc, testacc] = traintestAcc1d(traindata, testdata, vocabSize, numclasses)
   
   classlabels = traindata(:,1);
   m = size(classlabels, 1);
   
   trainDim = size(traindata);
   
   % Remember this has log of apt paras
   phiClass = zeros(numclasses,1);
   for i=1:numclasses
       % Since using -log()
       phiClass(i) = -(log(sum(classlabels==i))-log(m));
   end
   
   % Remember this has log of apt paras
   phiMult = zeros(numclasses, vocabSize);
   
   for i=1:m
       for j=2:trainDim(2)
           if (traindata(i,j)==0)
               break
           end
           phiMult(traindata(i,1), traindata(i,j)) = phiMult(traindata(i,1), traindata(i,j)) + 1;
       end
   end
   
   for i=1:numclasses
       curData = traindata(classlabels==i,2:trainDim(2));
       totWords = sum(sum(curData>0));
       % Since using -log()
       phiMult(i,:) = -log(phiMult(i,:)+1) + log(totWords + vocabSize);
   end
   
   testacc = findAcc1d(phiClass, phiMult, testdata, numclasses);
   trainacc = findAcc1d(phiClass, phiMult, traindata, numclasses);
   
end
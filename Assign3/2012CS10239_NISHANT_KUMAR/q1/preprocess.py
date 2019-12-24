import sys
import random as rand

#arg1 - Input file - 20ng-rec_talk.txt
#Output files - ?

if (len(sys.argv) < 2):
	print "Incorrect number of arguments.\n"
	exit(1)

N = 5 # Perform N-fold cross validation
forig = open(sys.argv[1],"r")
lines = forig.readlines()
rand.shuffle(lines)

# now lines is the whole file shuffled
# now build the vocab and change the lines into vectors

#############################
# Important: The vocab is built using the whole data and not the 4/5 of the data which will be the training data
# This makes sense because the vocab is global and not dependent on the train data
#############################


linesProcess = []
vocab = {}
classMap = {}
for eline in lines:
	arr = eline.split()
	featureVec = []
	for i,word in enumerate(arr):
		if i==0:
			# this is the class
			if word not in classMap:
				classMap[word] = len(classMap)
			# add 1 so that the class numbers start from 1 onwards .. 
			featureVec.append(classMap[word]+1)
		else:
			# this is a normal word
			if word not in vocab:
				vocab[word] = len(vocab)
			# add 1 so that the class numbers start from 1 onwards .. 
			featureVec.append(vocab[word]+1)
	linesProcess.append(featureVec)


# write down the vocabSize and classSize in a file
fvocab = open('vocab.dat','w')
fvocab.write(str(len(vocab))+'\n')
fvocab.write(str(len(classMap))+'\n')
fvocab.close()

fclasses = open('classLabels.txt','w')
arr = []
for k in classMap:
	arr.append([classMap[k]+1,k])

arr.sort()
for k in arr:
	fclasses.write(str(k[0])+' '+k[1]+'\n')
fclasses.close()

# now divide the file in N equal parts

lenEachpart = len(linesProcess)/N
subParts = []
for k in xrange(N):
	subParts.append(linesProcess[lenEachpart*k : lenEachpart*(k+1)])

# now subParts has the N parts of original shuffled file

for k in xrange(N):
	# open a train and test file for each k
	ftest = open('test_'+str(k)+'.dat','w')
	ftrain = open('train_'+str(k)+'.dat','w')

	for i in xrange(N):
		# leave the k-th part for test and rest for train
		if i==k:
			# use for test
			for l in subParts[i]:
				for num in l:
					ftest.write('%d,' % num)
				ftest.write('\n')
		else:
			# combine for train data
			for l in subParts[i]:
				for num in l:
					ftrain.write('%d,' % num)
				ftrain.write('\n')

	ftest.close()
	ftrain.close()

forig.close()
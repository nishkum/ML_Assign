import sys

#arg1 - Input file - the training file
#Output files - features.txt,[arg1]_cvx.txt,[arg1]_libsvm.txt

if (len(sys.argv) < 2):
	print "Incorrect number of arguments.\n"
	exit(1)

forig = open(sys.argv[1],"r")
# allwords is a list containing all the input words
# allwordsIndex contains the index of the word in allwords
# numFeatures is just the current number of features
allwords = []
allwordsIndex = {}
numFeatures = 0
for line in forig:
	arr = line.split()
	for i,st in enumerate(arr):
		if i<=1: continue #First 2 words are useless
		elif (i%2==0) and (st not in allwords): # if i is even
			allwords += [st]
			allwordsIndex[st] = numFeatures
			numFeatures+=1
forig.close()


# Write down allwords in the file features.txt
ffeature = open(sys.argv[1]+"_features.txt",'w')
for k in allwords:
	ffeature.write("%s\n" % k)
ffeature.close()

# allwords , allwordsIndex and numFeatures are passed on..
# Again reopen the train file to create the processed train file
forig = open(sys.argv[1],"r")
fcvx = open(sys.argv[1]+'_cvx.txt','w')
flsvm = open(sys.argv[1]+'_libsvm.txt','w')
for line in forig:
	arr = line.split()
	tempwords = [0]*numFeatures
	for i,st in enumerate(arr):
		if (i<=1): continue
		elif (i%2==0):
			tempwords[allwordsIndex[st]] = int(arr[i+1])
	if arr[1]=='ham':
		# -1 for ham
		fcvx.write('-1 ')
		flsvm.write('-1 ')
	else:
		# +1 for spam
		fcvx.write('1 ')
		flsvm.write('1 ')
	for i,v in enumerate(tempwords):
		fcvx.write(str(v)+' ')
		flsvm.write(str(i+1)+':'+str(v)+' ')
	fcvx.write('\n')
	flsvm.write('\n')

forig.close()
fcvx.close()
flsvm.close()
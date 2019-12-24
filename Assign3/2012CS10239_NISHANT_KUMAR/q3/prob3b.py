from __future__ import division
import sys,math,copy
import pprint as pp
import matplotlib.pyplot as plt

cptD = [[0,0]]
cptI = [[0,0]]
cptG = [[0,0,0] for x in xrange(4)]
cptS = [[0,0] for x in xrange(2)]
cptL = [[0,0] for x in xrange(3)]
eps = 1.0e-4
smooth = 0.01

def findMaxDiff(a,b):
	maxdiff = -1
	for i,row in enumerate(a):
		for j,val in enumerate(row):
			maxdiff = max(maxdiff,abs(val-b[i][j]))
	return maxdiff


def output(dlist):
	for row in dlist:
		for val in row:
			sys.stdout.write('%-5.5f\t' % val)
		sys.stdout.write('\n')
	sys.stdout.write('\n')


def findTestLikelihood():
	global cptD,cptI,cptG,cptS,cptL
	# Calculate the math.log likelihood of test data
	fidtest = open('./q3_data/test.data')
	testlines = fidtest.readlines()
	logli = 0.0
	for l in testlines:
		arr = map(int,l.split())
		logli += math.log(cptD[0][arr[0]])
		logli += math.log(cptI[0][arr[1]])
		logli += math.log(cptG[ arr[1]*2 + arr[0] ][arr[2]-1])
		logli += math.log(cptS[arr[1]][arr[3]])
		logli += math.log(cptL[arr[2]-1][arr[4]])
	fidtest.close()
	return logli


def findJtDist(values):
	global cptD,cptI,cptG,cptS,cptL
	# values has the value of the 5 variables
	# find the joint probability of the 5 variables using the CPT
	[d,i,g,s,l] = values
	return cptD[0][d]*cptI[0][i]*cptG[i*2 + d][g-1] *cptS[i][s]*cptL[g-1][l]


def initParas(completeData):
	global cptD,cptI,cptG,cptS,cptL
	
	diff = [0,0,0]
	intel = [0,0,0]
	grade = [[0,0,0,0] for x in xrange(4)]
	sat = [[0,0,0] for x in xrange(2)]
	letter = [[0,0,0] for x in xrange(3)]

	for arr in completeData:
		# use arr to fill in the CPT
		if (arr[0]!=-1):
			diff[arr[0]] += 1
			diff[2] += 1

		if (arr[1]!=-1):
			intel[arr[1]] += 1
			intel[2] += 1

		# grade[binary(i,d)][.]
		# Remember grade is 1 indexed
		if (arr[0]!=-1) and (arr[1]!=-1) and (arr[2]!=-1):
			grade[arr[1]*2 + arr[0]][arr[2]-1] += 1
			grade[arr[1]*2 + arr[0]][3] += 1

		# sat[i][.]
		if (arr[1]!=-1) and (arr[3]!=-1):
			sat[arr[1]][arr[3]] += 1
			sat[arr[1]][2] += 1

		# letter[grade][.]
		# Remember grade is 1 indexed
		if (arr[2]!=-1) and (arr[4]!=-1):
			letter[arr[2]-1][arr[4]] += 1
			letter[arr[2]-1][2] += 1

	tcptD = [[(diff[0]+smooth)*1.0/(diff[2]+2*smooth),(diff[1]+smooth)*1.0/(diff[2]+2*smooth)]]
	tcptI = [[(intel[0]+1*smooth)*1.0/(intel[2]+2*smooth),(intel[1]+1*smooth)*1.0/(intel[2]+2*smooth)]]
	tcptG = [[(r[0]+1*smooth)*1.0/(r[3]+3*smooth),(r[1]+1*smooth)*1.0/(r[3]+3*smooth),(r[2]+1*smooth)*1.0/(r[3]+3*smooth)] for r in grade]
	tcptS = [[(r[0]+1*smooth)*1.0/(r[2]+2*smooth),(r[1]+1*smooth)*1.0/(r[2]+2*smooth)] for r in sat]
	tcptL = [[(r[0]+1*smooth)*1.0/(r[2]+2*smooth),(r[1]+1*smooth)*1.0/(r[2]+2*smooth)] for r in letter]

	maxdiff = max(findMaxDiff(tcptD,cptD),findMaxDiff(tcptI,cptI),findMaxDiff(tcptG,cptG),findMaxDiff(tcptS,cptS),findMaxDiff(tcptL,cptL))

	cptD = tcptD
	cptI = tcptI
	cptG = tcptG
	cptS = tcptS
	cptL = tcptL

	return maxdiff



def computeParas(fullData,missingData):
	global cptD,cptI,cptG,cptS,cptL
	
	diff = [0,0,0]
	intel = [0,0,0]
	grade = [[0,0,0,0] for x in xrange(4)]
	sat = [[0,0,0] for x in xrange(2)]
	letter = [[0,0,0] for x in xrange(3)]

	for arr in fullData:
		# use arr to fill in the CPT
		diff[arr[0]] += 1
		diff[2] += 1

		intel[arr[1]] += 1
		intel[2] += 1

		# grade[binary(i,d)][.]
		# Remember grade is 1 indexed
		grade[arr[1]*2 + arr[0]][arr[2]-1] += 1
		grade[arr[1]*2 + arr[0]][3] += 1

		# sat[i][.]
		sat[arr[1]][arr[3]] += 1
		sat[arr[1]][2] += 1

		# letter[grade][.]
		# Remember grade is 1 indexed
		letter[arr[2]-1][arr[4]] += 1
		letter[arr[2]-1][2] += 1

	for arr in missingData[0]:
		diff[0] += arr[0][0]
		diff[1] += arr[0][1]
		diff[2] += 1

	for arr in missingData[1]:
		intel[0] += arr[1][0]
		intel[1] += arr[1][1]
		intel[2] += 1

	for arr in missingData[2]:
		grade[arr[1]*2 + arr[0]][0] += arr[2][0]
		grade[arr[1]*2 + arr[0]][1] += arr[2][1]
		grade[arr[1]*2 + arr[0]][2] += arr[2][2]
		grade[arr[1]*2 + arr[0]][3] += 1

	for arr in missingData[3]:
		sat[arr[1]][0] += arr[3][0]
		sat[arr[1]][1] += arr[3][1]
		sat[arr[1]][2] += 1

	for arr in missingData[4]:
		letter[arr[2]-1][0] += arr[4][0]
		letter[arr[2]-1][1] += arr[4][1]
		letter[arr[2]-1][2] += 1

	tcptD = [[(diff[0]+smooth)*1.0/(diff[2]+2*smooth),(diff[1]+smooth)*1.0/(diff[2]+2*smooth)]]
	tcptI = [[(intel[0]+1*smooth)*1.0/(intel[2]+2*smooth),(intel[1]+1*smooth)*1.0/(intel[2]+2*smooth)]]
	tcptG = [[(r[0]+1*smooth)*1.0/(r[3]+3*smooth),(r[1]+1*smooth)*1.0/(r[3]+3*smooth),(r[2]+1*smooth)*1.0/(r[3]+3*smooth)] for r in grade]
	tcptS = [[(r[0]+1*smooth)*1.0/(r[2]+2*smooth),(r[1]+1*smooth)*1.0/(r[2]+2*smooth)] for r in sat]
	tcptL = [[(r[0]+1*smooth)*1.0/(r[2]+2*smooth),(r[1]+1*smooth)*1.0/(r[2]+2*smooth)] for r in letter]

	maxdiff = max(findMaxDiff(tcptD,cptD),findMaxDiff(tcptI,cptI),findMaxDiff(tcptG,cptG),findMaxDiff(tcptS,cptS),findMaxDiff(tcptL,cptL))

	cptD = tcptD
	cptI = tcptI
	cptG = tcptG
	cptS = tcptS
	cptL = tcptL

	return maxdiff


def runEM(filename):
	global cptD,cptI,cptG,cptS,cptL
	# filename will correspond to various data files - namely - train-x.data
	fid = open(filename)
	strlines = fid.readlines()

	fid.close()

	completeData = []
	fullData = []
	missingData = [[] for x in xrange(5)]

	for line in strlines:
		arr = line.split()
		missFlag = -1
		for j,num in enumerate(arr):
			if num=='?':
				# this line has missing data
				missFlag = j

		temp1 = copy.copy(arr)
		
		if missFlag==-1:
			# no missing data
			fullData.append(map(int,arr))
			completeData.append(map(int,temp1))
		else:
			# line has missing data
			temp1[missFlag] = '-1'
			completeData.append(map(int,temp1))

			arr[missFlag] = '-1'
			arr = map(int,arr)
			if missFlag!=2:
				arr[missFlag] = [0,0]
			else:
				# this is the grade variable
				arr[missFlag] = [0,0,0]
			missingData[missFlag].append(arr)

	# now fullData has all the examples that have no missing data
	# and missingData has examples with missing data - with missing values replaced with -1
	cptD = [[0,0]]
	cptI = [[0,0]]
	cptG = [[0,0,0] for x in xrange(4)]
	cptS = [[0,0] for x in xrange(2)]
	cptL = [[0,0] for x in xrange(3)]

	# initialize parameters by giving missing data as empty
	curdiff = initParas(completeData)

	# print curdiff
	iter = 1
	while(iter<=100 and curdiff>=eps):
	# while(curdiff>=eps):
		# E-step
		for var in xrange(5):
			if var!=2:
				# if its not grade
				for i,data in enumerate(missingData[var]):
					temp0 = copy.copy(data)
					temp1 = copy.copy(data)
					temp0[var] = 0
					temp1[var] = 1
					jt0 = findJtDist(temp0)
					jt1 = findJtDist(temp1)
					missingData[var][i][var][0] = jt0/(jt0+jt1) # relying on __future__ import division
					missingData[var][i][var][1] = jt1/(jt0+jt1)

			else:
				# this is grade
				for i,data in enumerate(missingData[2]):
					temp1 = copy.copy(data)
					temp2 = copy.copy(data)
					temp3 = copy.copy(data)
					temp1[2] = 1 # Remember grade is 1 indexed
					temp2[2] = 2
					temp3[2] = 3
					jt1 = findJtDist(temp1)
					jt2 = findJtDist(temp2)
					jt3 = findJtDist(temp3)

					missingData[2][i][2][0] = jt1/(jt1+jt2+jt3)
					missingData[2][i][2][1] = jt2/(jt1+jt2+jt3)
					missingData[2][i][2][2] = jt3/(jt1+jt2+jt3)

		# M-step
		curdiff = computeParas(fullData,missingData)
		iter += 1
		# print curdiff
	# print "almost done"
	return findTestLikelihood()


# plotx = [100]
plotx = [0,20,40,60,80,100]
plotytemp = map(lambda x:'./q3_data/train-'+str(x)+'.data',plotx)
ploty = map(runEM,plotytemp)

# if -6300<=min(ploty) and max(ploty)<=-6100:
# 	plt.ylim(-6300,-6100)

plt.plot(plotx, ploty)
plt.xlabel('Percentage of missing data')
plt.ylabel('Log-likelihood of test data')

plt.show()

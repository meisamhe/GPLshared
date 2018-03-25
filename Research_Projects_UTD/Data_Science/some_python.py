# 1. Strip non alphabetic
inputStr = "I may opt for a top yam for Amy, May, and Tommy."
import re
regex = re.compile('[^a-zA-Z ]')
output = regex.sub('',inputStr)
# 2. Convert letters to lower case
output = output.lower()
# 3. sort all the letters within each word
# 4. also eliminate duplicates
DicOfWords = {}
for word in output.split():
	DicOfWords[''.join(sorted(word))] = 1
# 4. continue sort the list of words
outputWordList = DicOfWords.keys()
outputWordList.sort()
# 5. print the words with space
" ".join(outputWordList)



def Collatz(N):
	if (N/2 == float(N)/2): # if it is even
		return (N/2)
	else:
		return (3*N+1)

crrnt = N
for i in range(1,K+1):
	crrnt = Collatz(crrnt)

print(crrnt)




parameters= [1.5,2,-1,-2.5,3]	
attribute = [2,-1,2,0.5]
output = 0
for i in range(0, len(attribute)):
    output = output + float(attribute[i])*float(parameters[i])

output = output + float(parameters[len(attribute)])
import math
score = 1/(1+math.exp(-output))
print('%.3f'%score)


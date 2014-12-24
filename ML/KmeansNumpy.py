__author__ = 'MeisamHe'

from PIL import Image
print 'start to read the image\n'
im = Image.open("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\Koala.jpg") #Can be many different formats.
print 'reading the image done'
pix = im.load()
print im.size #Get the width and hight of the image for iterating over
print pix[0,5] #Get the RGBA Value of the a pixel of an image
#pix[x,y] = value # Set the RGBA Value of the image (tuple)
img = Image.new( 'RGB', (im.size[0],im.size[1]), "black") # create a new black image
pixels = img.load() # create the pixel map

# running k min clustering
k = 2
    # test for 2,5,10,15,20
import numpy
from random import randrange
kmean = []
clusterElements = []
for clust in range(k):
    kmean.insert(len(kmean),[randrange(256),randrange(256),randrange(256)])
    clusterElements.insert(len(clusterElements),[])
assignedPoints = -1*numpy.ones(shape=(im.size[0],im.size[1]))
assignmentChange = True
indx = 0
print 'starting the loop'
while assignmentChange == True:
    indx = indx + 1
    print 'current index is:%s'%indx
    for clust in range(k):
        clusterElements[clust]= []
    assignmentChange = False
    # assignment to clusters
    for i in range(img.size[0]):
        for j in range(img.size[1]):
            curDistance = (kmean[0][0]-pix[i,j][0])*(kmean[0][0]-pix[i,j][0])+(kmean[0][1]-pix[i,j][1])*(kmean[0][1]-pix[i,j][1])+(kmean[0][2]-pix[i,j][2])*(kmean[0][2]-pix[i,j][2])
            curCluster = 0
            for clust in range(1,k,1):
                clustDistance = (kmean[clust][0]-pix[i,j][0])*(kmean[clust][0]-pix[i,j][0])+(kmean[clust][1]-pix[i,j][1])*(kmean[clust][1]-pix[i,j][1])+(kmean[clust][2]-pix[i,j][2])*(kmean[clust][2]-pix[i,j][2])
                if curDistance>clustDistance :
                    curDistance = clustDistance
                    curCluster = clust
            if not (curCluster == assignedPoints[i][j]):
                assignmentChange = True
                assignedPoints[i][j] = curCluster
                clusterElements[curCluster].insert(len(clusterElements[curCluster]),(i,j))
    # calculate cluster mean
    for clust in range(k):
        clustSum0 = 0
        clustSum1 = 0
        clustSum2 = 0
        clustsize = 0
        for i in clusterElements[clust]:
            clustSum0= clustSum0+pix[i[0],i[1]][0]
            clustSum1= clustSum1+pix[i[0],i[1]][1]
            clustSum2= clustSum2+pix[i[0],i[1]][2]
            clustsize = clustsize + 1
        kmean[clust][0]= clustSum0/clustsize
        kmean[clust][1]= clustSum1/clustsize
        kmean[clust][2]= clustSum2/clustsize

for i in range(img.size[0]):
    for j in range(img.size[1]):
        pixels[i,j] = (kmean[assignedPoints[i][j]][0],kmean[assignedPoints[i][j]][1],kmean[assignedPoints[i][j]][2])
img.show()
img.save("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\test.jpg")

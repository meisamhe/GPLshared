__author__ = 'MeisamHe'

from PIL import Image
imageName = "Koala"
im = Image.open("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\%s.jpg"%imageName) #Can be many different formats.
pix = im.load()
print im.size #Get the width and hight of the image for iterating over
print pix[0,5] #Get the RGBA Value of the a pixel of an image
#pix[x,y] = value # Set the RGBA Value of the image (tuple)
img = Image.new( 'RGB', (im.size[0],im.size[1]), "black") # create a new black image
pixels = img.load() # create the pixel map

# running k min clustering
k = 20
    # test for 2,5,10,15,20
import numpy
from random import randrange
kmean = []
clusterElements = []
for clust in range(k):
    kmean.insert(len(kmean),[randrange(256),randrange(256),randrange(256)])
    clusterElements.insert(len(clusterElements),[])
assignedPoints = []
for i in range(img.size[0]):
    assignedPoints.insert(len(assignedPoints),[])
    for j in range(img.size[1]):
        assignedPoints[i].insert(len(assignedPoints[i]),int(-1))

#assignedPoints = -1*numpy.ones(shape=(im.size[0],im.size[1]))
assignmentChange = True
indx = 0
while (assignmentChange == True) and (indx<100):
    indx = indx + 1
    print 'starting loop %s\n'%indx
    for clust in range(k):
        clusterElements[clust]= []
    assignmentChange = False
    # assignment to clusters
    for i in range(img.size[0]):
        for j in range(img.size[1]):
            curDistance = (kmean[0][0]-pix[i,j][0])*(kmean[0][0]-pix[i,j][0])+(kmean[0][1]-pix[i,j][1])*(kmean[0][1]-pix[i,j][1])+(kmean[0][2]-pix[i,j][2])*(kmean[0][2]-pix[i,j][2])
            curCluster = int(0)
            for clust in range(1,k,1):
                clustDistance = (kmean[clust][0]-pix[i,j][0])*(kmean[clust][0]-pix[i,j][0])+(kmean[clust][1]-pix[i,j][1])*(kmean[clust][1]-pix[i,j][1])+(kmean[clust][2]-pix[i,j][2])*(kmean[clust][2]-pix[i,j][2])
                if curDistance>clustDistance :
                    curDistance = clustDistance
                    curCluster = int(clust)
            if (int(curCluster) != int(assignedPoints[i][j])):
                assignmentChange = True
                assignedPoints[i][j] = int(curCluster)
                clusterElements[curCluster].insert(len(clusterElements[curCluster]),(i,j))
    # calculate cluster mean
    for clust in range(k):
        clustSum0 = 0
        clustSum1 = 0
        clustSum2 = 0
        clustsize = 1
        for i in clusterElements[clust]:
            clustSum0 = clustSum0+pix[i[0],i[1]][0]
            clustSum1 = clustSum1+pix[i[0],i[1]][1]
            clustSum2 = clustSum2+pix[i[0],i[1]][2]
            clustsize = clustsize + 1
        kmean[clust][0]= float(clustSum0)/clustsize
        kmean[clust][1]= float(clustSum1)/clustsize
        kmean[clust][2]= float(clustSum2)/clustsize
        print 'cluster mean for cluster %s is: (%s,%s,%s)\n'%(clust,kmean[clust][0],kmean[clust][1],kmean[clust][2])
        #print 'current cluster is:%s'%assignedPoints

for i in range(img.size[0]):
    for j in range(img.size[1]):
        pixels[i,j] = (int(kmean[int(assignedPoints[i][j])][0]),int(kmean[int(assignedPoints[i][j])][1]),int(kmean[int(assignedPoints[i][j])][2]))
#img.show()
img.save("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\k=%s%s.jpg"%(imageName,k))
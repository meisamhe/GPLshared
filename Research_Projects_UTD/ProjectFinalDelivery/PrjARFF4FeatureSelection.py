__author__ = 'MeisamHe'


imageDataFilePath="C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\clusteringSummary\\AllImage FilesCleaned.txt"
imageDataFile = open(imageDataFilePath,'r')
imageData= imageDataFile.read()
imageDocs = imageData.split('\n')

docdocFilePath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textInput\\docDocMatrix.txt"
docdocFile = open(docdocFilePath,'r')
dodocData = docdocFile.read()
docdocDocs = dodocData.split('\n')


#outClustSummary.write("imgSize,clust1Frac,clust2Frac,clust3Frac,clust4Frac,clust5Frac,Rimg, Gimg, Bimg, Himg, Simg, Vimg, R1,R2,R3,R4,R5,G1,G2,G3,G4,G5,B1,
# B2,B3,B4,B5,H1,H2,H3,H4,H5,S1,S2,S3,S4,S5,V1,V2,V3,V4,V5\n")

docdocColumns=[]
for i in range(0,len(docdocDocs)-1,1):
    docdocColumns.insert(len(docdocColumns),'Doc%s'%i)

combinedARFFpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\combinedARFF\\combinedARFF.arff"

attributeList = ['imgSize','clust1Frac','clust2Frac','clust3Frac','clust4Frac','clust5Frac','Rimg', 'Gimg', 'Bimg', 'Himg','Simg', 'Vimg', 'R1','R2','R3','R4','R5','G1','G2','G3','G4','G5',
                 'B1','B2','B3','B4','B5','H1','H2','H3','H4','H5','S1','S2','S3','S4','S5','V1','V2','V3','V4','V5'] + docdocColumns

print 'start to create arff file of combined img and docdoc'

arffFile = open(combinedARFFpath, 'w')

arffFile.write("@relation CombinedImgTextFeatures\n")
arffFile.write("\n")
indx = 0
for token in attributeList:
    arffFile.write("@attribute ")
    if (len(token)==0):
        token = 'something%s'%indx
        indx = indx+1
    arffFile.write(token)
    arffFile.write(" numeric\n")
arffFile.write("@data\n")

print 'length of docdocDocs is:%s'%len(imageDocs)
for i in range(0,len(docdocDocs),1):
    print 'length of image is:%s'%len(imageDocs[i].split(','))
    print 'length of text is:%s'%(len(docdocDocs[i].split(','))-1)
    arffFile.write(imageDocs[i]+docdocDocs[i]+'\n')

arffFile.close()
print 'length of document descriptor is:%s'%len(docdocColumns)
__author__ = 'MeisamHe'

from PIL import Image

# curimgpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\ImageClassification\\DataSet\\InformationIsBeautiful\\"
# postfix    = "jpg"
# totalFiles = 64
# curOutput  = "InfoBeautiful"
# initial = 1
# curimgpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\ImageClassification\\DataSet\\hubspot\\"
# postfix = 'jpg'
# initial = 1
# totalFiles = 45
# curOutput  = "hubspot"
# initial = 48
# totalFiles = 82
# curOutput  = "hubspot1"
curimgpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\ImageClassification\\DataSet\\"
postfix = 'jpg'
initial = 1
initial = 183
totalFiles = 213
curOutput  = "pinterest"


RGBHUEARFFpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\RGBHUEARFFs\\"

attributeList = ['Red','Green','Blue','Hue','Value','Saturation']
import colorsys

for curimg in range(initial,totalFiles+1,1):
    print 'start to create arff file of %s of %s images'%(curimg,totalFiles)
    imageName = curimg
    im = Image.open(curimgpath+"%s.%s"%(imageName,postfix)) #Can be many different formats.
    pix = im.load()
    if pix[1,1] is not None:
        print im.size #Get the width and hight of the image for iterating over
        arffFile = open(RGBHUEARFFpath+"%spn.arff"%(imageName), 'w')
        arffFile.write("@relation RGBHVSImage\n")
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
        for i in range(im.size[0]):
            for j in range(im.size[1]):
                hsv = colorsys.rgb_to_hsv(pix[i,j][0],pix[i,j][1],pix[i,j][2])
                data = '%s,%s,%s,%s,%s,%s\n'%(pix[i,j][0],pix[i,j][1],pix[i,j][2],hsv[0],hsv[1],hsv[2])
                arffFile.write(data)

arffFile.close()

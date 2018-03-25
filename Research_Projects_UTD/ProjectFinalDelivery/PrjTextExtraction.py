__author__ = 'MeisamHe'
import sys, os, re
# for open vc use this library
import cv2
import cv2.cv as cv
# for OCR use this library
import tesseract
# use PyEnchant as a strong spell checking library
import enchant

# create english dictionary
d = enchant.Dict("en_US")

api = tesseract.TessBaseAPI()
api.Init(".","eng",tesseract.OEM_DEFAULT)
api.SetPageSegMode(tesseract.PSM_AUTO)

#curimgpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\ImageClassification\\DataSet\\InformationIsBeautiful\\"
#postfix    = "png"
#totalFiles = 64
#curOutput  = "InfoBeautiful"
#initial = 1
#curimgpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\ImageClassification\\DataSet\\hubspot\\"
#postfix = 'jpg'
#initial = 1
#totalFiles = 45
#curOutput  = "hubspot"
# initial = 48
# totalFiles = 82
# curOutput  = "hubspot1"
curimgpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\ImageClassification\\DataSet\\"
postfix = 'jpg'
initial = 1
totalFiles = 213
curOutput  = "pinterest"


textPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textOutput\\%s.txt"%curOutput #third dataset
outfile = open(textPath, 'w')
textPathout = textPath+'.html'

# run the ocr on all files in the folder and write the text of each file into a separate line
for curimg in range(initial,totalFiles+1,1):
    outfile.write("line%s\t"%curimg)
    print 'starting the %s out of %s files'%(curimg,totalFiles)
    imgpath  = curimgpath+"%s.%s"%(curimg,postfix)
    command = "tesseract %s %s hocr"%(imgpath, textPath)
    print command
    os.system(command)
    pattern = re.compile("""<span[^>]*><span class=.ocrx_word. id=.word_\d+. title=.bbox (\d+) (\d+) (\d+) (\d+).>([^<]*)</span>""")
    #<span class="ocrx_word" id="word_1" title="bbox 18 32 108 68">Who</span>
    text = open(textPathout,'r').read()
    img = cv2.imread(imgpath)
    if img is not None:
        # record it into text file
        for x1, y1, x2, y2, word in re.findall(pattern, text):
            # use PyEnchant as a strong spell checking library
            word = re.sub("[0-9. ]+", "", word) # numbers and dots
            term = '%s'%word
            if len(term)>1:
                if d.check(term)== True:
                    x1, y1, x2, y2 = map(int, [x1, y1, x2, y2])
                    # process the word error for frame 114 where <strong><em>Invest</em></strong>
                    #word = re.sub("</*\w+>", "", word) # replace extra tags
                    # get the contrast
                    region = img[y1:y2, x1:x2]
                    b, g, r = cv2.split(region) # split the 3 channels
                    r_contrast = r.max() - r.min()
                    g_contrast = g.max() - g.min()
                    b_contrast = b.max() - b.min()
                    # record
                    #outfile.write("\t".join(["%s"]*3) %( word, '%s,%s,%s,%s'%(x1,y1,x2,y2),'%s,%s,%s'%(r_contrast, g_contrast, b_contrast)) + "\n" )
                    outfile.write("%s "%term)
    outfile.write("\n")

outfile.close()

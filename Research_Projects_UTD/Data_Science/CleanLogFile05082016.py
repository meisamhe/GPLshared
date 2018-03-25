#=======================================================
# Code written by Meisam Hejazi Nia
# For C1
# Write: 05/08/2016
#=======================================================
import os
os.system('cls')
InputFile = "C:/Users/Meisam/Desktop/CorrelationOne/access.log/access.log"
InputHandler = open(InputFile,'r')
fileRows = InputHandler.readlines()

import re
outputFile = "C:/Users/Meisam/Desktop/CorrelationOne/access.log/responseLog.csv"
OutputHandler = open(outputFile,'w')
OutputHandler.write("Time,article_id,user_id,status_code,byteSize\n")

for line in fileRows:
	#[02/Jan/2015:08:07:32] "GET /click?article_id=162&user_id=5475 HTTP/1.1" 200 4352
	#"GET /click?article_id=([0-9]*)&user_id=([0-9]*) HTTP/1.1" ([0-9]*) ([0-9]*)\n
	logItem = re.findall('\[([0-9a-zA-Z:/]*)\] "GET /click.article_id=([0-9]*)&user_id=([0-9]*) HTTP/1.1" ([0-9]*) ([0-9]*)',line)
	logItem = logItem[0]
	OutputHandler.write("%s,%s,%s,%s,%s\n"%(logItem[0],logItem[1],logItem[2],logItem[3],logItem[4]))

OutputHandler.close()
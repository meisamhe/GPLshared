# an example of crawling data without using regular expression
# crawl all the teachers' names(and tid) and department from RateMyPorfessors.com
import urllib

urlRoot = '''http://www.ratemyprofessors.com/SelectTeacher.jsp?sid=1273&pageNo=%s'''
# traverse all the pages
outfile = open("UTD_professors.txt", 'w')
outfile.write('\t'.join(['tid', 'name', 'dept']) + '\n')
for pn in range(1, 64):
    print " Page number: %s" % pn
    urlFile = urllib.urlopen(urlRoot % pn)
    urlstr = urlFile.read()
    start = urlstr.find('<div class="profName">')
    count = 0
    while start != -1:
        count += 1
        cut_front = urlstr.find('tid=', start) + 4
        cut_end = urlstr.find('">', cut_front)
        tid = urlstr[cut_front:cut_end]

        cut_front = cut_end + 2
        cut_end = urlstr.find('</a>', cut_front)
        name = urlstr[cut_front:cut_end]

        cut_front = urlstr.find('<div class="profDept">', start) + 22
        cut_end = urlstr.find('</div>', cut_front)
        dept = urlstr[cut_front:cut_end]

        outfile.write('\t'.join([tid, name, dept]) + '\n')
        start = urlstr.find('<div class="profName">', cut_end)
    print "%s professors saved" % count
outfile.close()

# notepad ++ RX
#(\d+)=(\d+)
#\1 = \1 (refers to first Group in the above expression)
#Machine Learning: Sikit-learn, Scipy, Numpy
# IDE: Pychar, Ulipad

# Numbers 

width = 20
height = 5*9
width * height

# calculator

tax = 8.25 / 100
price = 100.50
price * tax

price + _

round(_, 2)

# Strings

# show ' and "
print 'spam eggs'

print 'doesn't'

print "doesn't"

# Target: "Yes," he said.



print '"Yes," he said.'

print "\"Yes,\" he said."

# span multiple lines
print '''
Usage: thingy [OPTIONS]
     -h                        Display this usage message
     -H hostname               Hostname to connect to
'''


# slice and index

word = 'Help' + 'A'
word[4]

word[0:2]

word[2:4]
word[2:]

# default to 0 and size
word[:2]    # The first two characters

word[2:]    # Everything except the first two characters

# Target: "HlA"


word[0::2]

word[0:len(word):2]

# negative index

word[-1]     # The last character

word[-2]     # The last-but-one character

word[-2:]    # The last two characters

word[:-2]    # Everything except the last two characters


# list

a = ['spam', 'eggs', 100, 1234]
a

a[0]

a[3]

a[-2]

a[1:-1]

a[:2] + ['bacon', 2*2]

3*a[:3] + ['Boo!']

# mutable
a

a[2] = a[2] + 23

a

# versatile features

# Replace some items:
a[0:2] = [1, 12]
a

# Remove some:
a[0:2] = [] # or del a[0:2]
a

# Insert some:
a[1:1] = ['insert', 'some']
a
# not the same
a=[1, 12, 100, 1234]
a[1] = ['insert', 'some']
a

# Insert (a copy of) itself at the beginning
a[:0] = a
a[0:0] = a
a
a[0:]=a

# Clear the list: replace all items with an empty list
a[:] = []
a


# nest lists
q = [2, 3]
p = [1, q, 4]
len(p)

p[1]

p[1][0]



# Fibonacci series:
# the sum of two elements defines the next
a, b = 0, 1 # multiple assignment
while a < 10:
 print a
 a, b = b, a+b

# if 
# Ask a user to input a number, if it's negative, x=0, else if it's 1
x = int(raw_input("Please enter an integer for x: "))
if x < 0:
     x = 0
     print 'Negative; changed to zero'
elif x == 0:
     print 'Zero'
elif x == 1:
     print 'Single'
else:
     print 'More'

# for 
# Measure some strings:
words = ['cat', 'window', 'defenestrate']
for i in words:
    print i, len(i)


# define function
def fib(n):    # write Fibonacci series up to n
    """Print a Fibonacci series up to n."""
    a, b = 0, 1
    while a < n:
        print a
        a, b = b, a+b
fib(200)
fib(2000000000000000) # do not need to worry about the type of a,b



def fib2(n): # return Fibonacci series up to n
    """Return a list containing the Fibonacci series up to n."""
    result = []
    a, b = 0, 1
    while a < n:
        result.append(a)    # see below
        a, b = b, a+b
    return result

f100 = fib2(100)    # call it
f100                # write the result



# list
# Target: Get the third power of integers between 0 and 10.

# loop way

cubes = []
for x in range(11):
        cubes.append(x**3)
cubes

# map way
def cube(x): return x*x*x

map(cube, range(11))

# list comprehension way

x_list=[x**3 for x in range(11)]

# if in list comprehension
# find the even number below 10
[i for i in range(11) if i%2==0]

l=[1,3,5,6,8,10]
[i for i in l if i%2==0]
# dict

tel = {'jack': 4098, 'sam': 4139}
tel['dan'] = 4127
tel

tel['jack']

del tel['sam']
tel['mike'] = 4127
tel

tel.keys()
tel.values()

'dan' in tel


## module: re
#import re
#re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')
#
#re.sub(r'(\b[a-z]+) \1', r'\1', 'cat in the the hat')





# mysql
# end all commands with ;
show databases;
create database test1;
use test1;
show tables;

create table example(
id int not null,
name varchar(30),
age tinyint,
primary key(id));

show tables;
desc example;

# Python
# load data into table

# Data values separated by tab
import string,random

# output for viewing
for i in range(50):
	print i+1,',',random.choice(string.uppercase),',',random.choice(range(11));
#	print i+1,',',random.choice(string.uppercase),',',random.randint(1,10);

# write it to a file 
outfile=open('data.txt','w')
columns=['id','name','age']
outfile.write('\t'.join(columns)+'\n')
for i in range(50):
	row=[str(i+1),random.choice(string.uppercase),str(random.randint(1,10))]
	outfile.write('\t'.join(row)+'\n')
else:
    outfile.close()
#outfile.close()


# MySQL        
 # linux use / to denote directory.
#?need test
#load data infile "D:\\Dropbox\\svn\\py\\teach\\data.txt" into table test.example FIELDS TERMINATED BY '\t' lines terminated by '\r\n' ignore 1 lines;
load data infile "D:\\Dropbox\\svn\\py\\teach\\data.txt" into table test1.example FIELDS TERMINATED BY '\t' lines terminated by '\r\n' ignore 1 lines;
#load data infile "/home/chengnie/age.txt" into table test1.example FIELDS TERMINATED BY ',' lines terminated by '\r\n' ;
# age histogram
select distinct age, count(*) from example group by age;







# MySQL part
drop table if exists e_copy;
create table e_copy select * from example;
alter table e_copy add primary key(id);

insert into e_copy (id, name, age) values (null,'P',6);
insert into e_copy (id, name, age) values (3,'P',6);
insert into e_copy (id, name, age) values (51,'P',6);
insert into e_copy (id, name, age) values (52,'Q',null);
insert into e_copy (id, name, age) values (54,'Q',null),(55,'Q',null);
insert into e_copy (id, name) values (53,'Q');
update e_copy set age=7 where id=53;
update e_copy set age=DEFAULT where id=53;
update e_copy set age='' where id=53;

select sum(age) from e_copy;
select * from e_copy where age=6 and name<="C";

#tuple: similar to list, but immutable (element cannot be changed)
x=1,2,3,4
x[0]
x[0]=7

# access table from Python

# connect to MySQL in Python
import mysql.connector
cnx = mysql.connector.connect(user='root',password='1234',database='test1')
# All DDL (Data Definition Language) statements are executed using a handle structure known as a cursor
cursor = cnx.cursor()
#cursor.execute("")

# age
cursor.execute('select id from e_copy;')
for i in cursor:
    print i


cursor.execute('alter table e_copy add mother_name varchar(1) default null')
query='update e_copy set mother_name="%s" where id=%s;'
for i in range(50):
    query1=query%(random.choice(string.uppercase),i+1)
    print query1
    cursor.execute(query1)
    cnx.commit()
 
# example for insert
query2='insert into e_copy (id, name,age,mother_name) values (%s,"%s",%s,"%s")'    
for i in range(10):
    query3=query2%(i+60, random.choice(string.uppercase), random.randint(1,10),random.choice(string.uppercase))
    print query3
    cursor.execute(query3)
    cnx.commit()


# call WEKA in Command line (Go to teach directory)
# train without saving model or output


# train while saving
java -cp "C:\Program Files\Weka-3-6\weka.jar" weka.classifiers.trees.J48  -C 0.25 -M 2 -t "C:\Program Files\Weka-3-6\data\iris.arff" -d "j48_iris.wkm" > "trainout.txt"
# test
java -cp "C:\Program Files\Weka-3-6\weka.jar" weka.classifiers.trees.J48 -l "j48_iris.wkm" -T "C:\Program Files\Weka-3-6\data\iris.arff"
# save output
java -cp "C:\Program Files\Weka-3-6\weka.jar" weka.classifiers.trees.J48 -l "j48_iris.wkm" -T "C:\Program Files\Weka-3-6\data\iris.arff" > "testout.txt"


# call WEKA from Python
# Delete previously generated files first
import os
classifier='weka.classifiers.trees.J48'
# train
cmd1='java -cp "C:\Program Files\Weka-3-6\weka.jar" %s  -C 0.25 -M 2 -t "C:\Program Files\Weka-3-6\data\iris.arff" -d "D:/Dropbox/svn/py/teach/j48_iris.wkm" > "D:/Dropbox/svn/py/teach/trainout.txt"'%classifier
print cmd1
cmd2='java -cp "C:\Program Files\Weka-3-6\weka.jar" %s -l "D:/Dropbox/svn/py/teach/j48_iris.wkm" -T "C:\Program Files\Weka-3-6\data\iris.arff" > "D:/Dropbox/svn/py/teach/testout.txt"'%classifier
print cmd2
os.system(cmd1)
# test
os.system(cmd2)


# regular expression in Python
import re
# digits
# find all the numbers 
infile=open(r'D:\Dropbox\svn\py\teach\digits.txt','r')
infile=open('D:\\Dropbox\\svn\\py\\teach\\digits.txt','r')
content=infile.read()
print content
numbers=re.findall(r'\d+',content)
for n in numbers:
        print n
        
# find equations
equations=re.findall(r'(\d+)=\d+',content)
for e in equations:
        print e
# subsitute equations to correct them

print re.sub(r'(\d+)=\d+',r'\1=\1',content)




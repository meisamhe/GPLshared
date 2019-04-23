#remove non alphabetic characters, except space
#pattern
regex = re.compile('[^a-zA-Z ]')
A = np.array([ [1,2,3], [4,5,6], [7,8,9]])
a.np.array([1,2,3]).reshape(1,3)
b.shape
b = np.array([1,2,3])
np.random.rand(3,2)
np.zeros((3,2))
np.ones((3,2))
np.eye(3)
np.diag(a)
A = np.array([[1,2,3], [4,5,6]])
A.shape
A[0,:]
A[0:2,:]
A[:,0]
A[:,[0]]
A[:,0:2]
A[A[:,2] == 9]
A[0,0]
A.flatten(1) # returns a copy
b = b[np.newaxis].T
total_elements = np.prod(A.shape)
B = A.reshape(1, total_elements)
A = np.array([[1, 2, 3], [4, 5, 6]])
B = np.array([[7, 8, 9],[10,11,12]])
C = np.concatenate((A, B), axis=0)
a = np.array([1,2,3])
b = np.array([4,5,6])
np.column_stack([a,b])
np.row_stack([a,b])
A * 2
A + 2
A - 2
A / 2
np.dot(A, A) # or A.dot(A)
np.dot(A,b) # or A.dot(b)
A + A
A - A
A / A
np.power(A, 2)
np.linalg.matrix_power(A, 2)
A.T
np.linalg.det(A)
np.linalg.inv(A)
x1 = np.array([ 4, 4.2, 3.9, 4.3, 4.1])
x2 = np.array([ 2, 2.1, 2, 2.1, 2.2])
x3 = np.array([ 0.6, 0.59, 0.58, 0.62, 0.63])
np.cov([x1, x2, x3])
A = np.array([[3, 1], [1, 3]])
eig_val, eig_vec = np.linalg.eig(A)
mean = np.array([0,0])
cov = np.array([[2,0],[0,2]])
np.random.multivariate_normal(mean, cov, 5)

words = [“this”, ‘is’, ‘a’, ‘list’, ‘of’, “strings”]
‘ ‘.join(words)
if test:
	#do stuff if test is true
elif test 2:
	#do stuff if test2 is true
else:
	#do stuff if both tests are false
for x in aSequence:
	#do stuff for each member of aSequence
	#for example, each item in a list, each
	#character in a string, etc.
for x in range(10):
	#do stuff 10 times (0 through 9)
for x in range(5,10):
	#do stuff 5 times (5 through 9)
emptyTuple = ()
singleItemTuple = (“spam”,) note the comma!
thistuple = 12, 89, ‘a’
thistuple = (12, 89, ‘a’)
emptyDict = {}
thisdict = {‘a’:1, ‘b’:23, ‘c’:”eggs”}
thisdict.has_key(‘e’) returns False
thisdict.keys() returns [‘a’, ‘c’]
thisdict.items() returns [(‘a’, 1), (‘c’, ‘eggs’)]
‘c’ in thisdict returns True
‘paradimethylaminobenzaldehyde’ in thisdict returns False
creation: thelist = [5,3,‘p’,9,‘e’]
accessing: thelist[0] returns 5
slicing: thelist[1:3] returns [3, ‘p’]
thelist[2:] returns [‘p’, 9, ‘e’]
thelist[:2] returns [5, 3]
thelist[2:-1] returns [‘p’, 9]
length: len(thelist) returns 5
sort: thelist.sort() no return value
add: thelist.append(37)
return & thelist.pop() returns 37
remove: thelist.pop(1) returns 5
insert: thelist.insert(2, ‘z’)
remove: thelist.remove(‘e’)
del thelist[0]
concatenation: thelist + [0] returns [‘z’,9,’p’,0]
finding: 9 in thelist returns True
[x*5 for x in range(5)]
[x for x in range(5) if x%2 == 0]
def myFunc(param1, param2):
	“””By putting this initial sentence in triple quotes, you can
	access it by calling myFunc.__doc___”””
	#indented code block goes here
	spam = param1 + param2
	return spam
class Eggs(ClassWeAreOptionallyInheriting):
	def __init__(self):
		ClassWeAreOptionallyInheriting.__init__(self)
		#initialization (constructor) code goes here
		self.cookingStyle = ‘scrambled’
	def anotherFunction(self, argument):
		if argument == “just contradiction”:
			return False
		else:
			return True

theseEggsInMyProgram = Eggs()

thisfile = open(“datadirectory/file.txt”)
thisfile.read()
thisfile.readline()
thisfile.readlines()
for eachline in thisfile:

Python UDFs
#/usr/bin/python
#Square - Square of a number of any data type
@otuputSchemaFunction("squareSchema") --Defines a script delegate function that defines schema for this funciton depending upon the input type.
def square(num):
	return ((num)*(num))
@schemaFunction("squareSchema") -- Defines delegate function and is not registerd to Pig.
def square Schema(input):
	return input
# Percent - Percentage
@outputSchema("percent:double") -- Defines schema for a script UDF in a format that Pig understands and is able to parse
def percent(num, total):
	return num * 100 / total

Data Types: int, long, float, doublle, chararray, bytearray, boolean
Complex types: tuple, bag (which is a collection of tuples), map

Python Quick Code
----------------
arr = array([])
arr.shape
convolve(a,b)
arr.reshape()
sum(arr)
mean(arr)
std(arr)
dot(arr1,arr2)
vectorize()
Pandas:
Create Structures:
s = Series (data, index)
df = DataFrame (data, index, columns)
p = Panel (data, items, major_axis, minor_axis)
df.pivot(index,column,values)
df.T
DataFrame commands
df[col]
df.iloc[label]
df.index
df.drop()
df1 = df1.reindex_like(df1,df2)
df.reset_index()
df.reindex()
df.head(n)
df.tail(n)
df.sort()
df.sort(axis=1)
df.stack()
df.unstack()
df.applymap()
df.apply()
df.dropna()
df.count()
df.min()
df.max()
df.describe()
concat()
Groupby:
groupby()
gb.agg()
gb.transform()
gb.filter()
gb.groups
df.to_csv(‘foo.csv’)
read_csv(‘foo.csv’)
to_excel(‘foo.xlsx’, sheet_name)
read_excel(‘foo.xlsx’,’sheet1’, index_col =
None, na_values = [‘NA’])
date_range(start, end, freq)
ts.resample()
ts.ix[start:end]
ts[]
ts.between_time()
to_pydatetime()
to_datetime()

Plot by matplotlib in python:
plot()
subplot(n,x,y)
xlabel()
ylabel()
title()
xticks([],[])
yticks([],[])
ax=gca()
ax.spines[].set_color()
ax.spines[].set_position()
legend(loc=’ ‘)
savefig(‘foo.png’)
Quandl: The Quandl package enables Quandl API access from
within Python, which makes acquiring and manipulating
numerical data as quick and easy as possible.
In your first Quandl function call you should specifiy your
authtoken (found on Quandl’s website after signing up) to
avoid certain API call limits.
authtoken = ‘YOURTOKENHERE’
get(‘QUANDL/CODE’)
search(‘searchterm’)
push(data, code, name)
Plotting Example in Python:
--
import Quandl as q
import matplotlib.pyplot as plt
rural = q.get(‘WORLDBANK/USA_SP_RUR_TOTL_ZS’)
urban = q.get(‘WORLDBANK/USA_SP_URB_TOTL_IN_ZS’)
plt.subplot(2, 1, 1)
plt.plot(rural.index,rural)
plt.xticks(rural.index[0::3],[])
plt.title(‘American Population’)
plt.ylabel(‘% Rural’)
plt.subplot(2, 1, 2)
plt.plot(urban.index,urban)
plt.xlabel(‘year’)
plt.ylabel(‘% Urban’)
plt.show()

history                 # copy the code.
history 5-13        # copy specific lines of code.
run mysqrt.py.
cd "./..".
%20.15f.
import mysqrt.
Python ...py.
def sqrt:                # to define a function.
reload (mysqrt).
?                 # to define.
??              # to see the script.
def sqrt2(x,debug=False)         # to define default.
from numpy import nan.
assert x>0., "should not get there".
Shift + Enter: ipython notebook. 
--pylib inline.

assert x>0. and type(x) is float, "should not get here!".
assert abs(s-s_numpy)<1e-14, \.
       "Disagree for x=%20.15e" % x.
x=[7,8,9].
print id(x), type(x).
x.append(10)          # list is a mutable object (object oriented) so y=x the same address i.e. id(x)=id(y).
y = list(x)                 # create a new object and not just a new reference.
x[0] # arrayes start from 0 index.
T = (3,4.5,'abc')       # tuple is like list but immutable.
.
# integer and floats are immutable.
import sys.
sys.path        # returns list of directories.
sys.path.append('newdirectory').
x = linespace(0,5*pi,1000).
print y[100].
# Demo of plotting $y=cos(x)~~$ and $y= - \cos(x)$           # to put latex in the web format of ipython notebook.
.
# another way to add a new path is to add it in PYTHONPATH environment variable.
import modname       # to import a module i.e. a file of modname.py with many functions inside.
from numpy import sqrt.
from numpy import *.
import numpy.
import numpy as np.
x = linespace(0,5*pi,100).
a = array(L).
a.
2*a.
y = cos(x).
plot(x,y).
clf().
plot(x,-y).
plot (x,-y,'r--').
# characters for figure styles: '-' solid line, '--' dashed line, '-.' dotted line, '.' point marker, ',' pixel marker, 'o' circle marker, 'v' triangle_down marker, '^' triangle_up marker, '>' triangle_left marker, '<' triangle right marker, '1' tri_down marker, '2' tri_up marker.
figure().
subplot(2,2,1).
quit().
x = np.array([2.,3.]).
np.sqrt(x)*np.cos(x)*x**3          # the element wise operation *.
x = np.array([1,2,3],dtype=complex).
(x+1.j)*2.j.
A = np.array([[1.,2],[3,4],[5,6]]).
A.shape     # dimensions.
A.T          # transpose.
np.dot(A,x) # matrix-vector product.
np.dot(A.T,A) # matrix-matrix product.
np.matrix([[1.,2], [3,4], [5,6]]).
A = np.matrix(1.,2;3,4; 5,6")       # Matlab style definition of matrix.
print x[0,0], x[1,0].
np.linespace(0.,3.,100)            # returns an array.
#http://www.scipy.org/NumPy_for_Matlab_Users.
A= np.ones((4,4)).
np.rank(A)           # returns 2 as the number of dimensions not rank of the matrix.
np.array(7.).
np.ones((2,2,2))         # returns an array of size 2*2*2.
T[0,0,0].
A = np.array([[1.,2.],[3,4]]).
b = np.dot(A,np.array([8.,9.])).
from numpy.linalg import solve.
solve (A,b)             # identical to A\b in MATLAB.
from numpy.linalg import eig.
eig(A)        # returns a tuple (evals, evecs).
eval, evecs = eig(A)        # unpacks tuple.
evals.
evecs.
from scipy.integrate import quad.
def f(x):.
         return x**2.
quad (f, 0., 2.)           # return integrals from guassian quadrature.
# define definition directly in the quad function.
quad(lambda x: x**2, 0, 2.).
if __name__ = "__main__"           # for hidden variables.
            # some code.
python filename.py.
execfile("filename.py").
run filename.py.
time sqrt(2.).
timeit sqrt(2.).
%% timeit.
y = zeros (1000).
y = zeros (1000).
for i in range (1000):.
	y[i] = sqrt(i).
	
# Python Code to Extract the location of the hotel from google.
# Written by: Meisam Hejazi Nia.
# Feb/18/2016.
#=============================================.
.
#import os.
#os.system('cls').
.
#===============================================.
# include libraries.
#===============================================.
from datetime import datetime.
from csv import DictReader.
from math import exp, log, sqrt.
import urllib2.
import re.
import time.
import os.
.
#check  current working directory.
#os.getcwd().
#change the current working directory to new one.
#os.chdir("new_working_directory").
.
.
#-------------------------------------------------------------.
# Define functions.
#-------------------------------------------------------------.
#set difference (list difference) function useful for amenities.
def diff(a, b):.
        b = set(b).
        return [aa for aa in a if aa not in b].
.
.
#*************************************************************.
# Test whether I can recognize the path on a simple example.
#*************************************************************.
# set the path to read a sample file and match the string.
#first example: "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Vila Gale Ericeira hotel - Google Search.html".
# second example:  "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Lion Pub with Rooms - Google Search.html".
# negative example:"C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Americas Best Value Inn V2058 - Google Search.html".
# test the combination with download them all.
.
sampleFilePath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Lion Pub with Rooms - Google Search.html".
.
#"C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Mayan+Inn.htm".
#.
#"C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Mayan+Inn.htm".
sampleFile = open(sampleFilePath).
content = sampleFile.read().
.
#Match the string of address.
#<span class="_xdb">Address: </span><span class="_Xbe">Navegantes, Estr. da Fonte Boa dos Nabos, 2659-501 Ericeira, Portugal</span>.
#<span class="_xdb">Address: </span><span class="_Xbe">Bridge St, Belper DE56 1AX, United Kingdom</span>.
addressTemp = re.findall('<span class="_xdb">Address: </span><span class="_Xbe">([^<]*)</span>', content).
starTemp = re.findall('<div class="_mr _Wfc vk_gy"><span>([^<]*)</span></div>',content).
reviewTemp = re.findall('<div><span style="margin-right:5px" class="rtng" aria-hidden="true">([^<]*)</span><g-review-stars>',content).
amenityTemp = re.findall('<span class="_Wzg">([^<]*)</span>',content).
.
#unavilable amenities.
amenityUnavailableTemp = re.findall('<span class="_bRg"><span class="_Czg _Xzg"></span></span><span class="_Wzg">([^<]*)</span>',content).
.
#available amenities.
amenityAvailableTemp = diff(amenityTemp,amenityUnavailableTemp).
.
.
# for description use xpath .
#installing within the program:  which did not work in my case.
#from setuptools.command import easy_install.
# easy_install.main( ["html"] ).
.
from lxml import html.
import requests.
tree = html.fromstring(content).
.
description = tree.xpath('//*[@id="rhs_block"]/div/div[1]/div/div[1]/ol/div[5]/div//span/text()').
.
# if exists: len(addressTemp)=1.
# if does not exist: len(addressTemp) = 0.
#*************************************************************.
.
#Changed plan: create the list of URL.
# put them on the google document.
# run download them all.

import numpy as np.
from scipy.stats import beta, gamma, expo, nbinom, expon, norm, binom.
def test_setup(number_of_testGroups):.
.
def update_posterior(prior_alpha, prior_beta, is_success, in_total_trials).
.
def simulations(prior_alpha, prior_beta, simulationSize = 10000000).
.
import plotly as py.
import plotly.graph_objs as go.
py.offline.init__notebook_mode().
.
import math.
.
from plotly.graph_objs import *.
from plotly.graph_objs import Scatter, Figure, Layout.

#===========================================================
# 3 SuM
#==========================================================
# -*- coding: utf-8 -*- 

# http://rosalind.info/problems/3sum/

def three_sum(xs):
    original_xs = xs[:]
    xs.sort()
    n = len(xs)
    for i in xrange(n-2):
        a = xs[i]
        j = i+1
        k = n-1
        while j < k:
            b = xs[j]
            c = xs[k]
            if a+b+c == 0:
                return sorted([original_xs.index(a)+1,
                               original_xs.index(b)+1,
                               original_xs.index(c)+1])
            elif a+b+c > 0:
                k = k-1
            else:
                j = j+1
    return [-1]

if __name__ == "__main__":
    with open("rosalind_3sum.txt") as f:
        k = int(f.readline().split()[0]) # number of arrays
        for i in xrange(k):
            xs = map(int, f.readline().split())
            res = three_sum(xs)
            print ' '.join(map(str, res))
        
#!/usr/bin/env python
# Written by: DGC
#==============================================================================
# Adaptor Design Pattern
#==============================================================================
class RCCar(object):

    def __init__(self):
        self.speed = 0

    def change_speed(self, speed):
        self.speed = speed
        print("RC car is moving at " + str(self.speed))

#==============================================================================
class RCAdapter(object):

    def __init__(self):
        self.car = RCCar()

    def move_forwards(self):
        self.car.change_speed(10)

    def move_backwards(self):
        self.car.change_speed(-10)

    def stop(self):
        self.car.change_speed(0)

#==============================================================================
class RemoteControl(object):

    def __init__(self):
        self.adapter = RCAdapter()

    def stick_up(self):
        self.adapter.move_forwards()

    def stick_down(self):
        self.adapter.move_backwards()

    def stick_middle(self):
        self.adapter.stop()

#==============================================================================
if (__name__ == "__main__"):
    controller = RemoteControl()
    controller.stick_up()
    controller.stick_middle()
    controller.stick_down()
    controller.stick_middle()
    
#==============================================================================
# AVL Tree
#==============================================================================
import random, math



def random_data_generator (max_r):
    for i in xrange(max_r):
        yield random.randint(0, max_r)



class Node():
    def __init__(self, key):
        self.key = key
        self.parent = None
        self.leftChild = None
        self.rightChild = None
        self.height = 0 
    
    def __str__(self):
        return str(self.key) + "(" + str(self.height) + ")"
    
    def is_leaf(self):
        return (self.height == 0)
   
    def max_children_height(self):
        if self.leftChild and self.rightChild:
            return max(self.leftChild.height, self.rightChild.height)
        elif self.leftChild and not self.rightChild:
            return self.leftChild.height
        elif not self.leftChild and  self.rightChild:
            return self.rightChild.height
        else:
            return -1
        
    def balance (self):
        return (self.leftChild.height if self.leftChild else -1) - (self.rightChild.height if self.rightChild else -1)

class AVLTree():
    def __init__(self, *args):
        self.rootNode = None
        self.elements_count = 0
        self.rebalance_count = 0
        if len(args) == 1:
            for i in args[0]:
                self.insert (i)
        
    def height(self):
        if self.rootNode:
            return self.rootNode.height
        else:
            return 0
        
    def rebalance (self, node_to_rebalance):
        self.rebalance_count += 1
        A = node_to_rebalance 
        F = A.parent #allowed to be NULL
        if node_to_rebalance.balance() == -2:
            if node_to_rebalance.rightChild.balance() <= 0:
                """Rebalance, case RRC """
                B = A.rightChild
                C = B.rightChild
                assert (not A is None and not B is None and not C is None)
                A.rightChild = B.leftChild
                if A.rightChild:
                    A.rightChild.parent = A
                B.leftChild = A
                A.parent = B                                                               
                if F is None:                                                              
                   self.rootNode = B 
                   self.rootNode.parent = None                                                   
                else:                                                                        
                   if F.rightChild == A:                                                          
                       F.rightChild = B                                                                  
                   else:                                                                      
                       F.leftChild = B                                                                   
                   B.parent = F 
                self.recompute_heights (A) 
                self.recompute_heights (B.parent)                                                                                         
            else:
                """Rebalance, case RLC """
                B = A.rightChild
                C = B.leftChild
                assert (not A is None and not B is None and not C is None)
                B.leftChild = C.rightChild
                if B.leftChild:
                    B.leftChild.parent = B
                A.rightChild = C.leftChild
                if A.rightChild:
                    A.rightChild.parent = A
                C.rightChild = B
                B.parent = C                                                               
                C.leftChild = A
                A.parent = C                                                             
                if F is None:                                                             
                    self.rootNode = C
                    self.rootNode.parent = None                                                    
                else:                                                                        
                    if F.rightChild == A:                                                         
                        F.rightChild = C                                                                                     
                    else:                                                                      
                        F.leftChild = C
                    C.parent = F
                self.recompute_heights (A)
                self.recompute_heights (B)
        else:
            assert(node_to_rebalance.balance() == +2)
            if node_to_rebalance.leftChild.balance() >= 0:
                B = A.leftChild
                C = B.leftChild
                """Rebalance, case LLC """
                assert (not A is None and not B is None and not C is None)
                A.leftChild = B.rightChild
                if (A.leftChild): 
                    A.leftChild.parent = A
                B.rightChild = A
                A.parent = B
                if F is None:
                    self.rootNode = B
                    self.rootNode.parent = None                    
                else:
                    if F.rightChild == A:
                        F.rightChild = B
                    else:
                        F.leftChild = B
                    B.parent = F
                self.recompute_heights (A)
                self.recompute_heights (B.parent) 
            else:
                B = A.leftChild
                C = B.rightChild 
                """Rebalance, case LRC """
                assert (not A is None and not B is None and not C is None)
                A.leftChild = C.rightChild
                if A.leftChild:
                    A.leftChild.parent = A
                B.rightChild = C.leftChild
                if B.rightChild:
                    B.rightChild.parent = B
                C.leftChild = B
                B.parent = C
                C.rightChild = A
                A.parent = C
                if F is None:
                   self.rootNode = C
                   self.rootNode.parent = None
                else:
                   if (F.rightChild == A):
                       F.rightChild = C
                   else:
                       F.leftChild = C
                   C.parent = F
                self.recompute_heights (A)
                self.recompute_heights (B)
                
    def sanity_check (self, *args):
        if len(args) == 0:
            node = self.rootNode
        else:
            node = args[0]
        if (node  is None) or (node.is_leaf() and node.parent is None ):
            # trival - no sanity check needed, as either the tree is empty or there is only one node in the tree     
            pass    
        else:
            if node.height != node.max_children_height() + 1:
                raise Exception ("Invalid height for node " + str(node) + ": " + str(node.height) + " instead of " + str(node.max_children_height() + 1) + "!" )
                
            balFactor = node.balance()
            #Test the balance factor
            if not (balFactor >= -1 and balFactor <= 1):
                raise Exception ("Balance factor for node " + str(node) + " is " + str(balFactor) + "!")
            #Make sure we have no circular references
            if not (node.leftChild != node):
                raise Exception ("Circular reference for node " + str(node) + ": node.leftChild is node!")
            if not (node.rightChild != node):
                raise Exception ("Circular reference for node " + str(node) + ": node.rightChild is node!")
            
            if ( node.leftChild ): 
                if not (node.leftChild.parent == node):
                    raise Exception ("Left child of node " + str(node) + " doesn't know who his father is!")
                if not (node.leftChild.key <=  node.key):
                    raise Exception ("Key of left child of node " + str(node) + " is greater than key of his parent!")
                self.sanity_check(node.leftChild)
            
            if ( node.rightChild ): 
                if not (node.rightChild.parent == node):
                    raise Exception ("Right child of node " + str(node) + " doesn't know who his father is!")
                if not (node.rightChild.key >=  node.key):
                    raise Exception ("Key of right child of node " + str(node) + " is less than key of his parent!")
                self.sanity_check(node.rightChild)
            
    def recompute_heights (self, start_from_node):
        changed = True
        node = start_from_node
        while node and changed:
            old_height = node.height
            node.height = (node.max_children_height() + 1 if (node.rightChild or node.leftChild) else 0)
            changed = node.height != old_height
            node = node.parent
       
    def add_as_child (self, parent_node, child_node):
        node_to_rebalance = None
        if child_node.key < parent_node.key:
            if not parent_node.leftChild:
                parent_node.leftChild = child_node
                child_node.parent = parent_node
                if parent_node.height == 0:
                    node = parent_node
                    while node:
                        node.height = node.max_children_height() + 1
                        if not node.balance () in [-1, 0, 1]:
                            node_to_rebalance = node
                            break #we need the one that is furthest from the root
                        node = node.parent     
            else:
                self.add_as_child(parent_node.leftChild, child_node)
        else:
            if not parent_node.rightChild:
                parent_node.rightChild = child_node
                child_node.parent = parent_node
                if parent_node.height == 0:
                    node = parent_node
                    while node:
                        node.height = node.max_children_height() + 1
                        if not node.balance () in [-1, 0, 1]:
                            node_to_rebalance = node
                            break #we need the one that is furthest from the root
                        node = node.parent       
            else:
                self.add_as_child(parent_node.rightChild, child_node)
        
        if node_to_rebalance:
            self.rebalance (node_to_rebalance)
    
    def insert (self, key):
        new_node = Node (key)
        if not self.rootNode:
            self.rootNode = new_node
        else:
            if not self.find(key):
                self.elements_count += 1
                self.add_as_child (self.rootNode, new_node)
      
    def find_biggest(self, start_node):
        node = start_node
        while node.rightChild:
            node = node.rightChild
        return node 
    
    def find_smallest(self, start_node):
        node = start_node
        while node.leftChild:
            node = node.leftChild
        return node
     
    def inorder_non_recursive (self):
        node = self.rootNode
        retlst = []
        while node.leftChild:
            node = node.leftChild
        while (node):
            retlst += [node.key]
            if (node.rightChild):
                node = node.rightChild
                while node.leftChild:
                    node = node.leftChild
            else:
                while ((node.parent)  and (node == node.parent.rightChild)):
                    node = node.parent
                node = node.parent
        return retlst
 
    def preorder(self, node, retlst = None):
        if retlst is None:
            retlst = []
        retlst += [node.key]
        if node.leftChild:
            retlst = self.preorder(node.leftChild, retlst) 
        if node.rightChild:
            retlst = self.preorder(node.rightChild, retlst)
        return retlst         
           
    def inorder(self, node, retlst = None):
        if retlst is None:
            retlst = [] 
        if node.leftChild:
            retlst = self.inorder(node.leftChild, retlst)
        retlst += [node.key] 
        if node.rightChild:
            retlst = self.inorder(node.rightChild, retlst)
        return retlst
        
    def postorder(self, node, retlst = None):
        if retlst is None:
            retlst = []
        if node.leftChild:
            retlst = self.postorder(node.leftChild, retlst) 
        if node.rightChild:
            retlst = self.postorder(node.rightChild, retlst)
        retlst += [node.key]
        return retlst  
    
    def as_list (self, pre_in_post):
        if not self.rootNode:
            return []
        if pre_in_post == 0:
            return self.preorder (self.rootNode)
        elif pre_in_post == 1:
            return self.inorder (self.rootNode)
        elif pre_in_post == 2:
            return self.postorder (self.rootNode)
        elif pre_in_post == 3:
            return self.inorder_non_recursive()      
          
    def find(self, key):
        return self.find_in_subtree (self.rootNode, key )
    
    def find_in_subtree (self,  node, key):
        if node is None:
            return None  # key not found
        if key < node.key:
            return self.find_in_subtree(node.leftChild, key)
        elif key > node.key:
            return self.find_in_subtree(node.rightChild, key)
        else:  # key is equal to node key
            return node
    
    def remove (self, key):
        # first find
        node = self.find(key)
        
        if not node is None:
            self.elements_count -= 1
            
            #     There are three cases:
            # 
            #     1) The node is a leaf.  Remove it and return.
            # 
            #     2) The node is a branch (has only 1 child). Make the pointer to this node 
            #        point to the child of this node.
            # 
            #     3) The node has two children. Swap items with the successor
            #        of the node (the smallest item in its right subtree) and
            #        delete the successor from the right subtree of the node.
            if node.is_leaf():
                self.remove_leaf(node)
            elif (bool(node.leftChild)) ^ (bool(node.rightChild)):  
                self.remove_branch (node)
            else:
                assert (node.leftChild) and (node.rightChild)
                self.swap_with_successor_and_remove (node)
            
    def remove_leaf (self, node):
        parent = node.parent
        if (parent):
            if parent.leftChild == node:
                parent.leftChild = None
            else:
                assert (parent.rightChild == node)
                parent.rightChild = None
            self.recompute_heights(parent)
        else:
            self.rootNode = None
        del node
        # rebalance
        node = parent
        while (node):
            if not node.balance() in [-1, 0, 1]:
                self.rebalance(node)
            node = node.parent
        
        
    def remove_branch (self, node):
        parent = node.parent
        if (parent):
            if parent.leftChild == node:
                parent.leftChild = node.rightChild or node.leftChild
            else:
                assert (parent.rightChild == node)
                parent.rightChild = node.rightChild or node.leftChild
            if node.leftChild:
                node.leftChild.parent = parent
            else:
                assert (node.rightChild)
                node.rightChild.parent = parent 
            self.recompute_heights(parent)
        del node
        # rebalance
        node = parent
        while (node):
            if not node.balance() in [-1, 0, 1]:
                self.rebalance(node)
            node = node.parent
        
    def swap_with_successor_and_remove (self, node):
        successor = self.find_smallest(node.rightChild)
        self.swap_nodes (node, successor)
        assert (node.leftChild is None)
        if node.height == 0:
            self.remove_leaf (node)
        else:
            self.remove_branch (node)
            
    def swap_nodes (self, node1, node2):
        assert (node1.height > node2.height)
        parent1 = node1.parent
        leftChild1 = node1.leftChild
        rightChild1 = node1.rightChild
        parent2 = node2.parent
        assert (not parent2 is None)
        assert (parent2.leftChild == node2 or parent2 == node1)
        leftChild2 = node2.leftChild
        assert (leftChild2 is None)
        rightChild2 = node2.rightChild
        
        # swap heights
        tmp = node1.height 
        node1.height = node2.height
        node2.height = tmp
       
        if parent1:
            if parent1.leftChild == node1:
                parent1.leftChild = node2
            else:
                assert (parent1.rightChild == node1)
                parent1.rightChild = node2
            node2.parent = parent1
        else:
            self.rootNode = node2
            node2.parent = None
            
        node2.leftChild = leftChild1
        leftChild1.parent = node2
        node1.leftChild = leftChild2 # None
        node1.rightChild = rightChild2
        if rightChild2:
            rightChild2.parent = node1 
        if not (parent2 == node1):
            node2.rightChild = rightChild1
            rightChild1.parent = node2
            
            parent2.leftChild = node1
            node1.parent = parent2
        else:
            node2.rightChild = node1
            node1.parent = node2           
           
    # use for debug only and only with small trees            
    def out(self, start_node = None):
        if start_node == None:
            start_node = self.rootNode
        space_symbol = "*"
        spaces_count = 80
        out_string = ""
        initial_spaces_string  = space_symbol * spaces_count + "\n" 
        if not start_node:
            return "AVLTree is empty"
        else:
            level = [start_node]
            while (len([i for i in level if (not i is None)])>0):
                level_string = initial_spaces_string
                for i in xrange(len(level)):
                    j = (i+1)* spaces_count / (len(level)+1)
                    level_string = level_string[:j] + (str(level[i]) if level[i] else space_symbol) + level_string[j+1:]
                level_next = []
                for i in level:
                    level_next += ([i.leftChild, i.rightChild] if i else [None, None])
                level = level_next
                out_string += level_string                    
        return out_string

if __name__ == "__main__":    
    """check empty tree creation"""
    a = AVLTree ()
    a.sanity_check()
    
    """check not empty tree creation"""
    seq = [1,2,3,4,5,6,7,8,9,10,11,12]
    seq_copy = [1,2,3,4,5,6,7,8,9,10,11,12]
    #random.shuffle(seq)
    b = AVLTree (seq)
    b.sanity_check()
    
    """check that inorder traversal on an AVL tree 
    (and on a binary search tree in the whole) 
    will return values from the underlying set in order"""
    assert (b.as_list(3) == b.as_list(1) == seq_copy)
    
    """check that node deletion works"""
    c = AVLTree (random_data_generator (10000))
    before_deletion = c.elements_count
    for i in random_data_generator (1000):
        c.remove(i)
    after_deletion = c.elements_count
    c.sanity_check()
    assert (before_deletion >= after_deletion)
    #print c.out()
    
    """check that an AVL tree's height is strictly less than 
    1.44*log2(N+2)-1 (there N is number of elements)"""
    assert (c.height() < 1.44 * math.log(after_deletion+2, 2) - 1)
		
#==============================================================================
# Bellman-Ford
#==============================================================================

"""
The Bellman-Ford algorithm
 
Graph API:
 
    iter(graph) gives all nodes
    iter(graph[u]) gives neighbours of u
    graph[u][v] gives weight of edge (u, v)
"""
 
# Step 1: For each node prepare the destination and predecessor
def initialize(graph, source):
    d = {} # Stands for destination
    p = {} # Stands for predecessor
    for node in graph:
        d[node] = float('Inf') # We start admiting that the rest of nodes are very very far
        p[node] = None
    d[source] = 0 # For the source we know how to reach
    return d, p
 
def relax(node, neighbour, graph, d, p):
    # If the distance between the node and the neighbour is lower than the one I have now
    if d[neighbour] > d[node] + graph[node][neighbour]:
        # Record this lower distance
        d[neighbour]  = d[node] + graph[node][neighbour]
        p[neighbour] = node
 
def bellman_ford(graph, source):
    d, p = initialize(graph, source)
    for i in range(len(graph)-1): #Run this until is converges
        for u in graph:
            for v in graph[u]: #For each neighbour of u
                relax(u, v, graph, d, p) #Lets relax it
 
    # Step 3: check for negative-weight cycles
    for u in graph:
        for v in graph[u]:
            assert d[v] <= d[u] + graph[u][v]
 
    return d, p
 
 
def test():
    graph = {
        'a': {'b': -1, 'c':  4},
        'b': {'c':  3, 'd':  2, 'e':  2},
        'c': {},
        'd': {'b':  1, 'c':  5},
        'e': {'d': -3}
        }
 
    d, p = bellman_ford(graph, 'a')
 
    assert d == {
        'a':  0,
        'b': -1,
        'c':  2,
        'd': -2,
        'e':  1
        }
 
    assert p == {
        'a': None,
        'b': 'a',
        'c': 'b',
        'd': 'e',
        'e': 'b'
        }
 
if __name__ == '__main__': test()

#==============================================================================
# Binary Tree
#==============================================================================
""" Implementation of a generic Binary Tree ADT.  

The purpose of this code is to allow experimentation with tree
traversals and other basic tree operations.  This class is not
particularly useful by itself but it could serve as the base-class of
a Binary Search Tree class.

If this module is executed it will build a tree, demonstrate several
traversals, and draw the tree using turtle graphics.

Author: Nathan Sprague, Nov. 2011
Modified: Apr. 2013
"""

from llistqueue import Queue
from lliststack import Stack
from draw_tree import drawTree


class _BinaryTreeNode(object):
    """ Private storage class for the binary tree. """

    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

class BinaryTree(object):
    """ Generic binary tree class.  Items are added in breadth first
    order, and are only accesible through traversals or iterators.  Items
    cannot be removed. """

    def __init__(self):
        """ Create an empty binary tree. """
        self._root = None
        self._size = 0

    def __len__(self):
        """ Return the number of nodes in this tree. """
        return self._size
    
    def height(self):
        """ Return the height of the tree. """
        return self._height(self._root)
    
    def _height(self, node):
        # Recursive helper method for height. 
        if node is None: 
            return 0
        else:
            return 1 + max(self._height(node.left),
                           self._height(node.right))


    def __contains__(self, data):
        """ Return true if data is contained in this tree. """
        raise NotImplementedError()
        
    def count(self, data):
        """ Return the number of times that data appears in this tree. """
        raise NotImplementedError()

    def breadthFirstAdd(self, data):
        """ Add data to the tree at the next available position in
        breadth first order."""

        if self._root is None:
            self._root = _BinaryTreeNode(data)
        else:
            q = Queue()
            q.enqueue(self._root)
            while True:
                node = q.dequeue()
                if node.left is None:
                    node.left = _BinaryTreeNode(data)
                    break
                else:
                    q.enqueue(node.left)

                if node.right is None:
                    node.right = _BinaryTreeNode(data)
                    break
                else:
                    q.enqueue(node.right)
        self._size += 1

    def randomAdd(self, data):
        """ 
        This method adds data to the tree in a new, randomly located
        leaf node. The (recursive) algorithm is as follows:
        
        ------
        If the root of the current subtree is None
            Replace the current subtree root 
            with a new node containing the data.
        Otherwise, 
              Flip a coin.
              If Heads,
                 Recursively add the data element to the left subtree
              otherwise, 
                 Recursively add the data element to the right subtree.  
        -------

        Where the root of the "current subtree" is initialized to be
        the root of the entire tree.
        """
        raise NotImplementedError()


    def traverseInorder(self, visitor):
        """ 
        Perform an inorder traversal. 
        
        Argument: visitor - An object that provides a visit method. 
                            visitor.visit should be a method that expects
                            a single argument. visitor.visit will be called
                            for each item stored in the tree. 
        Returns: None
        """

        self._traverseInorder(self._root, visitor)

    def _traverseInorder(self, subtreeRoot, visitor):
        # Recursive helper method for traverseInorder. 

        if subtreeRoot is not None:
            self._traverseInorder(subtreeRoot.left, visitor)
            visitor.visit(subtreeRoot.data)
            self._traverseInorder(subtreeRoot.right, visitor)

    def traversePreorder(self, visitor):
        """ 
        Perform an preorder traversal. 
        
        Argument: visitor - An object that provides a visit method. 
                            visitor.visit should be a method that expects
                            a single argument. visitor.visit will be called
                            for each item stored in the tree. 
        Returns: None
        """
        self._traversePreorder(self._root, visitor)

    def _traversePreorder(self, subtreeRoot, visitor):
        # Recursive helper method for traversePreorder. 
        if subtreeRoot is not None:
            visitor.visit(subtreeRoot.data)
            self._traversePreorder(subtreeRoot.left, visitor)
            self._traversePreorder(subtreeRoot.right, visitor)

    def traversePostorder(self, visitor):
        """ 
        Perform an postorder traversal. 
        
        Argument: visitor - An object that provides a visit method. 
                            visitor.visit should be a method that expects
                            a single argument. visitor.visit will be called
                            for each item stored in the tree. 
        Returns: None
        """
        self._traversePostorder(self._root, visitor)

    def _traversePostorder(self, subtreeRoot, visitor):
        # Recursive helper method for traversePostorder. 
        if subtreeRoot is not None:
            self._traversePostorder(subtreeRoot.left, visitor)
            self._traversePostorder(subtreeRoot.right, visitor)
            visitor.visit(subtreeRoot.data)
        
    def traverseBreadthFirst(self, visitor):
        """ 
        Perform an breadth-first traversal. 
        
        Argument: visitor - An object that provides a visit method. 
                            visitor.visit should be a method that expects
                            a single argument. visitor.visit will be called
                            for each item stored in the tree. 
        Returns: None
        """
        q = Queue()

        if self._root is not None:
            q.enqueue(self._root)

        while not q.isEmpty():
            curNode = q.dequeue()
            visitor.visit(curNode.data)
            if curNode.left is not None:
                q.enqueue(curNode.left)
            if curNode.right is not None:
                q.enqueue(curNode.right)
        
    def inorderIterator(self):
        """ Return an inorder iterator. 

        This iterator uses an iterator class that uses a Stack object
        in place of the call stack to keep track of traversal order. 
        """
        return _InorderIterator(self._root)

    def preorderIterator(self):
        """ Return a preorder iterator. 
        
        This iterator uses the yield keyword to return a generator. 
        (see http://docs.python.org/2/tutorial/classes.html#generators )
        """        
        return self._preorderIteratorHelper(self._root)

    def _preorderIteratorHelper(self, node):
        if node is not None:
            yield node.data
            for item in self._preorderIteratorHelper(node.left):
                yield item
            for item in self._preorderIteratorHelper(node.right):
                yield item

    def postorderIterator(self):
        """ Return a post order iterator. 
        
        This iterator does a complete traversal of the tree, inserts all
        elements into a python list, then returns an iterator for that list. 
        This is quite inefficient: 
           *It requires a complete tree traversal even if the iteration
           doesn't actually visit all elements. 
           *It requires O(n) additional space to store the list.
        """
        listVisitor = ListVisitor()
        self.traversePostorder(listVisitor)
        return iter(listVisitor.list)


    def bfsIterator(self):
        """ Return a breadth first iterator. """
        raise NotImplementedError()


class _InorderIterator(object):
    # Inorder Iterator class.  Traversal state is maintained between
    # calls using a stack.
    # This could be done more Pythonically using generators. 

    def __init__(self, root):
        self.stack = Stack()
        curNode = root

        # Keep pushing left children onto the stack.  After this, the
        # top node on the stack will be the leftmost node in the tree.
        # That will be the first item visited in an inorder traversal.

        while curNode is not None:
            self.stack.push(curNode)
            curNode = curNode.left
        
    def __iter__(self):
        return self

    def next(self):
        if self.stack.isEmpty():
            raise StopIteration()
        
        # The current node is at the top of the stack. 

        curNode = self.stack.pop()
        data = curNode.data

        # The next item that should be visited is the left-most node
        # in the right subtree.

        if curNode.right is not None:
            self.stack.push(curNode.right)

            curNode = curNode.right.left
            while curNode is not None:
                self.stack.push(curNode)
                curNode = curNode.left

        return data
           
class ListVisitor(object):
    """
    A simple visitor class that records the progress of a traversal by
    appending all data items to a list in the order that they are
    visited.
    """

    def __init__(self):
        """ Create a new ListVisitor. """
        self.list = []

    def visit(self, data):
        """ The visit method will be called during a tree traversal. """

        self.list.append(data)

    
class StringVisitor(object):
    """
    A simple visitor class that records the progress of a traversal by
    appending all data items a string in the order that they are
    visited.
    """

    def __init__(self):
        """ Create a new StringVisitor. """
        self.string = ""

    def visit(self, data):
        """ The visit method will be called during a tree traversal. """

        self.string += str(data) + " "

def main():
    """ Demonstrate tree traversals and other tree methods. """
    tree = BinaryTree()

    for ch in "ABCDEFGH":
        tree.breadthFirstAdd(ch)

    visitor = StringVisitor()

    print("\nTraversal Examples:\n")

    tree.traverseBreadthFirst(visitor)
    print("Breadth First: " + visitor.string)

    visitor.string = ""
    tree.traverseInorder(visitor)
    print("Inorder:       " + visitor.string)

    visitor.string = ""
    tree.traversePreorder(visitor)
    print("Preorder:      " + visitor.string)

    visitor.string = ""
    tree.traversePostorder(visitor)
    print("Postorder:     " + visitor.string)


    print("\nIterator Examples:\n")

    string = ""
    for item in tree.inorderIterator():
        string += str(item) + " "
    print ("Indorder Iterator: " + string)

    string = ""
    for item in tree.preorderIterator():
        string += str(item) + " "
    print ("Preorder Iterator: " + string)

    string = ""
    for item in tree.postorderIterator():
        string += str(item) + " "
    print ("Postorder Iterator: " + string)
 
    print( "\nTree height: " + str(tree.height()) + ".")

    drawTree(tree)


if __name__ == "__main__":
    main()

#==============================================================================
# Binary Tree
#==============================================================================
# simple binary tree
# in this implementation, a node is inserted between an existing node and the root


class BinaryTree():

    def __init__(self,rootid):
      self.left = None
      self.right = None
      self.rootid = rootid

    def getLeftChild(self):
        return self.left
    def getRightChild(self):
        return self.right
    def setNodeValue(self,value):
        self.rootid = value
    def getNodeValue(self):
        return self.rootid

    def insertRight(self,newNode):
        if self.right == None:
            self.right = BinaryTree(newNode)
        else:
            tree = BinaryTree(newNode)
            tree.right = self.right
            self.right = tree

    def insertLeft(self,newNode):
        if self.left == None:
            self.left = BinaryTree(newNode)
        else:
            tree = BinaryTree(newNode)
            self.left = tree
            tree.left = self.left


def printTree(tree):
        if tree != None:
            printTree(tree.getLeftChild())
            print(tree.getNodeValue())
            printTree(tree.getRightChild())



# test tree

def testTree():
    myTree = BinaryTree("Maud")
    myTree.insertLeft("Bob")
    myTree.insertRight("Tony")
    myTree.insertRight("Steven")
    printTree(myTree)

#==============================================================================
# Bridge Design Pattern
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

import abc

#==============================================================================
class Shape(object):
    __metaclass__ = abc.ABCMeta

    @abc.abstractmethod
    def __init__(self):
        pass

    def area(self):
        """ 
        Returns the area of the shape calculated using the shape specific 
        implementation. 
        """
        assert self.calculator != None, "self.calculator not defined."
        return self.calculator(self)

#==============================================================================
class Rectangle(Shape):
    
    def __init__(self, x, y):
        self.calculator = rectangular_area_calculator
        self.x = x
        self.y = y

#==============================================================================
def rectangular_area_calculator(rectangle):
    return rectangle.x * rectangle.y
 
#==============================================================================
class Triangle(Shape):

    def __init__(self, base, height):
        self.calculator = triangular_area_calculator
        self.base = base
        self.height = height

#==============================================================================
def triangular_area_calculator(triangle):
    return 0.5 * triangle.base * triangle.height
       
#==============================================================================
if (__name__ == "__main__"):
    x = 4
    y = 5
    rect = Rectangle(x, y)
    print(str(x) + " x " + str(y) + " Rectangle area: " + str(rect.area()))
  
    base = 4
    height = 5
    tri = Triangle(base, height);
    print(
        "Base " +
        str(base) +
        ", Height " +
        str(height) + 
        " Triangle area: " +
        str(tri.area())
        )

#==============================================================================
# B-Tree
#==============================================================================
import bisect
import itertools
import operator
 
 
class _BNode(object):
    __slots__ = ["tree", "contents", "children"]
 
    def __init__(self, tree, contents=None, children=None):
        self.tree = tree
        self.contents = contents or []
        self.children = children or []
        if self.children:
            assert len(self.contents) + 1 == len(self.children), \
                    "one more child than data item required"
 
    def __repr__(self):
        name = getattr(self, "children", 0) and "Branch" or "Leaf"
        return "<%s %s>" % (name, ", ".join(map(str, self.contents)))
 
    def lateral(self, parent, parent_index, dest, dest_index):
        if parent_index > dest_index:
            dest.contents.append(parent.contents[dest_index])
            parent.contents[dest_index] = self.contents.pop(0)
            if self.children:
                dest.children.append(self.children.pop(0))
        else:
            dest.contents.insert(0, parent.contents[parent_index])
            parent.contents[parent_index] = self.contents.pop()
            if self.children:
                dest.children.insert(0, self.children.pop())
 
    def shrink(self, ancestors):
        parent = None
 
        if ancestors:
            parent, parent_index = ancestors.pop()
            # try to lend to the left neighboring sibling
            if parent_index:
                left_sib = parent.children[parent_index - 1]
                if len(left_sib.contents) < self.tree.order:
                    self.lateral(
                            parent, parent_index, left_sib, parent_index - 1)
                    return
 
            # try the right neighbor
            if parent_index + 1 < len(parent.children):
                right_sib = parent.children[parent_index + 1]
                if len(right_sib.contents) < self.tree.order:
                    self.lateral(
                            parent, parent_index, right_sib, parent_index + 1)
                    return
 
        center = len(self.contents) // 2
        sibling, push = self.split()
 
        if not parent:
            parent, parent_index = self.tree.BRANCH(
                    self.tree, children=[self]), 0
            self.tree._root = parent
 
        # pass the median up to the parent
        parent.contents.insert(parent_index, push)
        parent.children.insert(parent_index + 1, sibling)
        if len(parent.contents) > parent.tree.order:
            parent.shrink(ancestors)
 
    def grow(self, ancestors):
        parent, parent_index = ancestors.pop()
 
        minimum = self.tree.order // 2
        left_sib = right_sib = None
 
        # try to borrow from the right sibling
        if parent_index + 1 < len(parent.children):
            right_sib = parent.children[parent_index + 1]
            if len(right_sib.contents) > minimum:
                right_sib.lateral(parent, parent_index + 1, self, parent_index)
                return
 
        # try to borrow from the left sibling
        if parent_index:
            left_sib = parent.children[parent_index - 1]
            if len(left_sib.contents) > minimum:
                left_sib.lateral(parent, parent_index - 1, self, parent_index)
                return
 
        # consolidate with a sibling - try left first
        if left_sib:
            left_sib.contents.append(parent.contents[parent_index - 1])
            left_sib.contents.extend(self.contents)
            if self.children:
                left_sib.children.extend(self.children)
            parent.contents.pop(parent_index - 1)
            parent.children.pop(parent_index)
        else:
            self.contents.append(parent.contents[parent_index])
            self.contents.extend(right_sib.contents)
            if self.children:
                self.children.extend(right_sib.children)
            parent.contents.pop(parent_index)
            parent.children.pop(parent_index + 1)
 
        if len(parent.contents) < minimum:
            if ancestors:
                # parent is not the root
                parent.grow(ancestors)
            elif not parent.contents:
                # parent is root, and its now empty
                self.tree._root = left_sib or self
 
    def split(self):
        center = len(self.contents) // 2
        median = self.contents[center]
        sibling = type(self)(
                self.tree,
                self.contents[center + 1:],
                self.children[center + 1:])
        self.contents = self.contents[:center]
        self.children = self.children[:center + 1]
        return sibling, median
 
    def insert(self, index, item, ancestors):
        self.contents.insert(index, item)
        if len(self.contents) > self.tree.order:
            self.shrink(ancestors)
 
    def remove(self, index, ancestors):
        minimum = self.tree.order // 2
 
        if self.children:
            # try promoting from the right subtree first,
            # but only if it won't have to resize
            additional_ancestors = [(self, index + 1)]
            descendent = self.children[index + 1]
            while descendent.children:
                additional_ancestors.append((descendent, 0))
                descendent = descendent.children[0]
            if len(descendent.contents) > minimum:
                ancestors.extend(additional_ancestors)
                self.contents[index] = descendent.contents[0]
                descendent.remove(0, ancestors)
                return
 
            # fall back to the left child
            additional_ancestors = [(self, index)]
            descendent = self.children[index]
            while descendent.children:
                additional_ancestors.append(
                        (descendent, len(descendent.children) - 1))
                descendent = descendent.children[-1]
            ancestors.extend(additional_ancestors)
            self.contents[index] = descendent.contents[-1]
            descendent.remove(len(descendent.children) - 1, ancestors)
        else:
            self.contents.pop(index)
            if len(self.contents) < minimum and ancestors:
                self.grow(ancestors)
 
 
class _BPlusLeaf(_BNode):
    __slots__ = ["tree", "contents", "data", "next"]
 
    def __init__(self, tree, contents=None, data=None, next=None):
        self.tree = tree
        self.contents = contents or []
        self.data = data or []
        self.next = next
        assert len(self.contents) == len(self.data), "one data per key"
 
    def insert(self, index, key, data, ancestors):
        self.contents.insert(index, key)
        self.data.insert(index, data)
 
        if len(self.contents) > self.tree.order:
            self.shrink(ancestors)
 
    def lateral(self, parent, parent_index, dest, dest_index):
        if parent_index > dest_index:
            dest.contents.append(self.contents.pop(0))
            dest.data.append(self.data.pop(0))
            parent.contents[dest_index] = self.contents[0]
        else:
            dest.contents.insert(0, self.contents.pop())
            dest.data.insert(0, self.data.pop())
            parent.contents[parent_index] = dest.contents[0]
 
    def split(self):
        center = len(self.contents) // 2
        median = self.contents[center - 1]
        sibling = type(self)(
                self.tree,
                self.contents[center:],
                self.data[center:],
                self.next)
        self.contents = self.contents[:center]
        self.data = self.data[:center]
        self.next = sibling
        return sibling, sibling.contents[0]
 
    def remove(self, index, ancestors):
        minimum = self.tree.order // 2
        if index >= len(self.contents):
            self, index = self.next, 0
 
        key = self.contents[index]
 
        # if any leaf that could accept the key can do so
        # without any rebalancing necessary, then go that route
        current = self
        while current is not None and current.contents[0] == key:
            if len(current.contents) > minimum:
                if current.contents[0] == key:
                    index = 0
                else:
                    index = bisect.bisect_left(current.contents, key)
                current.contents.pop(index)
                current.data.pop(index)
                return
            current = current.next
 
        self.grow(ancestors)
 
    def grow(self, ancestors):
        minimum = self.tree.order // 2
        parent, parent_index = ancestors.pop()
        left_sib = right_sib = None
 
        # try borrowing from a neighbor - try right first
        if parent_index + 1 < len(parent.children):
            right_sib = parent.children[parent_index + 1]
            if len(right_sib.contents) > minimum:
                right_sib.lateral(parent, parent_index + 1, self, parent_index)
                return
 
        # fallback to left
        if parent_index:
            left_sib = parent.children[parent_index - 1]
            if len(left_sib.contents) > minimum:
                left_sib.lateral(parent, parent_index - 1, self, parent_index)
                return
 
        # join with a neighbor - try left first
        if left_sib:
            left_sib.contents.extend(self.contents)
            left_sib.data.extend(self.data)
            parent.remove(parent_index - 1, ancestors)
            return
 
        # fallback to right
        self.contents.extend(right_sib.contents)
        self.data.extend(right_sib.data)
        parent.remove(parent_index, ancestors)
 
 
class BTree(object):
    BRANCH = LEAF = _BNode
 
    def __init__(self, order):
        self.order = order
        self._root = self._bottom = self.LEAF(self)
 
    def _path_to(self, item):
        current = self._root
        ancestry = []
 
        while getattr(current, "children", None):
            index = bisect.bisect_left(current.contents, item)
            ancestry.append((current, index))
            if index < len(current.contents) \
                    and current.contents[index] == item:
                return ancestry
            current = current.children[index]
 
        index = bisect.bisect_left(current.contents, item)
        ancestry.append((current, index))
        present = index < len(current.contents)
        present = present and current.contents[index] == item
 
        return ancestry
 
    def _present(self, item, ancestors):
        last, index = ancestors[-1]
        return index < len(last.contents) and last.contents[index] == item
 
    def insert(self, item):
        current = self._root
        ancestors = self._path_to(item)
        node, index = ancestors[-1]
        while getattr(node, "children", None):
            node = node.children[index]
            index = bisect.bisect_left(node.contents, item)
            ancestors.append((node, index))
        node, index = ancestors.pop()
        node.insert(index, item, ancestors)
 
    def remove(self, item):
        current = self._root
        ancestors = self._path_to(item)
 
        if self._present(item, ancestors):
            node, index = ancestors.pop()
            node.remove(index, ancestors)
        else:
            raise ValueError("%r not in %s" % (item, self.__class__.__name__))
 
    def __contains__(self, item):
        return self._present(item, self._path_to(item))
 
    def __iter__(self):
        def _recurse(node):
            if node.children:
                for child, item in zip(node.children, node.contents):
                    for child_item in _recurse(child):
                        yield child_item
                    yield item
                for child_item in _recurse(node.children[-1]):
                    yield child_item
            else:
                for item in node.contents:
                    yield item
 
        for item in _recurse(self._root):
            yield item
 
    def __repr__(self):
        def recurse(node, accum, depth):
            accum.append(("  " * depth) + repr(node))
            for node in getattr(node, "children", []):
                recurse(node, accum, depth + 1)
 
        accum = []
        recurse(self._root, accum, 0)
        return "\n".join(accum)
 
    @classmethod
    def bulkload(cls, items, order):
        tree = object.__new__(cls)
        tree.order = order
 
        leaves = tree._build_bulkloaded_leaves(items)
        tree._build_bulkloaded_branches(leaves)
 
        return tree
 
    def _build_bulkloaded_leaves(self, items):
        minimum = self.order // 2
        leaves, seps = [[]], []
 
        for item in items:
            if len(leaves[-1]) < self.order:
                leaves[-1].append(item)
            else:
                seps.append(item)
                leaves.append([])
 
        if len(leaves[-1]) < minimum and seps:
            last_two = leaves[-2] + [seps.pop()] + leaves[-1]
            leaves[-2] = last_two[:minimum]
            leaves[-1] = last_two[minimum + 1:]
            seps.append(last_two[minimum])
 
        return [self.LEAF(self, contents=node) for node in leaves], seps
 
    def _build_bulkloaded_branches(self, (leaves, seps)):
        minimum = self.order // 2
        levels = [leaves]
 
        while len(seps) > self.order + 1:
            items, nodes, seps = seps, [[]], []
 
            for item in items:
                if len(nodes[-1]) < self.order:
                    nodes[-1].append(item)
                else:
                    seps.append(item)
                    nodes.append([])
 
            if len(nodes[-1]) < minimum and seps:
                last_two = nodes[-2] + [seps.pop()] + nodes[-1]
                nodes[-2] = last_two[:minimum]
                nodes[-1] = last_two[minimum + 1:]
                seps.append(last_two[minimum])
 
            offset = 0
            for i, node in enumerate(nodes):
                children = levels[-1][offset:offset + len(node) + 1]
                nodes[i] = self.BRANCH(self, contents=node, children=children)
                offset += len(node) + 1
 
            levels.append(nodes)
 
        self._root = self.BRANCH(self, contents=seps, children=levels[-1])
 
 
class BPlusTree(BTree):
    LEAF = _BPlusLeaf
 
    def _get(self, key):
        node, index = self._path_to(key)[-1]
 
        if index == len(node.contents):
            if node.next:
                node, index = node.next, 0
            else:
                return
 
        while node.contents[index] == key:
            yield node.data[index]
            index += 1
            if index == len(node.contents):
                if node.next:
                    node, index = node.next, 0
                else:
                    return
 
    def _path_to(self, item):
        path = super(BPlusTree, self)._path_to(item)
        node, index = path[-1]
        while hasattr(node, "children"):
            node = node.children[index]
            index = bisect.bisect_left(node.contents, item)
            path.append((node, index))
        return path
 
    def get(self, key, default=None):
        try:
            return self._get(key).next()
        except StopIteration:
            return default
 
    def getlist(self, key):
        return list(self._get(key))
 
    def insert(self, key, data):
        path = self._path_to(key)
        node, index = path.pop()
        node.insert(index, key, data, path)
 
    def remove(self, key):
        path = self._path_to(key)
        node, index = path.pop()
        node.remove(index, path)
 
    __getitem__ = get
    __setitem__ = insert
    __delitem__ = remove
 
    def __contains__(self, key):
        for item in self._get(key):
            return True
        return False
 
    def iteritems(self):
        node = self._root
        while hasattr(node, "children"):
            node = node.children[0]
 
        while node:
            for pair in itertools.izip(node.contents, node.data):
                yield pair
            node = node.next
 
    def iterkeys(self):
        return itertools.imap(operator.itemgetter(0), self.iteritems())
 
    def itervalues(self):
        return itertools.imap(operator.itemgetter(1), self.iteritems())
 
    __iter__ = iterkeys
 
    def items(self):
        return list(self.iteritems())
 
    def keys(self):
        return list(self.iterkeys())
 
    def values(self):
        return list(self.itervalues())
 
    def _build_bulkloaded_leaves(self, items):
        minimum = self.order // 2
        leaves, seps = [[]], []
 
        for item in items:
            if len(leaves[-1]) >= self.order:
                seps.append(item)
                leaves.append([])
            leaves[-1].append(item)
 
        if len(leaves[-1]) < minimum and seps:
            last_two = leaves[-2] + leaves[-1]
            leaves[-2] = last_two[:minimum]
            leaves[-1] = last_two[minimum:]
            seps.append(last_two[minimum])
 
        leaves = [self.LEAF(
                self,
                contents=[p[0] for p in pairs],
                data=[p[1] for p in pairs])
            for pairs in leaves]
 
        for i in xrange(len(leaves) - 1):
            leaves[i].next = leaves[i + 1]
 
        return leaves, [s[0] for s in seps]
 
 
import random
import unittest
 
 
class BTreeTests(unittest.TestCase):
    def test_additions(self):
        bt = BTree(20)
        l = range(2000)
        for i, item in enumerate(l):
            bt.insert(item)
            self.assertEqual(list(bt), l[:i + 1])
 
    def test_bulkloads(self):
        bt = BTree.bulkload(range(2000), 20)
        self.assertEqual(list(bt), range(2000))
 
    def test_removals(self):
        bt = BTree(20)
        l = range(2000)
        map(bt.insert, l)
        rand = l[:]
        random.shuffle(rand)
        while l:
            self.assertEqual(list(bt), l)
            rem = rand.pop()
            l.remove(rem)
            bt.remove(rem)
        self.assertEqual(list(bt), l)
 
    def test_insert_regression(self):
        bt = BTree.bulkload(range(2000), 50)
 
        for i in xrange(100000):
            bt.insert(random.randrange(2000))
 
 
class BPlusTreeTests(unittest.TestCase):
    def test_additions_sorted(self):
        bt = BPlusTree(20)
        l = range(2000)
 
        for item in l:
            bt.insert(item, str(item))
 
        for item in l:
            self.assertEqual(str(item), bt[item])
 
        self.assertEqual(l, list(bt))
 
    def test_additions_random(self):
        bt = BPlusTree(20)
        l = range(2000)
        random.shuffle(l)
 
        for item in l:
            bt.insert(item, str(item))
 
        for item in l:
            self.assertEqual(str(item), bt[item])
 
        self.assertEqual(range(2000), list(bt))
 
    def test_bulkload(self):
        bt = BPlusTree.bulkload(zip(range(2000), map(str, range(2000))), 20)
 
        self.assertEqual(list(bt), range(2000))
 
        self.assertEqual(
                list(bt.iteritems()),
                zip(range(2000), map(str, range(2000))))
 
 
if __name__ == '__main__':
    unittest.main()
#==============================================================================
# Bubble Sort
#==============================================================================
# -*- coding: utf-8 -*-
from __future__ import print_function, division, absolute_import
from numba import *
import numpy as np
from timeit import default_timer as timer

def bubblesort(X, doprint):
    N = X.shape[0]
    for end in range(N, 1, -1):
        for i in range(end - 1):
            cur = X[i]
            if cur > X[i + 1]:
                tmp = X[i]
                X[i] = X[i + 1]
                X[i + 1] = tmp
#        if doprint:
#            print("Iteration: %d" % X)

# bubblesort_fast = autojit(bubblesort)
bubblesort_fast = jit(void(int64[::1], boolean))(bubblesort)

dtype = np.int64

def main():

    Xtest = np.array(list(reversed(range(8))), dtype=dtype)

    print('== Test Pure-Python ==')
    X0 = Xtest.copy()
    bubblesort(X0, True)

    print('== Test Numba == ')
    X1 = Xtest.copy()
    bubblesort_fast(X1, True)
#    return

    print(X0)
    print(X1)
    assert all(X0 == X1)

    REP = 10
    N = 1400

    Xorig = np.array(list(reversed(range(N))), dtype=dtype)

    t0 = timer()
    for t in range(REP):
        X0 = Xorig.copy()
        bubblesort(X0, False)
    tpython = (timer() - t0) / REP

    t1 = timer()
    for t in range(REP):
        X1 = Xorig.copy()
        bubblesort_fast(X1, False)
    tnumba = (timer() - t1) / REP

    assert all(X0 == X1)

    print('Python', tpython)
    print('Numba', tnumba)
    print('Speedup', tpython / tnumba, 'x')


if __name__ == '__main__':
    main()


#==============================================================================
# Concurrency in Operating System
#==============================================================================
"""
Concurrency API for Swiftly.

Copyright 2011-2013 Gregory Holt

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

__all__ = ['Concurrency']

import sys
import Queue

try:
    from eventlet import GreenPool, sleep, Timeout
except ImportError:
    GreenPool = None
    sleep = None
    Timeout = None


class Concurrency(object):
    """
    Convenience class to support concurrency, if Eventlet is
    available; otherwise it just performs at single concurrency.

    :param concurrency: The level of concurrency desired. Default: 10
    """

    def __init__(self, concurrency=10):
        self.concurrency = concurrency
        if self.concurrency and GreenPool:
            self._pool = GreenPool(self.concurrency)
        else:
            self._pool = None
        self._queue = Queue.Queue()
        self._results = {}

    def _spawner(self, ident, func, *args, **kwargs):
        exc_type = exc_value = exc_tb = result = None
        try:
            result = func(*args, **kwargs)
        except (Exception, Timeout):
            exc_type, exc_value, exc_tb = sys.exc_info()
        self._queue.put((ident, (exc_type, exc_value, exc_tb, result)))

    def spawn(self, ident, func, *args, **kwargs):
        """
        Returns immediately to the caller and begins executing the
        func in the background. Use get_results and the ident given
        to retrieve the results of the func. If the func causes an
        exception, this exception will be caught and the
        sys.exc_info() will be returned via get_results.

        :param ident: An identifier to find the results of the func
            from get_results. This identifier can be anything unique
            to the Concurrency instance.
        :param func: The function to execute concurrently.
        :param args: The args to give the func.
        :param kwargs: The keyword args to the give the func.
        :returns: None
        """
        if self._pool:
            self._pool.spawn_n(self._spawner, ident, func, *args, **kwargs)
            sleep()
        else:
            self._spawner(ident, func, *args, **kwargs)

    def get_results(self):
        """
        Returns a dict of the results currently available. The keys
        are the ident values given with the calls to spawn. The
        values are tuples of (exc_type, exc_value, exc_tb, result)
        where:

        =========  ============================================
        exc_type   The type of any exception raised.
        exc_value  The actual exception if any was raised.
        exc_tb     The traceback if any exception was raised.
        result     If no exception was raised, this will be the
                   return value of the called function.
        =========  ============================================
        """
        try:
            while True:
                ident, value = self._queue.get(block=False)
                self._results[ident] = value
        except Queue.Empty:
            pass
        return self._results

    def join(self):
        """
        Blocks until all currently pending functions have finished.
        """
        if self._pool:
            self._pool.waitall()


#==============================================================================
# Operating System: Deadlock
#==============================================================================
import threading
from contextlib import contextmanager

# Thread-local state to stored information on locks already acquired
_local = threading.local()

@contextmanager
def acquire(*locks):
    # Sort locks by object identifier
    locks = sorted(locks, key=lambda x: id(x))   

    # Make sure lock order of previously acquired locks is not violated
    acquired = getattr(_local, 'acquired',[])
    if acquired and max(id(lock) for lock in acquired) >= id(locks[0]):
        raise RuntimeError('Lock Order Violation')

    # Acquire all of the locks
    acquired.extend(locks)
    _local.acquired = acquired
    try:
        for lock in locks:
            lock.acquire()
        yield
    finally:
        # Release locks in reverse order of acquisition
        for lock in reversed(locks):
            lock.release()
        del acquired[-len(locks):]


#==============================================================================
# DFS
#==============================================================================
"""DFS.py

Algorithms for depth first search in Python.
We need to search iteratively rather than recursively in
order to avoid Python's low recursion limit.

D. Eppstein, July 2004.
"""

# Types of edges in DFS traversal.
# The numerical values are used in DepthFirstSearcher, change with care.
forward = 1     # traversing edge (v,w) from v to w
reverse = -1    # returning backwards on (v,w) from w to v
nontree = 0     # edge (v,w) is not part of the DFS tree

whole_graph = object()  # special flag object, do not use as a graph vertex

def search(G,initial_vertex = whole_graph):
    """
    Generate sequence of triples (v,w,edgetype) for DFS of graph G.
    The subsequence for each root of each tree in the DFS forest starts
    with (root,root,forward) and ends with (root,root,reverse).
    If the initial vertex is given, it is used as the root and vertices
    not reachable from it are not searched.
    """
    visited = set()
    if initial_vertex == whole_graph:
        initials = G
    else:
        initials = [initial_vertex]
    for v in initials:
        if v not in visited:
            yield v,v,forward
            visited.add(v)
            stack = [(v,iter(G[v]))]
            while stack:
                parent,children = stack[-1]
                try:
                    child = next(children)
                    if child in visited:
                        yield parent,child,nontree
                    else:
                        yield parent,child,forward
                        visited.add(child)
                        stack.append((child,iter(G[child])))
                except StopIteration:
                    stack.pop()
                    if stack:
                        yield stack[-1][0],parent,reverse
            yield v,v,reverse

def preorder(G,initial_vertex = whole_graph):
    """Generate all vertices of graph G in depth-first preorder."""
    for v,w,edgetype in search(G,initial_vertex):
        if edgetype is forward:
            yield w

def postorder(G,initial_vertex = whole_graph):
    """Generate all vertices of graph G in depth-first postorder."""
    for v,w,edgetype in search(G,initial_vertex):
        if edgetype is reverse:
            yield w

def reachable(G,v,w):
    """Can we get from v to w in graph G?"""
    return w in preorder(G,v)

class Searcher:
    """
    Handler for performing general depth first searches of graphs.
    Some or all of the routines preorder, postorder, and backedge
    should be shadowed in order to make the search do something useful.
    """

    def preorder(self,parent,child):
        """
        Called when DFS visits child, before visiting all grandchildren.
        Parent==child when child is the root of each DFS tree.
        """
        pass

    def postorder(self,parent,child):
        """
        Called when DFS visits child, after visiting all grandchildren.
        Parent==child when child is the root of each DFS tree.
        """
        pass

    def backedge(self,source,destination):
        """Called when DFS discovers an edge to a non-child."""
        pass

    def __init__(self,G):
        """Perform a depth first search of graph G."""
        dispatch = [self.backedge,self.preorder,self.postorder]
        for v,w,edgetype in search(G):
            dispatch[edgetype](v,w)


#==============================================================================
# Dijkestra
#==============================================================================
# Dijkstra's algorithm for shortest paths
# David Eppstein, UC Irvine, 4 April 2002

# http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/117228
from priodict import priorityDictionary

def Dijkstra(G,start,end=None):
	"""
	Find shortest paths from the  start vertex to all vertices nearer than or equal to the end.

	The input graph G is assumed to have the following representation:
	A vertex can be any object that can be used as an index into a dictionary.
	G is a dictionary, indexed by vertices.  For any vertex v, G[v] is itself a dictionary,
	indexed by the neighbors of v.  For any edge v->w, G[v][w] is the length of the edge.
	This is related to the representation in <http://www.python.org/doc/essays/graphs.html>
	where Guido van Rossum suggests representing graphs as dictionaries mapping vertices
	to lists of outgoing edges, however dictionaries of edges have many advantages over lists:
	they can store extra information (here, the lengths), they support fast existence tests,
	and they allow easy modification of the graph structure by edge insertion and removal.
	Such modifications are not needed here but are important in many other graph algorithms.
	Since dictionaries obey iterator protocol, a graph represented as described here could
	be handed without modification to an algorithm expecting Guido's graph representation.

	Of course, G and G[v] need not be actual Python dict objects, they can be any other
	type of object that obeys dict protocol, for instance one could use a wrapper in which vertices
	are URLs of web pages and a call to G[v] loads the web page and finds its outgoing links.
	
	The output is a pair (D,P) where D[v] is the distance from start to v and P[v] is the
	predecessor of v along the shortest path from s to v.
	
	Dijkstra's algorithm is only guaranteed to work correctly when all edge lengths are positive.
	This code does not verify this property for all edges (only the edges examined until the end
	vertex is reached), but will correctly compute shortest paths even for some graphs with negative
	edges, and will raise an exception if it discovers that a negative edge has caused it to make a mistake.
	"""

	D = {}	# dictionary of final distances
	P = {}	# dictionary of predecessors
	Q = priorityDictionary()	# estimated distances of non-final vertices
	Q[start] = 0
	
	for v in Q:
		D[v] = Q[v]
		if v == end: break
		
		for w in G[v]:
			vwLength = D[v] + G[v][w]
			if w in D:
				if vwLength < D[w]:
					raise ValueError, "Dijkstra: found better path to already-final vertex"
			elif w not in Q or vwLength < Q[w]:
				Q[w] = vwLength
				P[w] = v
	
	return (D,P)
			
def shortestPath(G,start,end):
	"""
	Find a single shortest path from the given start vertex to the given end vertex.
	The input has the same conventions as Dijkstra().
	The output is a list of the vertices in order along the shortest path.
	"""

	D,P = Dijkstra(G,start,end)
	Path = []
	while 1:
		Path.append(end)
		if end == start: break
		end = P[end]
	Path.reverse()
	return Path

# example, CLR p.528
G = {'s': {'u':10, 'x':5},
	'u': {'v':1, 'x':2},
	'v': {'y':4},
	'x':{'u':3,'v':9,'y':2},
	'y':{'s':7,'v':6}}

print Dijkstra(G,'s')
print shortestPath(G,'s','v')

#==============================================================================
# Dining Philosopher: Operating System
#==============================================================================
import threading
import random
import time
 
# Dining philosophers, 5 Philosphers with 5 chopsticks. 
# Must have two chopstick to eat.
# Deadlock is avoided by never waiting for a chopstick while holding a chopstick (locked)
#  
# dining philosophers http://en.wikipedia.org/wiki/Dining_philosophers_problem
# 'live lock' http://en.wikipedia.org/wiki/Livelock#Livelock
 
class Philosopher(threading.Thread):
 
    running = True
 
    def __init__(self, xname, chopstickOnLeft, chopstickOnRight):
        threading.Thread.__init__(self)
        self.name = xname
        self.chopstickOnLeft = chopstickOnLeft
        self.chopstickOnRight = chopstickOnRight
 
    def run(self):
        while(self.running):
            #  Philosopher is thinking (but really is sleeping).
            time.sleep( random.uniform(3,13))
            print("{n} is hungry.".format(n=self.name))
            self.dine()
 
    def dine(self):
        chopstick1, chopstick2 = self.chopstickOnLeft, self.chopstickOnRight
 
        while self.running:
            chopstick1.acquire(True)
            locked = chopstick2.acquire(False)
            if locked: break
            chopstick1.release()
            print("{n} swaps chopstick".format(n=self.name))
            chopstick1, chopstick2 = chopstick2, chopstick1
        else:
            return
 
        self.dining()
        chopstick2.release()
        chopstick1.release()
 
    def dining(self):			
        print("{n} starts eating".format(n=self.name))
        time.sleep(random.uniform(1,10))
        print("{n} finishes eating and starts to think.".format(n=self.name))
 
def DiningPhilosophers():
    chopstick = [threading.Lock() for n in range(5)]
    philosopher_names = ('Aristotle','Kant','Buddha','Marx', 'Russell')
 
    philosophers= [Philosopher(philosopher_names[i], chopstick[i%5], chopstick[(i+1)%5]) \
            for i in range(5)]
 
    random.seed(507129)
    Philosopher.running = True
    for p in philosophers:
        p.start()
    time.sleep(100)
    Philosopher.running = False
    print("Now we're finishing.")
 
DiningPhilosophers()

#==============================================================================
# Downhill Simplex
#==============================================================================
#!/usr/bin/env python
# encoding: utf-8

from numpy import *
from math import *


testfn_vectorspace = lambda (x): (1-x[0])**2 + 100*(x[1]-x[0]**2)**2

def DownhillSimplex(F, Start, slide=1.0, tol=1.0**-8):
	
	# Setup intial values
	
	n = len(Start)
	f = zeros(n+1)
	x = zeros((n+1,n))
	
	x[0] = Start
	
	# Setup intial X range
	
	for i in range(1,n+1):
		x[i] = Start
		x[i,i-1] = Start[i-1] + slide
	
	# Setup intial functions based on x's just defined
	
	for i in range(n+1):
		f[i] = F(x[i])
	
	# Main Loop operation, loops infinitly until break condition
	counter = 0
	while True:
		
		low = argmin(f)
		high = argmax(f)
		
		# Implement Counter 
		counter+=1
		
		# Compute Migration
		d = (-(n+1)*x[high]+sum(x))/n
		
		if sqrt(dot(d,d)/n)<tol:
			# Break condition, value is darn close
			return (x[low],counter)
			
		newX = x[high] + 2.0*d
		newF = F(newX)
		
		# Bad news, new values is lower than p. low
		
		if newF <= f[low]:
			x[high] = newX
			f[high] = newF
			newX = x[high] + d
			newF = F(newX)
			# Maybe I need to expand
			if newF <= f[low]:
				x[high] = newX
				f[high] = newF
		# Good news, new values is higher
		else:
			# Do I need to contract?
			if newF <= f[high]:
				x[high] = newX
				f[high] = newF
			else:
				# Contraction
				newX = x[high] + 0.5*d
				newF = F(newX)
				if newF <= f[high]:
					x[high] = newX
					f[high] = newF
				else:
					for i in range(len(x)):
						if i!=low:
							x[i] = (x[i]-x[low])
							f[i] = F(x[i])
	
	
# Example Call

(result, counter) =  DownhillSimplex(testfn_vectorspace, array([2.0,2.0]),1.0,1.0e-6)

print "Custom Downhill Simplex:"
print "Final Result: " + str(result)
print "Iteration Count: " + str(counter)


#==============================================================================
# Design Pattern: Builder
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

import abc

#==============================================================================
class Vehicle(object):

    def __init__(self, type_name):
        self.type = type_name
        self.wheels = None
        self.doors = None
        self.seats = None

    def view(self):
        print(
            "This vehicle is a " +
            self.type +
            " with; " +
            str(self.wheels) +
            " wheels, " +
            str(self.doors) +
            " doors, and " +
            str(self.seats) +
            " seats."
            )

#==============================================================================
class VehicleBuilder(object):
    """
    An abstract builder class, for concrete builders to be derived from.
    """
    __metadata__ = abc.ABCMeta
    
    @abc.abstractmethod
    def make_wheels(self):
        raise

    @abc.abstractmethod
    def make_doors(self):
        raise

    @abc.abstractmethod
    def make_seats(self):
        raise

#==============================================================================
class CarBuilder(VehicleBuilder):

    def __init__(self):
        self.vehicle = Vehicle("Car ")

    def make_wheels(self):
        self.vehicle.wheels = 4

    def make_doors(self):
        self.vehicle.doors = 3

    def make_seats(self):
        self.vehicle.seats = 5

#==============================================================================
class BikeBuilder(VehicleBuilder):

    def __init__(self):
        self.vehicle = Vehicle("Bike")

    def make_wheels(self):
        self.vehicle.wheels = 2

    def make_doors(self):
        self.vehicle.doors = 0

    def make_seats(self):
        self.vehicle.seats = 2

#==============================================================================
class VehicleManufacturer(object):
    """
    The director class, this will keep a concrete builder.
    """
    
    def __init__(self):
        self.builder = None

    def create(self):
        """ 
        Creates and returns a Vehicle using self.builder
        Precondition: not self.builder is None
        """
        assert not self.builder is None, "No defined builder"
        self.builder.make_wheels()
        self.builder.make_doors()
        self.builder.make_seats()
        return self.builder.vehicle
    
#==============================================================================
if (__name__ == "__main__"):
    manufacturer = VehicleManufacturer()
    
    manufacturer.builder = CarBuilder()
    car = manufacturer.create()
    car.view()

    manufacturer.builder = BikeBuilder()
    bike = manufacturer.create()
    bike.view()


#==============================================================================
# Design Pattern: Data Cache
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

# python imports
import math

#==============================================================================
class DataCache(object):

    def __init__(self):
        """ A class representing cachable data, starts invalid."""
        self.data = None

    def __call__(self):
        """ 
        When an instance is called it returns the stored data or None if no 
        data has been cached.
        e.g
        data = cached_data()
        """
        return self.data

    def __nonzero__(self):
        """ 
        Called on bool(instance) or if(instance) returns if there is data 
        cached.
        e.g
        if (not data):
            # set data
        """
        return self.data is not None
    
    def set(self, data):
        """ Sets the data. """
        self.data = data
        
    def reset(self):
        """ Returns the class to an invalid state. """
        self.data = None

#==============================================================================
class Line(object):
    
    def __init__(self, start, end):
        """ 
        This is a class representing a 2D line.
        Takes a start point and end point represented by two pairs.
        """
        self.start = start
        self.end = end
        self.length_data = DataCache()
        
    def length(self):
        if (not self.length_data):
            x_length = self.start[0] - self.end[0]
            y_length = self.start[1] - self.end[1]
            length = math.sqrt((x_length ** 2) + (y_length ** 2))
            self.length_data.set(length)
        else:
            print("Cached value used")
        return self.length_data()

#==============================================================================
if (__name__ == "__main__"):
    l = Line((0, 0), (1, 0))
    print(l.length())
    print(l.length())
    

#==============================================================================
# Design Pattern: Factory Method
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

#==============================================================================
class Line(object):
    """ A non-directed line. """

    def __init__(self, point_1, point_2):
        self.point_1 = point_1
        self.point_2 = point_2

    def __eq__(self, line):
        """ Magic method to overide == operator. """
        # if the lines are equal then the two points must be the same, but not 
        # necessarily named the same i.e self.point_1 == line.point_2 and 
        # self.point_2 == line.point_1 means that the lines are equal.
        if (type(line) != Line):
            return False
        if (self.point_1 == line.point_1):
            # line numbering matches
            return self.point_2 == line.point_2
        elif (self.point_1 == line.point_2):
            # line numbering does not match
            return self.point_2 == line.point_1
        else:
            # self.point_1 is not the start or end of the other line, not equal
            return False

#==============================================================================
class Vector(object):
    """ A directional vector. """
    
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, vector):
        """ Magic method to overide == operator. """
        if (type(vector) != Vector):
            return False
        return (self.x == vector.x) and (self.y == vector.y)

#------------------------------------------------------------------------------
# Factory functions
#------------------------------------------------------------------------------

class Factory(object):

    @classmethod
    def line_from_point_vector(self, point, vector):
        """ Returns the line from travelling vector from point. """
        new_point = (point[0] + vector.x, point[1] + vector.y)
        return Line(point, new_point)

    @classmethod
    def vector_from_line(self, line):
        """ 
        Returns the directional vector of the line. This is a vector v, such 
        that line.point_1 + v == line.point_2 
        """
        return Vector(
            line.point_2.x - line.point_1.x, 
            line.point_2.y - line.point_1.y
            )

#==============================================================================
if (__name__ == "__main__"):
    # make a line from (1, 1) to (1, 0), check that the line made from the 
    # point (1, 1) and the vector (0, -1) is the same line.
    constructor_line = Line((1, 1), (1, 0))
    vector = Vector(0, -1);
    factory_line = Factory.line_from_point_vector(
        (1, 1),
        vector
        )
    print(constructor_line == factory_line)
    

#==============================================================================
# Design Pattern: Interpreter
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

import re

#==============================================================================
class CamelCase(object):

    def __init__(self):
        self.SomeProperty = "A property"

    def SomeMethod(self, argument):
        print(argument)

#==============================================================================
class CamelCaseInterpreter(object):
    
    def __init__(self, old_class):
        super(CamelCaseInterpreter, self).__setattr__("__old_class", old_class)

    def __getattribute__(self, name):
        old_class = super(CamelCaseInterpreter, self).__getattribute__("__old_class")
        converter = super(CamelCaseInterpreter, self).__getattribute__("name_converter")
        return old_class.__getattribute__(converter(name))

    def __setattr__(self, name, value):
        old_class = super(CamelCaseInterpreter, self).__getattribute__("__old_class")
        converter = super(CamelCaseInterpreter, self).__getattribute__("name_converter")
        old_class.__setattr__(converter(name), value)

    def name_converter(self, name):
        """ 
        Converts function/property names which are lowercase with underscores 
        to CamelCase. i.e some_property becomes SomeProperty.
        """
        new_name = name[0].upper()
        previous_underscore = new_name == "_"
        for char in name[1:]:
            if (char == "_"):
                previous_underscore = True
            else:
                if (previous_underscore):
                    new_name += char.upper()
                else:
                    new_name += char
                previous_underscore = False
        return new_name

#==============================================================================
if (__name__ == "__main__"):
    old_class = CamelCase()

    interpreted_class = CamelCaseInterpreter(old_class)
    print(interpreted_class.some_property)

    interpreted_class.some_property = "Newly set property"
    print(interpreted_class.some_property)

    interpreted_class.some_method("Argument to some_method")
    

#==============================================================================
# Design Pattern: Iterator
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

#==============================================================================
class ReverseIterator(object):
    """ 
    Iterates the object given to it in reverse so it shows the difference. 
    """

    def __init__(self, iterable_object):
        self.list = iterable_object
        # start at the end of the iterable_object
        self.index = len(iterable_object)

    def __iter__(self):
        # return an iterator
        return self

    def next(self):
        """ Return the list backwards so it's noticeably different."""
        if (self.index == 0):
            # the list is over, raise a stop index exception
            raise StopIteration
        self.index = self.index - 1
        return self.list[self.index]

#==============================================================================
class Days(object):

    def __init__(self):
        self.days = [
        "Monday",
        "Tuesday", 
        "Wednesday", 
        "Thursday",
        "Friday", 
        "Saturday", 
        "Sunday"
        ]

    def reverse_iter(self):
        return ReverseIterator(self.days)

#==============================================================================
if (__name__ == "__main__"):
    days = Days()
    for day in days.reverse_iter():
        print(day)

#==============================================================================
# Design Pattern: Memento
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

import copy

#==============================================================================
class Memento(object):

    def __init__(self, data):
        # make a deep copy of every variable in the given class
        for attribute in vars(data):
            # mechanism for using properties without knowing their names
            setattr(self, attribute, copy.deepcopy(getattr(data, attribute)))

#==============================================================================
class Undo(object):

    def __init__(self):
        # each instance keeps the latest saved copy so that there is only one 
        # copy of each in memory
        self.__last = None

    def save(self):
        self.__last = Memento(self)

    def undo(self):
        for attribute in vars(self):
            # mechanism for using properties without knowing their names
            setattr(self, attribute, getattr(self.__last, attribute))

#==============================================================================
class Data(Undo):

    def __init__(self):
        super(Data, self).__init__()
        self.numbers = []

#==============================================================================
if (__name__ == "__main__"):
    d = Data()
    repeats = 10
    # add a number to the list in data repeat times
    print("Adding.")
    for i in range(repeats):
        print("0" + str(i) + " times: " + str(d.numbers))
        d.save()
        d.numbers.append(i)
    print("10 times: " + str(d.numbers))
    d.save()
    print("")
    
    # now undo repeat times
    print("Using Undo.")
    for i in range(repeats):
        print("0" + str(i) + " times: " + str(d.numbers))
        d.undo()
    print("10 times: " + str(d.numbers))

#==============================================================================
# Design Pattern: Mono State
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

# python imports

#==============================================================================
class MonoState(object):
    __data = 5
    
    @property
    def data(self):
        return self.__class__.__data

    @data.setter
    def data(self, value):
        self.__class__.__data = value

#==============================================================================
class MonoState2(object):
    pass

def add_monostate_property(cls, name, initial_value):
    """
    Adds a property "name" to the class "cls" (should pass in a class object 
    not a class instance) with the value "initial_value".
    
    This property is a monostate property so all instances of the class will 
    have the same value property. You can think of it being a singleton 
    property, the class instances will be different but the property will 
    always be the same.

    This will add a variable __"name" to the class which is the internal 
    storage for the property.

    Example usage:
    class MonoState(object):
        pass
        
    add_monostate_property(MonoState, "data", 5)
    m = MonoState()
    # returns 5
    m.data
    """
    internal_name = "__" + name

    def getter(self):
        return getattr(self.__class__, internal_name)
    def setter(self, value):
        setattr(self.__class__, internal_name, value)
    def deleter(self):
        delattr(self.__class__, internal_name)
    prop = property(getter, setter, deleter, "monostate variable: " + name)
    # set the internal attribute
    setattr(cls, internal_name, initial_value)
    # set the accesser property
    setattr(cls, name, prop)

#==============================================================================
if (__name__ == "__main__"):
    print("Using a class:")
    class_1 = MonoState()
    print("First data:  " + str(class_1.data))
    class_1.data = 4
    class_2 = MonoState()
    print("Second data: " + str(class_2.data))
    print("First instance:  " + str(class_1))
    print("Second instance: " + str(class_2))
    print("These are not singletons, so these are different instances")

    print("")
    print("")

    print("Dynamically adding the property:")
    add_monostate_property(MonoState2, "data", 5)
    dynamic_1 = MonoState2()
    print("First data:  " + str(dynamic_1.data))
    dynamic_1.data = 4
    dynamic_2 = MonoState2()
    print("Second data: " + str(dynamic_2.data))
    print("First instance:  " + str(dynamic_1))
    print("Second instance: " + str(dynamic_2))
    print("These are not singletons, so these are different instances")

#==============================================================================
# Design Pattern: Observer
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

import abc

class Observer(object):
    __metaclass__ = abc.ABCMeta
    
    @abc.abstractmethod
    def update(self):
        raise

class ConcreteObserver(Observer):
    pass

if (__name__ == "__main__"):
    print("thing")
    conc = ConcreteObserver()      

#==============================================================================
# Design Pattern: Resource Acquisition and Initialization
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

# python imports

# local imports

#==============================================================================
class Box(object):
    
    def __init__(self, name):
        self.name = name

    def __enter__(self):
        print("Box " + self.name + " Opened")
        return self

    def __exit__(self, exception_type, exception, traceback):
        all_none = all(
            arg is None for arg in [exception_type, exception, traceback]
            )
        if (not all_none):
            print("Exception: \"%s\" raised." %(str(exception)))
        print("Box Closed")
        print("")
        return all_none

#==============================================================================
if (__name__ == "__main__"):
    with Box("tupperware") as simple_box:
        print("Nothing in " + simple_box.name)
    with Box("Pandora's") as pandoras_box:
        raise Exception("All the evils in the world")
    print("end")


#==============================================================================
# Design Pattern: Singleton
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

import abc

#==============================================================================
class Singleton(object):
    """ A generic base class to derive any singleton class from. """
    __metaclass__ = abc.ABCMeta
    __instance = None

    def __new__(new_singleton, *arguments, **keyword_arguments):
        """Override the __new__ method so that it is a singleton."""
        if new_singleton.__instance is None:
            new_singleton.__instance = object.__new__(new_singleton)
            new_singleton.__instance.init(*arguments, **keyword_arguments)
        return new_singleton.__instance

    @abc.abstractmethod
    def init(self, *arguments, **keyword_arguments):
        """ 
        as __init__ will be called on every new instance of a base class of 
        Singleton we need a function for initialisation. This will only be 
        called once regardless of how many instances of Singleton are made.
        """
        raise

#==============================================================================
class GlobalState(Singleton):

    def init(self):
        self.value = 0
        print("init() called once")
        print("")

    def __init__(self):
        print("__init__() always called")
        print("")

class DerivedGlobalState(GlobalState):
    
    def __init__(self):
        print("derived made")
        super(DerivedGlobalState, self).__init__()

    def thing(self):
        print(self.value)

#==============================================================================
if (__name__ == "__main__"):
    d = DerivedGlobalState()
    print(type(d))
    d.thing()
    d.value = -20
    e = DerivedGlobalState()
    e.thing()
    f = DerivedGlobalState()
    f.thing()
    
    a = GlobalState()
    # value is default, 0
    print("Expecting 0, value = %i" %(a.value))
    print("")

    # set the value to 5
    a.value = 5

    # make a new object, the value will still be 5
    b = GlobalState()
    print("Expecting 5, value = %i" %(b.value))
    print("")
    print("Is a == b? " + str(a == b))

#==============================================================================
# Design Pattern: State
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

#==============================================================================
class Language(object):
    
    def greet(self):
        return self.greeting

#==============================================================================
class English(Language):
    
    def __init__(self):
        self.greeting = "Hello"

#==============================================================================
class French(Language):
    
    def __init__(self):
        self.greeting = "Bonjour"

#==============================================================================
class Spanish(Language):
    
    def __init__(self):
        self.greeting = "Hola"

#==============================================================================
class Multilinguist(object):

    def __init__(self, language):
        self.greetings = {
            "English": "Hello",
            "French": "Bonjour",
            "Spanish": "Hola"
            }
        self.language = language

    def greet(self):
        print(self.greetings[self.language])

#==============================================================================
if (__name__ == "__main__"):

    # talking in English
    translator = Multilinguist("English")
    translator.greet()

    # meets a Frenchman
    translator.language = "French"
    translator.greet()

    # greets a Spaniard
    translator.language = "Spanish"    
    translator.greet()

#==============================================================================
# Design Pattern: Strategy
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

#==============================================================================
class PrimeFinder(object):
    
    def __init__(self, algorithm):
        """ 
        Constructor, takes a callable object called algorithm. 
        algorithm should take a limit argument and return an iterable of prime 
        numbers below that limit.
        """ 
        self.algorithm = algorithm
        self.primes = []

    def calculate(self, limit):
        """ Will calculate all the primes below limit. """
        self.primes = self.algorithm(limit)

    def out(self):
        """ Prints the list of primes prefixed with which algorithm made it """
        print(self.algorithm.__name__)
        for prime in self.primes:
            print(prime)
        print("")

#==============================================================================
def hard_coded_algorithm(limit):
    """ 
    Has hardcoded values for all the primes under 50, returns a list of those
    which are less than the given limit.
    """
    hardcoded_primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
    primes = []
    for prime in hardcoded_primes:
        if (prime < limit):
            primes.append(prime)
    return primes

#==============================================================================
def standard_algorithm(limit):
    """ 
    Not a great algorithm either, but it's the normal one to use.
    It puts 2 in a list, then for all the odd numbers less than the limit if 
    none of the primes are a factor then add it to the list.
    """
    primes = [2]
    # check only odd numbers.
    for number in range(3, limit, 2):
        is_prime = True
        # divide it by all our known primes, could limit by sqrt(number)
        for prime in primes:
            if (number % prime == 0):
                is_prime = False
                break
        if (is_prime):
            primes.append(number)
    return primes

#==============================================================================
class HardCodedClass(object):
    
    def __init__(self, limit):
        hardcoded_primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
        self.primes = []
        for prime in hardcoded_primes:
            if (prime < limit):
                self.primes.append(prime)
        
    def __iter__(self):
        return iter(self.primes)

#==============================================================================
if (__name__ == "__main__"):
    hardcoded_primes = PrimeFinder(hard_coded_algorithm)
    hardcoded_primes.calculate(50)
    hardcoded_primes.out()

    standard_primes = PrimeFinder(standard_algorithm)
    standard_primes.calculate(50)
    standard_primes.out()

    class_primes = PrimeFinder(HardCodedClass)
    class_primes.calculate(50)
    class_primes.out()

    print(
        "Do the two algorithms get the same result on 50 primes? %s" 
        %(str(hardcoded_primes.primes == standard_primes.primes))
        )

    # the hardcoded algorithm only works on numbers under 50
    hardcoded_primes.calculate(100)
    standard_primes.calculate(100)

    print(
        "Do the two algorithms get the same result on 100 primes? %s" 
        %(str(hardcoded_primes.primes == standard_primes.primes))
        )

#==============================================================================
# Design Pattern: Facade
#==============================================================================
#!/usr/bin/env python
# Written by: DGC
# An example of how the client interacts with a complex series of objects 
# (car engine, battery and starter motor) through a facade (the car)

#==============================================================================
class Engine(object):
    
    def __init__(self):
        # how much the motor is spinning in revs per minute
        self.spin = 0

    def start(self, spin):
        if (spin > 2000):
            self.spin = spin // 15

#==============================================================================
class StarterMotor(object):
    
    def __init__(self):
        # how much the starter motor is spinning in revs per minute
        self.spin = 0

    def start(self, charge):
        # if there is enough power then spin fast
        if (charge > 50):
            self.spin = 2500

#==============================================================================
class Battery(object):

    def __init__(self):
        # % charged, starts flat
        self.charge = 0

#==============================================================================
class Car(object):
    # the facade object that deals with the battery, engine and starter motor.
    
    def __init__(self):
        self.battery = Battery()
        self.starter = StarterMotor()
        self.engine = Engine()
        
    def turn_key(self):
        # use the battery to turn the starter motor
        self.starter.start(self.battery.charge)

        # use the starter motor to spin the engine
        self.engine.start(self.starter.spin)
        
        # if the engine is spinning the car is started
        if (self.engine.spin > 0):
            print("Engine Started.")
        else:
            print("Engine Not Started.")

    def jump(self):
        self.battery.charge = 100
        print("Jumped")

#==============================================================================
if (__name__ == "__main__"):
    corsa = Car()
    corsa.turn_key()
    corsa.jump()
    corsa.turn_key()

#==============================================================================
# Algorithm: Network Computation
#==============================================================================
"Network flow computations."

import networkx as nx
from decimal import Decimal as D

from django.conf import settings
from django.core.cache import cache

from cc.account.models import CreditLine, Node
from cc.ripple import SCALE  # Number of decimal places in amounts.
from cc.payment.mincost import min_cost_flow

COST_SCALE_FACTOR = 1000000

class PaymentError(Exception):
    "Base class for all payment exceptions."
    pass

class NoRoutesError(PaymentError):
    "No possible routes between payer and recipient."
    pass

class InsufficientCreditError(PaymentError):
    "Not enough max flow between payer and recipient to make payment."
    pass

class FlowGraph(object):
    def __init__(self, payer, recipient, ignore_balances=False):
        "Takes payer and recipient nodes."
        self.payer = payer
        self.recipient = recipient
        self.graph = get_graph(self.payer, ignore_balances)
        
    def min_cost_flow(self, amount):
        """
        Determine minimum cost route for given amount between payer and
        recipient.
        
        Raises NoRoutesError if there is no route from payer to recipient.
        Raises InsufficientCreditError if the network cannot support the
        specified flow amount.
        """
        self._set_endpoint_demand(amount)
        if self.recipient.alias not in self.graph.nodes():
            raise NoRoutesError()
        try:
            _, flow_dict = min_cost_flow(self.graph)
        except nx.NetworkXUnfeasible:
            raise InsufficientCreditError()
        else:
            amounts = creditline_amounts(flow_dict, self.graph)
            return amounts

    def max_flow(self):
        if (self.recipient.alias not in self.graph.nodes() or
            self.payer.alias not in self.graph.nodes()):
            return 0
        try:
            amount = nx.max_flow(
                unmulti(self.graph), self.payer.alias, self.recipient.alias)
        except nx.NetworkXUnbounded:
            return D('Infinity')
        else:
            return unscale_flow_amount(amount)
            
    def _set_endpoint_demand(self, amount):
        "Add payer and recipient nodes with corresponding demands values."
        self.graph.node[self.payer.alias]['demand'] = scale_flow_amount(-amount)
        self.graph.node[self.recipient.alias]['demand'] = (
            scale_flow_amount(amount))

def get_graph(seed_node, ignore_balances=False, rebuild_graph=False):
    """
    Get flow graph for performing payment computations.

    A flow graph is a connected directed networkx DiGraph where the edges
    represent account-halves and exchanges between them performed by various
    users.  Payment always flows from credit line owner to the other
    partner.

    A flow graph contains all credit lines that could possibly be used to
    transfer value from seed_node to anyone else.  It may also contain other
    account-halves so it can be cached and used for other payments.  For
    example, the flow graph might contain the set of all nodes that could
    pay or be paid by the payer.

    If ignore_balances is True, existing account balances are ignored (assumed
    to be zero), allowing for flow calculations based only credit limits,
    which can be used for reputation metrics.
    
    The flow graph assigns costs to each credit line edge in order prioritize
    settling balances.  If ignore_balances is True, costs are all zero.

    To use this graph in the min cost demand flow algorithm, assign the payer
    a supply (negative demand) and the recipient a demand equal to the payment
    amount.

    Flow graph nodes are node aliases.
    """
    graph = None
    rebuilt = False
    if not rebuild_graph:
        graph = get_cached_graph(ignore_balances)
    if not graph:
        graph = build_graph(ignore_balances)
        set_cached_graph(graph, ignore_balances)
        rebuilt = True
    # Get subgraph component containing seed_node.
    for component in nx.weakly_connected_component_subgraphs(graph):
        if seed_node.alias in component:
            return component
    # Seed node not in cached graph - rebuild and try again.
    if not rebuilt:
        return get_graph(seed_node, ignore_balances, rebuild_graph=True)
    # Something's not coded right...
    assert(False)  # Should never get here.

def get_cached_graph(ignore_balances):
    return cache.get(cache_key(ignore_balances))

def set_cached_graph(graph, ignore_balances):
    cache.set(cache_key(ignore_balances), graph)

def cache_key(ignore_balances):
    return 'reputation_graph' if ignore_balances else 'payment_graph'

def update_creditline_in_cached_graphs(creditline):
    """
    Updates creditline in both payment and reputation graphs.
    *** Not threadsafe! ***
    """
    # Update in both cached graphs.
    for ignore_balances in (False, True):
        graph = get_cached_graph(ignore_balances)
        if not graph:
            continue
        if creditline.id:
            # Reload record to get absolute freshest data possible.
            try:
                creditline = CreditLine.objects.get(pk=creditline.id)
            except CreditLine.DoesNotExist:
                creditline.id = None
        update_creditline_in_graph(graph, creditline, ignore_balances)
        set_cached_graph(graph, ignore_balances)

def build_graph(ignore_balances):
    graph = nx.MultiDiGraph()
    graph.add_nodes_from((n.alias for n in Node.objects.iterator()))
    creditlines = CreditLine.objects.select_related(depth=1).iterator()
    for creditline in creditlines:
        update_creditline_in_graph(graph, creditline, ignore_balances)
    return graph

def update_creditline_in_graph(graph, creditline, ignore_balances):
    src = creditline.node.alias
    dest = creditline.partner.alias
    graph.remove_edges_from([(src, dest)])
    if ignore_balances:
        chunks = [(scale_flow_amount(creditline.limit), 0)]
    else:
        chunks = edge_data(creditline)
    for i, chunk in enumerate(chunks):
        capacity, weight = chunk
        graph.add_edge(src, dest, key=i, weight=weight,
                       creditline_id=creditline.id)
        # Infinite capacity is indicated by not adding a capacity.
        if capacity != D('Infinity'):
            graph[src][dest][i]['capacity'] = capacity

def edge_data(creditline):
    """
    Assigns a cost to using this creditline in a payment.  Cashing in existing
    IOUs has zero cost.  Issuing existing IOUs has a cost of 1 + distance of
    current balance from zero relative to the limit.

    Returns a tuple of (capacity, weight) tuples representing chunks of usable
    credit capacity, since when there is a positive balance, using up that
    balance will carry different weight than anything beyond.

    (TODO: Ideally, costs would be in proportion to the amount of credit
    remaining *after* the payment, but that is not known yet, and the naive min
    cost demand flow algorithm used can't factor that in.)
    """
    if creditline.limit is None:
        # No cost if no limit -- treat as if balance is always 0.
        data = ((D('Infinity'), 0),)  # Capacity is infinite.
    else:
        if creditline.balance > 0:
            # Return two chunks: one to get to zero balance, one for remainder.
            # Give positive cost only to issuing in new IOUs.
            data = ((creditline.balance, 0), (creditline.limit, 1))
        else:
            # No positive balance to cash in.
            capacity = creditline.balance + creditline.limit
            if creditline.limit != 0:
                cost = 1.0 + (float(creditline.balance / creditline.limit))
            else:
                cost = 0
            data = ((capacity, cost),)
    return scale_edge_data(data)

def scale_edge_data(edge_data):
    "Scale capacities and costs to ints."
    new_data = []
    for capacity, cost in edge_data:
        new_data.append((scale_flow_amount(capacity),
                         int(cost * COST_SCALE_FACTOR)))
    return new_data

def creditline_amounts(flow_dict, graph):
    """
    Returns a list of (creditline_id, amount) tuples that represent the
    flow of a payment. Takes a flow_dict from min_cost_flow.
    """
    amount_dict = {}  # Index by creditline.
    for src_node, node_flow_dict in flow_dict.items():
        for dest_node, edge_dict in node_flow_dict.items():
            creditline_id = graph[src_node][dest_node][0].get('creditline_id')
            for amount in edge_dict.values():
                amount = unscale_flow_amount(amount)
                if amount == 0:  # Ignore zero amounts.
                    continue
                amount_dict.setdefault(creditline_id, 0)
                amount_dict[creditline_id] += amount
    return amount_dict.items()

def scale_flow_amount(amount):
    "Convert amount decimal to int for min cost flow algorithm."
    if amount != D('Infinity'):
        amount = int(amount * 10**SCALE)
    return amount

def unscale_flow_amount(amount):
    "Convert scaled flow amount int back to decimal."
    return D(amount) / D('1' + '0' * SCALE)

def unmulti(G):
    # Convert multidigraph to regular digraph by inserting nodes in the middle
    # of each edge.
    H = nx.DiGraph()
    for n, data in G.nodes(data=True):
        H.add_node(n, **data)
    for u, v, k, data in G.edges(keys=True, data=True):
        i = '%s__%s__%s' % (u, v, k)
        H.add_edge(u, i, **data)
        H.add_edge(i, v)
    return H

#==============================================================================
# Floyd Warshal
#==============================================================================
"""
 * FloydWarshall.py
 *
 * Implementation of Floyd Warshall Algorithm
 * 
 * See README for details
 * 
 * by:
 *    Ananth Murthy
 * 	  Chandan Yeshwanth
 * 
 * on:
 * 	  14th April 2014
 * 
"""

import sys 


# recursive function to obtain the path as a string
def obtainPath(i, j):
    if dist[i][j] == float("inf"):
        return " no path to "
    if parent[i][j] == i:
        return " "
    else :
        return obtainPath(i, parent[i][j]) + str(parent[i][j]+1) + obtainPath(parent[i][j], j)


if len(sys.argv) < 2:
	print "Check README for usage."
	sys.exit(-1)
	
try:	
	fil = open(sys.argv[1], "r")
except IOError:
	print "File not found."
	sys.exit(-1)


# no of vertices
V = int(fil.readline().strip())

# array of shortest path distances 
dist = []

# array of shortest paths
parent = []

# no of edges
E = int(fil.readline().strip())




# initialize to infinity
for i in range (0, V):
    dist.append([])
    parent.append([])
    for j in range (0, V):
        dist[i].append(float("inf"))
        parent[i].append(0)




# read edges from input file and store
for i in range (0,E):
    t = fil.readline().strip().split()
    x = int(t[0]) - 1
    y = int(t[1]) - 1
    w = int(t[2])
    dist[x][y] = w
    parent[x][y] = x


# path from vertex to itself is set to 0
for i in range (0,V):
    dist[i][i] = 0



# initialize the path matrix
for i in range (0,V):
    for j in range (0,V):
        if dist[i][j] == float("inf"):
            parent[i][j] = 0
        else:
            parent[i][j] = i



# actual floyd warshall algorithm
for k in range(0,V):
    for i in range(0,V):
        for j in range(0,V):
            if dist[i][j] > dist[i][k] + dist[k][j]:
                dist[i][j] = dist[i][k] + dist[k][j]
                parent[i][j] = parent[k][j]
                
                
                
# check for negative cycles
for i in range (0,V):
    if dist[i][i] != 0:
        print "Negative cycle at : ", i+1
        sys.exit() 


# display final paths
print "All Pairs Shortest Paths : \n"

# display shortest paths 
for i in range (0,V):
    print
    for j in range (0,V):
        print "From :", i+1, " To :", j+1
        print "Path :", str(i+1) + obtainPath(i,j) + str(j+1)
        print "Distance :", dist[i][j]
        print 

fil.close()

#==============================================================================
# Hashtable
#==============================================================================	
#!/usr/bin/env python
 
import sys
 
class Item:
    key   = ""
    value = 0
 
    def __init__(self,key,value):
        self.key = key
        self.value = value
 
    def print(self):
        print("  '" + self.key + "' / " + str(self.value) )
     
 
class HashTable:
    'Common base class for a hash table'
    tableSize    = 0
    entriesCount = 0
    alphabetSize = 2*26
    hashTable    = []
     
 
    def __init__(self, size):
        self.tableSize = size
        self.hashTable = [[] for i in range(size)]
 
    def char2int(self,char):
        if char >= 'A' and char <= 'Z':
            return ord(char)-65
        elif char >= 'a' and char <= 'z':
            return ord(char)-65-7
        else:
            raise NameError('Invalid character in key! Alphabet is [a-z][A-Z]')
         
    def hashing(self,key):
        hash = 0
        for i,c in enumerate ( key ):
            hash += pow(self.alphabetSize, len(key)-i-1) * self.char2int(c)
        return hash % self.tableSize
 
    def insert(self,item):
        hash = self.hashing(item.key)
        # print(hash)
        for i,it in enumerate(self.hashTable[hash]):
            if it.key == item.key:
                del self.hashTable[hash][i]
                self.entriesCount -= 1
        self.hashTable[hash].append(item)
        self.entriesCount += 1           
 
    def get(self,key):
        print ("Getting item(s) with key '" + key + "'")
        hash = self.hashing(key)
        for i,it in enumerate(self.hashTable[hash]):
            if it.key == key:
                return self.hashTable[hash]
        print (" NOT IN TABLE!")            
        return None
 
    def delete(self,key):
        print ("Deleting item with key '" + key + "'")
        hash = self.hashing(key)
        for i,it in enumerate(self.hashTable[hash]):
            if it.key == key:
                del self.hashTable[hash][i]
                self.entriesCount -= 1
                return
        print (" NOT IN TABLE!")            
             
    def print(self):
        print ( ">>>>> CURRENT TABLE BEGIN >>>>" )
        print ( str(self.getNumEntries()) + " entries in table" )
        for i in range(self.tableSize):
            print ( " [" + str(i) + "]: " )
            for j in range(len(self.hashTable[i])):
                self.hashTable[i][j].print()
        print ( "<<<<< CURRENT TABLE END <<<<<" )
 
    def getNumEntries(self):
        return self.entriesCount
 
 
if __name__ == "__main__":
    hs = HashTable(11)
 
    item = Item("one",1)
    hs.insert(item)
    hs.print()
    hs.insert(item)
    hs.print()
 
    item = Item("two",2)
    hs.insert(item)
 
    item = Item("three",3)
    hs.insert(item)
    hs.print()
 
    item = Item("one",4);
    hs.insert(item);
 
    items = hs.get("one");
    if items != None:
        for j in range(len(items)):
            items[j].print()
     
    item = Item("PheewThisIsALongOne",12345)
    hs.insert(item)
    hs.print()
 
    items = hs.get("PheewThisIsALongOne")
    if items != None:
        for j in range(len(items)):
            items[j].print()
         
    items = hs.get("PheewThisIsOne")
    if items != None:
        for j in range(len(items)):
            items[j].print()
         
    hs.delete("PheewThisIsALongOne")
    hs.print()
 
    hs.delete("PheewThisIsTheOne")
    hs.print()
 
    hs.delete("one")
    hs.print()
 
    # This one leads to an exception as '!' is not part of the allowed alphabet
    # item = Item("!", 5)
    # hs.insert(item)
	
#==============================================================================
# HeapSort
#==============================================================================
#!/usr/bin/env python
# coding: utf-8

# Worst Case:    O(n log n)
# Best Case:     O(n log n)
# Average Case:  O(n log n)

def heapsort(a):
    """Run heapsort on a list a

    >>> a = [32,46,77,4344564,7322,3,46,7,32457,7542,4,667,54,]
    >>> heapsort(a)
    >>> print(a)
    [3, 4, 7, 32, 46, 46, 54, 77, 667, 7322, 7542, 32457, 4344564]
    """

    heapify(a, len(a))
    end = len(a)-1
    while end > 0:
        a[end], a[0] = a[0], a[end]
        end -= 1
        sift_down(a, 0, end)

def heapify(a, count):
    start = int((count-2)/2)
    while start >= 0:
        sift_down(a, start, count-1)
        start -= 1

def sift_down(a, start, end):
    root = start
    while (root*2+1) <= end:
        child = root * 2 + 1
        swap = root
        if a[swap] < a[child]:
            swap = child
        if (child + 1) <= end and a[swap] < a[child+1]:
            swap = child+1
        if swap != root:
            a[root], a[swap] = a[swap], a[root]
            root = swap
        else:
            return

if __name__ == "__main__":
    import doctest
    doctest.testmod()

#==============================================================================
# Insertation Sort
#==============================================================================
"""
Insertion Sort

Take the last value of a list and compare it to each element
of the sorted sublist and places it accordingly until there 
are no more elements of the given list.


Worst Case Performance: O(n^2) comparisons and swaps
Best Case Performance: O(n) comparisons, O(1) swaps
Average Case Performance: O(n^2) comparisons and swaps
"""

def insertionSort(inlist):
	inlistLength = len(inlist)

	for i in range(inlistLength):
		sorting_value = inlist[i]
		j = i - 1
		while j >= 0 and inlist[j] > sorting_value:
			inlist[j+1] = inlist[j]
			j -= 1
		inlist[j+1] = sorting_value

	return inlist

def insertionSort2(inlist):
	inlistLength = len(inlist)

	for i in range(inlistLength):
		sorting_value = inlist[i]
		for j in range(i - 1, -1, -1):
			if inlist[j] > sorting_value:
				inlist[j+1] = inlist[j]
		inlist[j+1] = sorting_value

	return inlist

# test
mylist = [0,10,3,2,11,22,40,-1,5]

print insertionSort(mylist)
#==============================================================================
# Interval Scheduling
#==============================================================================
import time
from datetime import datetime

"""
Unweighted Interval scheduling algorithm.
Runtime complexity: O(n log n)
"""

class Interval(object):
    '''Date interval'''

    def __init__(self, title, start, finish):
        self.title = title
        self.start = int(time.mktime(datetime.strptime(start, "%d %b, %y").timetuple()))
        self.finish = int(time.mktime(datetime.strptime(finish, "%d %b, %y").timetuple()))

    def __repr__(self):
        return str((self.title, self.start, self.finish))



def schedule_unweighted_intervals(I):
    '''Use greedy algorithm to schedule unweighted intervals
       sorting is O(n log n), selecting is O(n)
       whole operation is dominated by O(n log n)
    '''

    I.sort(lambda x, y: x.finish - y.finish)  # f_1 <= f_2 <= .. <= f_n

    O = []
    finish = 0
    for i in I:
        if finish <= i.start:
            finish = i.finish
            O.append(i)

    return O

if __name__ == '__main__':
    I = []
    I.append(Interval("Summer School" , "14 Jan, 13", "24 Feb, 13"))
    I.append(Interval("Semester 1" , "1 Mar, 13", "4 Jun, 13"))
    I.append(Interval("Semester 2" , "18 Aug, 13", "24 Nov, 13"))
    I.append(Interval("Trimester 1" , "22 Mar, 13", "16 May, 13"))
    I.append(Interval("Trimester 2" , "22 May, 13", "24 Jul, 13"))
    I.append(Interval("Trimester 3" , "28 Aug, 13", "16 Nov, 13"))
    O = schedule_unweighted_intervals(I)


#==============================================================================
# Algorithm: Knapsack Problem
#==============================================================================
# 0-1 knapsack problem dynamic program
# David Eppstein, ICS, UCI, 2/22/2002

# each item to be packed is represented as a set of triples (size,value,name)
def itemSize(item): return item[0]
def itemValue(item): return item[1]
def itemName(item): return item[2]

# example used in lecture
exampleItems = [(3,3,'A'),
		(4,1,'B'),
		(8,3,'C'),
		(10,4,'D'),
		(15,3,'E'),
		(20,6,'F')]
		
exampleSizeLimit = 32

# inefficient recursive algorithm
# returns optimal value for given
#
# note items[-1] is the last item, items[:-1] is all but the last item
#
def pack1(items,sizeLimit):
	if len(items) == 0:
		return 0
	elif itemSize(items[-1]) > sizeLimit:
		return pack(items[:-1],sizeLimit)
	else:
		return max(pack(items[:-1],sizeLimit),
			   pack(items[:-1],sizeLimit-itemSize(items[-1])) +
				itemValue(items[-1]))

# refactor so all params are integers
#
def pack2(items,sizeLimit):
	def recurse(nItems,lim):
		if nItems == 0:
			return 0
		elif itemSize(items[nItems-1]) > lim:
			return recurse(nItems-1,lim)
		else:
			return max(recurse(nItems-1,lim),
				   recurse(nItems-1,lim-itemSize(items[nItems-1])) +
					itemValue(items[nItems-1]))
	return recurse(len(items),sizeLimit)

# memoize
#
# Unlike previous class examples, I'm going to use a Python dictionary
# rather than a list of lists, because it's similarly efficient but can
# handle double indexing better.  Also that way I can use the has_key method
# instead of having to initialize each entry with a flag value.
#
# The difference in actual syntax is dictionary[item1,item2] instead of
# listoflists[item1][item2], and an empty dictionary is {} instead of [].
# The extra pair of parens in has_key is also important.
#
def pack3(items,sizeLimit):
	P = {}

	def recurse(nItems,lim):
		if not P.has_key((nItems,lim)):
			if nItems == 0:
				P[nItems,lim] = 0
			elif itemSize(items[nItems-1]) > lim:
				P[nItems,lim] = recurse(nItems-1,lim)
			else:
				P[nItems,lim] = max(recurse(nItems-1,lim),
				    recurse(nItems-1,lim-itemSize(items[nItems-1])) +
					itemValue(items[nItems-1]))
		return P[nItems,lim]

	return recurse(len(items),sizeLimit)

# iterate
# 
# At this step we have to think about how to order the nested loops over
# the two indices nItems and lim.  Each recursive call involves nItems-1,
# so the natural choice is to make the outer loop be over values of nItems.
# The ordering in the inner loop is not so important.
#
# The recursive function definition and has_key lines have been replaced
# by a nested pair of loops.  All recursive calls have been replaced
# by dictionary lookups.
#
def pack4(items,sizeLimit):
	P = {}
	for nItems in range(len(items)+1):
		for lim in range(sizeLimit+1):
			if nItems == 0:
				P[nItems,lim] = 0
			elif itemSize(items[nItems-1]) > lim:
				P[nItems,lim] = P[nItems-1,lim]
			else:
				P[nItems,lim] = max(P[nItems-1,lim],
				    P[nItems-1,lim-itemSize(items[nItems-1])] +
					itemValue(items[nItems-1]))
	return P[len(items),sizeLimit]
	
# backtrack through the matrix of solution values to find actual solution
#
# Like the LCS problem, and unlike the matrix chain problem, we only need
# to backtrack along a single path in the matrix, so we can do it with a
# while loop instead of a recursion.  We add each item to the end of a
# list L, then reverse L to match the input order -- it would work to add
# each item to the beginning of L but that's much less efficient in Python.
#
def pack5(items,sizeLimit):
	P = {}
	for nItems in range(len(items)+1):
		for lim in range(sizeLimit+1):
			if nItems == 0:
				P[nItems,lim] = 0
			elif itemSize(items[nItems-1]) > lim:
				P[nItems,lim] = P[nItems-1,lim]
			else:
				P[nItems,lim] = max(P[nItems-1,lim],
				    P[nItems-1,lim-itemSize(items[nItems-1])] +
					itemValue(items[nItems-1]))
	
	L = []		
	nItems = len(items)
	lim = sizeLimit
	while nItems > 0:
		if P[nItems,lim] == P[nItems-1,lim]:
			nItems -= 1
		else:
			nItems -= 1
			L.append(itemName(items[nItems]))
			lim -= itemSize(items[nItems])

	L.reverse()
	return L

# run the example
# output = ['A', 'C', 'F']
print pack5(exampleItems,exampleSizeLimit)


#==============================================================================
# LinkedList
#==============================================================================
# Try adding a tail pointer in addition to the front. You'll need to modify
# the operations which modify the list (insert and pop), when the change happens
# to the last element.
# Note that a tail pointer makes inserting at the end of a list much easier, but
# it doesn't help with removing from the end of a list.

# You can also try to implement any of the other list methods (just do help.lst
# in the shell to see all the existing Python list methods)

class LinkedList(object):
    '''A linked list implementation of a list'''
    
    class Node(object):
        '''A node of a singly linked list.'''
        
        def __init__(self, k):
            '''(Node) -> NoneType
            A new Node with key k and no next.'''
            
            self.key = k
            self.next = None
    
    def __init__(self):
        '''(LinkedList) -> NoneType
        A new empty LinkedList.'''
        
        self.front = None
        self.num_elements = 0
    
    def index(self, o):
        '''(LinkedList, object) -> int
        Return first index of object o. Raise ValueError if the value is not
        present.'''
        
        i = 0
        node = self.front
        while node and node.key != o:
            node = node.next
            i += 1
        if node:
            return i
        else:
            raise ValueError("%s is not in list" % str(o))
        
    def insert(self, i, o):
        '''(LinkedList, int, object) -> NoneType
        Insert object o before index i. Raise IndexError if i is out of 
        range.'''
        
        if i < 0 or i > self.num_elements:
            raise IndexError("insert index out of range")
            # To make this method like the insert method for Python lists, 
            # replace the above line with:
            # i = self.num_elements
        new_node = LinkedList.Node(o)
        if i == 0:
            new_node.next = self.front
            self.front = new_node
        else:
            node = self.front
            for j in range(i - 1):
                node = node.next
            new_node.next = node.next
            node.next = new_node
        self.num_elements += 1
        
    def append(self, o):
        '''(LinkedList, object) -> NoneType
        Append object o to end of list.'''
        
        self.insert(self.num_elements, o)
        
    def pop(self, i):
        '''(LinkedList, int) -> NoneType
        Remove and return item at index. Raise IndexError if list is empty or
        index is out of range.'''
        
        if i < 0 or i >= self.num_elements:
            raise IndexError("pop index out of range")
        if i == 0:
            result = self.front.key
            self.front = self.front.next
        else:
            node = self.front
            for j in range(i - 1):
                node = node.next
            result = node.next.key
            node.next = node.next.next
        self.num_elements -= 1
        return result
    
    def __len__(self):
        '''(LinkedList) -> int
        Return the length of this LinkedList.'''
        
        return self.num_elements
    
    def __str__(self):
        '''(LinkedList) -> str
        Return a string representation of this LinkedList.'''
        
        result = "["
        node = self.front
        if node != None:
            result += str(node.key)
            node = node.next
            for i in range(self.num_elements - 1):
                result += ", " + str(node.key)
                node = node.next
        result += "]"
        return result

if __name__ == "__main__":
    L = LinkedList()
    assert len(L) == 0
    assert str(L) == '[]'
    L.append(10)
    assert len(L) == 1
    assert str(L) == '[10]'
    L.insert(0, 20)
    assert len(L) == 2
    assert str(L) == '[20, 10]'
    assert L.index(10) == 1
    assert L.pop(0) == 20
    assert len(L) == 1
    assert str(L) == '[10]'
    assert L.pop(0) == 10
    assert len(L) == 0
    assert str(L) == '[]'
	
#==============================================================================
# LinkedList Simple
#==============================================================================
# simple linkedlist
#==================================
#! /usr/bin/env python

class node:
    def __init__(self):
        self.data = None # contains the data
        self.next = None # contains the reference to the next node


class linked_list:
    def __init__(self):
        self.cur_node = None

    def add_node(self, data):
        new_node = node() # create a new node
        new_node.data = data
        new_node.next = self.cur_node # link the new node to the 'previous' node.
        self.cur_node = new_node #  set the current node to the new one.

    def list_print(self):
        node = self.cur_node # cant point to ll!
        while node:
            print node.data
            node = node.next



ll = linked_list()
ll.add_node(1)
ll.add_node(2)
ll.add_node(3)

ll.list_print()

#====================================================================
# More through and more complicated implementation
#===================================================================

import itertools

class LinkedList(object):
	"""Immutable linked list code"""
	
	#if I get a list as input, the head is the item that I will keep, and the rest will be put into the tail
	def __new__(cls, list=[]):
		if isinstance(list, LinkedList): return l #Immutable, no need to copy
		i = iter(list)
		try: 
			head = i.next()
		except StopIteration:
			return cls.EmptyList   ##Return empty list singleton.
			
		tail = LinkedList(i)
		
		obj = super(LinkedList, cls).__new__(cls)
		obj._head = head
		obj._tail = tail
		return obj
	
	@classmethod
	def cons(cls, head, tail):
		ll = cls([head])
		if not isinstance(tail, cls):
			tail = cls(tail)
		ll._tail = tail
		return ll
		
	#head and tail are not modifiable
	@property
	def head(self): return self._head
	
	@property
	def tail(self): return self._tail
	
	def __nonzero__(self): return True
	
	def __len__(self):
		return sum(1 for _ in self)
		
	def __add__(self, other):
		other = LinkedList(other)
		
		if not self: return other
		start = l = LinkedList(iter(self)) #Create copy, as we'll mutate
		
		while l:
			if not l._tail: #last element?
				l._tail = other
				break
			l = l._tail
		return start
		
	def	__radd__(self, other):
		return LinkedList(other) + self
		
	def __iter__(self):
		x = self
		while x:
			yield x.head
			x = x.tail
			
	def __getitem__(self, idx):
		"""Get item at specified index"""
		if isinstance(idx, slice):
			#Special case: Avoid constructing a new list, or performing O(n) length
			# calculation for slices like l[3:]. Since we're immutable, just return
			# the appropriate node. This becomes O(start) rather than O(n).
			# We can't do this for more complicated slices however (e.g. [1:4]
			start = idx.start or 0
			if (start >= 0) and (idx.stop is None) and (idx.step is None or idx.step == 1):
                no_copy_needed=True
            else:
                length = len(self)  # Need to calc length.
                start, stop, step = idx.indices(length)
                no_copy_needed = (stop == length) and (step == 1)

            if no_copy_needed:
                l = self
                for i in range(start): 
                    if not l: break # End of list.
                    l=l.tail
                return l
            else:
                # We need to construct a new list.
                if step < 1:  # Need to instantiate list to deal with -ve step
                    return LinkedList(list(self)[start:stop:step])
                else:
                    return LinkedList(itertools.islice(iter(self), start, stop, step))
        else:       
            # Non-slice index.
            if idx < 0: idx = len(self)+idx
            if not self: raise IndexError("list index out of range")
            if idx == 0: return self.head
            return self.tail[idx-1]

    def __mul__(self, n):
        if n <= 0: return Nil
        l=self
        for i in range(n-1): l += self
        return l
    def __rmul__(self, n): return self * n

    # Ideally we should compute the has ourselves rather than construct
    # a temporary tuple as below.  I haven't impemented this here
    def __hash__(self): return hash(tuple(self))

    def __eq__(self, other): return self._cmp(other) == 0
    def __ne__(self, other): return not self == other
    def __lt__(self, other): return self._cmp(other) < 0
    def __gt__(self, other): return self._cmp(other) > 0
    def __le__(self, other): return self._cmp(other) <= 0
    def __ge__(self, other): return self._cmp(other) >= 0

    def _cmp(self, other):
        """Acts as cmp(): -1 for self<other, 0 for equal, 1 for greater"""
        if not isinstance(other, LinkedList):
            return cmp(LinkedList,type(other))  # Arbitrary ordering.

        A, B = iter(self), iter(other)
        for a,b in itertools.izip(A,B):
           if a<b: return -1
           elif a > b: return 1

        try:
            A.next()
            return 1  # a has more items.
        except StopIteration: pass

        try:
            B.next()
            return -1  # b has more items.
        except StopIteration: pass

        return 0  # Lists are equal

    def __repr__(self):
        return "LinkedList([%s])" % ', '.join(map(repr,self))

class EmptyList(LinkedList):
    """A singleton representing an empty list."""
    def __new__(cls):
        return object.__new__(cls)

    def __iter__(self): return iter([])
    def __nonzero__(self): return False

    @property
    def head(self): raise IndexError("End of list")

    @property
    def tail(self): raise IndexError("End of list")

# Create EmptyList singleton
LinkedList.EmptyList = EmptyList()
del EmptyList

l = LinkedList([1,2,3,4])
l.head, l.tail
assert l[2:] is l.next.next

LinkedList([-1, 0, 1, 2, 3, 4])

LinkedList([0, 1, 2, 3, 4])

#==============================================================================
# Operating System: Lock
#==============================================================================
# Copyright 2011 OpenStack Foundation.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

import collections
import contextlib
import errno
import functools
import logging
import os
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import weakref

from oslo_config import cfg
import retrying
import six

from oslo_concurrency._i18n import _, _LE, _LI
from oslo_concurrency.openstack.common import fileutils


LOG = logging.getLogger(__name__)


_opts = [
    cfg.BoolOpt('disable_process_locking', default=False,
                help='Enables or disables inter-process locks.',
                deprecated_group='DEFAULT'),
    cfg.StrOpt('lock_path',
               default=os.environ.get("OSLO_LOCK_PATH"),
               help='Directory to use for lock files.  For security, the '
                    'specified directory should only be writable by the user '
                    'running the processes that need locking. '
                    'Defaults to environment variable OSLO_LOCK_PATH. '
                    'If external locks are used, a lock path must be set.',
               deprecated_group='DEFAULT')
]


CONF = cfg.CONF
CONF.register_opts(_opts, group='oslo_concurrency')


def set_defaults(lock_path):
    """Set value for lock_path.

    This can be used by tests to set lock_path to a temporary directory.
    """
    cfg.set_defaults(_opts, lock_path=lock_path)


class _Hourglass(object):
    """A hourglass like periodic timer."""

    def __init__(self, period):
        self._period = period
        self._last_flipped = None

    def flip(self):
        """Flips the hourglass.

        The drain() method will now only return true until the period
        is reached again.
        """
        self._last_flipped = time.time()

    def drain(self):
        """Drains the hourglass, returns True if period reached."""
        if self._last_flipped is None:
            return True
        else:
            elapsed = max(0, time.time() - self._last_flipped)
            return elapsed >= self._period


def _lock_retry(delay, filename,
                # These parameters trigger logging to begin after a certain
                # amount of time has elapsed where the lock couldn't be
                # acquired (log statements will be emitted after that duration
                # at the provided periodicity).
                log_begins_after=1.0, log_periodicity=0.5):
    """Retry logic that acquiring a lock will go through."""

    # If this returns True, a retry attempt will occur (using the defined
    # retry policy we have requested the retrying library to apply), if it
    # returns False then the original exception will be re-raised (if it
    # raises a new or different exception the original exception will be
    # replaced with that one and raised).
    def retry_on_exception(e):
        # TODO(harlowja): once/if https://github.com/rholder/retrying/pull/20
        # gets merged we should just switch to using that to avoid having to
        # catch and inspect all execeptions (and there types...)
        if isinstance(e, IOError) and e.errno in (errno.EACCES, errno.EAGAIN):
            return True
        raise threading.ThreadError(_("Unable to acquire lock on"
                                      " `%(filename)s` due to"
                                      " %(exception)s") %
                                    {
                                        'filename': filename,
                                        'exception': e,
                                    })

    # Logs all attempts (with information about how long we have been trying
    # to acquire the underlying lock...); after a threshold has been passed,
    # and only at a fixed rate...
    def never_stop(hg, attempt_number, delay_since_first_attempt_ms):
        delay_since_first_attempt = delay_since_first_attempt_ms / 1000.0
        if delay_since_first_attempt >= log_begins_after:
            if hg.drain():
                LOG.debug("Attempting to acquire %s (delayed %0.2f seconds)",
                          filename, delay_since_first_attempt)
                hg.flip()
        return False

    # The retrying library seems to prefer milliseconds for some reason; this
    # might be changed in (see: https://github.com/rholder/retrying/issues/6)
    # someday in the future...
    delay_ms = delay * 1000.0

    def decorator(func):

        @six.wraps(func)
        def wrapper(*args, **kwargs):
            hg = _Hourglass(log_periodicity)
            r = retrying.Retrying(wait_fixed=delay_ms,
                                  retry_on_exception=retry_on_exception,
                                  stop_func=functools.partial(never_stop, hg))
            return r.call(func, *args, **kwargs)

        return wrapper

    return decorator


class _FileLock(object):
    """Lock implementation which allows multiple locks, working around
    issues like bugs.debian.org/cgi-bin/bugreport.cgi?bug=632857 and does
    not require any cleanup. Since the lock is always held on a file
    descriptor rather than outside of the process, the lock gets dropped
    automatically if the process crashes, even if __exit__ is not executed.

    There are no guarantees regarding usage by multiple green threads in a
    single process here. This lock works only between processes. Exclusive
    access between local threads should be achieved using the semaphores
    in the @synchronized decorator.

    Note these locks are released when the descriptor is closed, so it's not
    safe to close the file descriptor while another green thread holds the
    lock. Just opening and closing the lock file can break synchronisation,
    so lock files must be accessed only using this abstraction.
    """

    def __init__(self, name):
        self.lockfile = None
        self.fname = name
        self.acquire_time = None

    def acquire(self, delay=0.01):
        if delay < 0:
            raise ValueError("Delay must be greater than or equal to zero")

        basedir = os.path.dirname(self.fname)
        if not os.path.exists(basedir):
            fileutils.ensure_tree(basedir)
            LOG.info(_LI('Created lock path: %s'), basedir)

        # Open in append mode so we don't overwrite any potential contents of
        # the target file.  This eliminates the possibility of an attacker
        # creating a symlink to an important file in our lock_path.
        self.lockfile = open(self.fname, 'a')
        start_time = time.time()

        # Using non-blocking locks (with retries) since green threads are not
        # patched to deal with blocking locking calls. Also upon reading the
        # MSDN docs for locking(), it seems to have a 'laughable' 10
        # attempts "blocking" mechanism.
        do_acquire = _lock_retry(delay=delay,
                                 filename=self.fname)(self.trylock)
        do_acquire()
        self.acquire_time = time.time()
        LOG.debug('Acquired file lock "%s" after waiting %0.3fs',
                  self.fname, (self.acquire_time - start_time))

        return True

    def __enter__(self):
        self.acquire()
        return self

    def release(self):
        if self.acquire_time is None:
            raise threading.ThreadError(_("Unable to release an unacquired"
                                          " lock"))
        try:
            release_time = time.time()
            LOG.debug('Releasing file lock "%s" after holding it for %0.3fs',
                      self.fname, (release_time - self.acquire_time))
            self.unlock()
            self.acquire_time = None
        except IOError:
            LOG.exception(_LE("Could not unlock the acquired lock `%s`"),
                          self.fname)
        else:
            try:
                self.lockfile.close()
            except IOError:
                LOG.exception(_LE("Could not close the acquired file handle"
                                  " `%s`"), self.fname)

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.release()

    def exists(self):
        return os.path.exists(self.fname)

    def trylock(self):
        raise NotImplementedError()

    def unlock(self):
        raise NotImplementedError()


class _WindowsLock(_FileLock):
    def trylock(self):
        msvcrt.locking(self.lockfile.fileno(), msvcrt.LK_NBLCK, 1)

    def unlock(self):
        msvcrt.locking(self.lockfile.fileno(), msvcrt.LK_UNLCK, 1)


class _FcntlLock(_FileLock):
    def trylock(self):
        fcntl.lockf(self.lockfile, fcntl.LOCK_EX | fcntl.LOCK_NB)

    def unlock(self):
        fcntl.lockf(self.lockfile, fcntl.LOCK_UN)


if os.name == 'nt':
    import msvcrt
    InterProcessLock = _WindowsLock
else:
    import fcntl
    InterProcessLock = _FcntlLock


class Semaphores(object):
    """A garbage collected container of semaphores.

    This collection internally uses a weak value dictionary so that when a
    semaphore is no longer in use (by any threads) it will automatically be
    removed from this container by the garbage collector.
    """

    def __init__(self):
        self._semaphores = weakref.WeakValueDictionary()
        self._lock = threading.Lock()

    def get(self, name):
        """Gets (or creates) a semaphore with a given name.

        :param name: The semaphore name to get/create (used to associate
                     previously created names with the same semaphore).

        Returns an newly constructed semaphore (or an existing one if it was
        already created for the given name).
        """
        with self._lock:
            try:
                return self._semaphores[name]
            except KeyError:
                sem = threading.Semaphore()
                self._semaphores[name] = sem
                return sem

    def __len__(self):
        """Returns how many semaphores exist at the current time."""
        return len(self._semaphores)


_semaphores = Semaphores()


def _get_lock_path(name, lock_file_prefix, lock_path=None):
    # NOTE(mikal): the lock name cannot contain directory
    # separators
    name = name.replace(os.sep, '_')
    if lock_file_prefix:
        sep = '' if lock_file_prefix.endswith('-') else '-'
        name = '%s%s%s' % (lock_file_prefix, sep, name)

    local_lock_path = lock_path or CONF.oslo_concurrency.lock_path

    if not local_lock_path:
        raise cfg.RequiredOptError('lock_path')

    return os.path.join(local_lock_path, name)


def external_lock(name, lock_file_prefix=None, lock_path=None):
    lock_file_path = _get_lock_path(name, lock_file_prefix, lock_path)

    return InterProcessLock(lock_file_path)


def remove_external_lock_file(name, lock_file_prefix=None, lock_path=None,
                              semaphores=None):
    """Remove an external lock file when it's not used anymore
    This will be helpful when we have a lot of lock files
    """
    with internal_lock(name, semaphores=semaphores):
        lock_file_path = _get_lock_path(name, lock_file_prefix, lock_path)
        try:
            os.remove(lock_file_path)
        except OSError:
            LOG.info(_LI('Failed to remove file %(file)s'),
                     {'file': lock_file_path})


def internal_lock(name, semaphores=None):
    if semaphores is None:
        semaphores = _semaphores
    return semaphores.get(name)


@contextlib.contextmanager
def lock(name, lock_file_prefix=None, external=False, lock_path=None,
         do_log=True, semaphores=None, delay=0.01):
    """Context based lock

    This function yields a `threading.Semaphore` instance (if we don't use
    eventlet.monkey_patch(), else `semaphore.Semaphore`) unless external is
    True, in which case, it'll yield an InterProcessLock instance.

    :param lock_file_prefix: The lock_file_prefix argument is used to provide
      lock files on disk with a meaningful prefix.

    :param external: The external keyword argument denotes whether this lock
      should work across multiple processes. This means that if two different
      workers both run a method decorated with @synchronized('mylock',
      external=True), only one of them will execute at a time.

    :param lock_path: The path in which to store external lock files.  For
      external locking to work properly, this must be the same for all
      references to the lock.

    :param do_log: Whether to log acquire/release messages.  This is primarily
      intended to reduce log message duplication when `lock` is used from the
      `synchronized` decorator.

    :param semaphores: Container that provides semaphores to use when locking.
        This ensures that threads inside the same application can not collide,
        due to the fact that external process locks are unaware of a processes
        active threads.

    :param delay: Delay between acquisition attempts (in seconds).
    """
    int_lock = internal_lock(name, semaphores=semaphores)
    with int_lock:
        if do_log:
            LOG.debug('Acquired semaphore "%(lock)s"', {'lock': name})
        try:
            if external and not CONF.oslo_concurrency.disable_process_locking:
                ext_lock = external_lock(name, lock_file_prefix, lock_path)
                ext_lock.acquire(delay=delay)
                try:
                    yield ext_lock
                finally:
                    ext_lock.release()
            else:
                yield int_lock
        finally:
            if do_log:
                LOG.debug('Releasing semaphore "%(lock)s"', {'lock': name})


def synchronized(name, lock_file_prefix=None, external=False, lock_path=None,
                 semaphores=None, delay=0.01):
    """Synchronization decorator.

    Decorating a method like so::

        @synchronized('mylock')
        def foo(self, *args):
           ...

    ensures that only one thread will execute the foo method at a time.

    Different methods can share the same lock::

        @synchronized('mylock')
        def foo(self, *args):
           ...

        @synchronized('mylock')
        def bar(self, *args):
           ...

    This way only one of either foo or bar can be executing at a time.
    """

    def wrap(f):
        @six.wraps(f)
        def inner(*args, **kwargs):
            t1 = time.time()
            t2 = None
            try:
                with lock(name, lock_file_prefix, external, lock_path,
                          do_log=False, semaphores=semaphores, delay=delay):
                    t2 = time.time()
                    LOG.debug('Lock "%(name)s" acquired by "%(function)s" :: '
                              'waited %(wait_secs)0.3fs',
                              {'name': name, 'function': f.__name__,
                               'wait_secs': (t2 - t1)})
                    return f(*args, **kwargs)
            finally:
                t3 = time.time()
                if t2 is None:
                    held_secs = "N/A"
                else:
                    held_secs = "%0.3fs" % (t3 - t2)

                LOG.debug('Lock "%(name)s" released by "%(function)s" :: held '
                          '%(held_secs)s',
                          {'name': name, 'function': f.__name__,
                           'held_secs': held_secs})
        return inner
    return wrap


def synchronized_with_prefix(lock_file_prefix):
    """Partial object generator for the synchronization decorator.

    Redefine @synchronized in each project like so::

        (in nova/utils.py)
        from nova.openstack.common import lockutils

        synchronized = lockutils.synchronized_with_prefix('nova-')


        (in nova/foo.py)
        from nova import utils

        @utils.synchronized('mylock')
        def bar(self, *args):
           ...

    The lock_file_prefix argument is used to provide lock files on disk with a
    meaningful prefix.
    """

    return functools.partial(synchronized, lock_file_prefix=lock_file_prefix)


def _lock_wrapper(argv):
    """Create a dir for locks and pass it to command from arguments

    This is exposed as a console script entry point named
    lockutils-wrapper

    If you run this:
        lockutils-wrapper python setup.py testr <etc>

    a temporary directory will be created for all your locks and passed to all
    your tests in an environment variable. The temporary dir will be deleted
    afterwards and the return value will be preserved.
    """

    lock_dir = tempfile.mkdtemp()
    os.environ["OSLO_LOCK_PATH"] = lock_dir
    try:
        ret_val = subprocess.call(argv[1:])
    finally:
        shutil.rmtree(lock_dir, ignore_errors=True)
    return ret_val


class ReaderWriterLock(object):
    """A reader/writer lock.

    This lock allows for simultaneous readers to exist but only one writer
    to exist for use-cases where it is useful to have such types of locks.

    Currently a reader can not escalate its read lock to a write lock and
    a writer can not acquire a read lock while it owns or is waiting on
    the write lock.

    In the future these restrictions may be relaxed.

    This can be eventually removed if http://bugs.python.org/issue8800 ever
    gets accepted into the python standard threading library...
    """
    WRITER = b'w'
    READER = b'r'

    @staticmethod
    def _fetch_current_thread_functor():
        # Until https://github.com/eventlet/eventlet/issues/172 is resolved
        # or addressed we have to use complicated workaround to get a object
        # that will not be recycled; the usage of threading.current_thread()
        # doesn't appear to currently be monkey patched and therefore isn't
        # reliable to use (and breaks badly when used as all threads share
        # the same current_thread() object)...
        try:
            import eventlet
            from eventlet import patcher
            green_threaded = patcher.is_monkey_patched('thread')
        except ImportError:
            green_threaded = False
        if green_threaded:
            return lambda: eventlet.getcurrent()
        else:
            return lambda: threading.current_thread()

    def __init__(self):
        self._writer = None
        self._pending_writers = collections.deque()
        self._readers = collections.defaultdict(int)
        self._cond = threading.Condition()
        self._current_thread = self._fetch_current_thread_functor()

    def _has_pending_writers(self):
        """Returns if there are writers waiting to become the *one* writer.

        Internal usage only.

        :return: whether there are any pending writers
        :rtype: boolean
        """
        return bool(self._pending_writers)

    def _is_writer(self, check_pending=True):
        """Returns if the caller is the active writer or a pending writer.

        Internal usage only.

        :param check_pending: checks the pending writes as well, if false then
                              only the current writer is checked (and not those
                              writers that may be in line).

        :return: whether the current thread is a active/pending writer
        :rtype: boolean
        """
        me = self._current_thread()
        with self._cond:
            if self._writer is not None and self._writer == me:
                return True
            if check_pending:
                return me in self._pending_writers
            else:
                return False

    @property
    def owner_type(self):
        """Returns whether the lock is locked by a writer/reader/nobody.

        :return: constant defining what the active owners type is
        :rtype: WRITER/READER/None
        """
        with self._cond:
            if self._writer is not None:
                return self.WRITER
            if self._readers:
                return self.READER
            return None

    def _is_reader(self):
        """Returns if the caller is one of the readers.

        Internal usage only.

        :return: whether the current thread is a active/pending reader
        :rtype: boolean
        """
        me = self._current_thread()
        with self._cond:
            return me in self._readers

    @contextlib.contextmanager
    def read_lock(self):
        """Context manager that grants a read lock.

        Will wait until no active or pending writers.

        Raises a ``RuntimeError`` if an active or pending writer tries to
        acquire a read lock as this is disallowed.
        """
        me = self._current_thread()
        if self._is_writer():
            raise RuntimeError("Writer %s can not acquire a read lock"
                               " while holding/waiting for the write lock"
                               % me)
        with self._cond:
            while self._writer is not None:
                # An active writer; guess we have to wait.
                self._cond.wait()
            # No active writer; we are good to become a reader.
            self._readers[me] += 1
        try:
            yield self
        finally:
            # I am no longer a reader, remove *one* occurrence of myself.
            # If the current thread acquired two read locks, then it will
            # still have to remove that other read lock; this allows for
            # basic reentrancy to be possible.
            with self._cond:
                claims = self._readers[me]
                if claims == 1:
                    self._readers.pop(me)
                else:
                    self._readers[me] = claims - 1
                if not self._readers:
                    self._cond.notify_all()

    @contextlib.contextmanager
    def write_lock(self):
        """Context manager that grants a write lock.

        Will wait until no active readers. Blocks readers after acquiring.

        Raises a ``RuntimeError`` if an active reader attempts to acquire a
        writer lock as this is disallowed.
        """
        me = self._current_thread()
        if self._is_reader():
            raise RuntimeError("Reader %s to writer privilege"
                               " escalation not allowed" % me)
        if self._is_writer(check_pending=False):
            # Already the writer; this allows for basic reentrancy.
            yield self
        else:
            with self._cond:
                # Add ourself to the pending writes and wait until we are
                # the one writer that can run (aka, when we are the first
                # element in the pending writers).
                self._pending_writers.append(me)
                while (self._readers or self._writer is not None
                       or self._pending_writers[0] != me):
                    self._cond.wait()
                self._writer = self._pending_writers.popleft()
            try:
                yield self
            finally:
                with self._cond:
                    self._writer = None
                    self._cond.notify_all()


def main():
    sys.exit(_lock_wrapper(sys.argv))


if __name__ == '__main__':
    raise NotImplementedError(_('Calling lockutils directly is no longer '
                                'supported.  Please use the '
                                'lockutils-wrapper console script instead.'))

#==============================================================================
# Map
#==============================================================================
class HashTable:
    def __init__(self):
        self.size = 11
        self.slots = [None] * self.size
        self.data = [None] * self.size

    def put(self,key,data):
        hashvalue = self.hashfunction(key,len(self.slots))

        if self.slots[hashvalue] == None:
            self.slots[hashvalue] = key
            self.data[hashvalue] = data
        else:
            if self.slots[hashvalue] == key:
                self.data[hashvalue] = data #replace
            else:
                nextslot = self.rehash(hashvalue,len(self.slots))
                while self.slots[nextslot] != None and self.slots[nextslot] != key:
                    nextslot = self.rehash(nextslot,len(self.slots))

                if self.slots[nextslot] == None:
                    self.slots[nextslot] = key
                    self.data[nextslot] = data
                else:
                    self.data[nextslot] = data #replace

    def hashfunction(self,key,size):
        return key%size

    def rehash(self,oldhash,size):
        return (oldhash+1)%size

    def get(self,key):
        startslot = self.hashfunction(key,len(self.slots))

        data = None
        stop = False
        found = False
        position = startslot
        while self.slots[position] != None and not found and not stop:
                if self.slots[position] == key:
                    found = True
                    data = self.data[position]
                else:
                    position=self.rehash(position,len(self.slots))
                    if position == startslot:
                        stop = True
        return data

    def __getitem__(self,key):
        return self.get(key)

    def __setitem__(self,key,data):
        self.put(key,data)


H=HashTable()
H[54]="cat"
H[26]="dog"
H[93]="lion"
H[17]="tiger"
H[77]="bird"
H[31]="cow"
H[44]="goat"
H[55]="pig"
H[20]="chicken"
print(H.slots)
print(H.data)


print(H[20])
print(H[17])

H[20] = 'duck'
print(H[20])

print(H.data)

print(H[99])

#==============================================================================
# Maximum Flow
#==============================================================================
"""This module contains the following maximum flow algorithms:
    - Ford-Fulkerson - O(E*f), where f is the maximum flow.
    - Edmond-Karp - O(V*E^2)
    - (TODO) Push-relabel - O(E*V^2) -> generally the most performant.

Given a set of nodes and edges that connect them, and "capacities" assigned to each edge,
the maximum flow problem asks what is the maximum amount of X that you can route from one
node to another.

For example, the edges of the graph could be pipes, and the capacities could be the amount
of water that can flow through each pipe. By using max-flow, you can find the maximum water
that you can route from a starting point to an end point. Basically, how do you distribute water
among all the intermediary pipes such that the maximum amount of water reaches the end.

An optimal solution to this problem can be found in this image (from TopCoder's algorithm tutorials):
https://community.topcoder.com/i/education/maxFlow01.gif. The flow here is going from X -> Y.

References:
https://community.topcoder.com/tc?module=Static&d1=tutorials&d2=maxFlow
http://en.wikipedia.org/wiki/Ford%E2%80%93Fulkerson_algorithm
http://en.wikipedia.org/wiki/Edmonds%E2%80%93Karp_algorithm
http://en.wikipedia.org/wiki/Push%E2%80%93relabel_maximum_flow_algorithm
http://en.wikipedia.org/wiki/Flow_network
"""

from graphs.shortest_paths import dijkstra
from graphs import util
from graphs.graph import *


def ford_fulkerson (graph, source, sink):
    """Implements the Ford-Fulkerson maximum-flow algorithm.

    @param graph - A graph object.
    @param source - The source node.
    @param sink - The sink node.
    @return The maximum flow through the network.
    """
    # Create the network. We can't use the original graph as we must add reverse edges.
    network = Graph()
    for i in graph.nodes:
        network.add_node(i)
    for (a, b) in graph.weights:
        network.add_edge(a, b, graph.weights[(a, b)])
        network.add_edge(b, a, 0)
    capacities = network.weights

    # Initialize flows to zero.
    flows = {(a, b): 0 for (a, b) in network.weights}

    # Find the first augmenting path to add flow.
    path = _find_augmenting_path(network, capacities, flows, source, sink, [source])

    # Continue until no more augmenting paths can be found.
    while path != None:
        residuals = []
        for i in range(len(path) - 1):
            edge = (path[i], path[i+1])
            residuals.append(capacities[edge] - flows[edge])

        # Maximize the flow through this path by filling up the smallest residual edge.
        additionalFlow = min(residuals)

        # Add flow to the forward edges, subtract flow from the reverse edges.
        for i in range(len(path) - 1):
            edge = (path[i], path[i+1])
            flows[edge] += additionalFlow
            flows[(edge[1], edge[0])] -= additionalFlow

        # Find another augmenting path with the updated flows.
        path = _find_augmenting_path(network, capacities, flows, source, sink, [source])

    # Flow to the sink is equal to the flow coming out of the source.
    return sum(flows[(source, b)] for b in network.adjNodes[source])

def edmonds_karp (graph, source, sink):
    """Implements the Edmonds-Karp maximum-flow algorithm. This is an implementation of the
    Ford-Fulkerson for computing the maximum flow in O(V*E^2) time. This improvement is due
    to the selection of the shortest augmenting path rather than any random one.

    @param graph - A graph object.
    @param source - The source node.
    @param sink - The sink node.
    @return The maximum flow through the network.
    """
    # Create the network. We can't use the original graph as we must add reverse edges.
    network = Graph()
    for i in graph.nodes:
        network.add_node(i)
    for (a, b) in graph.weights:
        network.add_edge(a, b, graph.weights[(a, b)])
        network.add_edge(b, a, 0)
    capacities = network.weights

    # Initialize flows to zero.
    flows = {(a, b): 0 for (a, b) in capacities}

    while True:
        # Find the shortest augmenting path, not just ANY augmenting path, by using a
        # breadth-first search.
        path = _find_path_bfs(network, capacities, flows, source, sink)
        if not path:
            break

        # Maximize the flow through this path by filling up the smallest residual edge.
        flow = min(capacities[(u, v)] - flows[(u, v)] for (u, v) in path)

        # Add flow to the forward edges, subtract flow from the reverse edges.
        for (u, v) in path:
            flows[(u, v)] += flow
            flows[(v, u)] -= flow

    # Flow to the sink is equal to the flow coming out of the source.
    return sum(flows[(source, i)] for i in network.adjNodes[source])

def _find_augmenting_path (graph, capacities, flows, source, sink, path):
    """Helper method to find an augmenting path in the graph. An augmenting path is a path whose
    flow can be increased (none of the edges in the path has a maximized flow). This is used in
    the Ford-Fulkerson algorithm.

    @param graph - A graph object.
    @param capacities - A dictionary of tuples (source, target) representing edges, to their capacities
    @param flows - A dictionary of tuples (source, target) representing edges, to their current flows
    @param source - The source node.
    @param sink - The sink node.
    @param path - The current path (recursively builds it).
    @return res - The augmenting path.
    """
    if source == sink:
        return path
    for b in graph.adjNodes[source]:
        residual = capacities[(source, b)] - flows[(source, b)]
        if residual > 0 and (source, b) not in util.get_edge_list_from_path(path):
            res = _find_augmenting_path(graph, capacities, flows, b, sink, path + [b])
            if res != None:
                return res

def _find_path_bfs (graph, capacities, flows, source, sink):
    """Helper method to find the shortest augmenting path in the graph. This is used in
    the Edmonds-Karp algorithm.
    """
    queue = [source]
    paths = {source: []}
    while queue:
        u = queue.pop(0)
        for v in graph.adjNodes[u]:
            if capacities[(u, v)] - flows[(u, v)] > 0 and v not in paths:
                paths[v] = paths[u] + [(u, v)]
                if v == sink:
                    return paths[v]
                queue.append(v)
    return None
								
#==============================================================================
# Merge Sort
#==============================================================================

def merge(a, b):
	if len(a)*len(b) == 0:
		return a+b

	v = (a[0] < b[0] and a or b).pop(0)
	return [v] + merge(a, b)

def mergesort(lst):
	if len(lst) < 2:
		return lst

	m = len(lst)/2
	return merge(mergesort(lst[:m]), mergesort(lst[m:]))

mlst = [10, 9, 8, 4, 5, 6, 7, 3, 2, 1]
sorted = mergesort(mlst)
print sorted


#==============================================================================
# Minimum Spanning Tree
#==============================================================================
"""MinimumSpanningTree.py

Kruskal's algorithm for minimum spanning trees. D. Eppstein, April 2006.
"""

import unittest
from UnionFind import UnionFind
from Graphs import isUndirected

def MinimumSpanningTree(G):
    """
    Return the minimum spanning tree of an undirected graph G.
    G should be represented in such a way that iter(G) lists its
    vertices, iter(G[u]) lists the neighbors of u, G[u][v] gives the
    length of edge u,v, and G[u][v] should always equal G[v][u].
    The tree is returned as a list of edges.
    """
    if not isUndirected(G):
        raise ValueError("MinimumSpanningTree: input is not undirected")
    for u in G:
        for v in G[u]:
            if G[u][v] != G[v][u]:
                raise ValueError("MinimumSpanningTree: asymmetric weights")

    # Kruskal's algorithm: sort edges by weight, and add them one at a time.
    # We use Kruskal's algorithm, first because it is very simple to
    # implement once UnionFind exists, and second, because the only slow
    # part (the sort) is sped up by being built in to Python.
    subtrees = UnionFind()
    tree = []
    for W,u,v in sorted((G[u][v],u,v) for u in G for v in G[u]):
        if subtrees[u] != subtrees[v]:
            tree.append((u,v))
            subtrees.union(u,v)
    return tree        


# If run standalone, perform unit tests

class MSTTest(unittest.TestCase):
    def testMST(self):
        """Check that MinimumSpanningTree returns the correct answer."""
        G = {0:{1:11,2:13,3:12},1:{0:11,3:14},2:{0:13,3:10},3:{0:12,1:14,2:10}}
        T = [(2,3),(0,1),(0,3)]
        for e,f in zip(MinimumSpanningTree(G),T):
            self.assertEqual(min(e),min(f))
            self.assertEqual(max(e),max(f))

if __name__ == "__main__":
    unittest.main()   

#==============================================================================
# Min Max Heap
#==============================================================================
from math import log, floor, pow


class MinMaxHeap(object):
    """an implementation of min-max heap using an array,
        which starts at 1 (ignores 0th element)
    """

    def __init__(self, array=[]):
        super(MinMaxHeap, self).__init__()
        self.heap = [0]
        for i in array:
            self.Insert(i)

    def Insert(self, value):
        """place value at an available leaf, then bubble up from there"""
        self.heap = self.heap + [value]
        self.BubbleUp(len(self.heap) - 1)

    def DeleteAt(self, position):
        """delete given position"""
        self.heap[position] = self.heap[-1]
        del(self.heap[-1])
        self.TrickleDown(position)

    def Index(self, value):
        return self.heap.index(value)

    def PeekMax(self):
        if len(self.heap) > 1:
            return self.heap[1]
        else:
            raise Exception

    def PeekMin(self):
        size = len(self.heap)
        if size > 1:
            c = [self.heap[1]]
            if size >= 2:
                c = c + [self.heap[2]]
            if size >= 3:
                c = c + [self.heap[3]]
            return min(c)
        else:
            raise Exception

    def PopMax(self):
        m = self.PeekMax()
        mi = self.Index(m)
        self.DeleteAt(mi)
        return m

    def PopMin(self):
        m = self.PeekMin()
        mi = self.Index(m)
        self.DeleteAt(mi)
        return m

    def TrickleDown(self, position):
        """delete key at position"""
        if self.OnMinLevel(position):
            self.TrickleDownMin(position)
        else:
            self.TrickleDownMax(position)

    def TrickleDownMin(self, position):
        if self.HasChildren(position):
            min_pair = self.SortPairs(self.ChildrenAndGrandChildren(position))[0]
            m = min_pair[0]  # index of smallest kid
            if self.IsGrandChild(position, m):
                if self.heap[m] < self.heap[position]:
                    self.Swap(m, position)
                    if self.heap[m] > self.heap[self.Parent(m)]:
                        self.Swap(m, self.Parent(m))
                    self.TrickleDownMin(m)
            # if not grandchild, m must be a child
            else:
                if self.heap[m] < self.heap[position]:
                    self.Swap(m, position)
        else:
            pass

    def TrickleDownMax(self, position):
        if self.HasChildren(position):
            max_pair = self.SortPairs(self.ChildrenAndGrandChildren(position))[-1]
            m = max_pair[0]  # index of smallest kid
            if self.IsGrandChild(position, m):
                if self.heap[m] > self.heap[position]:
                    self.Swap(m, position)
                    if self.heap[m] < self.heap[self.Parent(m)]:
                        self.Swap(m, self.Parent(m))
                    self.TrickleDownMax(m)
            # if not grandchild, m must be a child
            else:
                if self.heap[m] > self.heap[position]:
                    self.Swap(m, position)
        else:
            pass

    def BubbleUp(self, position):
        if self.OnMinLevel(position):
            if self.HasParent(position):
                if self.heap[position] > self.heap[self.Parent(position)]:
                    self.Swap(position, self.Parent(position))
                    self.BubbleUpMax(self.Parent(position))
                else:
                    self.BubbleUpMin(position)
        else:
            if self.HasParent(position):
                if self.heap[position] < self.heap[self.Parent(position)]:
                    self.Swap(position, self.Parent(position))
                    self.BubbleUpMin(self.Parent(position))
                else:
                    self.BubbleUpMax(position)

    def BubbleUpMin(self, position):
        grandparent = self.Parent(self.Parent(position))
        if self.HasGrandParent(position):
            if self.heap[position] < self.heap[grandparent]:
                self.Swap(position, grandparent)
                self.BubbleUpMin(grandparent)

    def BubbleUpMax(self, position):
        if self.HasGrandParent(position):
            grandparent = self.Parent(self.Parent(position))
            if self.heap[position] > self.heap[grandparent]:
                self.Swap(position, grandparent)
                self.BubbleUpMax(grandparent)

    def Swap(self, a, b):
        """swap values between a and b"""
        a_val = self.heap[a]
        b_val = self.heap[b]
        self.heap[a] = b_val
        self.heap[b] = a_val

    def Parent(self, child):
        """return child's parent"""
        return int(child) / 2

    def IsGrandChild(self, parent, grand_child):
        """tell whether grand_child is parent's grandchild or not"""
        if self.HasGrandChildren(parent):
            size = len(self.heap)
            if grand_child < size:
                return True
            else:
                return False
        else:
            return False

    def SortPairs(self, list_of_pairs):
        """return 2-tuple representing smallest, sorted by value in second"""
        return sorted(list_of_pairs, key=lambda tup: tup[1])

    def ChildrenAndGrandChildren(self, position):
        """
        return list of children's and grandchildren's indices
        Don't call if position doesn't have children!
        """
        if self.HasChildren(position):
            a = []
            a = a + [(int(pow(2, position)), self.heap[int(pow(2, position))])]
            a = a + [(int(pow(2, position)) + 1, self.heap[int(pow(2, position)) + 1])]
            if self.HasChildren(int(pow(2, position))):
                cpos = int(pow(2, position))
                a = a + [(int(pow(2, cpos)), self.heap[int(pow(2, cpos))])]
                a = a + [(int(pow(2, cpos)) + 1, self.heap[int(pow(2, cpos)) + 1])]
            if self.HasChildren(int(pow(2, position)) + 1):
                cpos = int(pow(2, position)) + 1
                a = a + [(int(pow(2, cpos)), self.heap[int(pow(2, cpos))])]
                a = a + [(int(pow(2, cpos)) + 1, self.heap[int(pow(2, cpos)) + 1])]
            return a
        else:
            raise Exception

    def HasParent(self, position):
        p = self.Parent(position)
        if p is not 0:
            return True
        else:
            return False

    def HasGrandParent(self, position):
        gp = self.Parent(self.Parent(position))
        if gp is not 0:
            return True
        else:
            return False

    def HasChildren(self, position):
        """check if 2^position and 2^(position)+1 exist"""
        size = len(self.heap)
        if (pow(2, position) < size) or ((pow(2, position) + 1) < size):
            return True
        else:
            return False

    def HasGrandChildren(self, position):
        """check if either of position's children have children of their own"""
        if self.HasChildren(int(pow(2, position))) or \
           self.HasChildren(int(pow(2, position)) + 1):
            return True
        else:
            return False

    def OnMinLevel(self, position):
        """returns bool - is it on a min level?"""
        test = self.OnLevel(position) % 2
        if test == 0:
            return False
        else:
            return True

    def OnMaxLevel(self, position):
        """returns bool - is it on a max level?"""
        test = self.OnLevel(position) % 2
        if test == 0:
            return True
        else:
            return False

    def OnLevel(self, position):
        """returns what level the key at position is on"""
        return floor(log(int(position), 2))
#==============================================================================
# Min Spanning Tree: Kruskal
#==============================================================================
#!/usr/bin/env python

from __future__ import division
import math
import random
import networkx as nx

"""
Implementations of d-Heaps and Prim's MST following Tarjan. Includes testing
and visualization code for both.
"""

ARITY = 3  # the branching factor of the d-Heaps

#=======================================================================
# d-Heap
#=======================================================================

class HeapItem(object):
    """Represents an item in the heap"""
    def __init__(self, key, item):
        self.key = key
        self.item = item
        self.pos = None

def makeheap(S):
    """Create a heap from set S, which should be a list of pairs (key, item)."""
    heap = list(HeapItem(k,i) for k,i in S)
    for pos in xrange(len(heap)-1, -1, -1):
        siftdown(heap[pos], pos, heap)
    return heap

def findmin(heap):
    """Return element with smallest key, or None if heap is empty"""
    return heap[0] if len(heap) > 0 else None

def deletemin(heap):
    """Delete the smallest item"""
    if len(heap) == 0: return None
    i = heap[0]
    last = heap[-1]
    del heap[-1]
    if len(heap) > 0:
        siftdown(last, 0, heap)
    return i

def heapinsert(key, item, heap):
    """Insert an item into the heap"""
    heap.append(None)
    hi = HeapItem(key,item)
    siftup(hi, len(heap)-1, heap)
    return hi

def heap_decreasekey(hi, newkey, heap):
    """Decrease the key of hi to newkey"""
    hi.key = newkey
    siftup(hi, hi.pos, heap)

def siftup(hi, pos, heap):
    """Move hi up in heap until it's parent is smaller than hi.key"""
    p = parent(pos)
    while p is not None and heap[p].key > hi.key:
        heap[pos] = heap[p]
        heap[pos].pos = pos
        pos = p
        p = parent(p)
    heap[pos] = hi
    hi.pos = pos

def siftdown(hi, pos, heap):
    """Move hi down in heap until its smallest child is bigger than hi's key"""
    c = minchild(pos, heap)
    while c != None and heap[c].key < hi.key:
        heap[pos] = heap[c]
        heap[pos].pos = pos
        pos = c
        c = minchild(c, heap)
    heap[pos] = hi
    hi.pos = pos

def parent(pos):
    """Return the position of the parent of pos"""
    if pos == 0: return None
    return int(math.ceil(pos / ARITY) - 1)

def children(pos, heap):
    """Return a list of children of pos"""
    return xrange(ARITY * pos + 1, min(ARITY * (pos + 1) + 1, len(heap)))

def minchild(pos, heap):
    """Return the child of pos with the smallest key"""
    minpos = minkey = None
    for c in children(pos, heap):
        if minkey == None or heap[c].key < minkey:
            minkey, minpos = heap[c].key, c
    return minpos


#=======================================================================
# Heap Testing and Visualization Code
#=======================================================================

def bfs_tree_layout(G, root, rowheight = 0.02, nodeskip = 0.6):
    """Return node position dictionary, layingout the graph in BFS order."""
    def width(T, u, W):
        """Returns the width of the subtree of T rooted at u; returns in W the
        width of every node under u"""
        W[u] = sum(width(T, c, W) 
            for c in T.successors(u)) if len(T.successors(u))>0 else 1.0
        return W[u]

    T = nx.bfs_tree(G, root)
    W = {}
    width(T, root, W)

    pos = {}
    left = {}
    queue = [root]
    while len(queue):
        c = queue[0]
        del queue[0]  # pop

        left[c] = 0.0  # amt of child space used up

        # posn is computed relative to the parent
        if c == root:
            pos[c] = (0,0)
        else:
            p = T.predecessors(c)[0]
            pos[c] = (
                pos[p][0] - W[p]*nodeskip/2.0 + left[p] + W[c]*nodeskip/2.0,
                pos[p][1] - rowheight
            )
            left[p] += W[c]*nodeskip

        # add the children to the queue
        for i,u in enumerate(G.successors(c)):
            queue.append(u)
    return pos

def snapshot_heap(heap):
    draw_heap(heap, pdffile)

def draw_heap(heap, outfile=None):
    """Draw the heap using matplotlib and networkx"""
    import matplotlib.pyplot as plt
    G = nx.DiGraph()
    for i in xrange(1, len(heap)):
        G.add_edge(parent(i), i)

    labels = dict((u, "%d" % (heap[u].key)) for u in G.nodes())

    plt.figure(facecolor="w", dpi=80)
    plt.margins(0,0)
    plt.xticks([])
    plt.yticks([])
    plt.box(False)
    nx.draw_networkx(G, 
        labels=labels, 
        node_size = 700,
        node_color = "white",
        pos=bfs_tree_layout(G, 0))
    if outfile is not None:
        plt.savefig(outfile, format="pdf", dpi=150, bbox_inches='tight', pad_inches=0.0)
        plt.close()
    else:
        plt.show()

def test_heap():
    """Generate a random heap"""
    global pdffile
    pdffile = start_pdf("mst.pdf")
    draw_heap(makeheap((random.randint(0,100), 'a') for i in xrange(40)))


#=======================================================================
# Prim's minimum spanning tree algorithm
#=======================================================================

def prim_mst(G):
    """Compute the minimum spanning tree of G. Assumes each edge has an
    attribute 'length' giving it's length. Returns a dictionary P such
    that P[u] gives the parent of u in the MST."""

    for u in G.nodes():
        G.node[u]['distto'] = float("inf")  # key stores the Prim key
        G.node[u]['heap'] = None         # heap = pointer to node's HeapItem
    parent = {}

    heap = makeheap([])
    v = G.nodes()[0]

    # go through vertices in order of closest to current tree
    while v != None:
        G.node[v]['distto'] = float("-inf") # v now in the tree

        snapshot_mst(G, parent)
        
        # update the estimated distance to each of v's neighbors
        for w in G.neighbors(v):
            # if new length is smaller that old length, update
            if G[v][w]['length'] < G.node[w]['distto']:
                # closest tree node to w is v
                G.node[w]['distto'] = G[v][w]['length']
                parent[w] = v

                # add to heap or decreae key if already in heap
                hi = G.node[w]['heap']
                if hi is None:
                    G.node[w]['heap'] = heapinsert(G.node[w]['distto'], w, heap)
                else:
                    heap_decreasekey(hi, G.node[w]['distto'], heap)
        # get the next vertex closest to the tree
        v = deletemin(heap)
        v = v.item if v is not None else None
    return parent

#=======================================================================
# Union-Find
#=======================================================================

class ArrayUnionFind:
    """Holds the three "arrays" for union find"""
    def __init__(self, S):
        self.group = dict((s,s) for s in S) # group[s] = id of its set
        self.size = dict((s,1) for s in S) # size[s] = size of set s
        self.items = dict((s,[s]) for s in S) # item[s] = list of items in set s
        
def make_union_find(S):
    """Create a union-find data structure"""
    return ArrayUnionFind(S)
    
def find(UF, s):
    """Return the id for the group containing s"""
    return UF.group[s]

def union(UF, a,b):
    """Union the two sets a and b"""
    assert a in UF.items and b in UF.items
    # make a be the smaller set
    if UF.size[a] > UF.size[b]:
        a,b = b,a
    # put the items in a into the larger set b
    for s in UF.items[a]:
        UF.group[s] = b
        UF.items[b].append(s)
    # the new size of b is increased by the size of a
    UF.size[b] += UF.size[a]
    # remove the set a (to save memory)
    del UF.size[a]
    del UF.items[a]

#=======================================================================
# Kruskal MST
#=======================================================================

def kruskal_mst(G):
    """Return a minimum spanning tree using kruskal's algorithm"""
    # sort the list of edges in G by their length
    Edges = [(u, v, G[u][v]['length']) for u,v in G.edges()]
    Edges.sort(cmp=lambda x,y: cmp(x[2],y[2]))

    UF = make_union_find(G.nodes())  # union-find data structure

    # for edges in increasing weight
    mst = [] # list of edges in the mst
    for u,v,d in Edges:
        setu = find(UF, u)
        setv = find(UF, v)
        # if u,v are in different components
        if setu != setv:
            mst.append((u,v))
            union(UF, setu, setv)
            snapshot_kruskal(G, mst)
    return mst

#=======================================================================
# MST Testing and Visualization Code
#=======================================================================

def dist(xy1, xy2):
    """Euclidean distance"""
    return math.sqrt((xy1[0] - xy2[0])**2 + (xy1[1] - xy2[1])**2)

def random_mst_graph(n, k=4):
    """Make a random graph by choosing n nodes in the [0,1.0] by [0,1]
    square. The 'length' of each edge is the euclidean distance between
    them. Edges connect to the k nearest neighbors of each node.""" 

    # build random nodes
    G = nx.Graph()
    for i in xrange(n):
        G.add_node(i, pos=(0.9*random.random()+0.05,0.9*random.random()+0.05))

    # add edges
    for i in G.nodes():
        near = [(u, dist(G.node[i]['pos'],G.node[u]['pos'])) 
                    for u in G.nodes() if u != i]
        near.sort(cmp=lambda x,y: cmp(x[1],y[1]))
        for u,d in near[0:k]:
            G.add_edge(i, u, length=d)

    # ensure it's connected
    CC = nx.connected_components(G)
    for i in xrange(len(CC)-1):
        u = random.choice(CC[i])
        v = random.choice(CC[i+1])
        G.add_edge(u,v, length=dist(G.node[u]['pos'], G.node[v]['pos']))
    return G


def draw_mst_graph(G, T={}, outfile=None):
    """Draw the MST graph, highlight edges given by the MST parent dictionary
    T. T should be in the same format as returned by prim_mst()."""

    import matplotlib.pyplot as plt

    # construct the attributes for the edges
    pos = dict((u,G.node[u]['pos']) for u in G.nodes())
    labels = dict((u,str(u)) for u in G.nodes())
    colors = []
    width = []
    for u,v in G.edges():
        if isinstance(T, dict):
            inmst = (u in T and v == T[u]) or (v in T and u == T[v])
        elif isinstance(T, nx.Graph):
            inmst = T.has_edge(u,v)
        colors.append(1 if inmst else 255)
        width.append(5 if inmst else 1) 

    # draw it
    plt.figure(facecolor="w", dpi=80)
    plt.margins(0,0)
    plt.xticks([])
    plt.yticks([])
    plt.ylim(0.0,1.0)
    plt.xlim(0.0,1.0)
    plt.box(False)
    nx.draw_networkx(G, 
        labels=labels, 
        node_size = 500,
        node_color = "white",
        edge_color = colors, 
        width=width,
        pos=pos)
    if outfile is not None:
        plt.savefig(outfile, format="pdf", dpi=150, bbox_inches='tight', pad_inches=0.0)
        plt.close()
    else:
        plt.show()

def snapshot_kruskal(G, edges, pdf=True):
    T = nx.Graph()
    for u,v in edges: T.add_edge(u,v)
    draw_mst_graph(G, T, pdffile if pdf else None)

def snapshot_mst(G, parent):
    tree = dict((u,parent[u]) 
        for u in G.nodes() 
            if G.node[u]['distto'] == float("-inf") and u in parent)
    draw_mst_graph(G, tree, pdffile)

def test_mst():
    """Draw the MST for a random graph."""
    global pdffile
    pdffile = start_pdf("mst.pdf")
    N = random_mst_graph(20)
    draw_mst_graph(N, prim_mst(N))
    close_pdf(pdffile)

def test_kruskal():
    """Draw the MST for a random graph."""
    global pdffile
    pdffile = start_pdf("kruskal.pdf")
    N = random_mst_graph(20)
    snapshot_kruskal(N, kruskal_mst(N), False)
    close_pdf(pdffile)

def start_pdf(outfile):
    from matplotlib.backends.backend_pdf import PdfPages
    pp = PdfPages(outfile)
    return pp

def close_pdf(pp):
    pp.close()

def main():
    import sys
    if len(sys.argv) >= 2:
        if sys.argv[1] == "heap": test_heap()
        if sys.argv[1] == "mst": test_mst()
        if sys.argv[1] == "kruskal": test_kruskal()
    else:
        print "Usage: mstprim.py [heap|mst|kruskal]"

if __name__ == "__main__": main()

#==============================================================================
# Operating System: Mutex
#==============================================================================

"""Mutual exclusion -- for use with module sched

A mutex has two pieces of state -- a 'locked' bit and a queue.
When the mutex is not locked, the queue is empty.
Otherwise, the queue contains 0 or more (function, argument) pairs
representing functions (or methods) waiting to acquire the lock.
When the mutex is unlocked while the queue is not empty,
the first queue entry is removed and its function(argument) pair called,
implying it now has the lock.

Of course, no multi-threading is implied -- hence the funny interface
for lock, where a function is called once the lock is aquired.
"""
from warnings import warnpy3k
warnpy3k("the mutex module has been removed in Python 3.0", stacklevel=2)
del warnpy3k

from collections import deque

class mutex:
    def __init__(self):
        """Create a new mutex -- initially unlocked."""
        self.locked = False
        self.queue = deque()

    def test(self):
        """Test the locked bit of the mutex."""
        return self.locked

    def testandset(self):
        """Atomic test-and-set -- grab the lock if it is not set,
        return True if it succeeded."""
        if not self.locked:
            self.locked = True
            return True
        else:
            return False

    def lock(self, function, argument):
        """Lock a mutex, call the function with supplied argument
        when it is acquired.  If the mutex is already locked, place
        function and argument in the queue."""
        if self.testandset():
            function(argument)
        else:
            self.queue.append((function, argument))

    def unlock(self):
        """Unlock a mutex.  If the queue is not empty, call the next
        function with its argument."""
        if self.queue:
            function, argument = self.queue.popleft()
            function(argument)
        else:
            self.locked = False

#==============================================================================
# Design Pattern: MVC
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

from Tkinter import *
import random

#==============================================================================
class Model(object):
    
    def __init__(self):
        # q_and_a is a dictionary where the key is a question and the entry is
        # a list of pairs, these pairs are an answer and whether it is correct
        self.q_and_a = {
            "How many wives did Henry VIII have?": [
                ("Five", False),
                ("Six", True),
                ("Seven", False),
                ("Eight", False)
                ],
            "In which Italian city is Romeo and Juliet primarily set?": [
                ("Verona", True),
                ("Naples", False),
                ("Milano", False),
                ("Pisa", False)
                ],
            "A light year is a measure of what?": [
                ("Energy", False),
                ("Speed", False),
                ("Distance", True),
                ("Intensity", False)
                ]
            }

    def question_and_answers(self):
        """ 
        Returns a randomly chosen question (string) and answers (list of 
        strings)  as a pair.
        """
        key = random.choice(self.q_and_a.keys())
        return (key, [x[0] for x in self.q_and_a[key]])

    def is_correct(self, question, answer):
        answers = self.q_and_a[question]
        for ans in answers:
            if (ans[0] == answer):
                return ans[1]
        assert False, "Could not find answer."

#==============================================================================
class View(object):

    def __init__(self):
        self.parent = Tk()
        self.parent.title("Trivia")

        self.initialise_ui()

        self.controller = None

    def clear_screen(self):
        """ Clears the screen deleting all widgets. """
        self.frame.destroy()
        self.initialise_ui()
        
    def initialise_ui(self):
        self.answer_button = None
        self.continue_button = None

        self.frame = Frame(self.parent)
        self.frame.pack()

    def new_question(self, question, answers):
        """ 
        question is a string, answers is a list of strings
        e.g
        view.new_question(
          "Is the earth a sphere?", 
          ["Yes", "No"]
        )
        """
        self.clear_screen()
        # put the question on as a label
        question_label = Label(self.frame, text=question)
        question_label.pack()

        # put the answers on as a radio buttons
        selected_answer = StringVar()
        selected_answer.set(answers[0])

        for answer in answers:
            option = Radiobutton(
                self.frame,
                text=answer,
                variable=selected_answer,
                value=answer,
                )
            option.pack()

        # button to confirm
        answer_function = lambda : self.controller.answer(
            question,
            selected_answer.get()
            )
        self.answer_button = Button(
            self.frame,
            text="Answer",
            command=answer_function
            )
        self.answer_button.pack()
        
    def main_loop(self):
        mainloop()

    def register(self, controller):
        """ Register a controller to give callbacks to. """
        self.controller = controller

    def feedback(self, feedback):
        self.clear_screen()
        label = Label(self.frame, text=feedback)
        label.pack()
        
        self.continue_button = Button(
            self.frame,
            text="Continue",
            command=self.controller.next_question
            )
        self.continue_button.pack()

#==============================================================================
class Controller(object):

    def __init__(self, model, view):
        self.model = model
        self.view = view

        self.view.register(self)
        self.new_question()

    def new_question(self):
        q_and_a = self.model.question_and_answers()
        self.view.new_question(q_and_a[0], q_and_a[1])
        
    def next_question(self):
        self.new_question()
        
    def answer(self, question, answer):
        correct = self.model.is_correct(question, answer)
        feedback = ""
        if (correct):
            feedback = "That is correct."
        else:     
            feedback = "Sorry that's wrong."

        self.view.feedback(feedback)

#==============================================================================
if (__name__ == "__main__"):
    # Note: The view should not send to the model but it is often useful
    # for the view to receive update event information from the model. 
    # However you should not update the model from the view.

    view = View()
    model = Model()
    controller = Controller(model, view)

    view.main_loop()

#==============================================================================
# Data Structure: Node
#==============================================================================    
# Copyright (C) by Brett Kromkamp 2011-2014 (brett@youprogramming.com)
# You Programming (http://www.youprogramming.com)
# May 03, 2014

class Node:
    def __init__(self, identifier):
        self.__identifier = identifier
        self.__children = []

    @property
    def identifier(self):
        return self.__identifier

    @property
    def children(self):
        return self.__children

    def add_child(self, identifier):
        self.__children.append(identifier)
#==============================================================================
# Design Pattern: Proxy
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

# http://sourcemaking.com/design_patterns/proxy
# give 4 good reasons for a proxy to be made.

# A virtual proxy is a placeholder for "expensive to create" objects. The real
# object is only created when a client first requests/accesses the object.
#
# A remote proxy provides a local representative for an object that resides in
# a different address space. This is what the "stub" code in RPC and CORBA 
# provides.

# A protective proxy controls access to a sensitive master object. The 
# "surrogate" object checks that the caller has the access permissions required
# prior to forwarding the request.

# A smart proxy interposes additional actions when an object is accessed. 
# Typical uses include: 
#   o Counting the number of references to the real object so that it can be 
#     freed automatically when there are no more references (aka smart pointer)
#   o Loading a persistent object into memory when it's first referenced,
#   o Checking that the real object is locked before it is accessed to ensure
#     that no other object can change it.


#==============================================================================
class SharedData(object):

    def __init__(self):
        self.resource = "A resource"

#==============================================================================
class AsyncProxy(object):

    def __init__(self, data):
        """ 
        Takes some data which should now only be accessed through this class, 
        otherwise you could get 
        """
        self.data = data

#==============================================================================
# Queue
#==============================================================================
# Bradley N. Miller, David L. Ranum
# Introduction to Data Structures and Algorithms in Python
# Copyright 2005
# 
#queue.py

class Queue:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def enqueue(self, item):
        self.items.insert(0,item)

    def dequeue(self):
        return self.items.pop()

    def size(self):
        return len(self.items)


#==============================================================================
# Quick Sort in Place
#==============================================================================
# quick sort, in-place 3-way partition
# David Eppstein, UCI, 17 Jan 2002

import random
R = random.Random(42)

def qsort(L):
	quicksort(L,0,len(L))

def quicksort(L,start,stop):
	if stop - start < 2: return
	key = L[R.randrange(start,stop)]
	e = u = start
	g = stop
	while u < g:
		if L[u] < key:
			swap(L,u,e)
			e = e + 1
			u = u + 1
		elif L[u] == key:
			u = u + 1
		else:
			g = g - 1
			swap(L,u,g)
	quicksort(L,start,e)
	quicksort(L,g,stop)

def swap(A,i,j):
	temp = A[i]
	A[i] = A[j]
	A[j] = temp

L = [3,1,4,1,5,9,2,6,5,3,5,8,9,7,9]
qsort(L)
print L

#==============================================================================
# Redix Sort
#==============================================================================
#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Radix sort implementation in python.
"""

import unittest
import math


def _get_digit(num, pos):
    """Return the digit in the given position.

    If the given number is negative the returned digit will be negative. The
    positions start from right (1) to left.

    :param num: The number to extract the digits from.
    :param pos: The position of the digit to be extracted
    """
    base = 10
    if pos <= 0:
        raise ValueError()
    sign = -1 if num < 0 else 1
    num = int(math.fabs(num))
    pos -= 1 # Convert to zero index
    d = (num // base ** pos) % base
    return d * sign


def _num_digits(num):
    """Return the number of digits in a number

    :param num: The number in base 10
    :type num: int
    :returns: int -- The number of digits
    """
    return int(math.ceil(math.log10(num)))


def _max_digits(ls):
    """Return the length of maximum number in the list

    :param ls: List to find the maximum number.
    :type ls: List
    :returns: int
    """
    n = 0
    for item in ls:
        t = _num_digits(item)
        if t > n:
            n = t
    return n


def radix_sort(ls):
    """Sort a list of integers

    :param ls: List of integers
    :type ls: list
    :returns: list -- Sorted list
    """
    if not len(ls):
        return ls
    pos = 1
    max_digits = _max_digits(ls)
    while True:
        buckets = {}
        for item in ls:
            d = _get_digit(item, pos)
            l = buckets.get(d, [])
            l.append(item)
            buckets[d] = l
        i = 0
        ls_ = []
        while len(ls) > len(ls_):
            try:
                ls_ += buckets[i]
            except KeyError:
                pass
            i += 1
        ls = ls_
        if pos == max_digits:
            break
        else:
            pos += 1
    return ls


class TestModule(unittest.TestCase):

    def test_get_digit_first(self):
        self.assertEqual(4, _get_digit(34, 1))

    def test_get_digit_second(self):
        self.assertEqual(3, _get_digit(34, 2))

    def test_get_digit_third(self):
        self.assertEqual(2, _get_digit(234, 3))

    def test_get_digit_invalid_pos_zero(self):
        with self.assertRaises(ValueError):
            _get_digit(24, 0)

    def test_get_digit_invalid_pos_negative(self):
        with self.assertRaises(ValueError):
            _get_digit(234, -1)

    def test_get_digit_invalid_pos_large(self):
            self.assertEqual(0, _get_digit(234, 100))

    def test_get_digit_negative_value(self):
        self.assertEqual(-1, _get_digit(-1, 1))

    def test_get_digit_negative_value_multiple(self):
        self.assertEqual(-2, _get_digit(-123, 2))


    def test_radix_sorter_empty_list(self):
        self.assertEqual([], radix_sort([]))

    def xtest_radix_sort_success_single_digit(self):
        self.assertEqual([1, 2, 5], radix_sort([2, 5, 1]))

    def xtest_radix_sort_double_digits(self):
        self.assertEqual([10, 15], radix_sort([15, 10]))

    def test_radix_sort_mixed_digits(self):
        self.assertEqual([2, 24, 45, 66, 75, 90, 170, 802],
                         radix_sort([170, 45, 75, 90, 2, 24, 802, 66]))


if __name__ == '__main__':
    unittest.main()


#==============================================================================
# RBTree
#==============================================================================
#!/usr/bin/env python
#
# This code adapted from C source from
# Thomas Niemann's Sorting and Searching Algorithms: A Cookbook
#
# From the title page:
#   Permission to reproduce this document, in whole or in part, is
#   given provided the original web site listed below is referenced,
#   and no additional restrictions apply. Source code, when part of
#   a software project, may be used freely without reference to the
#   author.
#
# Adapted by Chris Gonnerman <chris.gonnerman@newcenturycomputers.net>
#        and Graham Breed
#
# Updated by Charles Tolman <ct@acm.org>
#        inheritance from object class
#        added RBTreeIter class
#        added lastNode and prevNode routines to RBTree
#        added RBList class and associated tests
#
# Updated by Stefan Fruhner <marycue@gmx.de>
#        Added item count to RBNode, which counts the occurence
#        of objects. The tree is kept unique, but insertions 
#        of the same object are counted
#        changed RBList.count():  returns the number of occurences of 
#                                 an item
#        Renamed RBList.count to RBList.elements, because of a name 
#        mismatch with RBList.count()
#        changed RBTree.insertNode to count insertions of the same item
#        changed RBList.insert(): uncommented some superfluid code
#        changed RBList.remove(): If called with all=True, then all instances
#                                 of the node are deleted from the tree;
#                                 else only node.count is decremented,
#                                 if finally node.count is 1 the node 
#                                 is deleted.  all is True by default.
#        changed RBTree.deleteNode : same changes as for RBList.remove()
#        finally I've changed the __version__ string to '1.6'

__version__ = "1.6"

import string

BLACK = 0
RED = 1

class RBNode(object):

    def __init__(self, key = None, value = None, color = RED):
        self.left = self.right = self.parent = None
        self.color = color
        self.key = key
        self.value = value
        self.nonzero = 1
        self.count = 1

    def __str__(self):
        return repr(self.key) + ': ' + repr(self.value)

    def __nonzero__(self):
        return self.nonzero

    def __len__(self):
        """imitate sequence"""
        return 2

    def __getitem__(self, index):
        """imitate sequence"""
        if index==0:
            return self.key
        if index==1:
            return self.value
        raise IndexError('only key and value as sequence')


class RBTreeIter(object):

    def __init__ (self, tree):
        self.tree = tree
        self.index = -1  # ready to iterate on the next() call
        self.node = None
        self.stopped = False

    def __iter__ (self):
        """ Return the current item in the container
        """
        return self.node.value

    def next (self):
        """ Return the next item in the container
            Once we go off the list we stay off even if the list changes
        """
        if self.stopped or (self.index + 1 >= self.tree.__len__()):
            self.stopped = True
            raise StopIteration
        #
        self.index += 1
        if self.index == 0:
            self.node = self.tree.firstNode()
        else:
            self.node = self.tree.nextNode (self.node)
        return self.node.value


class RBTree(object):

    def __init__(self, cmpfn=cmp, unique=True):
        self.sentinel = RBNode()
        self.sentinel.left = self.sentinel.right = self.sentinel
        self.sentinel.color = BLACK
        self.sentinel.nonzero = 0
        self.root = self.sentinel
        self.elements = 0
        
        #SF: If self.unique is True, all elements in the tree have 
       	#SF  to be unique and an exception is raised for multiple 
       	#SF insertions of a node
       	#SF If self.unique is set to False, nodes can be added multiple 
       	#SF times. There is still only one node, but all insertions are
       	#SF counted in the variable node.count
        self.unique = unique
        # changing the comparison function for an existing tree is dangerous!
        self.__cmp = cmpfn

    def __len__(self):
        return self.elements

    def __del__(self):
        # unlink the whole tree

        s = [ self.root ]

        if self.root is not self.sentinel:
            while s:
                cur = s[0]
                if cur.left and cur.left != self.sentinel:
                    s.append(cur.left)
                if cur.right and cur.right != self.sentinel:
                    s.append(cur.right)
                cur.right = cur.left = cur.parent = None
                cur.key = cur.value = None
                s = s[1:]

        self.root = None
        self.sentinel = None

    def __str__(self):
        return "<RBTree object>"

    def __repr__(self):
        return "<RBTree object>"

    def __iter__ (self):
        return RBTreeIter (self)

    def rotateLeft(self, x):

        y = x.right

        # establish x.right link
        x.right = y.left
        if y.left != self.sentinel:
            y.left.parent = x

        # establish y.parent link
        if y != self.sentinel:
            y.parent = x.parent
        if x.parent:
            if x == x.parent.left:
                x.parent.left = y
            else:
                x.parent.right = y
        else:
            self.root = y

        # link x and y
        y.left = x
        if x != self.sentinel:
            x.parent = y

    def rotateRight(self, x):

        #***************************
        #  rotate node x to right
        #***************************

        y = x.left

        # establish x.left link
        x.left = y.right
        if y.right != self.sentinel:
            y.right.parent = x

        # establish y.parent link
        if y != self.sentinel:
            y.parent = x.parent
        if x.parent:
            if x == x.parent.right:
                x.parent.right = y
            else:
                x.parent.left = y
        else:
            self.root = y

        # link x and y
        y.right = x
        if x != self.sentinel:
            x.parent = y

    def insertFixup(self, x):
        #************************************
        #  maintain Red-Black tree balance  *
        #  after inserting node x           *
        #************************************

        # check Red-Black properties

        while x != self.root and x.parent.color == RED:

            # we have a violation

            if x.parent == x.parent.parent.left:

                y = x.parent.parent.right

                if y.color == RED:
                    # uncle is RED
                    x.parent.color = BLACK
                    y.color = BLACK
                    x.parent.parent.color = RED
                    x = x.parent.parent

                else:
                    # uncle is BLACK
                    if x == x.parent.right:
                        # make x a left child
                        x = x.parent
                        self.rotateLeft(x)

                    # recolor and rotate
                    x.parent.color = BLACK
                    x.parent.parent.color = RED
                    self.rotateRight(x.parent.parent)
            else:

                # mirror image of above code

                y = x.parent.parent.left

                if y.color == RED:
                    # uncle is RED
                    x.parent.color = BLACK
                    y.color = BLACK
                    x.parent.parent.color = RED
                    x = x.parent.parent

                else:
                    # uncle is BLACK
                    if x == x.parent.left:
                        x = x.parent
                        self.rotateRight(x)

                    x.parent.color = BLACK
                    x.parent.parent.color = RED
                    self.rotateLeft(x.parent.parent)

        self.root.color = BLACK

    def insertNode(self, key, value):
        #**********************************************
        #  allocate node for data and insert in tree  *
        #**********************************************

        # we aren't interested in the value, we just
        # want the TypeError raised if appropriate
        hash(key)

        # find where node belongs
        current = self.root
        parent = None
        while current != self.sentinel:
            # GJB added comparison function feature
            # slightly improved by JCG: don't assume that ==
            # is the same as self.__cmp(..) == 0
            rc = self.__cmp(key, current.key)
            if rc == 0:
                #SF This item is inserted for the second, 
                #SF third, ... time, so we have to increment 
                #SF the count
                if self.unique == False: 
                    current.count += 1
                else: # raise an Error
                    print "Warning: This element is already in the list ... ignored!"
                    #SF I don't want to raise an error because I want to keep 
                    #SF the code compatible to previous versions
                    #SF But here would be the right place to do this
                    #raise IndexError ("This item is already in the tree.")
                return current
            parent = current
            if rc < 0:
                current = current.left
            else:
                current = current.right

        # setup new node
        x = RBNode(key, value)
        x.left = x.right = self.sentinel
        x.parent = parent

        self.elements = self.elements + 1

        # insert node in tree
        if parent:
            if self.__cmp(key, parent.key) < 0:
                parent.left = x
            else:
                parent.right = x
        else:
            self.root = x

        self.insertFixup(x)
        return x

    def deleteFixup(self, x):
        #************************************
        #  maintain Red-Black tree balance  *
        #  after deleting node x            *
        #************************************

        while x != self.root and x.color == BLACK:
            if x == x.parent.left:
                w = x.parent.right
                if w.color == RED:
                    w.color = BLACK
                    x.parent.color = RED
                    self.rotateLeft(x.parent)
                    w = x.parent.right

                if w.left.color == BLACK and w.right.color == BLACK:
                    w.color = RED
                    x = x.parent
                else:
                    if w.right.color == BLACK:
                        w.left.color = BLACK
                        w.color = RED
                        self.rotateRight(w)
                        w = x.parent.right

                    w.color = x.parent.color
                    x.parent.color = BLACK
                    w.right.color = BLACK
                    self.rotateLeft(x.parent)
                    x = self.root

            else:
                w = x.parent.left
                if w.color == RED:
                    w.color = BLACK
                    x.parent.color = RED
                    self.rotateRight(x.parent)
                    w = x.parent.left

                if w.right.color == BLACK and w.left.color == BLACK:
                    w.color = RED
                    x = x.parent
                else:
                    if w.left.color == BLACK:
                        w.right.color = BLACK
                        w.color = RED
                        self.rotateLeft(w)
                        w = x.parent.left

                    w.color = x.parent.color
                    x.parent.color = BLACK
                    w.left.color = BLACK
                    self.rotateRight(x.parent)
                    x = self.root

        x.color = BLACK

    def deleteNode(self, z, all=True):
        #****************************
        #  delete node z from tree  *
        #****************************

        if not z or z == self.sentinel:
            return
            
        #SF If the object is in this tree more than once the node 
        #SF has not to be deleted. We just have to decrement the 
        #SF count variable
        #SF we don't have to check for uniquness because this was
        #SF already captured in insertNode() and for this reason 
        #SF z.count cannot be greater than 1
        #SF If all=True then the complete node has to be deleted
        if z.count > 1 and not all: 
            z.count -= 1
            return          

        if z.left == self.sentinel or z.right == self.sentinel:
            # y has a self.sentinel node as a child
            y = z
        else:
            # find tree successor with a self.sentinel node as a child
            y = z.right
            while y.left != self.sentinel:
                y = y.left

        # x is y's only child
        if y.left != self.sentinel:
            x = y.left
        else:
            x = y.right

        # remove y from the parent chain
        x.parent = y.parent
        if y.parent:
            if y == y.parent.left:
                y.parent.left = x
            else:
                y.parent.right = x
        else:
            self.root = x

        if y != z:
            z.key = y.key
            z.value = y.value

        if y.color == BLACK:
            self.deleteFixup(x)

        del y
        self.elements = self.elements - 1

    def findNode(self, key):
        #******************************
        #  find node containing data
        #******************************

        # we aren't interested in the value, we just
        # want the TypeError raised if appropriate
        hash(key)
        
        current = self.root

        while current != self.sentinel:
            # GJB added comparison function feature
            # slightly improved by JCG: don't assume that ==
            # is the same as self.__cmp(..) == 0
            rc = self.__cmp(key, current.key)
            if rc == 0:
                return current
            else:
                if rc < 0:
                    current = current.left
                else:
                    current = current.right

        return None

    def traverseTree(self, f):
        if self.root == self.sentinel:
            return
        s = [ None ]
        cur = self.root
        while s:
            if cur.left:
                s.append(cur)
                cur = cur.left
            else:
                f(cur)
                while not cur.right:
                    cur = s.pop()
                    if cur is None:
                        return
                    f(cur)
                cur = cur.right
        # should not get here.
        return

    def nodesByTraversal(self):
        """return all nodes as a list"""
        result = []
        def traversalFn(x, K=result):
            K.append(x)
        self.traverseTree(traversalFn)
        return result

    def nodes(self):
        """return all nodes as a list"""
        cur = self.firstNode()
        result = []
        while cur:
            result.append(cur)
            cur = self.nextNode(cur)
        return result

    def firstNode(self):
        cur = self.root
        while cur.left:
            cur = cur.left
        return cur

    def lastNode(self):
        cur = self.root
        while cur.right:
            cur = cur.right
        return cur

    def nextNode(self, prev):
        """returns None if there isn't one"""
        cur = prev
        if cur.right:
            cur = prev.right
            while cur.left:
                cur = cur.left
            return cur
        while 1:
            cur = cur.parent
            if not cur:
                return None
            if self.__cmp(cur.key, prev.key)>=0:
                return cur

    def prevNode(self, next):
        """returns None if there isn't one"""
        cur = next
        if cur.left:
            cur = next.left
            while cur.right:
                cur = cur.right
            return cur
        while 1:
            cur = cur.parent
            if cur is None:
                return None
            if self.__cmp(cur.key, next.key)<0:
                return cur


class RBList(RBTree):
    """ List class uses same object for key and value
        Assumes you are putting sortable items into the list.
    """

    def __init__(self, list=[], cmpfn=cmp, unique=True):
        #SF new option: unique trees, see RBTree.__init__() for 
        #SF more information
        RBTree.__init__(self, cmpfn, unique)
        for item in list:
            self.insertNode (item, item)

    def __getitem__ (self, index):
        node = self.findNodeByIndex (index)
        return node.value

    def __delitem__ (self, index):
        node = self.findNodeByIndex (index)
        self.deleteNode (node)

    def __contains__ (self, item):
        return self.findNode (item) is not None

    def __str__ (self):
        # eval(str(self)) returns a regular list
        return '['+ string.join(map(lambda x: str(x.value), self.nodes()), ', ')+']'

    def findNodeByIndex (self, index):
        if (index < 0) or (index >= self.elements):
            raise IndexError ("pop index out of range")
        #
        if index < self.elements / 2:
            # simple scan from start of list
            node = self.firstNode()
            currIndex = 0
            while currIndex < index:
                node = self.nextNode (node)
                currIndex += 1
        else:
            # simple scan from end of list
            node = self.lastNode()
            currIndex = self.elements - 1
            while currIndex > index:
                node = self.prevNode (node)
                currIndex -= 1
        #
        return node

    def insert (self, item):
        #SF The function inserNode already checks for existing Nodes 
        #SF so this code seems to be superfluid
        #node = self.findNode (item)
        #if node is not None:
            #self.deleteNode (node)
        # item is both key and value for a list
        self.insertNode (item, item)

    def append (self, item):
        # list is always sorted
        self.insert (item)

    #SF this function is not implemented as a common list in python
    #def count (self):
        #return len(self)
        
    #SF Because we count all equal items in one node 
    #SF we now can use the function count as used in 
    #SF common python lists
    def count(self, item):
    	node = self.findNode (item)
        return node.count

    def index (self, item):
        index = -1
        node = self.findNode (item)
        while node is not None:
            node = self.prevNode (node)
            index += 1
        #
        if index < 0:
            raise ValueError ("RBList.index: item not in list")
        return index

    def extend (self, otherList):
        for item in otherList:
            self.insert (item)

    def pop (self, index=None):
        if index is None:
            index = self.elements - 1
        #
        node = self.findNodeByIndex (index)
        value = node.value      # must do this before removing node
        self.deleteNode (node)
        return value

    def remove (self, item, all=True):
        #SF When called with all=True then all occurences are deleted
        node = self.findNode (item)
        if node is not None:
            self.deleteNode (node, all)

    def reverse (self): # not implemented
        raise AssertionError ("RBlist.reverse Not implemented")

    def sort (self): # Null operation
        pass

    def clear (self):
        """delete all entries"""
        self.__del__()
        #copied from RBTree constructor
        self.sentinel = RBNode()
        self.sentinel.left = self.sentinel.right = self.sentinel
        self.sentinel.color = BLACK
        self.sentinel.nonzero = 0
        self.root = self.sentinel
        self.elements = 0

    def values (self):
        return map (lambda x: x.value, self.nodes())

    def reverseValues (self):
        values = map (lambda x: x.value, self.nodes())
        values.reverse()
        return values


class RBDict(RBTree):

    def __init__(self, dict={}, cmpfn=cmp):
        RBTree.__init__(self, cmpfn)
        for key, value in dict.items():
            self[key]=value

    def __str__(self):
        # eval(str(self)) returns a regular dictionary
        return '{'+ string.join(map(str, self.nodes()), ', ')+'}'

    def __repr__(self):
        return "<RBDict object " + str(self) + ">"

    def __getitem__(self, key):
        n = self.findNode(key)
        if n:
            return n.value
        raise IndexError

    def __setitem__(self, key, value):
        n = self.findNode(key)
        if n:
            n.value = value
        else:
            self.insertNode(key, value)

    def __delitem__(self, key):
        n = self.findNode(key)
        if n:
            self.deleteNode(n)
        else:
            raise IndexError

    def get(self, key, default=None):
        n = self.findNode(key)
        if n:
            return n.value
        return default

    def keys(self):
        return map(lambda x: x.key, self.nodes())

    def values(self):
        return map(lambda x: x.value, self.nodes())

    def items(self):
        return map(tuple, self.nodes())

    def has_key(self, key):
        return self.findNode(key) <> None

    def clear(self):
        """delete all entries"""

        self.__del__()

        #copied from RBTree constructor
        self.sentinel = RBNode()
        self.sentinel.left = self.sentinel.right = self.sentinel
        self.sentinel.color = BLACK
        self.sentinel.nonzero = 0
        self.root = self.sentinel
        self.elements = 0

    def copy(self):
        """return shallow copy"""
        # there may be a more efficient way of doing this
        return RBDict(self)

    def update(self, other):
        """Add all items from the supplied mapping to this one.

        Will overwrite old entries with new ones.

        """
        for key in other.keys():
            self[key] = other[key]

    def setdefault(self, key, value=None):
        if self.has_key(key):
            return self[key]
        self[key] = value
        return value


""" ----------------------------------------------------------------------------
    TEST ROUTINES
"""
def testRBlist():
    import random
    print "--- Testing RBList ---"
    print "    Basic tests..."

    initList = [5,3,6,7,2,4,21,8,99,32,23]
    rbList = RBList (initList)
    initList.sort()
    assert rbList.values() == initList
    initList.reverse()
    assert rbList.reverseValues() == initList
    #
    rbList = RBList ([0,1,2,3,4,5,6,7,8,9])
    for i in range(10):
        assert i == rbList.index (i)

    # remove odd values
    for i in range (1,10,2):
        rbList.remove (i)
    assert rbList.values() == [0,2,4,6,8]

    # pop tests
    assert rbList.pop() == 8
    assert rbList.values() == [0,2,4,6]
    assert rbList.pop (1) == 2
    assert rbList.values() == [0,4,6]
    assert rbList.pop (0) == 0
    assert rbList.values() == [4,6]

    # Random number insertion test
    rbList = RBList()
    for i in range(5):
        k = random.randrange(10) + 1
        rbList.insert (k)
    print "    Random contents:", rbList

    rbList.insert (0)
    rbList.insert (1)
    rbList.insert (10)

    print "    With 0, 1 and 10:", rbList
    n = rbList.findNode (0)
    print "    Forwards:",
    while n is not None:
        print "(" + str(n) + ")",
        n = rbList.nextNode (n)
    print

    n = rbList.findNode (10)
    print "    Backwards:",
    while n is not None:
        print "(" + str(n) + ")",
        n = rbList.prevNode (n)

    if rbList.nodes() != rbList.nodesByTraversal():
        print "node lists don't match"
    print

def testRBdict():
    import random
    print "--- Testing RBDict ---"

    rbDict = RBDict()
    for i in range(10):
        k = random.randrange(10) + 1
        rbDict[k] = i
    rbDict[1] = 0
    rbDict[2] = "testing..."

    print "    Value at 1", rbDict.get (1, "Default")
    print "    Value at 2", rbDict.get (2, "Default")
    print "    Value at 99", rbDict.get (99, "Default")
    print "    Keys:", rbDict.keys()
    print "    values:", rbDict.values()
    print "    Items:", rbDict.items()

    if rbDict.nodes() != rbDict.nodesByTraversal():
        print "node lists don't match"

    # convert our RBDict to a dictionary-display,
    # evaluate it (creating a dictionary), and build a new RBDict
    # from it in reverse order.
    revDict = RBDict(eval(str(rbDict)),lambda x, y: cmp(y,x))
    print "    " + str(revDict)
    print


if __name__ == "__main__":

    import sys

    if len(sys.argv) <= 1:
        testRBlist()
        testRBdict()
    else:

        from distutils.core import setup, Extension

        setup(name="RBTree",
            version=__version__,
            description="Red/Black Tree",
            long_description="Red/Black Balanced Binary Tree plus Dictionary and List",
            author="Chris Gonnerman, Graham Breed, Charles Tolman, and Stefan Fruhner",
            author_email="chris.gonnerman@newcenturycomputers.net",
            url="http://newcenturycomputers.net/projects/rbtree.html",
            py_modules=["RBTree"]
        )
    sys.exit(0)


# end of file.


#==============================================================================
# Algorithm: Traveling Sales Person
#==============================================================================
#!/usr/bin/env python

""" Traveling salesman problem solved using Simulated Annealing.
"""
from scipy import *
from pylab import *

def Distance(R1, R2):
    return sqrt((R1[0]-R2[0])**2+(R1[1]-R2[1])**2)

def TotalDistance(city, R):
    dist=0
    for i in range(len(city)-1):
        dist += Distance(R[city[i]],R[city[i+1]])
    dist += Distance(R[city[-1]],R[city[0]])
    return dist
    
def reverse(city, n):
    nct = len(city)
    nn = (1+ ((n[1]-n[0]) % nct))/2 # half the lenght of the segment to be reversed
    # the segment is reversed in the following way n[0]<->n[1], n[0]+1<->n[1]-1, n[0]+2<->n[1]-2,...
    # Start at the ends of the segment and swap pairs of cities, moving towards the center.
    for j in range(nn):
        k = (n[0]+j) % nct
        l = (n[1]-j) % nct
        (city[k],city[l]) = (city[l],city[k])  # swap
    
def transpt(city, n):
    nct = len(city)
    
    newcity=[]
    # Segment in the range n[0]...n[1]
    for j in range( (n[1]-n[0])%nct + 1):
        newcity.append(city[ (j+n[0])%nct ])
    # is followed by segment n[5]...n[2]
    for j in range( (n[2]-n[5])%nct + 1):
        newcity.append(city[ (j+n[5])%nct ])
    # is followed by segment n[3]...n[4]
    for j in range( (n[4]-n[3])%nct + 1):
        newcity.append(city[ (j+n[3])%nct ])
    return newcity

def Plot(city, R, dist):
    # Plot
    Pt = [R[city[i]] for i in range(len(city))]
    Pt += [R[city[0]]]
    Pt = array(Pt)
    title('Total distance='+str(dist))
    plot(Pt[:,0], Pt[:,1], '-o')
    show()

if __name__=='__main__':

    ncity = 100        # Number of cities to visit
    maxTsteps = 100    # Temperature is lowered not more than maxTsteps
    Tstart = 0.2       # Starting temperature - has to be high enough
    fCool = 0.9        # Factor to multiply temperature at each cooling step
    maxSteps = 100*ncity     # Number of steps at constant temperature
    maxAccepted = 10*ncity   # Number of accepted steps at constant temperature

    Preverse = 0.5      # How often to choose reverse/transpose trial move

    # Choosing city coordinates
    R=[]  # coordinates of cities are choosen randomly
    for i in range(ncity):
        R.append( [rand(),rand()] )
    R = array(R)

    # The index table -- the order the cities are visited.
    city = range(ncity)
    # Distance of the travel at the beginning
    dist = TotalDistance(city, R)

    # Stores points of a move
    n = zeros(6, dtype=int)
    nct = len(R) # number of cities
    
    T = Tstart # temperature

    Plot(city, R, dist)
    
    for t in range(maxTsteps):  # Over temperature

        accepted = 0
        for i in range(maxSteps): # At each temperature, many Monte Carlo steps
            
            while True: # Will find two random cities sufficiently close by
                # Two cities n[0] and n[1] are choosen at random
                n[0] = int((nct)*rand())     # select one city
                n[1] = int((nct-1)*rand())   # select another city, but not the same
                if (n[1] >= n[0]): n[1] += 1   #
                if (n[1] < n[0]): (n[0],n[1]) = (n[1],n[0]) # swap, because it must be: n[0]<n[1]
                nn = (n[0]+nct -n[1]-1) % nct  # number of cities not on the segment n[0]..n[1]
                if nn>=3: break
        
            # We want to have one index before and one after the two cities
            # The order hence is [n2,n0,n1,n3]
            n[2] = (n[0]-1) % nct  # index before n0  -- see figure in the lecture notes
            n[3] = (n[1]+1) % nct  # index after n2   -- see figure in the lecture notes
            
            if Preverse > rand(): 
                # Here we reverse a segment
                # What would be the cost to reverse the path between city[n[0]]-city[n[1]]?
                de = Distance(R[city[n[2]]],R[city[n[1]]]) + Distance(R[city[n[3]]],R[city[n[0]]]) - Distance(R[city[n[2]]],R[city[n[0]]]) - Distance(R[city[n[3]]],R[city[n[1]]])
                
                if de<0 or exp(-de/T)>rand(): # Metropolis
                    accepted += 1
                    dist += de
                    reverse(city, n)
            else:
                # Here we transpose a segment
                nc = (n[1]+1+ int(rand()*(nn-1)))%nct  # Another point outside n[0],n[1] segment. See picture in lecture nodes!
                n[4] = nc
                n[5] = (nc+1) % nct
        
                # Cost to transpose a segment
                de = -Distance(R[city[n[1]]],R[city[n[3]]]) - Distance(R[city[n[0]]],R[city[n[2]]]) - Distance(R[city[n[4]]],R[city[n[5]]])
                de += Distance(R[city[n[0]]],R[city[n[4]]]) + Distance(R[city[n[1]]],R[city[n[5]]]) + Distance(R[city[n[2]]],R[city[n[3]]])
                
                if de<0 or exp(-de/T)>rand(): # Metropolis
                    accepted += 1
                    dist += de
                    city = transpt(city, n)
                    
            if accepted > maxAccepted: break

        # Plot
        Plot(city, R, dist)
            
        print "T=%10.5f , distance= %10.5f , accepted steps= %d" %(T, dist, accepted)
        T *= fCool             # The system is cooled down
        if accepted == 0: break  # If the path does not want to change any more, we can stop

        
    Plot(city, R, dist)
    
#==============================================================================
# Operating System: Semaphore
#==============================================================================
from eventlet import greenthread
from eventlet import hubs

class Semaphore(object):
    """An unbounded semaphore.
    Optionally initialize with a resource *count*, then :meth:`acquire` and
    :meth:`release` resources as needed. Attempting to :meth:`acquire` when
    *count* is zero suspends the calling greenthread until *count* becomes
    nonzero again.

    This is API-compatible with :class:`threading.Semaphore`.

    It is a context manager, and thus can be used in a with block::

      sem = Semaphore(2)
      with sem:
        do_some_stuff()

    If not specified, *value* defaults to 1.
    """

    def __init__(self, value=1):
        self.counter  = value
        if value < 0:
            raise ValueError("Semaphore must be initialized with a positive "
                             "number, got %s" % value)
        self._waiters = set()

    def __repr__(self):
        params = (self.__class__.__name__, hex(id(self)),
                  self.counter, len(self._waiters))
        return '<%s at %s c=%s _w[%s]>' % params

    def __str__(self):
        params = (self.__class__.__name__, self.counter, len(self._waiters))
        return '<%s c=%s _w[%s]>' % params

    def locked(self):
        """Returns true if a call to acquire would block."""
        return self.counter <= 0

    def bounded(self):
        """Returns False; for consistency with
        :class:`~eventlet.semaphore.CappedSemaphore`."""
        return False

    def acquire(self, blocking=True):
        """Acquire a semaphore.

        When invoked without arguments: if the internal counter is larger than
        zero on entry, decrement it by one and return immediately. If it is zero
        on entry, block, waiting until some other thread has called release() to
        make it larger than zero. This is done with proper interlocking so that
        if multiple acquire() calls are blocked, release() will wake exactly one
        of them up. The implementation may pick one at random, so the order in
        which blocked threads are awakened should not be relied on. There is no
        return value in this case.

        When invoked with blocking set to true, do the same thing as when called
        without arguments, and return true.

        When invoked with blocking set to false, do not block. If a call without
        an argument would block, return false immediately; otherwise, do the
        same thing as when called without arguments, and return true."""
        if not blocking and self.locked():
            return False
        if self.counter <= 0:
            self._waiters.add(greenthread.getcurrent())
            try:
                while self.counter <= 0:
                    hubs.get_hub().switch()
            finally:
                self._waiters.discard(greenthread.getcurrent())
        self.counter -= 1
        return True

    def __enter__(self):
        self.acquire()

    def release(self, blocking=True):
        """Release a semaphore, incrementing the internal counter by one. When
        it was zero on entry and another thread is waiting for it to become
        larger than zero again, wake up that thread.

        The *blocking* argument is for consistency with CappedSemaphore and is
        ignored"""
        self.counter += 1
        if self._waiters:
            hubs.get_hub().schedule_call_global(0, self._do_acquire)
        return True

    def _do_acquire(self):
        if self._waiters and self.counter>0:
            waiter = self._waiters.pop()
            waiter.switch()

    def __exit__(self, typ, val, tb):
        self.release()

    @property
    def balance(self):
        """An integer value that represents how many new calls to
        :meth:`acquire` or :meth:`release` would be needed to get the counter to
        0.  If it is positive, then its value is the number of acquires that can
        happen before the next acquire would block.  If it is negative, it is
        the negative of the number of releases that would be required in order
        to make the counter 0 again (one more release would push the counter to
        1 and unblock acquirers).  It takes into account how many greenthreads
        are currently blocking in :meth:`acquire`.
        """
        # positive means there are free items
        # zero means there are no free items but nobody has requested one
        # negative means there are requests for items, but no items
        return self.counter - len(self._waiters)


class BoundedSemaphore(Semaphore):
    """A bounded semaphore checks to make sure its current value doesn't exceed
    its initial value. If it does, ValueError is raised. In most situations
    semaphores are used to guard resources with limited capacity. If the
    semaphore is released too many times it's a sign of a bug. If not given,
    *value* defaults to 1."""
    def __init__(self, value=1):
        super(BoundedSemaphore, self).__init__(value)
        self.original_counter = value

    def release(self, blocking=True):
        """Release a semaphore, incrementing the internal counter by one. If
        the counter would exceed the initial value, raises ValueError.  When
        it was zero on entry and another thread is waiting for it to become
        larger than zero again, wake up that thread.

        The *blocking* argument is for consistency with :class:`CappedSemaphore`
        and is ignored"""
        if self.counter >= self.original_counter:
            raise ValueError, "Semaphore released too many times"
        return super(BoundedSemaphore, self).release(blocking)

class CappedSemaphore(object):
    """A blockingly bounded semaphore.

    Optionally initialize with a resource *count*, then :meth:`acquire` and
    :meth:`release` resources as needed. Attempting to :meth:`acquire` when
    *count* is zero suspends the calling greenthread until count becomes nonzero
    again.  Attempting to :meth:`release` after *count* has reached *limit*
    suspends the calling greenthread until *count* becomes less than *limit*
    again.

    This has the same API as :class:`threading.Semaphore`, though its
    semantics and behavior differ subtly due to the upper limit on calls
    to :meth:`release`.  It is **not** compatible with
    :class:`threading.BoundedSemaphore` because it blocks when reaching *limit*
    instead of raising a ValueError.

    It is a context manager, and thus can be used in a with block::

      sem = CappedSemaphore(2)
      with sem:
        do_some_stuff()
    """
    def __init__(self, count, limit):
        if count < 0:
            raise ValueError("CappedSemaphore must be initialized with a "
                             "positive number, got %s" % count)
        if count > limit:
            # accidentally, this also catches the case when limit is None
            raise ValueError("'count' cannot be more than 'limit'")
        self.lower_bound = Semaphore(count)
        self.upper_bound = Semaphore(limit-count)

    def __repr__(self):
        params = (self.__class__.__name__, hex(id(self)),
                  self.balance, self.lower_bound, self.upper_bound)
        return '<%s at %s b=%s l=%s u=%s>' % params

    def __str__(self):
        params = (self.__class__.__name__, self.balance,
                  self.lower_bound, self.upper_bound)
        return '<%s b=%s l=%s u=%s>' % params

    def locked(self):
        """Returns true if a call to acquire would block."""
        return self.lower_bound.locked()

    def bounded(self):
        """Returns true if a call to release would block."""
        return self.upper_bound.locked()

    def acquire(self, blocking=True):
        """Acquire a semaphore.

        When invoked without arguments: if the internal counter is larger than
        zero on entry, decrement it by one and return immediately. If it is zero
        on entry, block, waiting until some other thread has called release() to
        make it larger than zero. This is done with proper interlocking so that
        if multiple acquire() calls are blocked, release() will wake exactly one
        of them up. The implementation may pick one at random, so the order in
        which blocked threads are awakened should not be relied on. There is no
        return value in this case.

        When invoked with blocking set to true, do the same thing as when called
        without arguments, and return true.

        When invoked with blocking set to false, do not block. If a call without
        an argument would block, return false immediately; otherwise, do the
        same thing as when called without arguments, and return true."""
        if not blocking and self.locked():
            return False
        self.upper_bound.release()
        try:
            return self.lower_bound.acquire()
        except:
            self.upper_bound.counter -= 1
            # using counter directly means that it can be less than zero.
            # however I certainly don't need to wait here and I don't seem to have
            # a need to care about such inconsistency
            raise

    def __enter__(self):
        self.acquire()

    def release(self, blocking=True):
        """Release a semaphore.  In this class, this behaves very much like
        an :meth:`acquire` but in the opposite direction.

        Imagine the docs of :meth:`acquire` here, but with every direction
        reversed.  When calling this method, it will block if the internal
        counter is greater than or equal to *limit*."""
        if not blocking and self.bounded():
            return False
        self.lower_bound.release()
        try:
            return self.upper_bound.acquire()
        except:
            self.lower_bound.counter -= 1
            raise

    def __exit__(self, typ, val, tb):
        self.release()

    @property
    def balance(self):
        """An integer value that represents how many new calls to
        :meth:`acquire` or :meth:`release` would be needed to get the counter to
        0.  If it is positive, then its value is the number of acquires that can
        happen before the next acquire would block.  If it is negative, it is
        the negative of the number of releases that would be required in order
        to make the counter 0 again (one more release would push the counter to
        1 and unblock acquirers).  It takes into account how many greenthreads
        are currently blocking in :meth:`acquire` and :meth:`release`."""
        return self.lower_bound.balance - self.upper_bound.balance



#==============================================================================
# Algorithm: Simplex
#==============================================================================
#!/usr/bin/env python
# 
# Copyright (c) 2001 Vivake Gupta (v@omniscia.org).  All rights reserved.
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA
#
# This software is maintained by Vivake (v@omniscia.org) and is available at:
#     http://www.omniscia.org/~vivake/python/Simplex.py

# Modified (debugged?) 7/16/2004 Michele Vallisneri (vallis@vallis.org)

""" Simplex - a regression method for arbitrary nonlinear function minimization

Simplex minimizes an arbitrary nonlinear function of N variables by the
Nelder-Mead Simplex method as described in:

Nelder, J.A. and Mead, R., "A Simplex Method for Function Minimization",
   Computer Journal, Vol. 7, 1965, pp. 308-313.

It makes no assumptions about the smoothness of the function being minimized.
It converges to a local minimum which may or may not be the global minimum
depending on the initial guess used as a starting point.
"""

import math
import copy
import sys

class Simplex:
    def __init__(self, testfunc, guess, increments, kR = -1, kE = 2, kC = 0.5):
        """Initializes the simplex.
        INPUTS
        ------
        testfunc      the function to minimize
        guess[]       an list containing initial guesses
        increments[]  an list containing increments, perturbation size
        kR            reflection constant  (alpha =-1.0)
        kE            expansion constant   (gamma = 2.0)
        kC            contraction constant (beta  = 0.5)
        """
        self.testfunc = testfunc
        self.guess = guess
        self.increments = increments
        self.kR = kR
        self.kE = kE
        self.kC = kC
        self.numvars = len(self.guess)
        self.simplex = []

        self.lowest = -1
        self.highest = -1
        self.secondhighest = -1

        self.errors = []
        self.currenterror = 0

        # Initialize vertices
        # MV: the first vertex is just the initial guess
        #     the other N vertices are the initial guess plus the individual increments
        #     the last two vertices will store the centroid and the reflected point
        #     the compute errors at the ... vertices
        
        for vertex in range(0, self.numvars + 3):
            self.simplex.append(copy.copy(self.guess))

        for vertex in range(0, self.numvars + 1):
            for x in range(0, self.numvars):
                if x == (vertex - 1):
                    self.simplex[vertex][x] = self.guess[x] + self.increments[x]
            self.errors.append(0)
        self.calculate_errors_at_vertices()

    def minimize(self, epsilon = 0.0001, maxiters = 250, monitor = 1):
        """Walks to the simplex down to a local minima.
        INPUTS
        ------
        epsilon       convergence requirement
        maxiters      maximum number of iterations
        monitor       if non-zero, progress info is output to stdout  

        OUTPUTS
        -------
        an array containing the final values
        lowest value of the error function
        number of iterations taken to get here
        """
        
        iter = 0
        
        for iter in range(0, maxiters):
            # Identify highest and lowest vertices
            
            self.highest = 0
            self.lowest = 0
            for vertex in range(1, self.numvars + 1):
                if self.errors[vertex] > self.errors[self.highest]:
                    self.highest = vertex
                if self.errors[vertex] < self.errors[self.lowest]:
                    self.lowest = vertex

            # Identify second-highest vertex

            self.secondhighest = self.lowest
            for vertex in range(0, self.numvars + 1):
                if vertex == self.highest:
                    continue
                elif vertex == self.secondhighest:
                    continue
                elif self.errors[vertex] > self.errors[self.secondhighest]:
                    self.secondhighest = vertex

            # Test for convergence:
            #   compute the average merit figure (ugly)

            S = 0.0
            for vertex in range(0, self.numvars + 1):
                S = S + self.errors[vertex]
            F2 = S / (self.numvars + 1)

            #   compute 
the std deviation of the merit figures (ugly)

            S1 = 0.0
            for vertex in range(0, self.numvars + 1):
                S1 = S1 + (self.errors[vertex] - F2)**2
            T = math.sqrt(S1 / self.numvars)
            
            # Optionally, print progress information

            if monitor:
                print '\r' + 72 * ' ',
                print '\rIteration = %d   Best = %f   Worst = %f' % \
                      (iter,self.errors[self.lowest],self.errors[self.highest]),
                sys.stdout.flush()
                
            if T <= epsilon:
                # We converged!  Break out of loop!
                
                break;
            else:
                # Didn't converge.  Keep crunching.
                
                # Calculate centroid of simplex, excluding highest vertex
                # store centroid in element N+1

                # loop over coordinates
                for x in range(0, self.numvars):
                    S = 0.0
                    for vertex in range(0, self.numvars + 1):
                        if vertex == self.highest:
                            continue
                        S = S + self.simplex[vertex][x]
                    self.simplex[self.numvars + 1][x] = S / self.numvars

                # reflect the simplex across the centroid
                # store reflected point in elem. N + 2 (and self.guess)
                
                self.reflect_simplex()
                self.currenterror = self.testfunc(self.guess)

                if self.currenterror < self.errors[self.highest]:
                    self.accept_reflected_point()

                if self.currenterror <= self.errors[self.lowest]:
                    self.expand_simplex()
                    self.currenterror = self.testfunc(self.guess)

                    # at this point we can assume that the highest
                    # value has already been replaced once
                    if self.currenterror < self.errors[self.highest]:
                        self.accept_expanded_point()
                elif self.currenterror >= self.errors[self.secondhighest]:
                    # worse than the second-highest, so look for
                    # intermediate lower point

                    self.contract_simplex()
                    self.currenterror = self.testfunc(self.guess)

                    if self.currenterror < self.errors[self.highest]:
                        self.accept_contracted_point()
                    else:
                        self.multiple_contract_simplex()
                        
        # Either converged or reached the maximum number of iterations.
        # Return the lowest vertex and the currenterror.

        for x in range(0, self.numvars):
            self.guess[x] = self.simplex[self.lowest][x]
        self.currenterror = self.errors[self.lowest]
        return self.guess, self.currenterror, iter

    # same as expand, but with alpha < 1; kC = 0.5 fine with NR

    def contract_simplex(self):
        for x in range(0, self.numvars):
            self.guess[x] = self.kC * self.simplex[self.highest][x] + (1 - self.kC) * self.simplex[self.numvars + 1][x]
        return

    # expand: if P is vertex and Q is centroid, alpha-expansion is Q + alpha*(P-Q),
    #         or (1 - alpha)*Q + alpha*P; default alpha is 2.0; agrees with NR
    def expand_simplex(self):
        for x in range(0, self.numvars):
            self.guess[x] = self.kE * self.guess[x]                 + (1 - self.kE) * self.simplex[self.numvars + 1][x]
        return

    # reflect: if P is vertex and Q is centroid, reflection is Q + (Q-P) = 2Q - P,
    #          which is achieved for kR = -1 (default value); agrees with NR
    def reflect_simplex(self):
        # loop over variables
        for x in range(0, self.numvars):
            self.guess[x] = self.kR * self.simplex[self.highest][x] + (1 - self.kR) * self.simplex[self.numvars + 1][x]
            # store reflected point in elem. N + 2
            self.simplex[self.numvars + 2][x] = self.guess[x]
        return

    # multiple contraction: around the lowest point; agrees with NR

    def multiple_contract_simplex(self):
        for vertex in range(0, self.numvars + 1):
            if vertex == self.lowest:
                continue
            for x in range(0, self.numvars):
                self.simplex[vertex][x] = 0.5 * (self.simplex[vertex][x] + self.simplex[self.lowest][x])
        self.calculate_errors_at_vertices()
        return

    def accept_contracted_point(self):
        self.errors[self.highest] = self.currenterror
        for x in range(0, self.numvars):
            self.simplex[self.highest][x] = self.guess[x]
        return

    def accept_expanded_point(self):
        self.errors[self.highest] = self.currenterror
        for x in range(0, self.numvars):
            self.simplex[self.highest][x] = self.guess[x]
        return

    def accept_reflected_point(self):
        self.errors[self.highest] = self.currenterror
        for x in range(0, self.numvars):
            self.simplex[self.highest][x] = self.simplex[self.numvars + 2][x]
        return

    def calculate_errors_at_vertices(self):
        for vertex in range(0, self.numvars + 1):
            if vertex == self.lowest:
                # compute the error unless we're the lowest vertex
                continue
            for x in range(0, self.numvars):
                self.guess[x] = self.simplex[vertex][x]
            self.currenterror = self.testfunc(self.guess)
            self.errors[vertex] = self.currenterror
        return

def myfunc(args):
    return abs(args[0] * args[0] * args[0] * 5 - args[1] * args[1] * 7 + math.sqrt(abs(args[0])) - 118)

def main():
    s = Simplex(myfunc, [1, 1, 1], [2, 4, 6])
    values, err, iter = s.minimize()
    print 'args = ', values
    print 'error = ', err
    print 'iterations = ', iter

if __name__ == '__main__':
    main()

#==============================================================================
# Algorithm: Splay Tree
#==============================================================================
"""Splay tree
Logan Ingalls <log@plutor.org>
Sept 3, 2012

Note that I only implemented insert and find. Delete is trivial,
and isn't the interesting part of splay trees. Some of these
algorithms would be simpler, but I chose to do this without parent
links from the tree nodes.

Example output on my desktop computer:

Building trees
Done building
Searched for 20 items 20000x in splay tree: 4.1 sec
Searched for 20 items 20000x in binary tree: 11.1 sec
"""
 
from random import shuffle
import time
 
class BinaryTreeNode:
    """A node in a binary tree. Each node has a val attribute,
    as well as left and right descendents. No parent links because
    I'm a masochist."""
    def __init__(self, val):
        self.val = val
        self.left = None
        self.right = None
 
    def __str__(self):
        return ("node[%s]" % self.val)
 
class BinaryTree:
    """A basic binary tree."""
    def __init__(self):
        self.root = None
 
    def insert(self, val, parent=None):
        """Insert a new value in the tree. Takes one argument
        (the value to insert). Recursive binary search."""
        if (parent == None):
            parent = self.root
        if (parent == None):
            # root is null, make this the new root, done
            self.root = BinaryTreeNode(val)
            return
        elif (val < parent.val):
            if (parent.left == None):
                # insert to the left of the parent
                parent.left = BinaryTreeNode(val)
                return
            else:
                # search under the left
                self.insert(val, parent.left)
        else:
            if (parent.right == None):
                # insert to the right of the parent
                parent.right = BinaryTreeNode(val)
                return
            else:
                # search under the right
                self.insert(val, parent.right)
 
    def find(self, val, node=None):
        """Find if a value is in the tree. Takes one argument
        (the value to find). If the value is in the tree, returns
        the node object. Otherwise returns None."""
        if (node == None):
            node = self.root
        if (node == None):
            # obviously it's not in an empty tree
            return None
        elif (val == node.val):
            return node
        elif (val < node.val):
            # Search left
            if (node.left != None):
                leftrv = self.find(val, node.left)
                if leftrv != None:
                    return leftrv
        elif (val > node.val):
            if (node.right != None):
                rightrv = self.find(val, node.right)
                if rightrv != None:
                    return rightrv
        return None
 
class SplayTree(BinaryTree):
    """Implementation of a splay tree. Splay trees are self-organizing.
    They look identical to binary trees, but when nodes are found, they
    are moved towards the root (one or two levels closer). Still
    O(lg n), but a shallower search on average when not all values are
    searched for equally."""
    def find(self, val, node=None, p=None, g=None, gg=None):
        """Find if a value is in the tree. Takes one argument
        (the value to find). If the value is in the tree, returns
        the node object. Otherwise returns None."""
        if (node == None):
            node = self.root
        if (node == None):
            # obviously it's not in an empty tree
            return None
        elif (val == node.val):
            # If it's found, we need to move things around
            if (p != None):
                if (g == None):
                    # Zig: swap node with its parent
                    self.rotateup(node, p, g)
                elif ((g.left == p and p.left == node) or
                      (g.right == p and p.right == node)):
                    # Zig-zig: swap parent with grandparent
                    self.rotateup(p, g, gg)
                    # Then swap node with parent
                    self.rotateup(node, p, gg)
                else:
                    # Zig-zag: swap node with parent
                    self.rotateup(node, p, g)
                    # Then swap node with grandparent
                    self.rotateup(node, g, gg)
            return node
        elif (val < node.val):
            # Search left
            if (node.left != None):
                leftrv = self.find(val, node.left, node, p, g)
                if leftrv != None:
                    return leftrv
        elif (val > node.val):
            if (node.right != None):
                rightrv = self.find(val, node.right, node, p, g)
                if rightrv != None:
                    return rightrv
        return None
 
    def rotateup(self, node, parent, gp=None):
        """Swap a node with its parent, keeping all child nodes
        (and grandparent node) in order."""
        if node == parent.left: 
            parent.left = node.right
            node.right = parent
            if (self.root == parent):
                self.root = node
        elif node == parent.right:
            parent.right = node.left
            node.left = parent
            if (self.root == parent):
                self.root = node
        else:
            print("This is impossible")
 
        if (gp != None):
            if (gp.right == parent):
                gp.right = node
            elif (gp.left == parent):
                gp.left = node
 
def test_splay_tree(treesize=100000, iters=20000):
    """Just a simple test harness to demonstrate the speed of
    splay trees when a few items are searched for very frequently."""
    # Build a binary tree and a splay tree
    print("Building trees")
    bintree = BinaryTree()
    spltree = SplayTree()
    x = [i for i in range(0, treesize)]
    shuffle(x)
    for n in x:
        bintree.insert(n)
        spltree.insert(n)
    print("Done building")
    searches = x[-20:]
 
    # Search the splay tree 1000 times
    t1 = time.time()
    for i in range(0, iters):
        for n in searches:
            node = spltree.find(n)
            if (node == None):
                print("ERROR: %d" % n)
    t2 = time.time()
    print("Searched for 20 items %dx in splay tree: %.1f sec" % (iters, t2-t1))
 
    # Search the binary tree 1000 times
    t1 = time.time()
    for i in range(0, iters):
        for n in searches:
            node = bintree.find(n)
            if (node == None):
                print("ERROR: %d" % n)
    t2 = time.time()
    print("Searched for 20 items %dx in binary tree: %.1f sec" % (iters, t2-t1))
 
test_splay_tree()

#==============================================================================
# Data Structure: Stack
#==============================================================================
# Bradley N. Miller, David L. Ranum
# Introduction to Data Structures and Algorithms in Python
# Copyright 2005
# 
#stack.py

class Stack:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        return self.items.pop()

    def peek(self):
        return self.items[len(self.items)-1]

    def size(self):
        return len(self.items)

#==============================================================================
# Design Pattern: Switch
#==============================================================================

from context.commands import Command

class Switch(Command):
    """Switch the current context"""
    alias = 's'

    def run(self, context, args, contexts):
        contexts.switch(args.subcommand[0])

#==============================================================================
# Operating System: Threads
#==============================================================================
# ==================================================================================================
# Copyright 2012 Twitter, Inc.
# --------------------------------------------------------------------------------------------------
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this work except in compliance with the License.
# You may obtain a copy of the License in the LICENSE file, or at:
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==================================================================================================

import threading
from functools import wraps


def __gettid():
  """Wrapper for the gettid() system call on Linux systems

  This is a lightweight, fail-fast function to obtain the thread ID of the thread from which it is
  called.  Unfortunately, there's not currently any means of obtaining this information on Linux
  other than through a direct system call. See man 2 gettid() for more details.

  This function can be called directly, but the more common usage pattern is through use of the
  identify_thread decorator on the run() function of a threading.Thread-derived object.

  Returns:
    on success, an int representing the thread ID of the calling thread, as returned from the
      gettid() system call. In the main thread of a process, this should be equal to the process
      ID (e.g. as returned by getpid())
    -1 on any failure (bad platform, error accessing ctypes/libraries, actual system call failure)

  """
  try:
    import platform
    if not platform.system().startswith('Linux'):
      raise ValueError
    syscalls = {
      'i386':   224,   # unistd_32.h: #define __NR_gettid 224
      'x86_64': 186,   # unistd_64.h: #define __NR_gettid 186
    }
    import ctypes
    tid = ctypes.CDLL('libc.so.6').syscall(syscalls[platform.machine()])
  except:
    tid = -1
  return tid


def identify_thread(instancemethod):
  """Simple decorator to expose Linux thread-IDs on an object.

  On Linux, each thread (aka light-weight process) is represented by a unique thread ID, an integer
  in the same namespace as process IDs. (This is distinct from the opaque identifier provided by the
  pthreads interface, which is essentially useless outside the context of the pthreads library.)
  This decorator provides a means to expose this thread ID on Python objects - most likely,
  subclasses of threading.Thread. The benefit of this is that operating-system level process
  information (for example, anything exposed through /proc on Linux) can then be correlated directly
  to Python thread objects.

  The means for retrieving the thread ID is extremely nonportable - specifically, it will only work
  on i386 and x86_64 Linux systems. However, including this decorator more generally should be safe
  and not break any cross-platform code - it will just result in an 'UNKNOWN' thread ID.

  This decorator can be used to wrap any instance method (and technically also class methods). To be
  truly useful, though, it should be used to wrap the run() function of a class utilising the Python
  threading API (i.e. a derivative of threading.Thread)

  Example usage:
    >>> import threading, time
    >>> from twitter.common.decorators import identify_thread
    >>> class MyThread(threading.Thread):
    ...   def __init__(self):
    ...     threading.Thread.__init__(self)
    ...     do_some_other_init()
    ...     self.daemon = True
    ...   @identify_thread
    ...   def run(self):
    ...     while True:
    ...       do_something_awesome()
    ...
    >>> thread1, thread2, thread3 = MyThread(), MyThread(), MyThread()
    >>> thread1.start(), thread2.start(), thread3.start()
    (None, None, None)
    >>> time.sleep(0.1)
    >>> for thread in (thread1, thread2, thread3):
    ...   print '%s => %s' % (thread.name, thread.__thread_id)
    ...
    Thread-1 => 19767
    Thread-2 => 19768
    Thread-3 => 19769
    >>> import os; os.system('ps -L -p %d -o pid,ppid,tid,thcount,cmd' % os.getpid())
      PID  PPID   TID THCNT CMD
    19764 19760 19764     4 /usr/bin/python2.6 /tmp/tmpSW3VIC
    19764 19760 19767     4 /usr/bin/python2.6 /tmp/tmpSW3VIC
    19764 19760 19768     4 /usr/bin/python2.6 /tmp/tmpSW3VIC
    19764 19760 19769     4 /usr/bin/python2.6 /tmp/tmpSW3VIC

  Note that there will be a non-zero delay between when the thread is started and when the thread ID
  attribute (self.__thread_id) is available.

  """
  @wraps(instancemethod)
  def identified(self, *args, **kwargs):
    tid = __gettid()
    if tid == -1:
      self.__thread_id = 'UNKNOWN'
    else:
      self.__thread_id = tid
      if isinstance(self, threading.Thread):
        self.setName('%s [TID=%d]' % (self.name, self.__thread_id))
    return instancemethod(self, *args, **kwargs)

  return identified


#==============================================================================
# Tree
#==============================================================================
# Brett Kromkamp (brett@youprogramming.com)
# You Programming (http://www.youprogramming.com)
# May 03, 2014

from node import Node

(_ROOT, _DEPTH, _BREADTH) = range(3)


class Tree:

    def __init__(self):
        self.__nodes = {}

    @property
    def nodes(self):
        return self.__nodes

    def add_node(self, identifier, parent=None):
        node = Node(identifier)
        self[identifier] = node

        if parent is not None:
            self[parent].add_child(identifier)

        return node

    def display(self, identifier, depth=_ROOT):
        children = self[identifier].children
        if depth == _ROOT:
            print("{0}".format(identifier))
        else:
            print("\t"*depth, "{0}".format(identifier))

        depth += 1
        for child in children:
            self.display(child, depth)  # recursive call

    def traverse(self, identifier, mode=_DEPTH):
        # Python generator. Loosly based on an algorithm from 
        # 'Essential LISP' by John R. Anderson, Albert T. Corbett, 
        # and Brian J. Reiser, page 239-241
        yield identifier
        queue = self[identifier].children
        while queue:
            yield queue[0]
            expansion = self[queue[0]].children
            if mode == _DEPTH:
                queue = expansion + queue[1:]  # depth-first
            elif mode == _BREADTH:
                queue = queue[1:] + expansion  # width-first

    def __getitem__(self, key):
        return self.__nodes[key]

    def __setitem__(self, key, item):
        self.__nodes[key] = item

#==============================================================================
# Tree Interface
#==============================================================================
# Copyright (C) by Brett Kromkamp 2011-2014 (brett@youprogramming.com)
# You Programming (http://www.youprogramming.com)
# May 03, 2014

from tree import Tree

(_ROOT, _DEPTH, _BREADTH) = range(3)

tree = Tree()

tree.add_node("Harry")  # root node
tree.add_node("Jane", "Harry")
tree.add_node("Bill", "Harry")
tree.add_node("Joe", "Jane")
tree.add_node("Diane", "Jane")
tree.add_node("George", "Diane")
tree.add_node("Mary", "Diane")
tree.add_node("Jill", "George")
tree.add_node("Carol", "Jill")
tree.add_node("Grace", "Bill")
tree.add_node("Mark", "Jane")

tree.display("Harry")
print("***** DEPTH-FIRST ITERATION *****")
for node in tree.traverse("Harry"):
    print(node)
print("***** BREADTH-FIRST ITERATION *****")
for node in tree.traverse("Harry", mode=_BREADTH):
    print(node)

#==============================================================================
# Data Structure: Trie Tree
#==============================================================================
class Trie:

    def __init__(self):
        self.__final = False
        self.__nodes = {}

    def __repr__(self):
        return 'Trie<len={}, final={}>'.format(len(self), self.__final)

    def __getstate__(self):
        return self.__final, self.__nodes

    def __setstate__(self, state):
        self.__final, self.__nodes = state

    def __len__(self):
        return len(self.__nodes)

    def __bool__(self):
        return self.__final

    def __contains__(self, array):
        try:
            return self[array]
        except KeyError:
            return False

    def __iter__(self):
        yield self
        for node in self.__nodes.values():
            yield from node

    def __getitem__(self, array):
        return self.__get(array, False)

    def create(self, array):
        self.__get(array, True).__final = True

    def read(self):
        yield from self.__read([])

    def update(self, array):
        self[array].__final = True

    def delete(self, array):
        self[array].__final = False

    def prune(self):
        for key, value in tuple(self.__nodes.items()):
            if not value.prune():
                del self.__nodes[key]
        if not len(self):
            self.delete([])
        return self

    def __get(self, array, create):
        if array:
            head, *tail = array
            if create and head not in self.__nodes:
                self.__nodes[head] = Trie()
            return self.__nodes[head].__get(tail, create)
        return self

    def __read(self, name):
        if self.__final:
            yield name
        for key, value in self.__nodes.items():
            yield from value.__read(name + [key])

#==============================================================================
# Design Pattern: Unit test of MVC
#==============================================================================
#!/usr/bin/env python
# Written by: DGC

# python imports
import unittest

# local imports
import MVC

#==============================================================================
class utest_MVC(unittest.TestCase):
    
    def test_model(self):
        model = MVC.Model()
        question, possible_answers = model.question_and_answers()

        # can't test what they are because they're random
        self.assertTrue(
            isinstance(question, str),
            "Question should be a string"
            )
        self.assertTrue(
            isinstance(possible_answers, list),
            "Answers should be a list"
            )

        for item in possible_answers:
            self.assertTrue(
                isinstance(item[0], str),
                "Elements of possible answer list should be strings"
                )

    def test_controller(self):
        model = ModelMock()
        view = ViewMock()
        controller = MVC.Controller(model, view)
        controller.new_question()
        self.assertEqual(
            view.question,
            "Question", 
            "Controller should pass the question to the view."
            )
        controller.answer("Question", "correct")
        self.assertEqual(
            controller.view.mock_feedback,
            "That is correct.", 
            "The feedback for a correct answer is wrong."
            )
        controller.answer("Question", "incorrect")
        self.assertEqual(
            controller.view.mock_feedback,
            "Sorry that's wrong.", 
            "The feedback for an incorrect answer is wrong."
            )
        
    def test_view(self):
        view = MVC.View()
        controller = ControllerMock(view)
        view.register(controller)

        self.assertIs(
            view.answer_button, 
            None,
            "The answer button should not be set."
            )
        self.assertIs(
            view.continue_button,
            None,
            "The continue button should not be set."
            )
        view.new_question("Test", ["correct", "incorrect"])
        
        self.assertIsNot(
            view.answer_button, 
            None,
            "The answer button should be set."
            )
        self.assertIs(
            view.continue_button,
            None,
            "The continue button should not be set."
            )
        # simulate a button press
        view.answer_button.invoke()
        self.assertIs(
            view.answer_button, 
            None,
            "The answer button should not be set."
            )
        self.assertIsNot(
            view.continue_button,
            None,
            "The continue button should be set."
            )

        self.assertEqual(
            controller.question,
            "Test",
            "The question asked should be \"Test\"."
            )
        self.assertEqual(
            controller.answer,
            "correct",
            "The answer given should be \"correct\"."
            )
        
        # continue
        view.continue_button.invoke()
        self.assertIsNot(
            view.answer_button, 
            None,
            "The answer button should be set."
            )
        self.assertIs(
            view.continue_button,
            None,
            "The continue button should not be set."
            )

#==============================================================================
class ViewMock(object):
    
    def new_question(self, question, answers):
        self.question = question
        self.answers = answers

    def register(self, controller):
        pass

    def feedback(self, feedback):
        self.mock_feedback = feedback

#==============================================================================
class ModelMock(object):
    
    def question_and_answers(self):
        return ("Question", ["correct", "incorrect"])

    def is_correct(self, question, answer):
        correct = False
        if (answer == "correct"):
            correct = True
        return correct

#==============================================================================
class ControllerMock(object):
    
    def __init__(self, view):
        self.view = view

    def answer(self, question, answer):
        self.question = question
        self.answer = answer
        self.view.feedback("test")

    def next_question(self):
        self.view.new_question("Test", ["correct", "incorrect"])
    

#==============================================================================
if (__name__ == "__main__"):
    unittest.main(verbosity=2)


#==============================================================================
# Weighted-Interval Scheduling
#==============================================================================
import collections
import bisect
import time
from datetime import datetime

"""
Weighted Interval scheduling algorithm.
Runtime complexity: O(n log n)
"""

class Interval(object):
    '''Date weighted interval'''

    def __init__(self, title, start, finish):
        self.title = title
        self.start = int(time.mktime(datetime.strptime(start, "%d %b, %y").timetuple()))
        self.finish = int(time.mktime(datetime.strptime(finish, "%d %b, %y").timetuple()))
        self.weight = self.finish - self.start

    def __repr__(self):
        return str((self.title, self.start, self.finish, self.weight))


def compute_previous_intervals(I):
    '''For every interval j, compute the rightmost mutually compatible interval i, where i < j
       I is a sorted list of Interval objects (sorted by finish time)
    '''
    # extract start and finish times
    start = [i.start for i in I]
    finish = [i.finish for i in I]

    p = []
    for j in xrange(len(I)):
        i = bisect.bisect_right(finish, start[j]) - 1  # rightmost interval f_i <= s_j
        p.append(i)

    return p

def schedule_weighted_intervals(I):
    '''Use dynamic algorithm to schedule weighted intervals
       sorting is O(n log n),
       finding p[1..n] is O(n log n),
       finding OPT[1..n] is O(n),
       selecting is O(n)
       whole operation is dominated by O(n log n)
    '''

    I.sort(lambda x, y: x.finish - y.finish)  # f_1 <= f_2 <= .. <= f_n
    p = compute_previous_intervals(I)

    # compute OPTs iteratively in O(n), here we use DP
    OPT = collections.defaultdict(int)
    OPT[-1] = 0
    OPT[0] = 0
    for j in xrange(1, len(I)):
        OPT[j] = max(I[j].weight + OPT[p[j]], OPT[j - 1])

    # given OPT and p, find actual solution intervals in O(n)
    O = []
    def compute_solution(j):
        if j >= 0:  # will halt on OPT[-1]
            if I[j].weight + OPT[p[j]] > OPT[j - 1]:
                O.append(I[j])
                compute_solution(p[j])
            else:
                compute_solution(j - 1)
    compute_solution(len(I) - 1)

    # resort, as our O is in reverse order (OPTIONAL)
    O.sort(lambda x, y: x.finish - y.finish)

    return O

if __name__ == '__main__':
    I = []
    I.append(Interval("Summer School" , "14 Jan, 13", "24 Feb, 13"))
    I.append(Interval("Semester 1" , "1 Mar, 13", "4 Jun, 13"))
    I.append(Interval("Semester 2" , "18 Aug, 13", "24 Nov, 13"))
    I.append(Interval("Trimester 1" , "22 Mar, 13", "16 May, 13"))
    I.append(Interval("Trimester 2" , "22 May, 13", "24 Jul, 13"))
    I.append(Interval("Trimester 3" , "28 Aug, 13", "16 Nov, 13"))
    O = schedule_weighted_intervals(I)
    print O
	
	

for line in f:
	# remove non-ascii characters
	text = line.strip()
	correctedString=''.join([i if ((ord(i) < 128) & (ord(i)!=26)) else ' ' for i in text])
	# only keep elements that do not have large number of missing items
	features=correctedString.split('\t')
	# write the first element
	outputFile.write("%s"%features[indxList[0]-1].strip())
	for indx in range(1,len(indxList)):
		outputFile.write("\t%s"%features[indxList[indx]-1].strip())
	outputFile.write("\n")

#num_lines = sum(1 for line in f)
f.close()
outputFile.close()


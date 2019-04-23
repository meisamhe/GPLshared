scala> val hamlet = sc.textFile(“/Users/akuntamukkala/temp
/gutenburg.txt”)
scala> val topWordCount = hamlet.flatMap(str=>str.split(“
“)). filter(!_.isEmpty).map(word=>(word,1)).reduceByKey(_+
_).map{case (word, count) => (count, word)}.sortByKey(fals
e)
scala> topWordCount.take(5).foreach(x=>println(x))
scala> topWordCount.toDebugString
Commonly Used Transformations:
TRANSFORMATION &
PURPOSE
EXAMPLE & RESULT
filter(func) Purpose: new
RDD by selecting those data
elements on which func
returns true
scala> val rdd =
sc.parallelize(List(“ABC”,”BCD”,”DEF”))
scala> val filtered =
rdd.filter(_.contains(“C”)) scala>
filtered.collect() Result:
Array[String] = Array(ABC, BCD)
map(func) Purpose: return
new RDD by applying func
on each data element
scala> val
rdd=sc.parallelize(List(1,2,3,4,5)) scala>
val times2 = rdd.map(_*2) scala>
times2.collect() Result:
Array[Int] = Array(2, 4, 6, 8, 10)
flatMap(func) Purpose:
Similar to map but func
returns a Seq instead of a
value. For example, mapping
a sentence into a Seq of
words
scala> val rdd=sc.parallelize(List(“Spark
is awesome”,”It is fun”)) scala> val
fm=rdd.flatMap(str=>str.split(“ “))
scala> fm.collect() Result:
Array[String] = Array(Spark, is,
awesome, It, is, fun)
reduceByKey(func,
[numTasks]) Purpose: To
aggregate values of a key
using a function.
“numTasks” is an optional
parameter to specify
number of reduce tasks
scala> val word1=fm.map(word=>
(word,1)) scala> val
wrdCnt=word1.reduceByKey(_+_)
scala> wrdCnt.collect() Result:
Array[(String, Int)] = Array((is,2), (It,1),
(awesome,1), (Spark,1), (fun,1))
groupByKey([numTasks])
scala> val cntWrd = wrdCnt.map{case
(word, count) => (count, word)} scala>
cntWrd.groupByKey().collect() Result
groupByKey([numTasks])
Purpose: To convert (K,V)
to (K,Iterable<V>)
cntWrd.groupByKey().collect() Result:
Array[(Int, Iterable[String])] =
Array((1,ArrayBuffer(It, awesome,
Spark, fun)), (2,ArrayBuffer(is)))
distinct([numTasks])
Purpose: Eliminate
duplicates from RDD
scala> fm.distinct().collect() Result:
Array[String] = Array(is, It, awesome,
Spark, fun)
Commonly Used Set Operations
TRANSFORMATION
AND PURPOSE
EXAMPLE AND RESULT
union()
Purpose: new RDD
containing all elements
from source RDD and
argument.
Scala> val rdd1=sc.parallelize(List(‘A’,’B’))
scala> val rdd2=sc.parallelize(List(‘B’,’C’))
scala> rdd1.union(rdd2).collect()
Result:
Array[Char] = Array(A, B, B, C)
intersection()
Purpose: new RDD
containing only common
elements from source
RDD and argument.
Scala> rdd1.intersection(rdd2).collect()
Result:
Array[Char] = Array(B)
cartesian()
Purpose: new RDD
cross product of all
elements from source
RDD and argument
Scala> rdd1.cartesian(rdd2).collect()
Result:
Array[(Char, Char)] = Array((A,B), (A,C),
(B,B), (B,C))
subtract()
Purpose: new RDD
created by removing
data elements in source
RDD in common with
argument
scala> rdd1.subtract(rdd2).collect() Result:
Array[Char] = Array(A)
join(RDD,[numTasks])
Purpose: When
invoked on (K,V) and
(K,W), this operation
creates a new RDD of (K,
(V,W))
scala> val personFruit =
sc.parallelize(Seq((“Andy”, “Apple”), (“Bob”,
“Banana”), (“Charlie”, “Cherry”),
(“Andy”,”Apricot”)))
scala> val personSE =
sc.parallelize(Seq((“Andy”, “Google”),
(“Bob”, “Bing”), (“Charlie”, “Yahoo”),
(“Bob”,”AltaVista”)))
scala> personFruit.join(personSE).collect()
Result:
Array[(String, (String, String))] =
Array((Andy,(Apple,Google)), (Andy,
(Apricot,Google)), (Charlie,(Cherry,Yahoo)),
(Bob,(Banana,Bing)), (Bob,
(Banana,AltaVista)))
cogroup(RDD,
[numTasks])
Purpose: To convert
(K,V) to (K,Iterable<V>)
scala>
personFruit.cogroup(personSe).collect()
Result:
Array[(String, (Iterable[String],
Iterable[String]))] = Array((Andy,
(ArrayBuffer(Apple,
Apricot),ArrayBuffer(google))), (Charlie,
(ArrayBuffer(Cherry),ArrayBuffer(Yahoo))),
(Bob,
(ArrayBuffer(Banana),ArrayBuffer(Bing,
AltaVista))))
ACTION &
PURPOSE
EXAMPLE & RESULT
count() Purpose: get
the number of data
elements in the RDD
scala> val rdd = sc.parallelize(list(‘A’,’B’,’c’))
scala> rdd.count() Result:
long = 3
collect() Purpose: get
all the data elements
in an RDD as an array
scala> val rdd = sc.parallelize(list(‘A’,’B’,’c’))
scala> rdd.collect() Result:
Array[char] = Array(A, B, c)
reduce(func)
Purpose: Aggregate
the data elements in
an RDD using this
function which takes
two arguments and
returns one
scala> val rdd = sc.parallelize(list(1,2,3,4))
scala> rdd.reduce(_+_) Result:
Int = 10
take (n) Purpose: :
fetch first n data
elements in an RDD.
computed by driver
program.
Scala> val rdd = sc.parallelize(list(1,2,3,4))
scala> rdd.take(2) Result:
Array[Int] = Array(1, 2)
foreach(func)
Purpose: execute
function for each data
element in RDD.
usually used to update
an
accumulator(discussed
later) or interacting
with external systems.
Scala> val rdd = sc.parallelize(list(1,2,3,4))
scala> rdd.foreach(x=>println(“%s*10=%s”.
format(x,x*10))) Result:
1*10=10 4*10=40 3*10=30 2*10=20
first() Purpose:
retrieves the first data
element in RDD.
Similar to take(1)
scala> val rdd = sc.parallelize(list(1,2,3,4))
scala> rdd.first() Result:
Int = 1
saveAsTextFile(path)
Purpose: Writes the
content of RDD to a
text file or a set of text
files to local file
system/ HDFS
scala> val hamlet =
sc.textFile(“/users/akuntamukkala/
temp/gutenburg.txt”) scala>
hamlet.filter(_.contains(“Shakespeare”)).
saveAsTextFile(“/users/akuntamukkala/temp/
filtered”) Result:
akuntamukkala@localhost~/temp/filtered$ ls
_SUCCESS part00000
part00001

RDD Persistence
guide.html//actions)
One of the key capabilities in Apache Spark is
persisting/caching RDD in cluster memory. This speeds up
iterative computation.
The following table shows the various options Spark for the
same.
STORAGE LEVEL PURPOSE
MEMORY_ONLY (Default
level)
This option stores RDD in available
cluster memory as deserialized Java
objects. Some partitions may not be
cached if there is not enough cluster
memory. Those partitions will be
recalculated on the fly as needed.
MEMORY_AND_DISK
This option stores RDD as deserialized
Java objects. If RDD does not fit in
cluster memory, then store those
partitions on the disk and read them
as needed.
MEMORY_ONLY_SER
This options stores RDD as serialized
Java objects (One byte array per
partition). This is more CPU intensive
but saves memory as it is more space
efficient. Some partitions may not be
cached. Those will be recalculated on
the fly as needed.
MEMORY_ONLY_DISK_SER
This option is same as above except
that disk is used when memory is not
sufficient.
DISC_ONLY
This option stores the RDD only on
the disk
MEMORY_ONLY_2,
MEMORY_AND_DISK_2,
etc.
Same as other levels but partitions are
replicated on 2 slave nodes
The above storage levels can be accessed through persist()
operation on RDD. cache() operation is a convenient way
of specifying MEMORY_ONLY option

scala> val map = sc.parallelize(Seq((“ground”,1),(“med”,2)
, (“priority”,5),(“express”,10))).collect().toMap

scala> val bcMailRates = sc.broadcast(map)

scala> val shippingCost=sc.accumulator(0.0)
scala> pts.map(x=>(x,1)).reduceByKey(_+_).map{case (x,y)=>
(x,y*bcMailRates.value(x))}.foreach(v=>shippingCost+=v._2)
scala> shippingCost.value

val sparkConf = new SparkConf().setAppName(“Customers”)
val sc = new SparkContext(sparkConf)
val sqlContext = new SQLContext(sc)
val r = sc.textFile(“/Users/akuntamukkala/temp/customers.t
xt”) val records = r.map(_.split(‘|’))
val c = records.map(r=>Customer(r(0),r(1).trim.toInt,r(2),
r(3))) c.registerAsTable(“customers”)
sqlContext.sql(“select * from customers where gender=’M’ a
nd age < 30”).collect().foreach(println)
val sparkConf = new SparkConf().setAppName(“TwitterPopular
Tags”)
val ssc = new StreamingContext(sparkConf, Seconds(2))
val stream = TwitterUtils.createStream(ssc, None, filters)
val hashTags = stream.flatMap(status => status.getText.spl
it(“ “).filter(_.startsWith(“//”)))
val topCounts60 = hashTags.map((_, 1)).reduceByKeyAndWindo
w(_ + _, Seconds(60)).map{case (topic, count) => (count, t
opic)}. transform(_.sortByKey(false))
val topList = rdd.take(10)
ssc.start()
val lines = ssc.socketTextStream(“localhost”, 9999, Storage
Level.MEMORY_AND_DISK_SER)


Spark Some moare
-----------------
Quick Tour of Scala
--------
Declaring variables:
var x: Int = 7
var x = 7 // type inferred
val y = "hi" //read-only
Functions:
def square(x: Int): Int = x*x
def square(x: Int): Int = { x*x }
def announce( text: string) = {println(text)}

Java equivalent:
int x = 7;
final string y = "hi";
int square (int x){
	return x*x;
}
void announce (String text){
	System.out.println(text);
}

Scala functions (closures):
(x: Int) => x + 2 // full version
x => x + 2 // type inferred
_+ 2 //placeholder syntax (each argument must be used exactly once)
x ={ // body is a block of code
	val numberToAdd = 2
	x + numberToAdd
}
// Regular functions
def addTwo(x: Int): Int = x + 2

val lst = List(1, 2, 3)
list.foreach(x => println(x)) // prints 1, 2, 3
list.foreach(println) //same
list.map(x => x+2) // return a new list (3, 4, 5)
list.map(_ + 2) // same
list.filter( x => x % 2 ==1) // returns a new list (1, 33)
list.filter(_ % 2 == 1) // same
list.reduce((x, y) => x + y) // => 6
lis.reduce(_ + _) // same

// All of those leave the list unchanged as it is immutable

map(f: T =>): Seq[u] // each element is result of f
flatMap(f: T => seq[u]): Seq[U] //one to many map
filter(f: T => Boolean): Seq[T] // Keep elements passing f
exists(f: T => Boolean): Boolean // True if one element passes f
forall(f: T => Boolean): Boolean // True if all element passes f
reduce(f: (T, T) => T): T // Merge elements using f
groupBy(f: T => K): Map[K, List[T]] // Group elements by f
sortBy(f: T => K): Seq[T] // Sort elements

Log mining example in Scala
----------
val lines = spark.textFile("hdfs://...")
val errors = lines.filter(_.startsWith("Error"))
val messages = errors.map(_.split('\t')(2))
messages.cache()
messages.filter(_.contains("mysql")).count()
messages.filter(_.contains("php")).count()

In memory caching, operator graphs in sparks
Data partitions read from RAM instead of disk
Scheduling optimization and fault tolerant by operator graphs

Easy expressive functions in Spark: 
------------
map, reduce, sample, filter, count, take, groupBy, fold, first, sort, reduceByKey, partitionBy, union, groupByKey, mapWith,
join, cogroup, pipe, leftOuterJoin, cross, save, rightOuterJoin, zip

Creating RDD's:
// python
sc.parallelize([1, 2, 3])
// scala
sc.parallelize(List(1,2, 3)) 
// Load text file from FS, HDFS, or S3 
sc.textFile("file.txt")
sc.textFile("directory/*.txt")
sc.textFile("hdfs://nnamenode:9000/path/file")
// Use existing Hadoop InputFormat (Java/Scala only)
sc.hadoopFile(keyClass, valClass, inputFmt, conf)

Basic transformation in Scala:
--
val nums = sc.parallelize(List(1,2,3))
// Pass each element through a function
val squares = nums.map(x: x*x) //{1,4,9}
// Keep elements passing a predicate
val even = squares.filter(x => x %2 ==0) //{4}
//Map each element to zero or more others
nums.flatMap(x => 0.to(x))

//Pass each partition through a function
val squares = nums.mapPartition(x.map(x*x))// {1,4,9}

// Set operations
this.union(rdd) // reduces a new RDD with elements from both rdds (fast!)
this.interesect*(rdd) // suprisingly slow
this.cartesian(rdd) // produce an RDD with the cartesian product from both RDDs (possibly not very fast)

Basic Actions (Scala)
--
val nums = sc.parallelize(List(1,2,3))
// Retrieve RDD contents as a local collection
nums.collect() // => List(1,2,3)
// Return first K elements
nums.take(2) // => List(1,2)
// Count number of elements
nums.count() //=> 3
// Merge elements with an associative function
nums.reduce{case (x,y) => x+y} //=> 6
//Write elements to a text file
nums.saveAsTextFile("hdfs://file.txt")

Basic Transformation (python)
-----
nums = sc.parallelize([1, 2, 3])
// Pass each element through a function
squares = nums.map(lambda x: x*x) // {1,4,9}
// Keep elements passing a predicate
even = squares.filter(lambda x: x%2 ==0)// {4}
// Map each element to zero or more others
nums.flatMap(lambda x: => range (x)) // => {0, 0, 1, 0, 1, 2}
// Retrieve RDD contents as a local collection
nums.collect() // => [1, 2, 3]
// Return first K elements
nums.take(2) // => [1, 2]
// Count number of elements
nums.count() // => 3
// Merge elements with an associative function
nums.reduce(lambda x, y: x + y) // => 6
// Write elements to a text file
nums.saveAsTextFile("hdfs://file.txt")

Working with Key-Value Pairse
---
Python: pair = (a, b), 
	pair[0] # => a
	pair[1] # => b
Scala:	val pair = (a, b)
	pair._1 // => a
	pair._2 // => b
Java:	Tuple2 pair = new Tuple2(a,b);
	pair._1 // => a
	pair._2 // => b

Some key-value operations in Scala:
pets = sc.parallelize( List(("cat", 1), ("dog", 1) , ("cat", 2)))
pets.reduceByKey(_ + _) // => ((cat, 3), (dog,1))
pets.groupByKey() // => {(cat, [1,2]), (dog, [1]))}
pets.sortByKey() // => {(cat, 1), (cat, 2), (dog, 1)}
// reduceByKey also automatically implements combiner on the map side


Some key-value operations in Python:
pets = sc.parallelize( [("cat", 1), ("dog", 1) , ("cat", 2)])
pets.reduceByKey(lambda x, y: x+y) # => ((cat, 3), (dog,1))
pets.groupByKey() # => {(cat, [1,2]), (dog, [1]))}
pets.sortByKey() # => {(cat, 1), (cat, 2), (dog, 1)}
# reduceByKey also automatically implements combiner on the map side

- it is possible to use wild-cards

Other Key-Value Operations
visits = sc.parallelize(List(("index.html", "1.2.3.4"), ("about.html", "3.4.5.6"), ("index.html", "1.3.3.1")))
pageNames = sc.parallelize(List("index.html", "Home"), ("about.html", "About")))
visits.join(pageNames)
// ("index.html", ("1.2.3.4", "Home"))
// ("index.html", ("1.3.3.1", "Home"))
// ("about.html", ("3.4.5.6", "About"))
visits.cogroup(pageNames)
// ("index.html", (Seq("1.2.3.4", "1.3.3.1"), Seq("Home")))
// ("about.html", (Seq("3.4.5.6"), Seq("About")))

// All the pair RDD operations take an optional second parameters of number of tasks
words.reduceByKey(_ + _, 5)
words.groupByKey(5)
visits.join(pageViews, 5)

// Any external variables used in closure will automatically be shipped to the cluster
val query = "pandas"
pages.filter(_.contains(query)).count()

// Complete App in Scala
import org.apache.spark._
import org.apache.spark.SparkContext._
object WordCount{
	def main(args: Array[String]){
		val sc = SparkContext(arg(0), "BasicMap", System.getenv("SPARK_HOME"))
		val input = sc.textFile(args(1))
		val counts = input.flatMap(_.split(" ")).map((_, 1)).reduceByKey(_ + _)
		counts.saveAsTextFile(args(2))
	}
}

// Spark Shell
./spark-shell
pyspark (IPYTHON=1)

// Word count in Scala
val lines = sc.textFile("hamlet.txt")
val counts = lines.flatMap(_.split(" ")).map((_, 1)).reduceByKey(_ + _)

# Word count in Python
lines = sc.textFile("hamlet.txt")
counts = lines.flatMap(lambda line: line.split(" ")).map(lamda word =>  (word, 1)).reduceByKey(lambda x, y: x+y)


//---------------------------
// Simple hello word on Figaro
//---------------------------
spark-shell
Tutorial:
//---------
https://www.cra.com/sites/default/files/pdf/Figaro_Tutorial.pdf
// on Hyper we have scala so
//-----------------------
// download the file into the current directory
wget  "https://www.cra.com/sites/default/files/files/figaro-4.1.0.0-linux-x64-installer.run"
chmod +x figaro-4.1.0.0-linux-x64-installer.run
./figaro-4.1.0.0-linux-x64-installer.run
// Quick start instructions
//-----------------------
https://www.cra.com/sites/default/files/pdf/Figaro_Quick_Start_Guide.pdf

// Use simple Built tool
---------------------------
Download the version of the SBT installer you need from http://www.scala-sbt.org/download.html
wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.13/sbt-0.13.13.tgz
tar xvzf sbt-0.13.13.tgz
// or a better approach: http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

// Note that ~/.bash_rc is not read by any program, and ~/.bashrc is the configuration file of interactive instances of bash. You should not define environment variables in ~/.bashrc. The right place to define environment variables such as PATH is ~/.profile (or ~/.bash_profile if you don't care about shells other than bash). See What's the difference between them and which one should I use?
\

// Add the sbt\bin directory to your system Path variable using the appropriate method for your operating system.
echo $PATH
PATH=~/sbt-launcher-packaging-0.13.13/bin:$PATH
export PATH=~/sbt-launcher-packaging-0.13.13/bin:$PATH
echo $PATH

// Run SBT to download the necessary files from the internet and test the installation. Enter: sbt
// You can also double-click the sbt.bat file in Windows to display the SBT console window.
// SBT will provide information messages as it downloads files, then it will display the SBT prompt.

Exit SBT. Enter:
exit

// To verify the Simple Build Tool installation
// 1 Create a HiWorld directory.
// 2 Create a HiWorld.scala file that contains the following:
object Hi {
 def main(args: Array[String]) = println("Hi!")
}
// 3 Open a command prompt.
// 4 Change directory to the HiWorld directory. For example, enter:
cd C:\Figaro\HiWorld
// 5 Start SBT. Enter:
sbt
SBT will provide information messages as it sets the project to the current directory. The command
prompt will look like:
>
// 6 Run the HiWorld project. Enter:
run
SBT will provide information messages as it updates files, resolves sources, and compiles the
HiWorld.scala file.
You will see a result similar to:
[info] ...
[info] Running Hi
Hi!
[success] Total time: 10 s, completed Sept 26, 2015 11:40:06 AM
// 7 Exit SBT. Enter:
exit

//------------------------------------
// Further configuration
//------------------------------------
http://alvinalexander.com/scala/scala-how-add-jar-file-scala-repl-classpath-command-line

scala
scala> :require figaro_2.11-4.1.0.0.jar

scala -cp ~/Figaro/figaro-4.1.0.0/lib/figaro_2.11-4.1.0.0.jar


//------------------------------------
// Downloading the FigaroWork project
//------------------------------------
// To download the Figaro Work project
// 1 Navigate to http://www.cra.com/figaro.
// 2 Click the Figaro Work link in the Figaro Work section to download the FigaroWork.zip file.
// wget  "https://www.cra.com/sites/default/files/files/FigaroWork.zip"
// 3 Extract the files to a folder on your local computer.
// unzip FigaroWork.zip
// This will create a top-level FigaroWork directory, with two subdirectories: FigaroWork and target.
// To verify your environment is configured properly
// 1 Open a command prompt.
// 2 Change directory to the FigaroWork/FigaroWork directory.
// cd FigaroWork/
// 3 Test SBT on the FigaroWork project. For example, on Windows, enter:
// sbt "runMain Test"
// SBT will provide information messages as it updates files, resolves sources, and compiles the
// Test.scala file included in the FigaroWork download. This process may take a few minutes.
// 4 Check that the following output is created:
// [info] Running Test
// 1.0
//[success] Total time: 200 s, completed Sept 26, 2015 12:40:06 AM
// If the output is not created, check that you ran SBT from the correct FigaroWork directory

//------------------------------------
// Downloading Figaro
//------------------------------------
// To download Figaro
// 1 Navigate to http://www.cra.com/figaro from a browser.
// 2 Click the Figaro zip file in the Download Figaro section.
// 3 Extract the files from the zip file.
//    The zip file contains the compiled Figaro code as a JAR file, examples, documentation, Scaladoc, and source code.
// 4 Add the directory that contains the Figaro JAR file to your system Path variable using the appropriate
// method for your operating system. For example, if you extracted the Figaro files to a Figaro folder on your C drive, add:
// C:\Figaro\figaro_3.3.0.0
 
echo $PATH
PATH=~/Figaro/figaro-4.1.0.0/lib:$PATH
export PATH=~/Figaro/figaro-4.1.0.0/lib:$PATH
PATH=~/Figaro/figaro-4.1.0.0/fat-jar:$PATH
export PATH=~/Figaro/figaro-4.1.0.0/fat-jar:$PATH
echo $PATH

//----------------------------------
Creating a model
//----------------------------------
1 Create a HelloWorldTest.scala file in the FigaroWork/src/main/scala directory.
SBT requires that your source code be placed in this directory.
If you cannot find this directory, follow the instructions in Installing the Simple Build Tool and
Downloading the FigaroWork project.
2 Edit the file to load the portion of the Figaro package that allows you to create models. Enter:
import com.cra.figaro.language_
The _ at the end of this line imports all the classes in the figaro.language package. It is
equivalent to Java’s *.
3 Create an object.
object HelloWorldTest{
 def main(args: Array[String]) {
 }
}
4 Create a probabilistic model after the definition of main. Enter:
val helloWorldElement = Constant(“Hello world!”)
We are creating an instance of Figaro’s Constant element with the field HelloWorldElement.
(In Scala, a field is similar to an immutable variable.) This element produces a value with the
probability of 1.0. When helloWorldElement is queried, it produces the string “Hello
world!” with a probability of 1.0.
Your file now looks like this:
import com.cra.figaro.language._
import com.cra.figaro.algorithm.sampling._
object HelloWorldTest{
         def main(args: Array[String]){
                val helloWorldElement = Constant("Hello world!")
                val sampleHelloWorld = Importance(1000, helloWorldElement)
                sampleHelloWorld.start()
                println("Probability of Hello world:")
                println(sampleHelloWorld.probability(hellowWorldElement, "Hello world!"))
                println("Probability of Goodbye world:")
                println(sampleHelloWorld.probability(helloWorldElement, "Goodbye world!"))
         }
}

// Load the portion of the Figaro package that contains the definition of the sampling algorithm.
// To determine which package you need to import, open http://www.cra.com/figaro, scroll to the
// Download Figaro section, and click the link to the documentation of the Figaro library interface
//    https://www.cra.com/Figaro_Scaladoc/index.html

//--------------------------------
// Slightly complicated example with Select rather than Constant
// and do Variable Elimination: exact algorithm
//----------------------------------
cd /src/main/scala
vim HelloWorldTest1

import com.cra.figaro.algorithm.factored.VariableElimination
import com.cra.figaro.language._
import com.cra.figaro.algorithm.sampling._
object HelloWorldTest1{
 def main(args: Array[String]){
 val helloWorldElement = Select(0.8->"Hello world!",0.2->"Goodbye world!")
 println("Probability of Hello world:")
 println(VariableElimination.probability(helloWorldElement, "Hello world!"))
 println("Probability of Goodbye world:")
 println(VariableElimination.probability(helloWorldElement,"Goodbye world!"))
 }
}

cd ~/Figaro/FigaroWork
sbt "runMain HelloWorldTest1"

//--------------------------------
// Producing results from queries
//--------------------------------
// 11 Open a command prompt.
// 12 Change directory to the FigaroWork/FigaroWork directory. For example, enter:
// cd c:\Program Files (x86)\sbt\FigaroWork
// SBT requires that you run your source code from the top-level FigaroWork directory (the same directory that contains the project, src, and target directories).
// 13 Enter the following to run your project:
// sbt "runMain HelloWorldTest"
// Figaro executes the program, running the reasoning algorithm and querying the model defined within
// the program. Running the program instantiates an Importance sampler, which takes 1000 samples from
// the model and saves each sample. Then it computes the probability of each string you queried within that result set.
// 14 Your HelloWorldTest project should produce the following output:
// [info] Running HelloWorldTest
// Probability of Hello world:
// 1.0
// Probability of Goodbye world:
// 0.0
// That is, helloWorldElement produced the string “Hello world!” 1000 times and never
// produced the string “Goodbye world!”

//----------------------------------
// Possible reasoning algorithms:
//-----------------------------------
1. VariableElimination: exact algorithm (expand all elements, elements --> factors)
2. BeliefPropagation: approximate inference, possible world expansion, messaging passing b/w factor and variable nodes
3. Importance Sampling: probability of evidence by forward sampling, multiply weight of sample by value of constraint (atomic continuous, infinite // elements)
4. MetropolisHastings: proposal distribution (ProposalScheme object), passed to this object and new state each step (accept, reject proposal)
5. ProbEvidenceSampler: compute the probability of all the evidence (not conditional on evidence), so constraint can be expluded or included
6. MPEVariableElimination or MetropolisHastingsAnnealer: most likely of value given available evidence using variable elimination and simulated annealing
7. ParticleFilter: dynamic model using an initial model, transition model, number of particles to produce at each step
8. ExpectationMaximization: parameter learning from data using expectation maximization

//----------------- 
// Creating sample example
//-----------------
val sampleHelloWorld = Importance(1000, HelloWorld)
sampleHelloWorld.start()

//----------------
// Example of query of the probability
//----------------
sampleHelloWorld.probability(helloWorldElement, “Hello world!”)
sampleHelloWorld.probability(helloWorldElement, “Goodbye world!”)

//----------------
Burglary example in Figaro
//----------------
https://www.cra.com/sites/default/files/pdf/Figaro_Quick_Start_Guide.pdf


//--------------------------------------------------------------
// Hello World in Figaro
//--------------------------------------------------------------
// Import Figaro constructs
import com.cra.figaro.language.{Flip, Select}
import com.cra.figaro.library.compound.If
import com.cra.figaro.algorithm.factored.VariableElimination
// Define the model
object HelloWorld {
  val sunnyToday = Flip(0.2)
  val greetingToday = If(sunnyToday,
       Select(0.6 -> "Hello, world!", 0.4 -> "Howdy, universe!"),
       Select(0.2 -> "Hello, world!", 0.8 -> "Oh no, not again"))
  val sunnyTomorrow = If(sunnyToday, Flip(0.8), Flip(0.05))
  val greetingTomorrow = If(sunnyTomorrow,
       Select(0.6 -> "Hello, world!", 0.4 -> "Howdy, universe!"),
       Select(0.2 -> "Hello, world!", 0.8 -> "Oh no, not again"))
 // Predict today’s greeting using an inference algorithm
  def predict() {
    val result = VariableElimination.probability(greetingToday,
                   "Hello, world!")
    println("Today’s greeting is \"Hello, world!\" " + "with probability " + result + ".")
	}
	// Use an inference algorithm to infer today’s weather, given the observation that today’s greeting is “Hello, world!”
	def infer() {
	  greetingToday.observe("Hello, world!")
	  val result = VariableElimination.probability(sunnyToday, true)
	  println("If today's greeting is \"Hello, world!\", today’s " +
	          "weather is sunny with probability " + result + ".")
	}
// Learn from observing that today’s greeting is “Hello, world!” to predict tomorrow’s greeting using an inference algorithm
	def learnAndPredict() {
	  greetingToday.observe("Hello, world!")
	  val result = VariableElimination.probability(greetingTomorrow,
	                 "Hello, world!")
	  println("If today's greeting is \"Hello, world!\", " +
	
	￼"tomorrow's greeting will be \"Hello, world!\" " +
	"with probability " + result + ".")
	}
// Main method that performs all the tasks
	  def main(args: Array[String]) {
	    predict()
	    infer()
	    learnAndPredict()
	} 
}


//----------------
Burglary example in Figaro
// An example of Bayesian Network
//----------------
// Bayesian Network to model scenarios
// It models the likelihood that a burglar set off a burglar alarm as opposed to an earthquake
// Measure probabilities using variable elimination algorithm
// Query the model using the algorithm to determine the cause

// 1. Create a BurglaryExample.scala file in the FigaroWork/src/main/scala directory
// do the following on Hyper:
// cd Figaro/FigaroWork/src/main/scala
// vim BurglaryExample.scala
2. The code and including conditional probability
	import com.cra.figaro.algorithm.factored._
	import com.cra.figaro.language._
	import com.cra.figaro.library.compound._
	object Burglary {
	 Universe.createNew()
	 private val burglary = Flip(0.01)
	 private val earthquake = Flip(0.0001)
	 private val alarm = CPD(burglary, earthquake,
	 (false, false) -> Flip(0.001),
	 (false, true) -> Flip(0.1),
	 (true, false) -> Flip(0.9),
	 (true, true) -> Flip(0.99))
	 private val johnCalls = CPD(alarm,
	 false -> Flip(0.01),
	 true -> Flip(0.7))
	 def main(args: Array[String]) {
	 johnCalls.observe(true)
	 val alg = VariableElimination(burglary, earthquake)
	 alg.start()
	 println("Probability of burglary: " + alg.probability(burglary,
	true))
	 alg.kill
	 }
	} 
3. run the Burglary algorithm
  cd ~/Figaro/FigaroWork
  sbt "runMain Burglary"

//------------------------------
// Figaro Representation
//------------------------------
// Elements:
// atomic:
Constant(6) // it's probability is 1, which is instance of Element[Int]
// Figaro classes are capitalized, while Scala reserved words are not
Constant("Hello") // this is an instance of Element[String]
// value type is the value that is generated by the probabilistic model that could be Int, Strig, etc.
// Scala uses type inference, so the value type of the parameter can often be omitted at class creation 
//	(the compiler will determine the type)
// All figaro Elements are instances of Element class
// Element class is parameterized by value types

//other elements:
// Flip(0.7) is an Element[Boolean] that represents the probabilistic
//	model that produces true with probability 0.7 and false with probability 0.3.
// Select(0.2 -> 1, 0.3 -> 2, 0.5 -> 3) is an Element[Int] that
//	represents the probabilistic model that produces 1 with probability
//	0.2, 2 with probability 0.3, and 3 with probability 0.5.
//	Select can select between elements of any type, so we may also
//	have Select(0.4 -> "a", 0.6 -> "b"), which is an Element[String].
// The continuous Uniform(0.0, 2.0) is an Element[Double] that
//	represents the continuous uniform probability distribution between 0 and 2.
//   It is int he package called: import com.cra.figaro.library.atomic.continuous._

// The _ is the Scala version of Java’s * for imports


// continuous atomic classes in the following package are:
//	library.atomic.continuous
//		Normal, Exponential, Gamma, Beta, and Dirichlet

// discrete elements included in the following package are:
//	library.atomic.discrete
//		Uniform, Geometric, Binomial, and Poisson

// Compound Elements:
// 	Flip(Uniform(0.0, 1.0))  // which is of type Element[Double].

// Conditional compound elements (in library.compound package package):
// If(Flip(0.7), Constant(1), Select(0.4 -> 2, 0.6 -> 3))
//	 Note If is a Figaro class, not the Scala if reserved word
// 	The first argument to If must be an Element[Boolean], 
// 	while the other two arguments must have the same value type, which also becomes the value type of the If.

// chain as a form of Compound element
//	Chain(Flip(0.7), (b: Boolean) =>
//		if (b) Constant(1); else Select(0.4 -> 2, 0.6 -> 3))
// a Chain[T,U] is an Element[U], so the first element is the parnet, and the second one U is the child
// this is a generative process of child given parent
// If more parents are required for a Chain, multiple Chains can be nested together.

// Scala notation for the type of a function is: inType => outType
// Anonymous functions in Scala are created by defining an
//	argument list and the body of the function. The return type is inferred by the compiler

// Apply
// Figaro Apply is a class, different than the Scala apply which is a method defined on many classes
// Apply(Select(0.2 -> 1, 0.8 -> 2), (i: Int) => i + 5) // first generates numbers then adds five to them

// variety of operators that can be defined using Apply:
//	^^ creates tuples. For example, ^^(x, y) where x and y are elements,
//		creates an element of pairs. ^^ is defined for up to five
//		arguments. The arguments can have different value types.
//	If x is an element whose value type is a tuple, x._1 is an element
//		that corresponds to extracting the first component of x.
//		Similarly for _2, _3, _4, and _5.
// 	x === y, where x and y have the same value type, is the element
//		that produces true whenever they are equal. Similarly for !=.

// Sequences in Scala are similar to Java. Seq is the superclass in Scala for many
//		types of data structures, such as List.

// Processes
//-------------------
// infinite collection of random variables
// Formally, a Process is a mapping from an index set to an element. 
// A Process is parameterized by two types: the type of the indices and the type of the values of the elements in the collection.
// The Process is an extremely general class that can be used to represent things like Gaussian processes or continuous time Markov processes.
// When creating a Process, you need to specify how elements in the collection are generated given an index

// Not only that, in some collections, the elements are dependent. Therefore, the Process class contains a method to generate elements for many indices simultaneously,
//	including the dependencies between them. 
// This method must also be provided by the user. If all the elements are independent, you can use the IndependentProcess trait to specify this method.

// Getting the element at an index. If p is a Process[Int, Double], p(5) gets the Element[Double] at index 5. This method throws
//		IndexOutOfRangeException if no element is defined at index 5.

// Getting elements at many indices simultaneously, for example, using p(List(4,5,6)). This method can also throw IndexOutOfRangeException.
//		The method creates a Scala Map from indices to elements. Any elements representing dependencies between
//		the elements at these indices are also created but they are not returned by this method

// Safely getting an optional element at an index. p.get(5) will return an Element[Option[Double]]. This element will always
//		have value None if no element is defined at index 5.

// Safely getting an optional element at many indices.

// Mapping the values of every element in the process through a function. For example, p.map(_ > 0) will produce a Process[Int, Boolean].

// Chaining the value of every element in the process through a function that returns an element. For example, 
//	p.chain(Normal(_,1)) will produce a new collection in which every element is normally distributed with mean equal to the value of the corresponding
//	element in the original process.

// Containers:
//	If you have a finite index set, you can use a Container, which takes a sequence of indices. Because they are finite, containers have many
//	more operations defined on them, including a variety of folds and aggregates. 
// FixedSizeArray: A specific kind of container 
//	takes the number of elements as the first argument and a function that generates an element for a given index as the second argument. 
//	new FixedSizeArray(10, (i: Int) => Flip(1.0 / (i + 1))) creates a container of ten Boolean elements.
// Container constructor:
//	takes any number of elements and produces a container with those elements. 
//	Container(Flip(0.2), Flip(0.4)) creates a container consisting of the two elements.

// You can, naturally, have elements whose values are processes or containers. 
// Figaro provides the ProcessElement and ContainerElement classes to represent these. 
// Similar operations are defined for ProcessElement and ContainerElement as for processes and containers.

// VariableSizeArray represents a collection of an unknown number of elements, where the number is itself defined by an element. 
// It takes two arguments, the number element, and a function that generates an element for a given index, like a fixed size array. 
// For example, VariableSizeArray(Binomial(20, 0.5), (i: Int) => Flip(1.0 / (i+ 1)) creates a container of between 0 and 20 Boolean elements.

// val in Figaro represents an immutable value. When a thing is assigned to a val, data inside the thing can change but the reference stored in
//	the val is constant

// element defines a process that probabilistically produces a value.

// in the following y produces the value true with probability 1.0
val x = Flip(0.5)
val y = x === x

// in the following the left and right hand sides are distinct elements (each call produces a new Flip), so they need not produce the same value. 
val y = Flip(0.5) === Flip(0.5)

// Scala statements can be written on multiple lines 

// CPD:
// 	every single combination of values of the parents needs today’s be listed

// RichCPD:
// a more flexible format that allows for specification of structures such as context specific independence
// each clause consists of a tuple of cases, one for each parent
// case can be OneOf a set of values, NoneOf a set of values (meaning that it matches all values except for the ones listed), or *, meaning that it
//		accepts all values.
// All possible values of the parent still need to be accounted for in the argument list using a combination of OneOf, NoneOf and *.

import com.cra.figaro.language._
import com.cra.figaro.library.compound._
val x1 = Select(0.1 -> 1, 0.2 -> 2, 0.3 -> 3, 0.4 -> 4)
val x2 = Flip(0.6)
val x3 = Constant(5)
val x4 = Flip(0.8)
val y = RichCPD(x1, x2, x3, x4,
(OneOf(1, 2), *, OneOf(5), *) -> Flip(0.1),
(NoneOf(4), OneOf(false), *, *) -> Flip(0.7),
(*, *, NoneOf(6, 7), OneOf(true)) -> Flip(0.9),
(*, *, *, OneOf(false)) -> Constant(true))

// It is also possible to influence the values of elements by imposing conditions or constraints on them
// A condition represents something the value of the element must satisfy.
// Only values that satisfy the condition are possible. 
// Every element has a condition, which is a function from a value of the element to a Boolean. 
// If the element is of type Element[T], the condition is of type T => Boolean. 
// Conditions can have multiple purposes. One is to assert evidence, by specifying something that is known about an element. 
// Alternatively, a condition can specify a structural property of a model, for example, that only one of two teams playing a game can be the winner.
// The default condition of an element returns true for all values.

// change condition using setCondition
val x1 = Select(0.1 -> 1, 0.2 -> 2, 0.3 -> 3, 0.4 -> 4)
x1.setCondition((i: Int) => i == 1 || i == 4)
// which says that x1 must have value 1 or 4.

// Adding condition:
// the following code says that not only must x1 equal 1 or 4, it must also be odd:
x1.addCondition((i: Int) => i % 2 == 1)

// observe method: specify condition that allows a single value: removes all previous conditions on an element
x1.observe(2)

// A constraint provides a way to specify a potential or weighting over an element
// It is function from a value of the element to a Double, so if the element has type Element[T], the constraint is of type T => Double
// constraint values should always be non-negative
// constraint value shall be at most 1
// Constraints serve multiple purposes in Figaro. One is to specify soft evidence on an element. 

// For example, if in the above Bayesian network we think we heard John call but we’re not sure, we might introduce the constraint:
johnCalls.setConstraint((b: Boolean) => if (b) 1.0; else 0.1)
// This line will have the effect of making John calling 10 times more likely than not, all else being equal.

// Another purpose of constraints is to define some probabilistic relationships conveniently that are more difficult to express without them

// firms: _* explanation:
// Since firms is a single field representing an array, we must convert it into a sequence of arguments, which is accomplished using the :_* notation

// winningBid.setConstraint((d: Double) => 20 - d)
// Finally, we introduce the constraint, which says that a winning bid of d has weight 20 − d. This means that a winning bid of 5 is 15
//		times more likely than a winning bid of 19.
// The effect is to make the winning bid more likely to be low.
// Note that in this model, the winning bid is not necessarily the lowest bid. For various reasons, the lowest bidder might not win the contract, perhaps because they
//		offer a poor quality service or they don’t have the right connections.

// Constraints are useful for expressing undirected models such as relational Markov networks or Markove logic
// friends and smokers example: number of people and their smoking habit, people have propensity to smoke, 
//		and people are likely to have the same smoking habit as their firends

// Single line function definitions in Scala do not need bracketing

// Package definition structure in Scala and Figaro:
package com.cra.figaro.example
// in case of Class Not found problem, the package definition might be the source

// Abstract classes in Scala are similar as in Java; they cannot be instantiated

// Defining class contents at instantiation time will override undefined values

// The ’ in front of a string creates a Scala symbol, which are treated like String constants

// The _.award notation is Scala shorthand to retrieve the award value of each element of the map

// val is for immutable case
// functional makes it inconvenient to represent situation in which different entities refer to each other, so this is non-function style that is supported in scala

// ::= is Scala shorthand for list concatenation

// var is mutbable, and val is immutable

// Side effects and unintended consequences can occur if a lazy element declared outside a Chain is first required (i.e., created) during the execution of a Chain.

// universe
// A central concept in Figaro is a universe. A universe is simply a collection of elements. 
// Reasoning algorithms operate on a universe (or, as we shall see for dependent universe reasoning, on multiple connected universes). 
// Most of the time while using Figaro, you will not need to create a new universe and can rely on the default universe, which is just called universe. 
// It can be accessed using:
import com.cra.figaro.language._
import com.cra.figaro.language.Universe._

// if you need a different universe you can call
Universe.createNew()
// then this becomes the default universe

// to need the old default universe, you can refer to it by:
val u1 = Universe.universe
val u2 = Universe.createNew()

// u1 is old universe, and u2 is the new one
// when an element is created it is assigned to the current default universe
// in element collection, we can assigne a particular element to a different universe from the current default

// activate and deactivate an element
// the elements that are deactivated are not operated on by the reasoning algorithms
// elements are active when created
// to deactivate an element use:
e.deactivate();

// to reactivate an element use:
e.activate()

// when a compound element is created that uses a parent element, the parent must already be active

// you can get the list of all active elements in universe u using:
u.activeElements

// documation of Universe.scala for details

// every element in Figaro has a name and belongs to an element collection
// universe are element collections

// an element collection, like a universe, is simply a set of elements
// universe is a set of elements on which a reasoning algorithm operates
// an element collection provides the ability to refer to an element by name
//		e.g. if car is instance of car use car.get[Engine]("engine") to get element named "engine"
//		the get method takes a type parameter, which is the value type of the element being refered to
//		the notation [Engine] specifies this type of parameter, and serves to make sure that expression car.get[Engine]("engine") has type Element[Engine]

// element collection ability:
// ability to get element embeded int he value (by using references)
// a reference is a series of names separated by dots
// e.g. "engine.power" is a reference, so car.get[Symbol]("egine.power") refers to the element named "engine" within the car
// 		returns ReferenceElement that captures the uncertainty about which power element is actually being referred to
//		in particular state of the world, ie., an assignment of values to all elements, determine the value of engine and which power element is being referred to
//		ReferenceElement is a deterministic element that defines a way to get its value in any possible world

// PRM allows for multi-valued relationships, where an entity is related to multiple entities via an attribute 
//		in Figaro multi-valued references and aggregate are for these kinds of situations

// The body of the sum function is shorthand notation for Scala’s fold function. 
// Fold iterates through a sequence and applies a function to the previous result and each new entry in turn. 
// The (_ + _ ) notation will add the previous value to each value in xs.
//		it is used to "fold" a function through the list
//		we begin with 0 and then repeatedly add the current result to the next element of the list until the list is exhausted
//		this notation is shorthand for the function that takes two arguments and adds them

// The notation (0 : xs) means theat this function should be folded through xs, starting from 0

// Reasoning in Figaro:
// 1. Algorithm that computes the range of possible values of all elements in a universe
// 2. Three algorithms for computing the conditional probability of query element given evidence (conditions and constraints) on elements:
//	- Variable elimination
//	- Importance sampling
//	- Markov chain Monte Carlo
// 3. Algorithm for computing the most likely values of elements given the evidence:
//	- Variable elimination
//	- Simulated annealing
// 4. Additional features of reasoning:
//	- the ability to reason across multiple universes
//	- a way to use abstraction in reasoning algorithms

// Compute the set of possible values of elements in the universe (computing ranges), 
//		as long as expanding the probabilistic model of the universe does not:
//	(1) result in generating an infinite number of elements
//		- computing the possible values of a chain requires computing the possible values of the arguments
//		- for each value generating the appropriate element and computing all its possible values
//		- if the generated element also contains a chain, it will require recursively generating new elements for all possible values of the contained chains' argument
//		- this coule potentially lead to an infinite recursion, in which case computing ranges will not terminate
//	(2) result in an infinite number of values for an element
//		- most built in element classes have a finite number of possible values, except atomic continuous classes like Uniform and Normal
//	(3) involves an element class for which getting the range has not been implemented

// to compute the values of elements in universe u, first create a Values object using:
import com.cra.figaro.algorithm._
val values = Values(u)

// create a Values object for the current universe simply with
val values = Values()
// values can be used to get the possible values of any object, e.g.:
val e1 = Flip(0.7)
val e2 = If(e1, Select(.2 -> 1, .8 -> 2), Select(.4 -> 2, .6 -> 3))
val values = Values()
values(e2)
// returns a Set[Int] euql to [1, 2, 3]

// if only interested in getting the range of the single element e2, use the shorthand:
Values()(e2)

// if you want the range of multiple elements, you are better off creating Values object and applying it repeatedly to get the range of different elements by
val values = Values()
// this is because within Values object, computing the range of an element is memoized(cached), 
//		meaning the range is only computed once for each object, and then sorted for future use

// Asserting Evidence
// Figaro reasoning involves drawing conclusion from evidence by two ways:
// 1. conditions and contraints
// 2. providing named evidence, in which the evidence is associated with an element with a particular name or reference
//	Benefits of using named evidence:
//		- situation where the actual element refered to by reference is uncertain, so can't directly specify a condition or constraint on the element
//		-    but associating the evidence with the reference can ensure it is applied correctly
//		- Names allow us to keep track of and apply evidence to elements that correspond to the same object in different universe, as will be seen in dynamic reasoning
//		- associating evidence with names and references allows us to keep the evidence separate from the definition of the probabilistic model 
//		-		which is not achievable by conditions and constraints

// Named evidence specification:
NamedEvidence(reference, evidence)
// evidence is instance of Evidence class
// reference is a reference

// three concrete subclasses of Evidence:
Condition
Constraint
Observation
// they behave like an element's methods:
setCondition
setConstraint
observe

// examples of NamedEvidence
NamedEvidence("car.size", Condition((s: Symbol) => s != 'small))
// represents the evidence that the element refered to by "car.size" does not have value 'small

// Exact inference using variable elimination Algorithm in Figaro:
// 1. Expand the universe to include all elements generated in any possible world
//	- requires that the expansion of the universe terminate in a finite amount of time (like for range computation)
// 2. Convert each element into a factor
//	- requires each element be of a class that can be converted into a set of factors (every built in class can be converted)
//	- Atomic continous elements with infinite range are handled in one of two ways
//		- Abstractions can be used to make variable elimination work for continuous classes
// 		- if no abstractions are defined for continuous elements, then each continuous element is sampled and a factor is created from the samples
//		-	(Figaro outputs a warning in this instance to ensure the user intended to use a continuous variable in a factored algorithm)
//		-   (also there is a way to specify to convert a new class into a set of factors for a new element class)
// 3. Apply variable elimination to all the factors

// To use variable Elimination, specify a set of query elements whose conditional probability you want to compute given the evidence
// e.g.
import com.cra.figaro.language._
import com.cra.figaro.algorithm.factored._
val e1 = Select(0.25 -> 0.3, 0.25 -> 0.5, 0.25 -> 0.7, 0.25 -> 0.9)
val e2 = Flip(e1)
val e3 = If(e2, Select(0.3 -> 1, 0.7 -> 2), Constant(2))
e3.setCondition((i: Int) => i ==2)
val ve = VariableElimination(e2)
// create a VariableElimination object that will apply variable elimination to the universe containing e1, e2, and e3
//		leaving query variable e2 uneliminated (but does not perform VE immediately, so start method needs to be called)
ve.start()

// after this call terminates, it is possible to use ve to answer queries using three methods:

// 1. First method:
ve.distribution(e2)
// returns a stream containing possible values of e2 with their associated probabilities

// 2. Second method:
ve.probability(e2, predicate)
// returns the probability that the value of e2 satisfies the given predicate
// e.g. (b: Boolean) => b is the functiont hat takes a Boolean argument and returns true precisely if its argument is true
ve.probability(e2, (b: Boolean) => b)
// computes the probability that e2 has value true
// this method also provides a shorthand version that specifies a value as the second argument instead of a predicate 
//		and returns the probability the element takes the specific value, e.g.:
ve.probability(ve, true)

// 3. Third method:
ve.expectation(e2, (b: Boolean) => if (b) 3.0; else 1.5)
// returns the expectation of the given function applied to e2
// if just the expectation of element is required, just provide a function that returns the value of the function

// once done with the result of variable elimination, you can call
ve.kill()
// frees up the memory used for the results
// only elements provided in the argument list of the VariableElimination class can be queried
// if at later point you want to query a different element not in the argument list, you must create a new instance of VariableElimination

// Uniform interface to all reasoning algorithms that compute the conditional probability of query variables given the evidence:
start()
kill()
distribution()
probability()
expectation()


// Figaro provides a one-line query method using variable elimination
VariableElimination.probability(element, value)
// takes care of instantiating the algorithm and running inference, and returning the probability that the element has the given value

// Approximate Inference Using Belief Propagation
// Factored inference algorithm in Figaro is called Belief Propagation (BP)
// * On factor graph with no loop (loopy factor graph), BP can be used to perform approximate inference on the target variables
// 	- In Figaro, the way that Chains are converted to factors always produces a loopy factor graph, even if the actual definition of the model contains no loops
//	=> most inference with BP in Figaro is approximate

// Algorithm for Belief Propagation (BP) works as follows:
// 1. Expand the universe to include all elements generated in any possible world.
// 2. Convert each element into a factor and create a factor graph from the factors.
//		- step 1 and 2 operate in the same manner as variable elimination (the same restrictions on factors applies)
// 3. Pass message between the factor nodes and available nodes for the specified number of iterations.
// 4. Queries are answered on the targets using the posterior distributions computed at each variable node.

// a factor graph is a bipartite graph with variable and factor nodes, so adjacent to variable nodes should be only factors and vise versa
// factors clusters with Jurisdications over each of the couple of variables
// evidence or belief as psi functions (factors)
// 1. initialize with uninformative message (one: delta = 1)
//	- each cluster or node represents the subset of variables
//	- edge between clusters depend on the membership of varaibles in those clusters (so the nodes between clusters have variables at the middle)
//	- we give information to the clusters by assigning one factor to each cluster
//	- initial belief of a particular cluster is the product of all factors that are assigned to that cluster (initial potentials) 
//		- as some clusters might have several factors assigned to them
//	- so although each factor is assigned to one cluster
// 2. Integrate over the variable that the node does not care about (so it takes the evidence and sums over the variable that is not of interested)
//	- the message is sent across the clusters (i.e. clusters or factors connect variables)
//	- so incoming message is integrated (is summed over) by the weights (i.e. weighted average) of variable that new cluster don't care about
//   - multiply all incoming messages from the variables that connect to cluster (some variables might appear on multiple edges) and 
//			weight by the factor assigned to the cluster and then sum (integrate out) the variables that are not of interest
// 3. we don't want to re-inforce, so when a cluster (or factor) wants to send a message to another cluster (or factor), 
//	- it does not include the message that it has already heard from that cluster
//	- so there is no rumor re-inforcement of the message that is already heard from the same person
//	- at the end it takes all the messages and multiplies to initial potential and it forms the beliefs
//	- the order can be round robin (prespecified order) and the number of iteration could be until convergence of the probability (approximate NP hard)

// summary: message is multiply all incoming message and weight them by the potential (i.e. joint factor), 
//		then sum over all variables that the node is not interested about
//	what MCMC does is actually give close form for this sum after recieving all the messages (i.e. combine data and prior for posterior)
//	also the way continuous case is handled is to take sample from the potential range

//	just like in variable elimination, specify a set of query elements whose conditional probability you want to compute given evidence
// e.g. 

import com.cra.figaro.language._
import com.cra.figaro.algorithm.factored._
import com.cra.figaro.algorithm.factored.beliefpropagation._

val e1 = Select(0.25 -> 0.3, 0.25 -> 0.5, 0.25 -> 0.7, 0.25 -> 0.9)
val e2 = Flip(e1)
val e3 = If(e2, Select(0.3 -> 1, 0.7 -> 2), Constant(2))
e3.setCondition((i: Int) => i==2)
val bp = BeliefPropagation(100, e2)
// creates a BeliefPropagation object that will pass messages on a factor graph created from the universe containing e1, e2, and e3
// the first argument is the number of iterations to pass messages b/w the factor and variable nodes

// to perform BP
bp.start()

// factored inference algorithms like variable elimination and belief propagation conannot be applied to infinitely recursive models
//	it is easy to define such models, such as probabilistic grammars for natural language, in Figaro
// Figaro provides lazy factored inference algorithms that expand the factor graph to a bounded depth and 
//		precisely quantify the effect of unexplored part of the graph on the query
//		it uses this information to compute lower and upper bounds on the probability of the query
// To use lazy variable elimination, create an instance of LazyVariable-Elimination
LazyVariable-Elimination

// to increase the depth of expansion by 1 use pump method
pump

// to expand to the given depth:
run(depth)

// lazy belief propagation is also possible

// Importance Sampling
// - it is a combination of importance and rejection sampling
// - it uses a simple forward sampling approach
// - when it encounters a condition, it checks to see if the condition is satisfied and rejects if it is not
// - when it encounters a constraint, it multiplies the weight of the sample by the value of the constraint
// - unlike variable elimination, it can be applied to models whose expansion produces an infinite number of elements, 
//		- provided any particular possible world only requires a finite number of elements to be generated
// - it works for atomic continuous models
// - As an approximate algorithm, it can produce reasonably accurate answers much more quickly than the exact variable elimination

// The basic idea of importance sampling is to sample the states from a different distribution to lower the variance of the estimation of E[X;P], 
//		or when sampling from P is difficult. 
// summary: importance sampling is actually the sample we get by accept reject algorithm

import com.cra.figaro.language._
import com.cra.figaro.algorithm.sampling._

val e1 = Select(0.25 -> 0.3, 0.25 -> 0.5, 0.25 -> 0.7, 0.25 -> 0.9)
val e2 = Flip(e1)
val e3 = If(e2, Select(0.3 -> 1, 0.7 -> 2), Constant(2))
e3.setCondition((i: Int) => i == 2)
val imp = Importance(1000, e2)
// the first argument is indication of how many samples the algorithm should take
// the second argument (and subsequent arguments) lists the element(s) that will be required

imp.start()
// meethod distribution, probability, and expectation can be used to answer queries
// this is "one-time" algorithm, so it is run for 10,000 iterations and terminates (so cannot be used again)
// there is "anytime" importance sampling that runs in a separate threat and continuous to accumulate samples until it is stopped
//		- the benefit is that it can be queried while it is running
//		- another benefit is that you can tell how long you want it to run
//		- imp.stop() and imp.resume() can stop accumulating samples and start it going again carrying on from where it left off
//		- kill method kills the threat

// anytime sampling example: omit the number of samples argument to Importance
// 		typical case is allowing it to run for one second
val imp = Importance(e2)
imp.start()
Thread.sleep(1000)
imp.stop()
println(imp.probability(e2, (b: Boolean) => b ))
imp.kill()

// Importance sampling provides a one-line query shortcut
// there is parallel version of Importance sampling that uses Scala's built in parallel collections. The difference in Interface:
//	1. this version sampling uses a model generator, which is a functiont hat produces a universe 
//			- Importance sampling is run in parallel on separate but identical universe
//	2. the user must indicate the number of threads to use
//	3. instead of taking a set of elements to query, the algorithm takes in a set of references, 
//			- where each reference refers to the same element on each of the parallel universes

// Metrapolis-Hasting Markov Chain Monte Carlo
//----------------------
// uses a proposal distribution to propose a new state at each step of the algorithm
// either accepts or rejects the proposal
// proposal involves proposing new randomness for any number of elements
// after proposing new randomnesses, any element that depends on those randomness must have its value updated
// the value of an element is a deterministic function of its randomness and the value of its arguments
// this update process is a deterministic result of the randomness proposal
// Proposing the randomness of an element involves calling the next Randomness method of the element (takes the current value of the randomness as the argument)
nextRandomness // implemented for all the built-in model classes (so need to be defined for your own class)

// Computing the acceptance probability requires computing the ratio of the element's constrant of the new value deivided by the constraint of the old value
//		- achieved by applying the constraint to the new and old value separately and take the ratio
//		- sometimes we want to apply the constraint on a large data structure, and applying it either on new and old causes overflow or underflow (not well defined)
//		-  the ratio might be well defined even though the constraints are large, since only a small part of the dat

// 1. variables in Figaro
val rembrandt: Element[Boolean] = // definition goes here
val size: Element[Symbol] = // definition goes here
val height: Element[Double] = // definition goes here
val lastYearSold: Element[Int] = // definition goes here
val allYearsSold: Element[List[Integer]] = // definition goes here


// 2. defining dependancies between variables in Figaro
//conditional probabilities in figaro
val size = CPD(subject,
  'people -> Select(p1 -> 'small, p2 -> 'medium, p3 -> 'large),
  'landscape -> Select(p4 -> 'small, p5 -> 'medium, p6 -> 'large)
)

// complete table is required
val price = CPD(rembrandt, subject,
  (false, 'people) -> Flip(p1),
  (false, 'landscape) -> Flip(p2),
  (true, 'people) -> Flip(p3),
  (true, 'landscape) -> Flip(p4)
)

// Rich CPD for the possible cases: all possible values
// you can use a “default” clause at the end that uses * for each parent
val x1 = Select(0.1 -> 1, 0.2 -> 2, 0.3 -> 3, 0.4 -> 4)
val x2 = Flip(0.6)
val y = RichCPD(x1, x2,
￼￼￼(OneOf(1, 2), *) -> Flip(0.1),
	(NoneOf(4), OneOf(false)) -> Flip(0.7),
	(*, *) -> Flip(0.9))

// other ways to identify dependancies
Apply
Chain
If // defined using Chain
Normal // defined using Chain

// 3. Defining Numerical Parameters
// Learn parameters from data
// Prior with minimal assumptions
// Use expert knowledge to affect learning

// 4. Generative models
// Probabilistic programming relies on an analogy between probabilistic models and programs in a programming language

// Beta binomial model in Figaro
val bias = Beta(?,?)
val numberOfHeads = Binomial(100, bias)
val toss101 = Flip(bias)

//Building a probabilistic model requires specifying variables and their types, dependencies between the variables in the form of a network, 
// 	and a functional form and numerical parameters for each variable.

// Chain: underlies directed dependencies 
// Conditions and Constraints: basis for undirected dependencies

// Printer down and power botton modeling
val printerPowerButtonOn = Flip(0.95)
val printerState =
  Chain(printerPowerButtonOn,
        (on: Boolean) =>
          if (on) Select(0.2 -> 'down, 0.8 -> 'up)
          else Constant('down)
val printerState =
  If(printerPowerButtonOn,
     Select(0.2 -> 'down, 0.8 -> 'up),
     Constant('down))
val printerState =
  CPD(printerPowerButtonOn,
      false -> Constant('down),
      true -> Select(0.2 -> 'down, 0.8 -> 'up))
val printerState =
  RichCPD(printerPowerButtonOn,
￼￼￼OneOf(false) -> Constant('down),
	* -> Select(0.2 -> 'down, 0.8 -> 'up))

// another example of asymmetric relationship between bias of coin and results
val toss = Chain(bias, (d: Double) => Flip(d))
val toss = Flip(bias)

// Expressing undirected dependencies in Figaro
// You can express asymmetric relationships in Figaro in two ways: using 
// (1) constraints and using 
// (2) conditions. E
// advantage and a disadvantage: 
//	The advantage of the constraints method is that it’s conceptually simpler.  (simple but not accessible for learning algorithm)
//		But the numbers that go in the constraints are hardcoded and can’t be learned in Figaro because they aren’t accessible to a learning algorithm. 
//	The advantage of the method that uses conditions is that the numbers can be learned. (learn numbers)

// Logic behind constraint modeling undirected dependencies
// (preference of values or weights) When an undirected dependency exists between two variables, some joint values of the two variables are preferred to others. 
// This can be achieved by assigning weights to the different joint values. 
// A constraint encodes the weights by specifying a function from a joint value of the two variables to a real number representing the weight of that value.
// => constraint encods the weight by specifying a function from joint value to real number representing weight [Joint value => weight]
// the interpretation is that all else equal there is higher probability of same color of two adjacent pixels


// Example of image segmentation
import com.cra.figaro.library.compound.^^
val pair = ^^(color1, color2)
def sameColorConstraint(pair: (Boolean, Boolean)) =
  if (pair._1 == pair._2) 0.3; else 0.1
pair.setConstraint(sameColorConstraint _)
// underline means you want the function itself and not to apply it

// conditioned approach to explain the undirected graph
// define an auxiliary bollean element 
// define it in the way that the probability that it comes true is equal to the probability of the constraint: 
//		so defining random variable as outcome rather than explicit number
val sameColorConstraintValue =
  Chain(color1, color2,
        (b1: Boolean, b2: Boolean) =>
          if (b1 == b2) Flip(0.3); else Flip(0.1))
sameColorConstraintValue.observe(true)

// so condition actually puts the likelihood in, and says I have observed this likelihood 
//		by specifying the generative process that incorporates data
//		the parameters can be defined at top level and it can be incorporated into this observation => observation specification not by matrix, but the process

// Markove Networks:
// A set of potentials—These potentials provide the numerical parameters of the model. I’ll explain what potentials are in detail in a moment.

// Intuitively, these edges encode the fact that, all else being equal, two adjacent pixels are more likely to have the same value than different values.
// 	- I call this locality principle

// The specific knowledge expressed by the edge between pixel 11 and pixel 12 is represented by the potential on that edge.

// Joint states with high weights are more likely than joint states with low weights, all else being equal. 

// The rel- ative probability of the two joint states is equal to the ratio between their weights, again, all else being equal.

// Mathematically, a potential is simply a function from the values of variables to real numbers. 
// How do potential functions interact with the graph structure? There are two rules:
	- A potential function can mention only variables that are connected in the graph.
	- If two variables are connected in the graph, they must be mentioned together by some potential function.
- In our image-recovery example, every variable will have a copy of the unary potential in table 5.2, and every pair of adjacent pixels, either horizontally or vertically, will have a copy of the binary potential in table 5.2. You can see that the two rules are respected by this assignment of potentials.

// you multiply the potential values of all of the potentials to get the “probabil- ity” of a possible world

// To get the probability of any possible world, you normalize the “probabilities” computed by multiplying the potential values. You call these the unnor- malized probabilities. The sum of these unnormalized probabilities is called the normaliz- ing factor and is usually denoted by the letter Z. So you take the unnormalized probabilities and divide them by Z to get the probabilities. 

// All else being equal relationship is the key.
// Learn parameters from data.

// Difference between Bayesian network and Markov network:
// In a Bayesian network, you could compute the probability of a possible world by multiplying the relevant CPD entries. 
// In a Markov network, you can’t determine the probability of any possible world without considering all possible worlds.
	- You need to compute the unnormalized probability of every possible world to calculate the normalizing factor.

- A Markov network has no notion of induced dependencies. You can reason from one variable to another variable along any path, as long as that path isn’t blocked by a variable that has been observed. 

- Two variables are dependent if there’s a path between them, and they become conditionally independent given a set of variables if those variables block all paths between the two variables.

// there is no notion of past and future, cause and effect in Markov Network:
// - because all edges in a Markov network are undirected, there’s no notion of cause and effect or past and future.
// - You don’t usually think of tasks such as predicting future outcomes or inferring past causes of current observations.
// - you simply infer the values of some variables, given other variables.

//---------------------------------------------------------------------------------------------------------
// Scala symbol definition
//---------------------------------------------------------------------------------------------------------
// ->    // Automatically imported method
// ||=   // Syntactic sugar
// ++=   // Syntactic sugar/composition or common method
// <=    // Common method
// _._   // Typo, though it's probably based on Keyword/composition
// ::    // Common method
// :+=   // Common method
// // Keywords
// <-  // Used on for-comprehensions, to separate pattern from generator
// =>  // Used for function types, function literals and import renaming

// // Reserved
// ( )        // Delimit expressions and parameters
// [ ]        // Delimit type parameters
// { }        // Delimit blocks
// .          // Method call and path separator
// // /* */   // Comments
// //          // Used in type notations
// :          // Type ascription or context bounds
// <: >: <%   // Upper, lower and view bounds
// <? <!      // Start token for various XML elements
// " """      // Strings
// '          // Indicate symbols and characters
// @          // Annotations and variable binding on pattern matching
// `          // Denote constant or enable arbitrary identifiers
// ,          // Parameter separator
// ;          // Statement separator
// _*         // vararg expansion
// _          // Many different meanings
// import scala._    // Wild card -- all of Scala is imported
// import scala.{ Predef => _, _ } // Exception, everything except Predef
// def f[M[_]]       // Higher kinded type parameter
// def f(m: M[_])    // Existential type
// _ + _             // Anonymous function placeholder parameter
// m _               // Eta expansion of method into method value
// m(_)              // Partial function application
// _ => 5            // Discarded parameter
// case _ =>         // Wild card pattern -- matches anything
// f(xs: _*)         // Sequence xs is passed as multiple parameters to f(ys: T*)
// case Seq(xs @ _*) // Identifier xs is bound to the whole matched sequence

//----------------------------
//	Inference
//	two main families of inference algorithms: 
//		1. factored algorithms and 
//		2. sampling algorithms. 
//----------------------------
// 1. The chain rule lets you turn a set of conditional probability distributions into a joint probability distribution. 
	- lets you go from simple (local con- ditional probability distributions over individual variables) to complex (a full joint probability distribution over all variables).
// 2. The total probability rule lets you take a joint probability distribution over a set of variables and produce a distribution over a single variable. 
	- goes from complex (a full joint distribution) back to simple (a distribution over a single variable).
// 3. Bayes’ rule lets you “invert” a conditional probability distribution over an effect, given a cause, into a conditional probability distribution over the cause, given the effect.
//	- Bayes’ rule lets you “flip” the direction of the dependencies, turning a conditional distribution over an effect, given a cause, into a distribution over a cause, given an effect. Bayes’ rule is essential to incorporating evidence, which is often an observation of an effect, and inferring a cause.

// COMPARING THE METHODS
Having seen these three methods, let’s compare them:
//	1. The MLE method provides the best fit to the data, but is also liable to overfit the data. Overfitting is a problem in machine learning whereby the learner fits the pattern found in the data too closely, in a way that’s unable to be general- ized. This can especially be a problem with only a few coin tosses. For example, if there are only 10 coin tosses and 7 of them come out heads, should you immediately conclude that the bias is 0.7? Even a fair coin will come out heads 7 times out of 10 a fair percentage of times, so the coin tosses don’t provide con- clusive evidence that the coin isn’t fair.
The MLE method has two advantages that make it popular. First, it tends to be relatively efficient, because it doesn’t require integrating over all parameter values to predict the next instance. Second, it doesn’t require specifying a prior, which can be difficult when you don’t have any basis for one. Nevertheless, the susceptibility to overfitting can be a significant problem with this method.

//	2. The MAP method can be a good compromise. Including a prior can serve two pur- poses. One is to encode prior beliefs that you have. The other is to counteract overfitting. For example, if you start with a beta(11, 11) prior, you aren’t biasing the results toward heads or tails in any way, but the effect of the data will be dampened by adding 10 imaginary heads and tails to the result. To see this, sup- pose you toss the coin 10 times and 7 of them come up heads. Remember that a beta(11, 11) prior means that you’ve seen 10 imaginary heads and 10 imaginary tails. Adding 7 more heads and 3 more tails gives you 17 heads and 13 tails in total. So the MAP estimate for the bias is 17 / (17 + 13) = 17/30 􏰏 0.5667. You can also see this from the formula for the mode of a beta distribution given ear- lier, which is..

//	3. The full Bayesian approach, where feasible, can be superior to the other approaches, because it uses the full distribution. In particular, when the mode of the distribution isn’t representative of the full distribution, the other approaches can be misleading. For a beta distribution, this isn’t a serious issue; the MAP and full Bayesian predictions are close to each other in our example. Specifically, with a beta(11, 11) prior and seven observed heads and three observed tails, you get a beta(18, 14) posterior. The Bayesian estimate of the probability that the next toss will be 18 / (18 + 14) = 18/32 = 0.5625, or just slightly less than the MAP estimate. For other distributions, especially those with multiple peaks, however, the full Bayesian approach can produce significantly better estimates than the MAP approach. Even the MAP approach, which uses a prior, will settle on one of the peaks, and completely ignore an important part of the distribution. But the Bayesian approach is more difficult to execute com- putationally.

// So now you know the basic rules of inference, and you understand how Bayesian modeling uses Bayes’ rule to learn from data and use the learned knowledge for future predictions. In the forthcoming chapters, you’ll learn specific algorithms for inference. Two main families of inference algorithms are used in probabilistic pro- gramming: factored algorithms and sampling algorithms. These two families are the subjects of the next two chapters.



// Summary
//	1. The chain rule lets you take the conditional probability distributions of individ- ual variables and construct a joint probabilistic model over all variables.
//	2. The total probability rule lets you take a joint probabilistic model over a set of variables and reduce it to get a probability distribution over individual variables.
//	3. The network arrows in a probabilistic model typically follow the process by which the data is generated, but inference in the model can go in any direction.
Bayes’ rule lets you do this.
//	4. Bayesian modeling uses Bayes’ rule to infer causes from observations of their
effects, and uses those inferences to predict future outcomes.
//	5. In Bayesian inference, the posterior probability of a value of a variable is pro- portional to the prior probability of the value times the likelihood of the value,
which is the probability of the evidence given the value.
//	6. In the MAP estimation approach, the most likely posterior value of a parameter
is used to predict future instances.
//	7. In the MLE approach, the prior is ignored, and the parameter value that maxi-
mizes the likelihood is used for prediction. This is the simplest approach but
can overfit the data.
//	8. In the full Bayesian approach, the full posterior probability distribution over
the parameter value is used to predict future instances. This is the most accu- rate approach but can be computationally difficult.


//----------------------------
//	Modeling dynamic systems:
// 	how to model and reason about an important special case—a dynamic model of a situation that changes over time.
//	Using different kinds of dynamic models including:
//		 Markov chains, 
//		 hidden Markov models, and 
//		 dynamic Bayesian networks
//	Using probabilistic models to create new kinds of dynamic models, 
//		such as models with time-varying structure
//	Monitoring a dynamic system in an ongoing manner
//----------------------------
//	a dynamic system whose state varies over time.
//	starting from fixed length time, but then enabling modeling systems that go on indefinitely. 
//	This requires a new Figaro concept, the universe


// Three kinds of queries could be answered with a probabilistic reasoning system:
// 1. Outcome: Predicting the outcome of a corner kick, given factors such as the wind, height of the center forward, and so on
// 2. Inferring parameter: Inferring properties that may have led to the observed outcome, such as the skill level of the goalie
// 3. Predicting generalized case: Using the outcome of one corner kick to infer properties that can influence the outcome of a second corner kick, and then predicting the second corner kick accordingly

// you’ll move from modeling individual corner kicks as isolated events 
//	to modeling an entire soccer match as a sequence of connected events. 
// A soccer match is an example of a dynamic system. This means two things:
//	1. A soccer match has a state at every point in time. 
//		This state can include things such as the score, who has possession, and 
//		how confident each team is feeling.
//	2. The state at any point in time is dependent on earlier states. 
//		For example, in a soccer match, the score at any point in time is dependent on the previous score and 
//		whether a goal was just scored; 
//		the possession is dependent on the previous possession, because a team in possession has a chance to maintain possession; and 
//		the confidence of a team also depends on their previous confidence, 
//		because confidence doesn’t usually fluctuate wildly and suddenly.

// a dynamic system is:
//	1. a system that has a state at every point in time, and 
//	2. those states at different time points are dependent.
//	e.g. Whether, business performance, traffic on a highway are dynamic systems

// In a dynamic probabilistic model, the state is represented by random variables. 

// For the performance of a business you might have variables representing
// 		levels of revenues and profits at any given time point (state variables)

//	The probabilistic model defines probabilistic dependencies between the values of state variables at different time points

// Use cases of the probabilistic graphical model:
// 1. Predicting the state of the system at a future time point, taking into account the current state and the dependencies between states over time. 
//		For example, you might predict the final score of the soccer match 
//		by considering the current score and confi- dence of the teams.
// 2. Inferring the past causes of the current state. 
//		For example, if your team lost the soccer match, 
//		you can try to determine which decisions during the game led to the bad result.
// 3. Monitoring the state of the system over time, based on observations that you get over time. 
//		For example, you might continually estimate the confidence and quality of the two teams based on what you observe to be happening on the field over time. 
//		You can then use these estimates to predict what will happen in the rest of the game.

//----------------------------
// Markov Chains
// state that varies over time, such that 
// the states at different times are dependent.
// Characterised by two things:
//	1. the state consists of a single variable. 
//	2. the state variable at each point in time depends probabilistically on the variable at the previous point in time, but not on any prior state variables.

// Example Markov chain model of Possessions in a soccer match:
//	The state at a time point consists of a single variable, which depends on the variable at the previous time. 
// Possession(1) depends directly on Possession(0), 
// Possession(2) depends directly on Possession(1), and so on through to 
// Possession(n) depending directly on Possession(n – 1).

// Possession(2) is conditionally independent of Posses- sion(0), given Possession(1)

// Markov Assumption:
// the possession at any point in time is conditionally independent of the possession at all earlier times, given the possession at the immediately previous time. 

// MARKOV ASSUMPTION 
// A dynamic probabilistic model satisfies the Markov assumption if the state at any time point depends only on the directly previous state; 
// the state at any time point is conditionally independent of all earlier states given the directly previous state.


// SPECIFYING A MARKOV CHAIN:
//	1. Decide on the set of values for the state variable. 
//		These consist of all of the val- ues of the variable that you consider to be relevant at any point in time. 
//	not include more values than is neces- sary.
//		 the size of the Markov chain representation is quadratic in the number of values of the state variable, so you want to avoid it getting too large.
//		e.g only restrict the score differential state to the range –5 to +5 in soccer that  
//			as the difference in leading by 15 and 5 is inconsequential, as overcoming 5 is rare
//	2. Specify one of the following:
//		2.1. initial value for the Markov chain. This means the value of the first state variable. 
//			e.g. score differential at the start of a soccer match is 0.
//		2.2. distribution over the initial value.  This is needed if you don’t know the exact value. 
//			e.g. the possession at the start of the game depends on the coin toss, 
//				so the probability of each team having possession is 0.5.
//	3. Specify the transition model. 
//		The transition model defines how the state at one time point depends on the state at the previous time point.
//		transition model specifies P(Possession(t) | Possession(t – 1)) for any t 􏰉 1.
//		transtion probabilities can be defined the same across time


// dynamic models can become expensive to work with:
//	 The complexity of representing and reasoning about dynamic models depends 
//			crucially on the number of states. 
//	In a Markov chain, the number of parameters in the transition model is quadratic in the number of values of the state variable.

//----------------------------
// Markov chain specification
//  if you know the total number of time steps
//----------------------------
// Length of the chain
val length = 90

// Array of state variables, one for each time step
// This initial value is unimport- ant because you’ll overwrite it explicitly in a moment.
val ourPossession: Array[Element[Boolean]] =
  Array.fill(length)(Constant(false))

// Sets the distribution for the initial state of the sequence
ourPossession(0) = Flip(0.5)

// Transition model defining a distribution for each state variable based on the one before in the sequence
// Next comes a loop that goes through all of the time points 1 through 89. 
// At each time point, it defines whether you have possession at that time point based on whether you had possession at the previous time point. 
// Specifically, if you did have possession, you continue to have it with probability 0.6, but if you didn’t have possession, you take it with probability 0.3.
for { minute <- 1 until length } {
  ourPossession(minute) =
    If(ourPossession(minute - 1), Flip(0.6), Flip(0.3))
}

// You can query this Markov model for the probability distribution over the state variable at any time point, given observations at any time points.
VariableElimination.probability(ourPossession(5), true)
ourPossession(4).observe(true)

// you can reason not only forward through the Markov chain to predict the future, 
//		but also backward to infer previous states from future observations. 

//----------------------------
// Hidden Markov models
// A hidden Markov model (HMM) is an extension of a Markov chain in which two variables exist at each time point, one representing a “hidden” state and the other representing an observation.
// e.g.:
//		The hidden state represents whether your team is confident at each time point
//		You can never truly know whether your team is confident
//		You have to infer it based on what’s happening on the pitch.
//		A hidden Markov model. Confident is a hidden state variable, and Possession represents an observation. 
//		The hidden state variables make a Markov chain, and the observation depends only on the hidden state at that time point.
//		HMM satisfies two conditions:
//		1. The hidden states form a Markov chain that satisfies the Markov assumption.
//		2. The observation at a point in time depends only on the hidden state at that point in time. 
//			The observation is independent of all previous hidden states 
//				and observations, given the hidden state at that time point.
//		the hidden state at a particular time point is independent of all previous observations given the previous hidden state.
// The current hidden state isn’t independent of previous observations 
//		if you don’t know the previous hidden state.
//		e.g. Possession(0) isn’t independent of Confident(2) 
//			if you don’t observe Confident(0) or Confident(1).
//----------------------------
// Steps in specifying HMM in Figaro:
//	1. Define the set of values of the hidden state variable.e.g. Confident might be a Boolean var.
//	2. Define the set of values of the observation variable. 
//		e.g.  Boolean variable representing whether our team has possession at a particular time point. 
//		Because the observation variable depends on the hidden state but not on previous observations,
//		 the size of the representation will be proportional to the number of values of the hidden 
//			state times the number of values of the observation.
//	3. Define a probability distribution over the initial hidden state. 
//		This is known as the initial model. In our example, this specifies P(Confident(0)).
//	4. Define the transition model for the hidden state variables, 
//		representing the conditional distribution over the state variable at one time point given the previous time point. 
//		In our example, this specifies P(Confident(t) | Confident(t – 1)).
//	5. Define the observation model that specifies the conditional probability distribution 
//		over the observation variable at any time point, given the hidden state variable at that time point. 
//		e.g. , this specifies P(Possession(t) | Confident(t )).

val length = 90

// Array of hidden state variables, one for each time step
val confident: Array[Element[Boolean]] =
  Array.fill(length)(Constant(false))

// Array of observation variables, one for each hidden state variable
val ourPossession: Array[Element[Boolean]] =
  Array.fill(length)(Constant(false))

// Sets the distribution for the initial hidden state of the sequence
confident(0) = Flip(0.4)

// Transition model defining a distribution for each hidden state variable based on the one before in the sequence
for { minute <- 1 until length } {
  confident(minute) = If(confident(minute - 1), Flip(0.6), Flip(0.3))
￼￼} //

// Observation model defining a distribution for each observation variable given its corresponding hidden state variable
for { minute <- 0 until length } {
  ourPossession(minute) = If(confident(minute), Flip(0.7), Flip(0.3))
} //

// all observations need to be taken into account to infer the hidden state, 
//		not just the current and most immediate neighboring observations. 
println("Probability we are confident at time step 2")
println("Prior probability: " +
  VariableElimination.probability(confident(2), true))
ourPossession(2).observe(true)
println("After observing current possession at time step 2: " +
     VariableElimination.probability(confident(2), true))
ourPossession(1).observe(true)
println("After observing previous possession at time step 1: " +
  VariableElimination.probability(confident(2), true))
ourPossession(0).observe(true)
println("After observing previous possession at time step 0: " +
  VariableElimination.probability(confident(2), true))
ourPossession(3).observe(true)
println("After observing future possession at time step 3: " +
  VariableElimination.probability(confident(2), true))
ourPossession(4).observe(true)
println("After observing future possession at time step 4: " +
  VariableElimination.probability(confident(2), true))
// You see that every observation adds to your belief that you are confident at time step 2.

//----------------------------
// Dynamic Bayesian Networks (DBN)
//	In general, there might be many variables you’re interested in, and 
//		they might be dependent on each other in a variety of ways. 
//	Dynamic Bayesian networks (DBNs) are a generalization of HMMs that serve this need. 
//	They operate on the same principle as HMMs of modeling a sequence of variables over time, 
//	but there can be many variables and they can be dependent on each other in interesting ways.
//
//	A dynamic Bayesian network. Several variables exist at each point in time. 
//	A variable at a time point can depend on other variables at that time point or 
//		on variables at the previous time point.
//----------------------------
// A DBN has the following content:
// 1 A set of state variables at each time point.
//	e.g.:
//		 Winning, representing which team is currently winning the match
//		 Confident, representing whether your team is confident
//		 Possession, representing whether your team has possession
//		 Goal, representing whether a goal is scored at that time point
//		 coreDiff, representing the score differential between the two teams

// 2 For each variable, a set of possible values. 
//		e.g.:
//		 Winning could be “us”, “them”, or “none”
//		 Confident is Boolean
//		 Possession is Boolean
//		 Goal is Boolean
//		 ScoreDiff is an integer from –5 to 5

//	3. A transition model, consisting of the following:

// *	For each variable, a set of parents. 
//	These parents could be other variables at the same time step or variables at the previous time step. 
//	The only restrictions on the parents:
//		 (1) edges can’t cross more than one time step, and 
//		 (2) the edges can’t make directed cycles, just as in a Bayesian network. 
//	e.g. the following dependencies:
//		– Whether you’re Winning at one time point depends on the ScoreDiff at the previous time point.
//		– Whether you’re Confident at one time point depends on who is currently Winning and 
//			whether you were previously Confident.
//		– Whether you have Possession depends on whether you’re currently Confident.
//		– Whether a Goal is scored (by either team) depends on whether 
//			you have Possession and on your Confidence.
//		– The new ScoreDiff is determined by the previous ScoreDiff, whether a Goal was scored, and 
//			who scored the goal if it was scored, determined by whether you had Possession.

// * For each variable, a conditional probability distribution (CPD) that specifies, for each variable, 
//		the probability distribution over the variable for each value of the parents. 
//	e.g., the CPDs are as follows:
// 		– Winning is determined by the previous ScoreDiff in the obvious way.
//		– The CPD of Confident specifies that you’re more likely to be Confident 
//			if you’re Winning and if you were previously Confident.
//		– The CPD of Possession specifies that you’re more likely to have Possession if you’re Confident.
//		– The CPD of Goal makes a Goal more likely 
//			if the team that has possession also has favorable confidence. 
//			That means that if you have Possession and are Confident, or 
//			you don’t have Possession and aren’t Confident, a Goal is more likely to be scored.
//		– The new ScoreDiff is a deterministic function of the previous ScoreDiff, 
//			whether a Goal was scored, and whether you had Possession 
//			(which deter- mines whether you or they scored the goal).

// 4. An initial model that specifies a probability distribution over variables at the initial time point.
//		this is an ordinary Bayesian network over the initial variables. 
//		But you need the distribution only over variables that have an effect on the next time point to get the DBN going. 
//		In our DBN, these are the variables Confident(0) and ScoreDiff(0).

// The main content of the DBN specification is in the transition model. 
// rather than show the sequence of variables over time, 
//		it’s typical to show the relationship between a time step and the previous time step. 
// A two-time-step Bayesian network (2TBN) for our example. 
//		The 2TBN shows the variables at time step t and their dependence on time step t – 1.
// The only difference is that the variables at time step t – 1 have no parents and no CPDs; 
//		only the dependencies and distributions of the variables at time step t are defined.

// Create arrays of the five state variables at each point in time
val length = 91
val winning: Array[Element[String]] = Array.fill(length)(Constant(""))
val confident: Array[Element[Boolean]] =
￼  Array.fill(length)(Constant(false))
val ourPossession: Array[Element[Boolean]] =
  Array.fill(length)(Constant(false))
val goal: Array[Element[Boolean]] =
  Array.fill(length)(Constant(false))
val scoreDifferential: Array[Element[Int]] =
  Array.fill(length)(Constant(0))

// Create Figaro elements to represent the initial values of confident and scoreDifferential
confident(0) = Flip(0.4)
scoreDifferential(0) = Constant(0)

// The loop defines the transitions at every time point. 
//	The transition model specifies how the five state variables depend on the previous state of confident and score- Differential. 
// Each variable can also depend on earlier variables in the loop. For example, confident depends on winning at the same time point.  

for { minute <- 1 until length } {
  winning(minute) =
  Apply(scoreDifferential(minute - 1), (i: Int) =>
          if (i > 0) "us" else if (i < 0) "them" else "none")
confident(minute) =
  CPD(confident(minute - 1), winning(minute),
      (true, "us") -> Flip(0.9),
      (true, "none") -> Flip(0.7),
      (true, "them") -> Flip(0.5),
      (false, "us") -> Flip(0.5),
      (false, "none") -> Flip(0.3),
      (false, "them") -> Flip(0.1))
ourPossession(minute) = If(confident(minute), Flip(0.7), Flip(0.3))
goal(minute) =
  CPD(ourPossession(minute), confident(minute),
      (true, true) -> Flip(0.04),
      (true, false) -> Flip(0.01),
      (false, true) -> Flip(0.045),
      (false, false) -> Flip(0.02))
scoreDifferential(minute) =
  If(goal(minute),
     Apply(ourPossession(minute), scoreDifferential(minute - 1),
     (poss: Boolean, diff: Int) =>
        if (poss) (diff + 1).min(5) else (diff - 1).max(-5)),
scoreDifferential(minute - 1))
}

//----------------------------
// Models with variable structure over time
// e.g. a restaurant owner who wants to know how full her restaurant will be on a given night; 
//	this might help her decide various things like how much food to make, whether to encourage her patrons to linger or leave quickly, and so on. 
//	The restaurant is a dynamic system involving guests arriving, eating their dinners, and leaving. 
//	The state of the system might consist of the number of guests currently at the restaurant and 
//		the amount of time they’ve been there, as well as the number of people waiting to be seated. 
//	Because the number of guests changes over time, the structure of the state varies. 
//	Furthermore, you don’t know in advance what the structure will be at any point in time; 
//		at any given time point, you must consider many possible structures.
//	The easiest way to model this kind of system using probabilistic programming is to create a set of state variables whose types are data structures that can vary. 
//----------------------------
//	e.g.
//	1. Seated represents the guests who are currently seated at the restaurant and 
//			the amount of time they’ve been there. 
//		Its data type is a list of integers. 
//		The length of the list is the current number of guests seated, and 
//		each integer represents the amount of time a particular guest has been seated.
//	2. Waiting represents the number of guests currently waiting to be seated. It’s a simple integer.


// Assume that the restaurant has ten tables of equal size, and each group of guests occupies one table, so the capacity is 10. 
//	In addition, assume that you’ll be reasoning in time steps of 5 minutes each, for a period of 1 hour, so the number of steps is 12.
val numSteps = 12
val capacity = 10

val seated: Array[Element[List[Int]]] =
  Array.fill(numSteps)(Constant(List()))
val waiting: Array[Element[Int]] = Array.fill(numSteps)(Constant(0))

// This example assumes that the restaurant owner is starting at a particular point in the evening with a known state
// At the initial time point, the res- taurant is already full and three people are waiting.
seated(0) = Constant(List(0, 5, 15, 15, 25, 30, 40, 60, 65, 75))
   waiting(0) = Constant(3)

// Representing the Transition Model
//	Dynamic model with variable structure—code skeleton
// Define a transition function that takes the previous state variables, and returns a joint probability distribution over the new state variables
// The next state is an element over the pair of seated and waiting values.
// It defines a joint distribution over the seated and waiting variables at the new time step. 
// In the transition function, this element is constructed by using Figaro’s ^^ constructor, which creates elements over pairs (or larger tuples) from individual elements. 
// In this transition function, these are the elements allSeated and newWaiting. 
def transition(seated: List[Int], waiting: Int):
  (Element[(List[Int], Int)]) = {
  // details go here
  ^^(allSeated, newWaiting)
}

// Produce the joint distribution over the new state variables from the distributions over the previous state variables
for { step <- 1 until numSteps } {
  val newState =
    Chain(seated(step - 1), waiting(step - 1),
     (l: List[Int], i: Int) => transition(l, i))
     // Extract the new state variables, from this joint distribution
     seated(step) = newState._1
     waiting(step) = newState._2
}

// So to get the distribution over possession(t), you can write this:
Chain(possession(t – 1), transitionModel)

// Dynamic model with variable structure—detailed transition function
// Determine the new amount of time each guest is at the table.
// 	–1 indicates that they're leaving, which happens with probability time / 80
def transition(seated: List[Int], waiting: Int):
  (Element[(List[Int], Int)]) = {
  val newTimes: List[Element[Int]] =
    for { time <- seated }
    yield Apply(Flip(time / 80.0),
    (b: Boolean) => if (b) -1 else time + 5)

// newTimes is a list of Element[Int]. You need to turn it into an Element [List[Int]], which is achieved by Inject.
val newTimesListElem: Element[List[Int]] = Inject(newTimes:_*)

// Determine the number of people who are leaving by removing all those whose seated time is less than 0
val staying = Apply(newTimesListElem,
                      (l: List[Int]) => l.filter(_ >= 0))
// Determine the number of people who arrive at the restaurant and the resulting number that are waiting
val arriving = Poisson(2)
val totalWaiting = Apply(arriving, (i: Int) => i + waiting)

// Determine the number of waiting people that can be newly seated
val placesOccupied =
  Apply(staying, (l: List[Int]) => l.length.min(capacity))
val placesAvailable =
  Apply(placesOccupied, (i: Int) => capacity - i)
val numNewlySeated =
  Apply(totalWaiting, placesAvailable,
         (tw: Int, pa: Int) => tw.min(pa))


// Determine the new list of seated guests
val newlySeated =
  Apply(numNewlySeated, (i: Int) => List.fill(i)(0))
val allSeated =
  Apply(newlySeated, staying,
          (l1: List[Int], l2: List[Int]) => l1 ::: l2)

// Determine the new number of waiting guests
val newWaiting = Apply(totalWaiting, numNewlySeated,
                        (tw: Int, ns: Int) => tw - ns)


// Return an element over a pair of the new list of seated guests and number of waiting guests
^^(allSeated, newWaiting)
}

// Figaro’s Inject element can turn a list of elements into an element of lists. 
//  What does that mean? Suppose you have a list consisting of three Element[Int]s. 
//  One possible set of values is that the first is 5, the second is 10, and the third is 15. 
// You can make this into a list consisting of the values 5, 10, and 15. 
// In this case, the value of Inject(l) will be List(5, 10, 15).

// Why is this useful? Some operations in our model, namely, determining the new amount of time a guest is seated and whether the guest is leaving, are applied to individual elements. 
// Other operations, such as determining the list of guests who are stay- ing, are applied to the list of guests as a whole. 
// You need an element over lists, and Inject gives you that.

// In general, you probably won’t use a factored algorithm such as variable elimination or belief propagation for these variable structure models. 
// The number of possible values of the state variables is enormous. 
// In the restaurant example, each possible seated time is a number between 0 and 75 that’s divisible by 5. 
// (Once the seated time reaches 75, the guest will definitely leave at the next time step.) 
// This produces 16 pos- sible values. 
// The number of possible lists of 10 seated times is 1610. 
// You also need to consider cases where the number of guests is less than 10. 
// This results in far too many possibilities to enumerate.

// Therefore, a sampling algorithm will work better. 
//  This example uses importance sampling to predict the number of people waiting to get into the restaurant at the end of the next hour. 
val alg = Importance(10000, waiting(numSteps - 1))
alg.start()
println(alg.probability(waiting(numSteps - 1), (i: Int) => i > 4))

// example query to answer: more than four people will be waiting at the end of the hour.

// A limitation of all of the programs I’ve shown so far is that you have to define the number of time steps in advance. 

//----------------------------
// Modeling systems that go on indefinitely
//		dynamic probabilistic models that can go on for any length of time.
//		These models can be used to monitor the state of the system in an
//			ongoing fashion based on evidence that’s accumulated over time. 
//		you’ll need a new Figaro concept, the universe.
//		A universe is a special type of element collection 
//			that also provides services that are useful to inference algorithms, 
//			such as memory management and dependency analysis. 
//		Universe ane Element collection: 
//			1. Every universe is an element collection, but not every element collection is a universe.
//			2. Every element collection is associated with a universe. 
//				In the case of an element collection that is also a universe, 
//				the associated universe is itself.
//			3. When you place an element in an element collection, 
//				its universe is the uni- verse associated with the element collection.
//----------------------------
// Because a universe is an element collection, 
//	you can place an element directly in a universe 
//		by supplying the universe as the second optional argument, for example:
Flip(0.5)("coin", universe)

// default universe is held in the Scala variable Universe.universe in the com.cra.figaro.language package.

// Algorithms also operate on a universe. 
// 	A different universe can be specified by providing an optional additional argument in its own argument list. 
//	For example, VariableElimination (target) creates a variable elimination algorithm on the default universe with the given target. 
VariableElimination(target)(u2) 
// 	creates a variable elimination algorithm on universe u2 with the given target. 

// You can get a new universe in two ways. One is to call
new Universe
//	which creates a fresh universe with no elements in it. The other is to call
Universe.createNew()
// 	which, in addition to creating a fresh universe, also sets the default universe to this new universe.

Universe.createNew()
val x = Beta(1, 2)
val y = Flip(x)
println(VariableElimination.probability(y, true))

// The elements x and y will be placed in the new universe, 
//		and the variable elimination algorithm will be run on it.       

// Using universes to model ongoing systems
// To represent a dynamic probabilistic model with no time limit in Figaro, 
//	you create a universe for every time step that contains all of the variables at that time step. 
//	The model is normally specified in two pieces:
//		1. An initial universe
//		2. A function from one universe to the next universe

// These two pieces define a dynamic probabilistic model, shown in figure 8.6, as follows:
//	1 Begin with a probability distribution over the initial state at time 0 as specified by all elements in the initial universe.
//	2 Apply the function to the initial universe to get a time 1 universe. 
//		The elements in the new universe define a probability distribution over the time 1 state.
//	3 Apply the function to the time 1 universe to get a time 2 universe. 
//		The elements in the new universe define a probability distribution over the time 2 state.
//	4 Continue for as long as desired.

// Progression of a dynamic model through a series of universes. 
//	Each universe contains the state variables at a given time point. 
//	The first universe is defined by the initial model, and 
//		subsequent universes are created by applying the nextUniverse function to the previous universe.

//	Any element in a time step that directly influences an element at the next time step must be given a name. 
//	This name enables the program to refer to the element in the previous universe. 
//	In the restaurant example, the number of guests waiting for a seat at the end of a time step influences the state at the next time step. 
//	You need to give the element representing this number the name waiting.

//	Now, the transition function takes the previous universe as an argument. 
//	Let’s say this universe is contained in a Scala variable named previous. 
//	You can write to get the element named waiting in the previous universe. 
previous.get[Int]("waiting")
//	you had to tell Scala the value type of this element (Int), 
//		because otherwise the get method would have no idea what kind of element to return.

// Any element that you want to query or observe also needs to be given a name. 
//	That way, you can refer to the element consistently at every time step.

// The transition function is unchanged, except that you also include the number of people arriving in the returned element because you’ll observe it.
def transition(seated: List[Int], waiting: Int):
  (Element[(List[Int], Int, Int)]) = {
    // details are the same as before
    ^^(allSeated, newWaiting, arriving)
}

// Define a function from the previous universe to the next universe
def nextUniverse(previous: Universe): Universe = {
// Create the new universe, make it the default, and assign it to a Scala variable
	val next = Universe.createNew()
	// Get the previous state variables from the previous universe
	val previousSeated = previous.get[List[Int]]("seated")
	val previousWaiting = previous.get[Int]("waiting")
	//	Use Chain to get the element representing the new state
	val state = Chain(previousSeated, previousWaiting, transition _)
	// Get the elements representing the individual state variables out of this element and 
	//		give each a name in the next universe
	Apply(state, (s: (List[Int], Int, Int)) => s._1)("seated", next)
	Apply(state, (s: (List[Int], Int, Int)) => s._2)("waiting", next)
	Apply(state, (s: (List[Int], Int, Int)) => s._3)("arriving", next)
	// return the next universe
	next
}

// Running a monitoring application
// Your goal is to begin with an initial belief about the state of the system and 
//	repeatedly update your beliefs about the state, given evidence that you receive at every time step.
//	1 Begin with a distribution over the state of the system at time 0.
//	2 Incorporate observations received at time 1 to produce a distribution over the state of the system at time 1.
//	3 Incorporate observations received at time 2 to produce a distribution over the state of the system at time 2.
//	4 Repeat for as long as desired.

// Propagate dynamics and condition on Observations
//	The filtering process. 
//	Figaro maintains a probability distribution over the state of the system at each time point. 
//	From one time point to the next, Figaro takes into account the dynamics of the model and 
//		conditions on the new observations to produce a probability distribution over the new state.

// This process goes by various names, including monitoring, state estimation, and filtering. 
//	All are different names for the same thing. 
//	Algorithms for achieving this process are often called filtering algorithms, and 
//		this is the name used in Figaro. Probably the most popular filtering algorithm is called particle filtering. 
//	This is a sampling algorithm that represents the distribution over the state of the system at each time point by using a set of samples or “particles.” 

// To create a particle-filtering algorithm in Figaro, you pass it three arguments:
// 	1. The initial universe
//	2. The function that takes the previous universe to the next universe
//	3. The number of particles to use at every time step

val alg = ParticleFilter(initial, nextUniverse, 10000)
alg.start()
// For a particle filter, this produces the probability distribution over the initial state.

// Most of the work of the particle filter is accomplished by the advanceTime method, 
//	which advances the system from one time step to the next while taking into account the new evidence.
alg.advanceTime(evidence)

// The way the evidence is specified is different from what you’ve seen before. 
//	Through- out the book, you’ve seen evidence specified by adding conditions or constraints to elements. 
//	You can’t do that here, because you have no direct handle on the elements representing the state of the system at any time point; 
//	they’re internal to the next- Universe function. 
//	Instead, you refer to these elements by name. 
//	So you have to tell the particle filter the names of the elements you have evidence for as well as the nature of that evidence.
NamedEvidence("arriving", Observation(3))

// This is an instance of the NamedEvidence class, which pairs a name (arriving) with a piece of evidence 
// (in this case, the observation that the element named arriving has value 3). 
// The piece of evidence could also be a more general condition or constraint. 
// The argument to the particle filter’s advanceTime method is a list of these Named- Evidence items, 
//		which specify all evidence newly received at the time point.

// In our restaurant example, let’s assume that the restaurant owner intermittently observed the number of people arriving at the restaurant in a time step. 
//	So she may or may not get evidence at any particular time step. 
//	You can accomplish this in Scala by making her get an Option[Int], 
//		which could be None or could be a particular observed number of people.

// You then translate this optional observation into the argument to advanceTime. 
val evidence = {
  arrivingObservation(time) match {
    case None => List()
    case Some(n) => List(NamedEvidence("arriving", Observation(n)))
  }
}
alg.advanceTime(evidence)

// to get the probability that more than 4 people are waiting
alg.currentProbability("waiting", (i: Int) => i > 4)

// To get the expected (average) number of guests seated at the restaurant, you can call
alg.currentExpectation("seated", (l: List[Int]) => l.length)

// To summarize, here are the steps you take to run a particle filter, 
//	given the initial universe and the function that takes the previous universe and 
//	 returns the next universe:
// 1 Create the particle filter.
// 2 Start the particle filter to get the initial distribution.
// 3 Do the following for each time step:
// 	a Collect the evidence at that time step.
//	b Call advanceTime with that evidence to get the distribution over the new state.
//	c Query the new distribution.

// Summary
//	1. A dynamic system consists of state that varies over time; the states at different time points are dependent.
//	2. Many dynamic probabilistic models implement the Markov assumption that the current state is conditionally independent of all earlier states, given the directly previous state.
//	3. Even though a hidden Markov model implements the Markov assumption, all previous evidence must be considered when inferring the current state, because the previous state is unobserved.
//	4. A dynamic Bayesian network is like an extension of a hidden Markov model that has multiple state variables; by making the types of these variables rich data structures, you can model systems with structure that varies over time.
//	5. Monitoring or filtering is the process of keeping track of the state of the system over time, given observations that are received; this process is achieved by using algorithms such as particle filtering.
//	6. Filtering in Figaro is accomplished by creating an initial universe and a function that maps the previous universe to the next universe.
//	7. When filtering in Figaro, elements that influence the next time step, as well as evidence and query elements, are referred to by name.

//----------------------------
// Object orientation in Figaro
// Two types of uncertainty:
//		(1) Object type uncertainty
//		(2) Relational uncertainty
//	element collections and references
//	concepts from relational DBs
//----------------------------

// An example of cornor kick
// modeling a cor- ner kick in a game of soccer, taking into account information such as:
//		the skill of the attacking and defending teams, 
//		environmental conditions such as the wind, and so on. 
// Players are objects. 
// Players belong on teams, which are also objects. 
// Players do things like move or kick the ball. 
// Different kinds of players, like center forwards and goalies, can be modeled using subclasses of the Player class. 
// Players interact with other players, as well as the ball, which is also an object. 
// The environment, which can also be modeled as an object, also interacts with the ball and the players.

// Two main advantages of object oriented programming
// (1) coherent units that capture set of data and behavior
//		- unifrom interface of an object for dat and behavior
//		- encapsulation of internal objects
//		- allows modification of object internals in modular way, without affecting the rest of the program
// (2) Enabling reuse of code
//		- reuse internal structure for all instanses of the class
//		- inheritence: common aspect of different class

// Both probabilistic programming and object oriented explain real world in terms of objects

// Object oriented in the context of probabilistic models:
//  - A probabilistic class model defines a general process for generating the values of random variables. e.g.:
//		- general process for generating whether the power is on, 
//		- whether the paper is stuck, 
//		- the overall state of the printer, and so on.
//  - An instance is a specific instantiation of this general class model that describes a process to generate the values of random variables that pertain to this specific instance.
//		- a process to generate values for variables representing whether this particular printer’s power is on
//		- this printer’s paper is stuck, and 
//		- the overall state of this printer

// a generative process over the val- ues of the attributes of myPrinter.
 class Printer {
          val powerButtonOn = Flip(0.95)
          val paperFlow = Select(0.6 -> 'smooth, 0.2 -> 'uneven, 0.2 -> 'jammed)
          val state = // etc.
        }
val myPrinter = new Printer

// Classes:
// User
// Printer
// User Experience
// Software
// Network

// Steps in writing object oriented Figaro model
// 1 Define the class models.
// 2 Create instances of those classes.
// 3 Reason with the instances.

// the instances are used to infer whether the printer’s power button is on, given the summary of the print experience

// Class models
package chap07
import com.cra.figaro.language._
import com.cra.figaro.library.compound._
import com.cra.figaro.algorithm.factored.VariableElimination
object PrinterProblemOO {
  class Printer {
    val powerButtonOn = Flip(0.95)
    val tonerLevel = Select(0.7 -> 'high, 0.2 -> 'low, 0.1 -> 'out)

    val tonerLowIndicatorOn =
      If(powerButtonOn,
         CPD(tonerLevel,
             'high -> Flip(0.2),
             'low -> Flip(0.6),
             'out -> Flip(0.99)),
         Constant(false))
    val paperFlow = Select(0.6 -> 'smooth, 0.2 -> 'uneven, 0.2 -> 'jammed)

    val paperJamIndicatorOn =
      If(powerButtonOn,
         CPD(paperFlow,
             'smooth -> Flip(0.1),
             'uneven -> Flip(0.3),
             'jammed -> Flip(0.99)),
         Constant(false))

    val state =
      Apply(powerButtonOn, tonerLevel, paperFlow,
            (power: Boolean, toner: Symbol, paper: Symbol) => {
		  if (power) {
		    if (toner == 'high && paper == 'smooth) 'good
		    else if (toner == 'out || paper == 'out) 'out
		    else 'poor
			} else 'out })
	}

  class Software {
    val state = Select(0.8 -> 'correct, 0.15 -> 'glitchy, 0.05 -> 'crashed)
	}

  class Network {
    val state = Select(0.7 -> 'up, 0.2 -> 'intermittent, 0.1 -> 'down)
	}

  class User {
    val commandCorrect = Flip(0.65)
	}

// A print experience involves a particular printer, software, network, and user, 
//	so the PrintExperience class takes instances of those classes as arguments.

class PrintExperience(printer: Printer, software: Software, network:
	   Network, user: User) {


	  // The print experience depends on particular attributes of the printer, software, network, and user. 
	  // These are referred to by putting the name of the instance, then a ‘.’, then the name of the attribute. 
	  // For example, “printer.state” refers to the attribute named “state” of the instance named “printer.”
	  val numPrintedPages =
	    RichCPD(user.commandCorrect, network.state, software.state,
	   printer.state,
	        (*, *, *, OneOf('out)) -> Constant('zero),
	        (*, *, OneOf('crashed), *) -> Constant('zero),
	        (*, OneOf('down), *, *) -> Constant('zero),
	        (OneOf(false), *, *, *) -> Select(0.3 -> 'zero, 0.6 -> 'some, 0.1
		-> 'all),
		(OneOf(true), *, *, *) -> Select(0.01 -> 'zero, 0.01 -> 'some, 0.98
	   -> 'all))

	  val printsQuickly =
	    Chain(network.state, software.state,
	          (network: Symbol, software: Symbol) =>
	            if (network == 'down || software == 'crashed) Constant(false)
	            else if (network == 'intermittent || software == 'glitchy)
	  			Flip(0.5)
	            else Flip(0.9))

	  val goodPrintQuality =
	    CPD(printer.state,
	        'good -> Flip(0.95),
	        'poor -> Flip(0.3),
	        'out -> Constant(false))

	  val summary =
	    Apply(numPrintedPages, printsQuickly, goodPrintQuality,
	          (pages: Symbol, quickly: Boolean, quality: Boolean) =>
	          if (pages == 'zero) 'none
	          else if (pages == 'some || !quickly || !quality) 'poor
	          else 'excellent)
	￼￼}

// Create instanses of these classes and hook them up
// Create instances of the classes. 
// myExperience is related to myPrinter, mySoftware, myNetwork, and me by the PrintExperience constructor.

val myPrinter = new Printer
val mySoftware = new Software
val myNetwork = new Network
val me = new User
val myExperience = new PrintExperience(myPrinter, mySoftware, myNetwork, me)

// Queries and evidence involve particular attributes of the instances.
def step1() {
  val answerWithNoEvidence =
   VariableElimination.probability(myPrinter.powerButtonOn, true)
  println("Prior probability the printer power button is on = " +
   answerWithNoEvidence)
}

def step2() {
  myExperience.summary.observe('poor)
  val answerIfPrintResultPoor =
  VariableElimination.probability(myPrinter.powerButtonOn, true) println("Probability the printer power button is on given a poor result =
     " + answerIfPrintResultPoor)
  }

def main(args: Array[String]) {
    step1()
	step2() 
	}
}

// Reasoning about multiple printers
// Imagine you have two kinds of printers: laser printers and inkjet printers. 
// Both kinds of printers share a power button and a paper-feed mechanism, 
// 		but each has characteristics of its own
// This design has two benefits. 
//		First, it enables code reuse between LaserPrinter and InkjetPrinter. 
//		Second, it defines a common interface for printers that the rest of the model can depend on. 
//			If myPrinter is an instance of a subclass of Printer, it can be relied on to have a state attribute.

// This class is abstract because it contains a state attribute with no definition.
// Reused code that’s common to all printers
abstract class Printer {
  val powerButtonOn = Flip(0.95)
  val paperFlow =
    Select(0.6 -> 'smooth, 0.2 -> 'uneven, 0.2 -> 'jammed)
  val paperJamIndicatorOn =
    If(powerButtonOn,
       CPD(paperFlow,
           'smooth -> Flip(0.1),
           'uneven -> Flip(0.3),
           'jammed -> Flip(0.99)),
       Constant(false))

       // Common interface that declares an attribute all printers have. Concrete subclasses must implement this attribute.
       Constant(false))
       val state: Element[Symbol]
}

// Attributes specific to the LaserPrinter subclass
class LaserPrinter extends Printer {
  val tonerLevel = Select(0.7 -> 'high, 0.2 -> 'low, 0.1 -> 'out)
  val tonerLowIndicatorOn =
    If(powerButtonOn,
       CPD(tonerLevel,
           'high -> Flip(0.2),
           'low -> Flip(0.6),
           'out -> Flip(0.99)),
       Constant(false))
   // Separate implementations of the common interface
   val state =
		    Apply(powerButtonOn, tonerLevel, paperFlow,
		￼￼￼￼￼￼￼￼(power: Boolean, toner: Symbol, paper: Symbol) => {
		 	 if (power) { //
		  		  if (toner == 'high && paper == 'smooth) 'good
		  		  else if (toner == 'out || paper == 'out) 'out
			   	 else 'poor
				} else 'out 
			}
		)
	}

	// Attributes specific to the InkjetPrinter subclass
	class InkjetPrinter extends Printer {
		  val inkCartridgeEmpty = Flip(0.1)
		  val inkCartridgeEmptyIndicator =
		    If(inkCartridgeEmpty, Flip(0.99), Flip(0.3))
		  val cloggedNozzle = Flip(0.001)

		 val state =
		    Apply(powerButtonOn, inkCartridgeEmpty,
		          cloggedNozzle, paperFlow,
		          (power: Boolean, ink: Boolean,
		           nozzle: Boolean, paper: Symbol) => {
		            if (power && !ink && !nozzle) {
		              if (paper == 'smooth) 'good
		              else if (paper == 'uneven) 'poor
		              else 'out
		            } else 'out
				}
				
			) 
		}


	  // Multiple instances of printer that share the same software, network, ser
	  // Print experience expects superclass Printer
	  val myLaserPrinter = new LaserPrinter
	  val myInkjetPrinter = new InkjetPrinter
	  val mySoftware = new Software
	  val myNetwork = new Network
	  val me = new User
	  val myExperience1 =
	    new PrintExperience(myLaserPrinter, mySoftware, myNetwork, me)
	  val myExperience2 =
	    new PrintExperience(myInkjetPrinter, mySoftware, myNetwork, me)

	 // Now reason about the common elements across these two experiences:
	 //			oftware, network, and user. 
	 def step1() {
            myExperience1.summary.observe('none)
            val alg =
              VariableElimination(myLaserPrinter.powerButtonOn, myNetwork.state)
            alg.start()
            println("After observing that printing with the laser printer " +
              "produces no result:")
            println("Probability laser printer power button is on = " +
              alg.probability(myLaserPrinter.powerButtonOn, true))
            println("Probability network is down = " +
              alg.probability(myNetwork.state, 'down))
           alg.kill()
		}

	def step2() {
            myExperience2.summary.observe('none)
            val alg =
              VariableElimination(myLaserPrinter.powerButtonOn, myNetwork.state)
            alg.start()
            println("\nAfter observing that printing with the inkjet printer " +
              "also produces no result:")
            println("Probability laser printer power button is on = " +
              alg.probability(myLaserPrinter.powerButtonOn, true))
            println("Probability network is down = " +
              alg.probability(myNetwork.state, 'down))
           alg.kill()
	}

	// after observing that the inkjet printer also fails to print, it’s less likely that the problem the first time around was with the laser printer 
	//		(which would mean the inkjet printer was also faulty), and 
	//	more likely that it was something else, such as the network. 
	//		So the probability that the laser printer’s power button is on goes up, as does the probability that the network is down.


//----------------------------
// Relational probability models 
// model users on a social media site like Fac and want to infer their interests and relationships 
//		by observing their posts and comments. 
// classes for people, posts, and comments
// 	relationships also exist between people and their posts and comments
// 	relationship between a post and a comment to that post
//	A relational probability model is nothing more than an OO model in which 
//	relationships are made an explicit and central part of the representation.
// Languages: robabilistic Relational Models and Markov Logic.
// Programming style
// Class probability models purpose:
//	1. describe the structure of the model, including the classes in the model, their attributes, and relationships between classes
//	2. define the probabilistic dependencies, functional forms, and numerical param- eters that govern the probabilistic model
//----------------------------
// High level method and steps:
//		First, you decide on the variables describing the situation. 
//		Next, you specify the dependencies. 
//		Finally, you specify the functional forms and numerical parameters characteriz- ing each of these dependencies.


// model has four classes: Person, Connection, Post, and Comment

// Simple attributes, shown as ovals, represent random variables over values of some type.
// Person has an Interest, which is a random variable over strings. 
// A Post has a Topic, which is also a variable over strings. 
// A Connection has a Type, which could be family, close friend, or acquaintance. 
// A Comment has a Match attribute, which is a variable over a Boolean indicating whether a match exists between the interest of the commenter and the topic of the post.

// Arrows show targets of relationships; e.g., target of Post.Poster is Person.
// Complex attributes (rectangles) represent relationships to other objects. (i.e. reference)
// Post class has a Poster attribute that naturally represents the person who posted the post. (Relationship = reference)

// The guiding principle:
//		 an attribute of an instance can depend on other attributes of that instance or on attributes of related instances
// e.g.:
// Post 1.Topic can depend on Amy.Interest. 
//		- in relation between Post1 and Amy, that are related by Post 1.Poster)
//		-> instance level dependancies
//		draw an arrow from the Interest attribute of the Person class to the Topic attribute of the Post class

// Figure depiction principles:
// Dashed line shows asymmetric dependency; 
//		e.g., between Comment.Match and Connection (Comment.Post.Poster, Comment.Commenter).Type.
// Duplication:
//		Person class is duplicated because the Commenter can be different from the Poster, so the Interest attribute that influences the Topic is different from the Interest attribute that influences the Match.
// Thick arrows show probabilistic dependencies; e.g., Post.Topic depends on Post.Poster.Interest.

// After you’ve specified the dependencies, you can specify the functional forms and numerical parameters.
// the directed dependencies in a Bayesian network are specified using conditional probability distributions, 
// whereas the undirected dependencies in a Markov network are encoded using potentials. 
// potential is a function that’s defined over a set of variables and assigns a non-negative real number to each combination of values of the variables.

// Relationships
//		1. For Person.Interest, because it has no parents, you’ll have a probability distribution over the possible interests.
// 2. For Connection.Type, again it has no parents, so you’ll have a probability distribution over the possible connection types.
// 3. For Post.Topic, you have a CPD given Post.Poster.Interest that specifies that the topic of a post usually matches the interest of the poster.
// 4. For Comment.Match, you have a CPD given Comment.Post.Topic and Comment.Commenter.Interest. A deterministic CPD specifies that a match exists if the post’s topic and commenter’s interest coincide.
// You also have a potential over whether the comment matches and the connection type between the poster and commenter. 
//		The connection type can be identified as the Type attribute of the Connection, in which Person 1 is Comment.Post.Poster and Person 2 is Comment.Commenter. 
//		You call this attribute Connection(Comment.Post.Poster, Comment.Commenter).Type. 
//		For any instance c of Comment, you identify the two instances of Person who are the c.Post.Poster and c.Commenter. 
//		You then identify the Connection instance that connects these two people and get that Connection’s Type attribute. 
//		So the potential is defined over that attribute and c.Match. 
//		The potential says that the Comment is highly likely to match if the connection type is acquaintance, but less so if the connection type is close friend, and even less so for family.
//	5. On the reference variables that for example shows relation between person who comments and commenter, it is deterministic reference relationship

// Describing a situation:
//	- exactly what the instances are of each class in the situation (different from values)
//		e.g. for person Amy, Brian, Cheryl
//	- how they’re connected.
//		e.g. Comment1, Post 1, and and Brian as commenter, and Post1 is Posted by Amy
//	You don’t need to specify Connection instances, as these are derived automatically. 
//		e.g. c of Comment, you automatically derive Connection(c.Post.Poster, c.Commenter). 
//		For Comment 1, Post.Poster is Amy and Commenter is Brian, so you derive Connection(Amy, Brian). 
//		Similarly, for Comments 2 and 3, you derive Connection(Amy, Cheryl) and Connection(Brian, Amy).
// - How inference works:
//		- For Comment 4, you also derive Connection(Amy, Cheryl). 
//		- This is the same Connection instance as the one derived for Comment 2. 
//		- This is an important point. You want to infer things from both of Cheryl’s comments to Amy’s points. 
//		- If you used dif- ferent Connection instances for each comment, you wouldn’t be able to infer from the combination of the comments to the connection type. 
//		- By using the same Connec- tion instance, you make sure that all comments by Cheryl on Amy’s posts are used to infer the type of the connection. 
//		- On the other hand, in our model, Connection(Amy, Brian) is different from Connection(Brian, Amy). This is a design choice; you’ve chosen to regard connections as asymmetric. 
//				- You could easily model connec- tions as symmetric, in which case you’d have a single Connection instance for both Comment 1 and Comment 3.


// For the variables, after these instances and relationships have been specified, 
//	they automatically define a set of simple attributes for all instances in the situation, 
//		each of which becomes a variable in the model
//	Amy.Interest, Brian.Interest, Cheryl.Interest
//  Post 1.Topic, Post 2.Topic, Post 3.Topic
//  Comment 1.Match, Comment 2.Match, Comment 3.Match, Comment 4.Match
//	Connection(Amy, Brian).Type, Connection(Amy, Cheryl).Type, Connection
(Brian, Amy).Type

// benefits of object orientation
// By describing the application domain using objects and relationships, you pro- vide structure to potentially complex situations (thousands of comments and posts of thousands of users)
// Class models can be applied to many instances with different relationships. This is a powerful reuse mechanism, because you can use the same class-level defini- tion of the probabilistic model for many situations.

class Person() {
          val interest = Uniform("sports", "politics")
}

// reference is recieved int he constructor (with the keyword this?)
class Post(val poster: Person) {
  val topic = If(Flip(0.9), poster.interest, Uniform("sports", "politics"))
}

//Breaking the chain of dependancy by assigning null first
// If the poster also depended on the post, you couldn’t make poster an argument of Post, 
// 		because the poster can’t be generated before the post. 
// You have two solutions to this:
//		One is to use Scala’s lazy evaluation, so that the post could depend on the poster, 
//		but attributes of the poster won’t be evaluated until they’re needed. 
//		The other is to give Post an internal attribute called poster, which is initially null, and 
//		have the value of this attribute set later, before calling Figaro’s inference algorithms. 
//		As long as all references to poster happen inside Chain elements 
//		(in our example, inside the If, which is syntactic sugar for Chain), 
//		the poster elements won’t be needed until inference, 
//		by which time the value of the poster attribute will have been set correctly.

// You need to make sure that when you call connection(person1, person2) multiple times, 
//		you get the same connection every time. 
//	Figaro provides an easy way to do this using its memo function, 
//		which is found in the com.cra.figaro .util package, 
//		which ensures that a function returns the same value every time when called on the same arguments. 

import com.cra.figaro.util.memo
class Connection(person1: Person, person2: Person) {
  val connectionType = Uniform("acquaintance", "close friend", "family")
}
def generateConnection(pair: (Person, Person)) =
  new Connection(pair._1, pair._2)
val connection = memo(generateConnection _)

// === (three equals signs) is Figaro equality. 
//		It’s a Boolean element whose value is true if the values of its two arguments are equal.
class Comment(val post: Post, val commenter: Person) {
  val topicMatch = post.topic === commenter.interest
  // define indirected relationship
  val pair =
    ^^(topicMatch, connection(post.poster, commenter).connectionType)
  def constraint(pair: (Boolean, String)) = {
	    val (topicMatch, connectionType) = pair
	    if (topicMatch) 1.0
	    else if (connectionType == "family") 0.8
		else if (connectionType == "close friend") 0.5
		else 0.1 
	}
	// add indirect relationship
      pair.addConstraint(constraint _)
   }

// specify evidence:
post1.topic.observe("politics")
post2.topic.observe("sports")
post3.topic.observe("politics")

// Finally, you answer some queries:         
println("Probability Amy's interest is politics = " +
          VariableElimination.probability(amy.interest, "politics"))
println("Probability Brian's interest is politics = " +
  VariableElimination.probability(brian.interest, "politics"))
println("Probability Cheryl's interest is politics = " +
  VariableElimination.probability(cheryl.interest, "politics"))
println("Probability Brian is Amy's family = " +
  VariableElimination.probability(connection(amy, brian).connectionType,
                                  "family"))
println("Probability Cheryl is Amy's family = " +
 VariableElimination.probability(connection(amy, cheryl).connectionType,
                                  "family"))
println("Probability Cheryl is Brian's family = " +
  VariableElimination.probability(connection(brian, cheryl).connectionType,
	"family"))


//---------------------------
// Modeling relational and type uncertainty
// at any given time, some topics are hot, which makes them more likely to be posted.
//	topics objects instead of strings, creating a Topic class with a hot attribute. 
// The topic attribute of the Post class will now be a complex attribute that points to the Topic class.
//	don’t know the topic of a given post p. 
// Maybe you’re using natu- ral language processing to identify the topic, 
//		and your algorithms aren’t perfect.
//  You have uncertainty about the value of p.topic, which is a complex attribute
// Relational uncertainty (reference uncertainty):
//		uncertainty about the relationship between the post and its topic, 
//		which could be one of a number of instances of Topic
// 		not knowing to which object p.topic refers to
// Type uncertaint (special case of relational uncertainty): printer example:
//		not know what type of printer you have. 
//		Maybe you’re working at a help desk and a user has called in and 
//			not told you what kind of printer he’s using. 
//		you can handle it by creating putative printers of each possible class, 
//			with uncertainty over which is the printer
// Solution is element collections and references Machinery:
//		1. Handling relational uncertainty
//		2. Working with dynamic models
//---------------------------
// Element collection:
//		every Figaro element has a name and belongs to an element collection
//		is a Figaro collection in which an element is indexed by a string, which is its name
//		By default, an element’s name is the empty string
//		there’s a default element col- lection that every element goes into, unless told otherwise
//		Element collections are useful because they give you a way to identify elements other than through Scala variables.
//		 If ec is an element collection, you can get the ele- ment associated with the name n using ec.get(n)
//				it is like compile time versus runtime type checking
//		Sometimes, you can’t fully determine the type of a variable at compile time, 
//				so you have to perform a runtime check.
//		you might not know how to get at a particular element at compile time, and 
//				element collections give you a way to get the variable dynamically at runtime.

// Relational uncertainty handling:
//		unsure about the value of the topic attribute of Post.
//		The topic has an attri- bute named hot, which is an element.
//		ability to refer to topic.hot from within the Post class 
//		But you can’t do this using Scala, because topic isn’t a specific instance of Topic!
// make Post and Topic ele- ment collections and use get("topic.hot") to get at the element you need.
//	topic.hot is a concatination of two names
//	The first name:
//		 topic, is the name of an element in the Post element collection. 
//		In this case, it’s an Element[Topic] whose value repre- sents the particular topic of the post.
//	The second name:
//		 hot, is the name of an element in the Topic element collection. 
//	This concatenation of names is called a reference
//		each subsequent name in the reference is defined in an element collection 
//			that’s a possible value of the previous element.

// in summary: Post is an element collection, and "topic" is the name, and 
//		when we get the corresponding item to this name int he element dictionary 
//		i.e. Element identified by the name, we have Topic as an element collection that is value type
//		of previous element, and "hot" is a string, and in the Element dictionary it has an element

// think about them in a principled way as defining random processes
//		Suppose that there are two possible topics, sports and politics. 
//		Each of these is an instance of the Topic class.
//		Topic is an element collec- tion, and it has an attribute hot whose name is "hot". 
//		post1 is an instance of Post, which is also an element collection, 
//			with poster and topic attributes
//		 The name of the topic attribute is "topic". 
//		Calling post1.get("topic.hot") defines a random process,

// an element in Figaro represents a random process
//	use an element to represent the random process defined by post1.get("topic.hot")

//----------------------------
// Social media model with relational uncertainty
//----------------------------
// uncertainty over the topics of posts.
// an instance of Topic is also an ElementCollection
class Topic() extends ElementCollection {
	// put "hot" name in the element collection this
	//	Within the context of the Topic class, the this keyword refers to this specific instance of Topic.
     val hot = Flip(0.1)("hot", this)
}

// These arguments are optional and can usually be omitted. 
//	You need them only if you want to give your element a name or put it in a specific element collection. 

// In general, all of Figaro’s built-in element constructors allow you to specify a name and element collection for the element.

// define two instances of the Topic class
val sports = new Topic()
val politics = new Topic()

// A Person has an interest that’s an unknown Topic. 
// Here, the attribute interest is an Element[Topic]
class Person() {
  val interest = Uniform(sports, politics)
}

// A Post is also an ElementCollection. 
//	It has an attribute named topic. This is an Element[Topic] that depends on poster.interest:
class Post(val poster: Person) extends ElementCollection {
  val topic =
    If(Flip(0.9), poster.interest,
       Uniform(sports, politics))("topic", this)
}

//  people will comment on hot topics even if they’re not usually interested in them
//	So a comment is appropriate if either the topic matches the commenter’s interest 
//		or the topic is hot. 
class Comment(val post: Post, val commenter: Person) {
  val isHot = post.get[Boolean]("topic.hot")
  val appropriateComment =
    Apply(post.topic, commenter.interest, isHot,
    (t1: Topic, t2: Topic, b: Boolean) => (t1 == t2) || b)
  // add the undirected constraint on appropriateComment and the connection
  // type as before
}

// you have to specify the value type of the element (Boolean, in this case). 
//	generally you have to specify the value type. 
//	There’s no way for the Scala compiler to know, just from the name of the element, what the value type of the element is. 
//	But to be able to use isHot, you have to know its value type. 
//	Specifying the value type as a type argument to get, in square brackets, tells the Scala compiler what it needs.

// assert evidence about a complex attribute is exactly the same as for a simple attribute
post1.topic.observe(politics) 
// to observe that the value of the topic attribute is the politics instance of Topic.

// Queries and inference:
// 		query for the interests of people and topics of posts, which are instances of the Topic class
println("Probability Amy's interest is politics = " +
  VariableElimination.probability(amy.interest, politics))
println("Probability post 2's topic is sports = " +
  VariableElimination.probability(post2.topic, sports))
println("Probability post 3's topic is sports = " +
  VariableElimination.probability(post3.topic, sports))
println("Probability Amy is Brian's family = " +
  VariableElimination.probability(connection(brian, amy).connectionType,
"family"))

// Now let’s observe that the sports topic is hot (sports.hot.observe(true)) and run the same queries.
// include reasoning that she commented not because she was interested in sport, 
//		but because sport topic was hot
//	Alternative explanation when it is not interest and hot

// A priori, Amy being Brian’s family and the hotness of sports are independent. 
// There’s no reason why the two should be connected. 
// But after you observe that Amy is likely to be interested in politics and Amy commented on Brian’s post, they become connected. 
// This is a classic example of the reasoning pattern known as explaining away, 
//		where there are two alternative explanations for the same observation, and 
//		observing one explanation discounts the other explanation.

//----------------------------
//	Printer model with type uncertainty
// 	type uncertainty using the printer model with a printer of unknown type.
//	The principles are similar: you use element collections and references.
//		create multiple printer instances, one for each possible type, and 
//		create an element whose value is one of the printer instances to represent the unknown printer.
//	First, you’ll be asserting evidence on and querying elements whose identity is uncertain. 
//		So you use get within the query and observation.
//	The second wrinkle is that:
//		you’re not going to fundamentally change the original definition of PrintExperience, which took Printer as an argument. 
//		You don’t have a specific printer—instead, 
//		you have an Element[Printer] representing an unknown printer, and 
//		you have to create a PrintExperience and access its attributes. 
//		You’ll use Figaro’s Apply to achieve this. 
//		Given an unknown printer, represented by an Element[Printer], 
//			you use Apply to create an Element[PrintExperience], 
//			where the PrintExperience is based on whatever printer the printer is.
//----------------------------
// Changes are:
object PrinterProblemTypeUncertainty extends ElementCollection { 
//	We place the entire model in an element collection.

// A printer is an element collection.
abstract class Printer extends ElementCollection {

// powerButtonOn, which is an attribute you’ll query, 
//		is given a name and placed in the element collection of the printer to which it belongs.
val powerButtonOn = Flip(0.95)("power button on", this)

// A print experience is also an element collection.
class PrintExperience(printer: Printer, software: Software, network: Network, user: User) extends 		ElementCollection {

// You’ll observe evidence about the print summary, 
//		so you give it a name and put it in the print experience element collection.
val summary = Apply(...)("summary", this)

// Now you describe a specific situation. 
//	Here’s where the type uncertainty comes in. You proceed as follows. 
//		First you define myPrinter to be a random choice among printers of different types, 
//			give myPrinter a name, and put it in the element collection of the entire model:
//	my printer here is the name of the printer instance I have uncertainty about
val myPrinter =
    Select(0.3 -> new LaserPrinter,
           0.7 -> new InkjetPrinter)("my printer", this)

// Next, you create instances of Software, Network, and User, just like before:
val mySoftware = new Software
val myNetwork = new Network
val me = new User

//	Finally, to create myExperience, you use Apply and the existing PrintExperience class, 
//		which takes a particular printer, software, network, and user as arguments. 
//	Again, you give myExperience a name and put it in the top-level element collection:
// print experience here is the name of an instance of my experience
val myExperience =
  Apply(myPrinter,(p: Printer) =>
    new PrintExperience(p, mySoftware, myNetwork, me))("print experience",
                                                       this)

// observe evidence on the summary of the print experience. 
//	But myExperience is an Element [PrintExperience], 
//		so how do you get at its summary? 
//	You use a reference, of course! 
//	You gave the summary element a name and put it in the PrintExperience element collection, and 
//	you gave myExperience a name and put it in the top-level element col- lection so you could do this.
val summary = get[Symbol]("print experience.summary")
summary.observe('none)

// Based on the evidence that nothing was printed, you’ll query two things. 
//	One is whether the printer’s power button is on. 
//	Again, myPrinter is an element, so you can’t query it directly, but you can use a reference:
val powerButtonOn = get[Boolean]("my printer.power button on")


// Imagine that you’re at the help desk wondering what type of printer the user has. 
//	After the user starts telling you things about the print experience, 
//	you might develop hypotheses about the type of printer. 
//	You can query your model for the type of the printer based on the evidence. 
//	You use Scala’s runtime type-checking method isInstanceOf to achieve this. 
//	Specifically, you can define an element whose value is true if the myPrinter is a laser printer as follows:
val isLaser =
          Apply(myPrinter, (p: Printer) => p.isInstanceOf[LaserPrinter])

// To represent relational or type certainty, 
//		you create an element whose value is an unknown element collection and 
//		use a reference to refer to attributes of that element collection.


//----------------------------
// Figaro collections: keep elements that define probability distribution over values
//		they let you reach inside the elements and work with operations on the values
// 		which can help you product new elements and new collections
//----------------------------
// generate equivalent element by transformming or mappligy Apply(e, (i:Int) => i*2)
// c is the Figaro cllection of Integer Elements
c.map((i:Int) => i*2)
// each element corresponds to the process of starting with an element in the original collection, 
//	generating its value, and multiplying it by 2.

// If c is the Figaro cllection containing two Elements Uniform(2,3) and Constant(5)
c.map((i: Int) => i * 2)
// is a Figaro cllection containing the elements:
//	Apply(Uniform(2, 3), (i: Int) => i * 2) and 
//	Apply(Constant(5), (i: Int) =>i*2)
// i.e. the collection has two elements, one is uniformly distributed over 4 (2*2) and 6 (3*2)
//		and the other of which is constantly 10 (5*2)

// Creating collection based on parameters
// If c is a Figaro collection of double elements
c.chain((d: Double) => Flip(d))
// produce a new Figaro collection, in which for each element e of the original collection
//		there is Chain(e, (d: Double) => Flip(d))
// The first collection is the collection of parameters
// The second is the collection of flips, each flip depending on the corresponding parameter
// e.g. if c contained the elements Beta(2,1) and Beta(1,2)
//		the two elements in the resulting collection will be equivalent to: 
//		Flip(Beta(2,1)) and Flip(Beta(1,2))

// If c is Figaro collection of Integer elements
c.exists((i:Int) => i<0)
// returns a Boolean element representing whether any of the elements in the collection have negative value

// returns the number of elements in the collection that have negative value
c.count((i: Int) => i<0)

// Apply fold aggregation operation on a container
c.foldleft(_+_)
// on the c as Collection of Integer elements creates an element representing sum of the values

// if c is figaro collection with the two elements Uniform(2,3) and Constant(5)
// Two sums are possible 2+5 = 7, and 3+5 = 8
// foldLeft produces an element athat is uniformly distributed over 7 and 8

/ Other reasons that Figaro collections are useful:
// 	a. allow representing unknown number of objects by using variable-size collections
// 	b. enable you to represents infinitely many vairables, or even a continuum of variables

//-----------------------------
// Hierarchical model of coin toss from the bag
// Figaro collection
//-----------------------------
// Use FixedSizeArray(number of elemens, an element generator)
// An element generator is a function that takes Integer argument representing an index into the array
//		and represents an element that may depend on the index
new FixedSizeArray(10, i => Flip(1.0 / (i + 1))
// includ ? defining whether the outcome of the coin toss is observed


import com.cra.figaro.language.{Flip, Constant}
import com.cra.figaro.library.atomic.continuous.{Uniform, Beta} import com.cra.figaro.library.compound.If
import com.cra.figaro.algorithm.sampling.Importance
import com.cra.figaro.library.process.FixedSizeArray
// com.cra.figaro.library .process is the package containing Figaro’s collections library.

object HierarchicalContainers {
  def main(args: Array[String]) {
    val numCoins = args.length
    val fairProbability = Uniform(0.0, 1.0)

		// In this fixed-size array, every element is Flip(fairProbability), regardless of the index.
		val isFair =
		         new FixedSizeArray(numCoins + 1, i => Flip(fairProbability))

		// For each coin, this creates a new element that’s either Constant(0.5) or Beta(2, 5), 
		//		depending on the value of isFair(coin).
		val biases = isFair.chain(if (_) Constant(0.5) else Beta(2,5))

		// The variable tosses is a Scala sequence (one for each coin) where every item is a Figaro collection, 
		// in which every element is a Flip whose probability of coming out heads is the bias of the appropriate coin.
		// The for...yield construct creates a Scala sequence, in which you have a fixed-size array for every coin. 
		val tosses =
			for { coin <- 0 until numCoins } yield
			new FixedSizeArray(args(coin).length, i => Flip(biases(coin)))

		// For each coin, hasHeads(coin) is an element representing whether any of the tosses of the coin came out heads. See text for a breakdown of tosses(coin) .exists(b => b).
		val hasHeads =
			for { coin <- 0 until numCoins } yield 
			tosses(coin).exists(b => b)

		// Observing the evidence is done in almost the exact same way as before. tosses(coin) is a FixedSizeArray, and you can use tosses(coin)(toss) to get an element just as in a Scala array.
		for {
		     coin <- 0 until numCoins
		     toss <- 0 until args(coin).length
		   } {
		   args(coin)(toss) match {
		  	case 'H' => tosses(coin)(toss).observe(true)
			case 'T' => tosses(coin)(toss).observe(false)
			case _ => ()
			}

		val algorithm = Importance(fairProbability, hasHeads(2))
		algorithm.start()
		Thread.sleep(1000)
		algorithm.stop()
		println("Probability at least one of the tosses of the third " + "coin was heads = " +
		algorithm.probability(hasHeads(2), true)) algorithm.kill()
	}
}

//----------------------------
// Converting to and From scala and Figaro collections
//-----------------------------
// Container:
//		a general class of collection containing a finite number of elements
//		the constructor takes vairable number of elements, each over the same value type
Container(toss1, toss2, toss3) // Figaro collection containing these tosses

// Scala collection is a kind of sequence (implements Seq trait such as an array or list)
:_*
// can convert Scala collection to argument
tosses = List(toss1, toss2, toss3)
Container(tosses:_*)
// it is the same as Figaro collection in the bag-toss example

// if your collection is something like set, which isn't a sequence
//	first convert it to a sequence by using the toList method
// and then use the :_* construct
Container(Set(toss1, toss2, toss3)).toList:_*)

// Enumerating the elements in a Container
// turn Figaro Container (a finite collection) into a Scala Seq of elements by using elements method
Container(toss1, toss2, toss3).elements
// generates a Scala Seq

// Producing a mapping from indices to elements
// useful for infinite process in which the index set consists of real numbers
// for a FixedSizeArray, the index set comprises the integers from 0 to number of elements minus 1
// for Container the index set is finite
// so you can turn container into Scala Map from indices to values
toMap

//-----------------------------
// Sales Prediction
// you have a number of products, each with a product quality; 
//	and a number of regions, each with a degree of region penetration. 
//	You’ll observe the sales of each product in each region last year and 
//	predict the sales of each product in each region in the coming year. 
//	You’ll further predict the number of new people your company might hire to support each product line and each region’s sales force.
//-----------------------------
// Define one dimensional Scala arrays of products and regions
val productQuality = Array.fill(numProducts)(Beta(2,2))
val regionPenetration = Array.fill(numRegions)(Beta(2,2))
def makeSales(i: Int, j: Int) =
    Flip(productQuality(i) * regionPenetration(j))
val highSalesLastYear =
    Array.tabulate(numProducts, numRegions)(makeSales _)
val highSalesNextYear =
    Array.tabulate(numProducts, numRegions)(makeSales _)

// Scala array, with one item for each product, 
//	in which each item is a Figaro Container containing the elements representing the predicted sales of the corresponding product in all regions:
// Use figaro because we want to predict the number of new hires per product and per region, and for that, you need Figaro collections. 
def getSalesByProduct(i: Int) =
  for { j <- 0 until numRegions } yield highSalesNextYear(i)(j)

val salesPredictionByProduct =
  Array.tabulate(numProducts)(i => Container(getSalesByProduct(i):_*))

// Predict the number of hires using figaro collection
// First, for each product create an element representing the number of regions with high sales next year
// Scala array, with one item for each product saying the number of products for which predict high sales
val numHighSales =
	for { predictions <- salesPredictionByProduct } yield predictions.count(b => b)

// for each product, create an element representing the number of hires for that product 
//		which depends on the number of Highsales (dependancy created by Chain)

// First, approach using Scala collection
val numHiresByProduct =
  for { i <- 0 until numProducts }
  yield Chain(numHighSales(i), (n: Int) => Poisson(n  + 1))
  // This creates a Scala array of Chain elements. 

// Second, another approach using Figaro collections:
val numHiresByProduct =
  Container(numHighSales:_*).chain((n: Int) => Poisson(n + 1)) 
  // This creates a Figaro Container of Chain elements.


// Because the query targets are the elements in the numHiresByProduct, 
// for the version in which numHires- ByProduct is a Figaro Container, 
//	you need to get its elements to pass them to the importance sampling algorithm.
val targets = numHiresByProduct.elements
val algorithm = Importance(targets:_*)

// take aways doing count in Scala is not trivial, but multidimensional arrays in Scala is easy

//---------------------------
// Modeling situations with an unknown number of objects
// Situation: 
// Traffic camera at specific points
// Preict Viehcle passing a specific point, Traffic Jam prediction, 
// A situation in which you don’t know the number of objects is known as an open-universe situation 
// 1. Not know the exact number of objects, e.g. number of vehicles: number uncertainty.
// 2. Uncertain about the identity of the objects: identity uncertainty
//	e.g. uncertain whether two vehicle images at different sites belong to the same vehicle
//---------------------------
// Negation by failure is a form of closed-universe reasoning (if I don't know, it does not exist).
// In contrast, full first-order logic is open universe. To prove that there’s no green vehi- cle in your image, you have to prove that there can’t possibly be such a vehicle, even if you don’t know about it. 


VariableSizeArray(Binomial(20, 0.3), i => Beta(1, i + 1))
// Element representing number of elements in the array
// Element generator: Index into array => Element definition
// It is one of the many arrays
// Creating a Make-Array element represent this random variable

// Operations on variable size array
// Getting the element at an index —In principle, vsa(5) if exists or IndexOutOfRangeException
vsa(5)

// Safely getting an optional element at an index 
vsa.get(5)
// returns Element[Option[String]]
// Returns a String or None

// Map the variable-size array through a function on values
vsa.map(_.length)
// produces a new variable-size array, with each string replace by its length

// Chain the variable-size array through a function that maps values to elements
vsa.map((s: String) => discrete.Uniform(s:_*)) 
// creates a variable-size array 
// each element contains a random character from the corresponding string
// s:_* turns the string into a sequence of characters, and 
// discrete.Uniform (s:_*) selects a random member from the sequence.

// Folds and aggregates
vsa.count (_.length > 2)
// returns Element[Int] representing the number of strings whose length is greater than 2.


//----------------------------
// predicting sales of an unknown number of new products
// planning the research and development (R&D) investment of your company in the coming year.
// Higher R&D investment leads to more new products being developed, which leads to higher sales.
// But at the time of making the investment, you don’t know exactly how many new products will be devel- oped for a given level of investment.
//----------------------------
// use a variable-size array to represent the new products
// rNDLevel: Double, level of R&D investment

// numNewProducts: Integer element, number of new products developed as a result of R&D
//		Geometric(rNDLevel)
// After each step, the process can terminate or it can go on to the next step. 
// The probability of going on to the next step is provided by the parameter of the Geometric element (in this case, rNDLevel)	
// The value of the process is the number of steps before termination
// The probabilities of the number of steps decrease geometrically by a factor of rNDLevel each time
// The higher the rNDLevel, the longer the process is likely to go on, and the more new products will be developed.
 val numNewProducts = Geometric(rNDLevel)

// productQuality: VariableSizeArray, the quality of each of the new products
// 		expected value of Beta(1, i + 1) is 1 / (i + 2), 
//		so the product quality tends to decrease as more new products are developed, 
//		representing iminishing return on R&D investment.
val productQuality =
      VariableSizeArray(numNewProducts, i => Beta(1, i + 1))

// Turn product quality into prediction of sales of products:
//	First, you generate the raw sales by using a Normal element centered on the product quality. 
//		But a Normal element can have negative values, and negative sales are impossible
// 	Second, ou truncate the Normal element and give it a lower bound of 0. 
// 		using Chain and Map methods ov VariableSizeArray
val productSalesRaw = productQuality.chain(Normal(_, 0.5))
val productSales = productSalesRaw.map(_.max(0))

// Finally, you get the total sales by folding the sum function through the product- Sales variable-size array.
val totalSales = productSales.foldLeft(0.0)(_ + _)

//----------------------------
// Woring with infinite  processes
//----------------------------
//	elements in the collection are defined only implicitly. 
//	You never access infinitely many elements. But they’re all available to you should you need them.
Process
// The Process trait is Figaro’s general representation of collections, which could be finite or infinite. 
// Like array, you can access items by index, but index can be any type you want
// Process can be parameterized by two types:
//		(1) the index type
//		(2) the value type

// generate: essential method to be defined for Process[Index, Value]
//		takes an index of type Index and returns Element[Value]
//		if called, it creates and returns the appropriate element for the given index
//		shouldn't be called directly
//		just call p(5) and it calls generate, and caches it
//		p(5) is short for p.apply(5)

// generate lets you to get the elements for many indices at once => in the case of dependancy
// In a Figaro process, dependencies might exist between the ele- ments at different indices.
// e.g.  suppose you have a process representing the amount of rainfall at various locations in a region
// the elements representing rainfall at nearby locations should be dependent on each other.
// If you get the elements one at a time, you won’t capture these dependencies, but if you get the elements at all of the locations you’re interested in together, you can generate the dependencies between them.
// 		takes as an argument a list of indices
//		returns Map[Index, Element[Value]], a mapping from indices to elements
//		This map should contain the element corresponding to each of the indices in its argument
// 		also produce elements representing the dependencies between the elements for the indices, although these aren’t put in the map.
// e.g.   
//		if you have a process containing the rainfall at different locations, then calling generate with a set of locations will produce the elements representing the rainfall at those locations, 
//		as well as elements representing the dependencies between the rainfall at those locations.

// Index 0 to length of array minus 1 is valid only, rangeCheck method:
//			takes index argument and returns a Boolean indicating whether the index is in range and valid
//			process's apply method to get element it first checks and throws IndexOutOfRangeException

// If container in infinite fold and map does not work, but Process trait supports map and chain
//		like Containers

// FiexedSizeArray: subclass of Container
//		1. the sequence of valid indices is integers from 0 up to the size of the array minus 1
// 		2. the elements in FixedSizeArray are assumed to be independent
//			no dependency encoded

//-----------------------------
// 	Example: a temporal health process
// 	the value that varies over time
//	process models the health of a patient over time.
//	Two approaches modeling temporal process
//		(1) set up discrete time points at regular intervals (for example, every minute) and define a random variable to repre- sent the health of the patient at each discrete time point.
//		(2) treat time as continuous, with a health variable defined at every time point. 
//			- This lets you access the health variables at exactly the time points you want. 
//-----------------------------
// HealthProcess object: a Process whose indices are doubles representing time points and whose elements are Boolean elements representing whether the patient is healthy at each point in time. 
object HealthProcess extends Process[Double, Boolean]

// We need to three methods: 
//	(1) The version of generate that produces an element for a single time point; 
//	(2) the version of generate that produces elements for multiple time points, along with their dependencies; and 
//	(3) rangeCheck.

// first start with rangeCheck and mention that time is greater than zero
def rangeCheck(time: Double) = time >= 0

//  implement the generate method: produces the health of patient at a single point in time
//	When you look at a single time point in isolation, the health vari- able is a simple Flip.
//	suppose that you don’t know the Flip probability and want to learn it.
//	 introduce a parameter called healthyPrior to represent this probability. healthyPrior 
val healthyPrior = Uniform((0.05 to 0.95 by 0.1):_*)
def generate(time: Double): Element[Boolean] = Flip(healthyPrior)
//  discrete Uniform element is used that chooses between the values 0.05, 0.15, ..., 0.95.

//implement a generate function that can produce the elements for a set of time points along with the dependencies between them. 
// How should you model the dependencies between time points? 
// One natural model is that nearby time points are likely to have the same health value. 
// The degree to which this is true depends on how close the time points are to each other. 
// You’ll assume that the influence of one time point on the next decreases exponentially with the distance between the time points. 
// You’ll use a parameter called health- ChangeRate to represent the speed with which the health status changes over time, and you’ll learn this parameter from the data.

// create 2 sets of elements:
// 1. set of the elements for the time points, which are created using the single time point generate method. 
// 2. set encodes dependencies between each successive pair of time points. 
//  go through the ordered sequence of time points, and for each pair, create an element that encodes the fact that successive time points are more likely to have the same health status than different health statuses. 
// The strength of this constraint will depend on the distance between the time points and will be modulated by healthChangeRate.

def generate(times: List[Double]): Map[Double, Element[Boolean]] = {
// Sort the times so we can always assume they are in order health 
// Produce the map from time indices tostatus elements
  val sortedTimes = times.sorted
  val healthy = sortedTimes.map(time => (time, generate(time))).toMap

	// Go through the times, in order, processing each successive pair
	def makePairs(remaining: List[Double]) {
	  if (remaining.length >= 2) {
	    val time1 :: time2 :: rest = remaining

	    // Create an element encoding the dependency between the health status at successive time points
	    val probChange =
	      Apply(healthChangeRate,
	            (d: Double) => 1 - math.exp(- (time2 - time1) / d))

	    val equalHealth = healthy(time1) === healthy(time2)
	    val healthStatusChecker =
	      If(equalHealth, Constant(true), Flip(probChange))
		healthStatusChecker.observe(true)
	    makePairs(time2 :: rest)
	  }
	}
	makePairs(sortedTimes)
	healthy
}
//  create the element encoding the dependency between the health sta- tuses at successive time points by:
//		model it as an undirected dependency
//		create a Boolean element whose probability of being true depends on the two health statuses, and observe that the element has value true.  
// The inputs are:
//	 healthy(time1)—The health status at the first time point
//	 healthy(time2)—The health status at the second time point
//	 healthChangeRate—The rate at which health status tends to change
// If healthy(time1) and healthy(time2) are equal, healthyStatusChecker will definitely be true
// If health(time1) and healthy(time2) are unequal, the probability healthStatusCheck is true depends on the distance between time2 and time1
//		i.e. the larger the distance between time1 and time2, the more likely the healthy status has changed

// probChange: the probability health status hasn't changed is exponentially decreasing in time2-time1
//		so has change increasing in time2-time1 divided by the value of healthChangeRate
//		so probability that the health status has changed gets closer to 1 the larger the time difference.

// Using the process:
// you’ll assume that you’re given data containing the health status at a number of time points. 
// You want to query the health status at other time points
// You also want to query the learned healthyPrior and healthChangeRate based on the data.

// The crucial step is to generate the elements for all time points you’re interested in, including the time points in both the data and the query, in one go. 
// That way, all necessary dependencies will be created. 
// If you generated elements for the data and the query separately, you wouldn’t get any dependencies between them, and you wouldn’t be able to use the data to predict the health at the query times.

// Inference process:
// 	(1) generating the required elements, 
//	(2) asserting evidence, 
//	(3) running inference, and 
//  (4) getting the answers to queries:
//  the data maps time points to observed health status.
val data = Map(0.1 -> true, 0.25 -> true, 0.3 -> false,
	0.31 -> false, 0.34 -> false, 0.36 -> false, 
	0.4 -> true, 0.5 -> true, 0.55 -> true) 

//Generate elements for all data and query points
val queries = List(0.35, 0.37, 0.45, 0.6)
// critical step to put the query points and data together
val targets = queries ::: data.keys.toList
val healthy = generate(targets)

// after putting data into the model by generate function
// attach the data (i.e. evidence)
// Assert the evidence. healthy, which was returned by generate, is a map from time points to elements.
for { (time, value) <- data } {
  healthy(time).observe(value)
}

// Run inference on the target elements. 
// Again you use the healthy map to get the relevant elements. Which gives the dependancies as well.
val queryElements = queries.map(healthy(_))

// put both prior, and the change rate and the elements including the dependancy in the list
// and ask the variable elimination algorithm to do the inference and give the results
val queryTargets = healthyPrior :: healthChangeRate :: queryElements
val algorithm = VariableElimination(queryTargets:_*)
algorithm.start()

for { query <- queries } {
  println("Probability the patient is healthy at time " + query + " = " +
          algorithm.probability(healthy(query), true))
}

println("Expected prior probability of healthy = " +
        algorithm.mean(healthyPrior))
println("Expected health change rate = " +
       algorithm.mean(healthChangeRate))
algorithm.kill()

// Fixed- SizeArray takes care of all of the work of defining rangeCheck and the two versions of generate
// But here we defined our own custom process or container

// We started with simple but useful design patterns
//  gradually moved to more powerful and far-reaching concepts


// Summary of Collection chapter:
//  Just as in ordinary programming, collections let you organize many objects and use the same code to operate on all of them.
// Figaro collections let you model open-universe situations with an unknown number of objects.
// Figaro processes let you model collections over an infinite set of indices, such as time or space.


//----------------------------
// Bayesian Network for two-dimensional sales model
// Sales of a product in each region depends on the product quality and region penetration
// Despite the simplicity of the network, reasoning can be camplicated: 
//	e.g. inferring product quality and region penetration by observing product 1, 
//	but predicting product 2
//	This inference power comes from comparison within each area
// reasoning pattern: As the path is not blocked it is active
// Collective inference: 
//		- infer the quality of all of the products and the penetration of all regions simultaneously. 
//----------------------------
// Two Dimensional sales model in Figaro
import com.cra.figaro.library.atomic.continuous.Beta
import com.cra.figaro.language.Flip
import com.cra.figaro.algorithm.sampling.Importance
// The command-line arguments are a number of strings, one for each product. 
// Each string has one character for each region; the strings should have the same length.
object Sales {
  def main(args: Array[String]) {
    val numProducts = args.length
    val numRegions = args(0).length
    val productQuality = Array.fill(numProducts)(Beta(2,2))
	val regionPenetration = Array.fill(numRegions)(Beta(2,2))
	// Array.tabulate(numProducts, numRegions) creates a two-dimensional array, 
	// where each item is generated based on the corresponding product and region indices. 
	// Each item is a Flip where the probability is the appropriate product quality times the appropriate region penetration.
	def makeSales(i: Int, j: Int) =
  		Flip(productQuality(i) * regionPenetration(j))
	val highSales =
  		Array.tabulate(numProducts, numRegions)(makeSales _)
  	// The sales observations are taken from the command line; 
  	// a T indicates high sales for the corresponding product and region. 
  	// The appropriate evidence is asserted on each highSales element.
  	for {
	  i <- 0 until numProducts
 	  j <- 0 until numRegions
	}{
		val observation = args(i)(j) == 'T' 
		highSales(i)(j).observe(observation)
	}
	// Create an anytime Importance sampling algorithm in which 
	//		the query targets are all of the product quality and region penetration elements
	val targets = productQuality ++ regionPenetration
	val algorithm = Importance(targets:_*)
	algorithm.start()
	Thread.sleep(1000)
	algorithm.stop()
	// Print the average inferred product quality and region penetration of every product and region
￼￼￼￼for { i <- 0 until numProducts } {
  		println("Product " + i + " quality: " +
          algorithm.mean(productQuality(i)))
	}
	for { j <- 0 until numRegions } {
		println("Region " + j + " penetration: " +
              algorithm.mean(regionPenetration(j)))
    }
    algorithm.kill()
  }
}


//----------------------------
// Example of multiple coins in a single bag
// Hierarchical Models in Figaro
// Sequences of sequences
// toss of coin which is one of many coins in the bag,
// 	which is one of many bags in a box, so on.
// two levels of sequences
//----------------------------
// property of a toss (namely, whether it came up heads) depended on 
//		a property of the coin (namely, its bias). 
// coin’s bias depends on a property of the bag.
// The bag has a property that represents the probability that any given coin in the bag will be fair.
// The third layer contains the tosses of each coin.
// Each toss has two subscripts, representing the coin number and the toss number. 
// Each toss depends on the bias of the appropriate coin. 
// different coins can have different numbers of tosses; 

// code expects a number of command-line arguments, one for each observed coin
val numCoins = args.length
// Creates a sequence of length numCoins in which each item is a Flip(fairProbability) element
val fairProbability = Uniform(0.0, 1.0)
val isFair =
  for { coin <- 0 until numCoins }
  yield Flip(fairProbability)
// For each coin, if the coin is fair, its bias is definitely 0.5; otherwise it’s Beta(2, 5).
val biases =
  for { coin <- 0 until numCoins }
  yield If(isFair(coin), Constant(0.5), Beta(2,5))
// Given a coin, produces a sequence of Flip(biases(coin)) elements whose length is the number of tosses of the coin, read from the command line
// ￼￼￼Produces a sequence of toss sequences, one for each coin
val tosses =
  for { coin <- 0 until numCoins }
  yield {
    for { toss <- 0 until args(coin).length }
    yield Flip(biases(coin))
}

// use two dimensional for comprehension to assert the evidences
for {
  coin <- 0 until numCoins
  toss <- 0 until args(coin).length
}{
val outcome = args(coin)(toss) == 'H' 
tosses(coin)(toss).observe(outcome)
}

// run inferences
val algorithm = Importance(fairProbability, biases(0))
algorithm.start()
Thread.sleep(1000)
algorithm.stop()
val averageFairProbability = algorithm.mean(fairProbability)
val firstCoinAverageBias = algorithm.mean(biases(0))
println("Average fairness probability: " + averageFairProbability)
println("First coin average bias: " + firstCoinAverageBias)
algorithm.kill()

//----------------------------
// Coin Toss as an example of Figaro collections
//----------------------------
//Create an array of size numTosses in which each item is a different instantiation of Flip(bias). Each element of this array represents a separate coin toss.
val outcomes = args(0)
val numTosses = outcomes.length
val bias = Beta(2,5)
val tosses = Array.fill(numTosses)(Flip(bias))
val nextToss = Flip(bias)

// observe the outcome of tosses
for {
  toss <- 0 until numTosses
}{
val outcome = outcomes(toss) == 'H' 
tosses(toss).observe(outcome)
}

// Anytime algorithm inference (separate thread) as oppose to one time
// At a given point in time it generates the best answer it can
// Kill anytime algorithm otherwise it will not release the resources
// in anytime algorithm we don't tell importance sampling how many samples, 
//		because it takes as many as it can during time

// Create a version of importance sampling with the goal of querying nextToss and bias. Figaro knows it’s the anytime version because there’s no argument for the number of samples.
val algorithm = Importance(nextToss, bias)

algorithm.start()
// Wait 1000 miliseconds (in this duration the algorithm is running in another thread)
Thread.sleep(1000)
algorithm.stop()

println("Average bias = " + algorithm.mean(bias))
println("Probability of heads on next toss = " +
        algorithm.probability(nextToss, true))

// Release all the resources
algorithm.kill()



//----------------------------
// Image recovery model in Figaro
// you’ll assume that some of the pixels are observed and the rest are unobserved.
// You want to recover the unobserved pixels.
// Specifies both the potential value for each pixel being on and the potential value for adjacent pixels having the same value.
// Pixels are either dark or bright, so either True or False
// There are two methods for specifying symmetric relationships, a constraints method and a conditions method. 
// This code uses the constraints method:
//----------------------------
// Set uniry constraint on each variable
// array and fills every element of the array with a different instance of Flip(0.4).
val pixels = Array.fill(10, 10)(Flip(0.4))
// Set the binary constraint on a pair of variables given their coordinates
def setConstraint(i1: Int, j1: Int, i2: Int, j2: Int) {
  val pixel1 = pixels(i1)(j1)
  val pixel2 = pixels(i2)(j2)
  val pair = ^^(pixel1, pixel2)
  pair.addConstraint(bb => if (bb._1 == bb._2) 0.9; else 0.1)
}
// Apply the binary constraint to all pairs of adjacent variables
// until means exclusive, and to means inclusive
// this is an example of nested loop
// In other lan- guages, this would have been written using one for loop inside another
for {
    i <- 0 until 10
    j <- 0 until 10
  } {
    if (i <= 8) setConstraint(i, j, i+1, j)
    if (j <= 8) setConstraint(i, j, i, j+1)
}
// REASONING WITH THE IMAGE-RECOVERY MODEL
// a way to ingest and process the evidence, 
// a way to compute the most likely states of pixels, 
// and a way to view the results.

// Process evidence: 
// Data for each pixel has on, off, or unknown
// Uses Scala pattern matching, which in this case is a lot like a switch statement in other languages. // The _ indicates a default case. So no observation will be made on a ‘?’.
def setEvidence(data: String) = {
  for { n <- 0 until data.length } {
    val i = n / 10
    val j = n % 10
    data(n) match {
    	case '0' => pixels(i)(j).observe(false)
	case '1' => pixels(i)(j).observe(true)
	case _ => () // this is the default case
￼} }
}

// Compute the most likely state of pixels:
// In the past, you’ve wanted to estimate the posterior proba- bilities of elements. 
// This time, you’re interested in the most likely values of elements (the values with highest probability)
// But you’re not interested in the most likely val- ues of elements individually, without regard to the other elements; 
//		rather, you want he most likely joint assignment of values to all of the variables.
// You want to know what the most likely possible world is.

// The query for Markov models is: most probable explanation (MPE)
// 		you want to know the world that’s the most probable explanation of the data.
// algorithms for MPE queries are different from the probability computation algorithms
//		a version of the belief propagation designed for computing the MPE
//		MPE- BeliefPropagation
val algorithm = MPEBeliefPropagation(10)
algorithm.start()

// Viewing the results: 
//	This is simply a matter of going through all of the pixels, 
// getting their most likely values, and printing them accordingly. 
for {
      i <- 0 until 10
}{
for { j <- 0 until 10 } {
        val mlv = algorithm.mostLikelyValue(pixels(i)(j))
        if (mlv) print('1') else print('0')
      }
println() }

// provide input directly to the program
// Scala’s """ constructor allows you to create long strings that span multiple lines. 
// You filter out all whitespace characters to produce a string of 100 characters.
val data =
  """00?000?000
     0?010?0010
     110?010011
     11??000111
     11011000?1
     1?0?100?10
     00001?0?00
     0010??0100
     01?01001?0
     0??000110?""".filterNot(_.isWhitespace)
  setEvidence(data)

// Result of running algorithm on the above will return:
0000000000
0001000010
1100010011
1100000111
1101100011
1000100010
0000100000
0010000100
0100100100
0000001100



//------------------------------
// General Print Fault Model in Figaro
//  chap05/PrinterProb- lem.scala
//------------------------------
val printerState = ...
val softwareState =
  Select(0.8 -> 'correct, 0.15 -> 'glitchy, 0.05 -> 'crashed)
val networkState =
  Select(0.7 -> 'up, 0.2 -> 'intermittent, 0.1 -> 'down)
val userCommandCorrect =
  Flip(0.65)
val numPrintedPages =
  RichCPD(userCommandCorrect, networkState,
          softwareState, printerState,
          (*, *, *, OneOf('out)) -> Constant('zero),
          (*, *, OneOf('crashed), *) -> Constant('zero),
          (*, OneOf('down), *, *) -> Constant('zero),
          (OneOf(false), *, *, *) ->
            Select(0.3 -> 'zero, 0.6 -> 'some, 0.1 -> 'all),
          (OneOf(true), *, *, *) ->
            Select(0.01 -> 'zero, 0.01 -> 'some, 0.98 -> 'all))
val printsQuickly =
  Chain(networkState, softwareState,
        (network: Symbol, software: Symbol) =>
           if (network == 'down || software == 'crashed)
                  Constant(false)
           else if (network == 'intermittent || software == 'glitchy)
           Flip(0.5)
           else Flip(0.9))
val goodPrintQuality =
  CPD(printerState,
      'good -> Flip(0.95),
      'poor -> Flip(0.3),
      'out -> Constant(false))
val printResultSummary =
  Apply(numPrintedPages, printsQuickly, goodPrintQuality,
        (pages: Symbol, quickly: Boolean, quality: Boolean) =>
          if (pages == 'zero) 'none
          else if (pages == 'some || !quickly || !quality) 'poor
          else 'excellent)

val printerPowerButtonOn = Flip(0.95)
val tonerLevel = Select(0.7 -> 'high, 0.2 -> 'low, 0.1 -> 'out)
val tonerLowIndicatorOn =
￼￼￼￼￼￼If(printerPowerButtonOn,
   CPD(paperFlow,
       'high -> Flip(0.2),
       'low -> Flip(0.6),
       'out -> Flip(0.99)),
       Constant(false))
val paperFlow = Select(0.6 -> 'smooth, 0.2 -> 'uneven, 0.2 -> 'jammed)
￼￼￼￼val paperJamIndicatorOn =
  If(printerPowerButtonOn,
     CPD(tonerLevel,
         'high -> Flip(0.1),
         'low -> Flip(0.3),
         'out -> Flip(0.99)),
     Constant(false))

 val printerState =
  Apply(printerPowerButtonOn, tonerLevel, paperFlow,
        (power: Boolean, toner: Symbol, paper: Symbol) => {
          if (power) {
            if (toner == 'high && paper == 'smooth) 'good
            else if (toner == 'out || paper == 'out) 'out
            else 'poor
} else 'out }) // ' is used for symbols in scala

// using prior probability
val answerWithNoEvidence =
  VariableElimination.probability(printerPowerButtonOn, true)
println("Prior probability the printer power button is on = " +
  answerWithNoEvidence)

// inference after providing evidence
printResultSummary.observe('poor)
val answerIfPrintResultPoor =
  VariableElimination.probability(printerPowerButtonOn, true)
println("Probability the printer power button is on given a poor "
  + "result = " + answerIfPrintResultPoor)

printResultSummary.observe('none)
val answerIfPrintResultNone =
  VariableElimination.probability(printerPowerButtonOn, true)
println("Probability the printer power button is on given empty "
  + "result = " + answerIfPrintResultNone)

// independance and blocking of path
printResultSummary.unobserve()
printerState.observe('out)
val answerIfPrinterStateOut =
  VariableElimination.probability(printerPowerButtonOn, true)
println("Probability the printer power button is on given " +
        "out printer state = " + answerIfPrinterStateOut)
printResultSummary.observe('none)
val answerIfPrinterStateOutAndResultNone =
  VariableElimination.probability(printerPowerButtonOn, true)
println("Probability the printer power button is on given " +
        "out printer state and empty result = " +
        answerIfPrinterStateOutAndResultNone)

// reasoning between different effects of the same cause
printResultSummary.unobserve()
printerState.unobserve()
val printerStateGoodPrior =
  VariableElimination.probability(printerState, 'good)
println("Prior probability the printer state is good = "
        + printerStateGoodPrior)
tonerLowIndicatorOn.observe(true)
val printerStateGoodGivenTonerLowIndicatorOn =
  VariableElimination.probability(printerState, 'good)
println("Probability printer state is good given low toner "
	+ "indicator = " + printerStateGoodGivenTonerLowIndicatorOn)

// REASONING BETWEEN DIFFERENT CAUSES OF THE SAME EFFECT: INDUCED DEPENDENCIES
tonerLowIndicatorOn.unobserve()
val softwareStateCorrectPrior =
  VariableElimination.probability(softwareState, 'correct)
println("Prior probability the software state is correct = " +
        softwareStateCorrectPrior)
networkState.observe('up)
val softwareStateCorrectGivenNetworkUp =
  VariableElimination.probability(softwareState, 'correct)
println("Probability software state is correct given network up = " +
        softwareStateCorrectGivenNetworkUp)

networkState.unobserve()
printsQuickly.observe(false)
val softwareStateCorrectGivenPrintsSlowly =
  VariableElimination.probability(softwareState, 'correct)
println("Probability software state is correct given prints "
        + "slowly = " + softwareStateCorrectGivenPrintsSlowly)


networkState.observe('up)
val softwareStateCorrectGivenPrintsSlowlyAndNetworkUp =
  VariableElimination.probability(softwareState, 'correct)
println("Probability software state is correct given prints "
        + "slowly and network up = "
        + softwareStateCorrectGivenPrintsSlowlyAndNetworkUp)


//-------------------------------
// Using probabilistic programming to extend Bayesian networks: predicting product success
//-------------------------------
class Network(popularity: Double) {
  val numNodes = Poisson(popularity)
}
class Model(targetPopularity: Double, productQuality: Double,
            affordability: Double) {
  // recursive function
  def generateLikes(numFriends: Int,
                    productQuality: Double): Element[Int] = {
    def helper(friendsVisited: Int, totalLikes: Int,
               unprocessedLikes: Int): Element[Int] = {
      // termination
      if (unprocessedLikes == 0) Constant(totalLikes)
      else {
      	// fraction of people who have not been visited
        val unvisitedFraction =
          1.0 – (friendsVisited.toDouble – 1) / (numFriends – 1)
        // The person being processed promotes the product to two friends, the probability that each friend hasn't yet been visit is unvisitedFraction
        val newlyVisited = Binomial(2, unvisitedFraction)
        // The probability that a given person likes the product
        val newlyLikes =
          Binomial(newlyVisited, Constant(productQuality))
        // recursive process written in terms of chain
        Chain(newlyVisited, newlyLikes,
        (visited: Int, likes: Int) =>
  helper(friendsVisited + unvisited, // cumulate the new number of visited
         totalLikes + likes, // cumulate the number of people who like
         unprocessedLikes + likes - 1)) // Everyone who newly likes the products is an unprocessed person, but you subtract one for the person you just processed.
} }
  helper(1, 1, 1)
}
val targetSocialNetwork = new Network(targetPopularity)
val targetLikes = Flip(productQuality)
￼￼￼￼￼￼val numberFriendsLike =
  Chain(targetLikes, targetSocialNetwork.numNodes,
        (l: Boolean, n: Int) =>
          if (l) generateLikes(n, productQuality)
          else Constant(0))
 val numberBuy =
    Binomial(numberFriendsLike, Constant(affordability))
}

algorithm.expectation(model.numberBuy, (i: Int) => i.toDouble)

def predict(targetPopularity: Double, productQuality: Double,
            affordability: Double): Double = {
  val model =
    new Model(targetPopularity, productQuality, affordability)
  val algorithm = Importance(1000, model.numberBuy)
  algorithm.start()
  val result =
  algorithm.expectation(model.numberBuy, (i: Int) => i.toDouble)
￼  algorithm.kill()
result 
}


//------------------------------
// Firms – Models firms bidding for a contract and the likelihood that one will be selected as the winner using constraints. 
//------------------------------
/*
 * Firms.scala
 * An example with rich constraints.
 * 
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

//package com.cra.figaro.example

import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.language._
import com.cra.figaro.library.atomic._
import com.cra.figaro.library.compound._

/**
 * An example with rich constraints.
 */
object Firms {
  private class Firm {
    val efficient = Flip(0.3)
    val bid = If(efficient, continuous.Uniform(5, 15), continuous.Uniform(10, 20))
  }

  private val firms = Array.fill(20)(new Firm)
  private val winner = discrete.Uniform(firms: _*)
  private val winningBid = Chain(winner, (f: Firm) => f.bid)
  winningBid.setConstraint((d: Double) => 20 - d)

  def main(args: Array[String]) {
    val winningEfficiency = Chain(winner, (f: Firm) => f.efficient)
    val alg = Importance(winningEfficiency)
    alg.start()
    Thread.sleep(1000)
    alg.stop()
    println("Probability the winner is efficient: " + alg.probability(winningEfficiency, true))
    alg.kill()
  }
}

3. run the Burglary algorithm
  cd ~/Figaro/FigaroWork
  sbt "runMain Firms"

//-----------------------------
// Smokers: People have some propensity to smoke, and people are likely to have the same smoking habit as their friends.
// Models the likelihood that someone will smoke based on their friends’ smoking habits using a Markov network/Markov random field.
//-----------------------------
/*
 * Smokers.scala
 * A Markov logic example.
 * 
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.language._
import com.cra.figaro.library.compound.^^

/**
 * A Markov logic example.
 */
object Smokers {
  private class Person {
    val smokes = Flip(0.6)
  }

  private val alice, bob, clara = new Person
  private val friends = List((alice, bob), (bob, clara))
  clara.smokes.observe(true)

  // having same smoking habbit is 3 times as likely as a different smoking habit
  private def smokingInfluence(pair: (Boolean, Boolean)) =
    if (pair._1 == pair._2) 3.0; else 1.0

  for { (p1, p2) <- friends } { // apply the constraint to all the friends
    ^^(p1.smokes, p2.smokes).setConstraint(smokingInfluence) // add constraints to their smoking habbit
    // notion ^^ takes each pair and creates the pair element consisting of their smoking habit
  }

  def main(args: Array[String]) {
    val alg = MetropolisHastings(20000, ProposalScheme.default, alice.smokes)
    alg.start()
    println("Probability of Alice smoking: " + alg.probability(alice.smokes, true))
    alg.kill
  }
}

3. run the Burglary algorithm
  cd ~/Figaro/FigaroWork
  sbt "runMain Smokers"



//-----------------------------
// Sources: n two possible sources and a sample that came from one of the sources, and want to determine which
//		source the sample came from based on the strength of the match
//		with each source.
// Sources – Models the distance between a point and its source using dependent universes. 
//-----------------------------
 /*
 * Sources.scala
 * An example of dependent universe reasoning.
 * 
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.example

import com.cra.figaro.algorithm._
import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.algorithm.factored._
import com.cra.figaro.library.compound.{ If, ^^ }
import com.cra.figaro.library.atomic.continuous._
import com.cra.figaro.language._
import com.cra.figaro.util._

/**
 * An example of dependent universe reasoning.
 */
object Sources {
  private class Source(val name: String) {
    override val toString = name
  }

  private abstract class Sample(val name: String) {
    val fromSource: Element[Source] // abstract class because we don't say anything about what source the sample came from

    override val toString = name
  }

  private class Pair(val source: Source, val sample: Sample) { //pair of source and sample
    val universe = new Universe(List(sample.fromSource))
    //produces true if the sample is from the source int the pair
    val isTheRightSource = Apply(sample.fromSource, (s: Source) => s == source)("isTheRightSource", universe) 
    val rightSourceDistance = Normal(0.0, 1.0)("rightSourceDistance", universe)
    val wrongSourceDistance = Uniform(0.0, 10.0)("wrongSourceDistance", universe)
    // measures the closeness of the match between the sample and the source (lower distance means better match).
    val distance = If(isTheRightSource, rightSourceDistance, wrongSourceDistance)("distance", universe)
    // The distance will tend to be smaller if the sample is from the right source but will not always be so.
  }

  private val source1 = new Source("Source 1")
  private val source2 = new Source("Source 2")
  private val source3 = new Source("Source 3")
  private val sample1 = new Sample("Sample 1") { val fromSource = Select(0.5 -> source1, 0.5 -> source2) } // specification to instanciate as it is abstract 
  private val sample2 = new Sample("Sample 2") { val fromSource = Select(0.9 -> source1, 0.1 -> source3) }
  private val pair1 = new Pair(source1, sample1)
  private val pair2 = new Pair(source2, sample1)
  private val pair3 = new Pair(source1, sample2)
  private val pair4 = new Pair(source3, sample2)

  private val values = Values()
  private val samples = List(sample1, sample2)
  for {
    (firstSample, secondSample) <- upperTriangle(samples)
    sources1 = values(firstSample.fromSource)
    sources2 = values(secondSample.fromSource)
    if sources1.intersect(sources2).nonEmpty
  } {
  	// add condition about the distance
    println("First sample: " + firstSample + ", Second sample: " + secondSample)
    ^^(firstSample.fromSource, secondSample.fromSource).addCondition((p: (Source, Source)) => p._1 != p._2)
  }

  def main(args: Array[String]) {
  // The conditions are ranges rather than exact observations because exact observations on continuous elements can be problematic
	//		for many types of inference algorithms.
    val evidence1 = NamedEvidence("distance", Condition((d: Double) => d > 0.5 && d < 0.6))
    val evidence2 = NamedEvidence("distance", Condition((d: Double) => d > 1.5 && d < 1.6))
    val evidence3 = NamedEvidence("distance", Condition((d: Double) => d > 2.5 && d < 2.6))
    val evidence4 = NamedEvidence("distance", Condition((d: Double) => d > 0.5 && d < 0.6))
    val ue1 = (pair1.universe, List(evidence1))
    val ue2 = (pair2.universe, List(evidence2))
    val ue3 = (pair3.universe, List(evidence3))
    val ue4 = (pair4.universe, List(evidence4))
    def peAlg(universe: Universe, evidence: List[NamedEvidence[_]]) = () => ProbEvidenceSampler.computeProbEvidence(100000, evidence)(universe)
    val alg = VariableElimination(List(ue1, ue2, ue3, ue4), peAlg _, sample1.fromSource)
    alg.start()
    val result = alg.probability(sample1.fromSource)(_ == source1)
    println("Probability of Source 1: " + result)
    alg.kill()

  }
}


//----------------------------
// SimpleMovie.scala
// Actor and Movie
// Probabilistic Relational Models (PRM)
// SimpleMovie – Models the likelihood of an actor receiving an award for their appearance in a movie using a Metropolois-Hastings Markov chain Monte Carlo algorithm. 
// There are three classes: actors, movies, and appearances relating actors to movies.
// Whether an actor receives an award for an appearance depends on
// 	(1) the fame of the actor and (2) the quality of the movie. 
//----------------------------
/*
 * SimpleMovie.scala
 * A simple probabilistc relational model example with single-valued attributes.
 * 
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.example

import com.cra.figaro.algorithm.factored._
import com.cra.figaro.library.compound._
import com.cra.figaro.util
import com.cra.figaro.language._
import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.library.atomic.discrete._

/**
 * A simple probabilistc relational model example with single-valued attributes.
 */
object SimpleMovie {
  private val random = new scala.util.Random()

  private class Actor {
    val famous = Flip(0.1)
  }

  private class Movie {
    val quality = Select(0.3 -> 'low, 0.5 -> 'medium, 0.2 -> 'high)
  }

  private class Appearance(val actor: Actor, val movie: Movie) {
    def probAward(quality: Symbol, famous: Boolean) =
      (quality, famous) match {
        case ('low, false) => 0.001
        case ('low, true) => 0.01
        case ('medium, false) => 0.01
        case ('medium, true) => 0.05
        case ('high, false) => 0.05
        case ('high, true) => 0.2
      }
    val award = SwitchingFlip(Apply(movie.quality, actor.famous, (q: Symbol, f: Boolean) => probAward(q, f)))
  }

  private val numActors = 3 // 200
  private val numMovies = 2 // 100
  private val numAppearances = 3 // 300
  private val actor1 = new Actor
  private val actor2 = new Actor
  private val actor3 = new Actor
  private val movie1 = new Movie
  private val movie2 = new Movie
  private val appearance1 = new Appearance(actor1, movie1)
  private val appearance2 = new Appearance(actor2, movie2)
  private val appearance3 = new Appearance(actor3, movie2)
  private val otherActors = Array.fill(numActors - 3)(new Actor)
  private val otherMovies = Array.fill(numMovies - 2)(new Movie)
  private val actors = otherActors ++ Array(actor1, actor2, actor3)
  private val movies = otherMovies ++ Array(movie1, movie2)
  private val otherAppearances =
    Array.fill(numAppearances - 3)(new Appearance(actors(random.nextInt(numActors)), movies(random.nextInt(numMovies))))
  private val appearances = otherAppearances ++ Array(appearance1, appearance2, appearance3)

  // Ensure that exactly one appearance gets an award.
  // counts the number of elements in the list that satisfy the predicate contained in its argument
  // so it counts the number of elements that  b is true
  private def uniqueAwardCondition(awards: List[Boolean]) = awards.count((b: Boolean) => b) == 1
  //element over lists of Booleans consisting of the award field of all the appearances
  // apply function to every element of the list and return a clist consisting of results
  // shorthand for a function of one argument in which the argument appears once in the body and the type of the argument is known
  // here the type of the argument is appearance
  // we could have used appearance => apperance.award
  private val allAwards: Element[List[Boolean]] = Inject(appearances.map(_.award): _*)
  // ensuring exactly one apperance is awarded
  allAwards.setCondition(uniqueAwardCondition)

  // A proposal either proposes to switch the awardee to another awardee or proposes the properties of a movie or
  // an actor.
  private def chooseScheme(): ProposalScheme = {
    DisjointScheme(
      (0.5, () => switchAwards()),
      (0.25, () => ProposalScheme(actors(random.nextInt(numActors)).famous)),
      (0.25, () => ProposalScheme(movies(random.nextInt(numMovies)).quality)))
  }

  /*
   * It's possible that as a result of other attributes changing, an appearance becomes awarded or unawarded.
   * Therefore, we have to take this into account in the proposal scheme.
   */
  private def switchAwards(): ProposalScheme = {
    val (awarded, unawarded) = appearances.partition(_.award.value)
    awarded.length match {
      case 1 =>
        val other = unawarded(random.nextInt(numAppearances - 1))
        ProposalScheme(awarded(0).award, other.award)
      case 0 =>
        ProposalScheme(appearances(random.nextInt(numAppearances)).award) // make something unawarded awarded
      case _ =>
        ProposalScheme(awarded(random.nextInt(awarded.length)).award)
    }
  }

  def main(args: Array[String]): Unit = {
    actor3.famous.observe(true)
    movie2.quality.observe('high)

    // We first make sure the initial state satisfies the unique award condition, and then make sure that all
    // subsequent proposals keep that condition.
    appearances.foreach(_.award.randomness = 0.0)
    appearances(random.nextInt(numAppearances)).award.randomness = 1.0
    appearances.foreach(appearance =>
      appearance.award.value = appearance.award.generateValue(appearance.award.randomness))
    allAwards.generate()

    val alg = MetropolisHastings(200000, chooseScheme, 5000, appearance1.award, appearance2.award, appearance3.award)

    util.timed(alg.start(), "Inference")
    alg.stop()
    println(alg.probability(appearance3.award, true))
    alg.kill()
  }
}


//-------------------------------------------
// Mutable Movie: non functional programming
// MutableMovie – Models the quality of a movie based on the skill of its actors using a non-functional style of programming, mutable variables, and Figaro collections. 
//-------------------------------------------
/*
 * MutableMovie.scala
 * A probabilistic relational model example with multi-valued attributes.
 *
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 *
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 *
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.example

import com.cra.figaro.algorithm.factored._
import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.language._
import com.cra.figaro.library.compound._
import com.cra.figaro.library.collection.Container
import com.cra.figaro.library.atomic.discrete._
import com.cra.figaro.util

/**
 * A probabilistc relational model example with multi-valued attributes.
 */
object MutableMovie {
  private val random = com.cra.figaro.util.random

  private class Actor {
  // var allows mutable, so Actor can be created before movie
    var movies: List[Movie] = List()

    // lazy means the content will not be determined until they are required by some other computation
    // this is necessary because it's content depend on the list of movies the actor appears in
    // e.g. whether the actor is famous depends on whether at least two movies have high quality
    lazy val skillful = Flip(0.1)
    // if it was not lazy, so was ordinary, it's value would have been defined  at the point of definition of Actor (using empty list)
    lazy val qualities = Container(movies.map(_.quality):_*)

    lazy val numGoodMovies = qualities.count(_ == 'high)

    lazy val famous = Chain(numGoodMovies, (n: Int) => if (n >= 2) Flip(0.8) else Flip(0.1))
  }

  private class Movie {
  // actors is a mutable list, so Movie can be created before actor
    var actors: List[Actor] = List()

    lazy val skills = Container(actors.map(_.skillful):_*)

    lazy val actorsAllGood = skills.exists(b => b)

    lazy val probLow = Apply(actorsAllGood, (b: Boolean) => if (b) 0.2; else 0.5)

    lazy val probHigh = Apply(actorsAllGood, (b: Boolean) => if (b) 0.5; else 0.2)

    lazy val quality = Select(probLow -> 'low, Constant(0.3) -> 'medium, probHigh -> 'high)
  }

  private class Appearance(actor: Actor, movie: Movie) {
  // we make sure we add movie to the actor's list of movies and vice versa
    actor.movies ::= movie
    // notiation is short for actor.movies = movie::actor.movies 
    // this appends movie to the current actor movies
    movie.actors ::= actor

    def probAward(quality: Symbol, famous: Boolean) =
      (quality, famous) match {
        case ('low, false) => 0.001
        case ('low, true) => 0.01
        case ('medium, false) => 0.01
        case ('medium, true) => 0.05
        case ('high, false) => 0.05
        case ('high, true) => 0.2
      }
    lazy val award = SwitchingFlip(Apply(movie.quality, actor.famous, (q: Symbol, f: Boolean) => probAward(q, f)))
  }

  private val numActors = 3
  private val numMovies = 3
  private val numAppearances = 4
  private val actor1 = new Actor
  private val actor2 = new Actor
  private val actor3 = new Actor
  private val movie1 = new Movie
  private val movie2 = new Movie
  private val movie3 = new Movie
  private val appearance1 = new Appearance(actor1, movie1)
  private val appearance2 = new Appearance(actor2, movie2)
  private val appearance3 = new Appearance(actor3, movie2)
  private val appearance4 = new Appearance(actor3, movie3)
  private val otherActors = Array.fill(numActors - 3)(new Actor)
  private val otherMovies = Array.fill(numMovies - 3)(new Movie)
  private val actors = otherActors ++ Array(actor1, actor2, actor3)
  private val movies = otherMovies ++ Array(movie1, movie2, movie3)
  private val otherAppearances =
    Array.fill(numAppearances - 4)(new Appearance(actors(random.nextInt(numActors)), movies(random.nextInt(numMovies))))
  private val appearances = otherAppearances ++ Array(appearance1, appearance2, appearance3, appearance4)

  // Ensure that exactly one appearance gets an award.
  private def uniqueAwardCondition(awards: List[Boolean]) = awards.count((b: Boolean) => b) == 1
  private val allAwards: Element[List[Boolean]] = Inject(appearances.map(_.award): _*)
  allAwards.setCondition(uniqueAwardCondition)

  // A proposal either proposes to switch the awardee to another awardee or proposes the properties of a movie or
  // an actor.
  private def chooseScheme(): ProposalScheme = {
    DisjointScheme(
      (0.4, () => switchAwards()),
      (0.2, () => ProposalScheme(actors(random.nextInt(numActors)).skillful)),
      (0.2, () => ProposalScheme(movies(random.nextInt(numMovies)).quality)),
      (0.2, () => ProposalScheme(actors(random.nextInt(numActors)).famous)))
  }

  /*
   * It's possible that as a result of other attributes changing, an appearance becomes awarded or unawarded.
   * Therefore, we have to take this into account in the proposal scheme.
   */
  private def switchAwards(): ProposalScheme = {
    val (awarded, unawarded) = appearances.partition(_.award.value)
    awarded.length match {
      case 1 =>
        val other = unawarded(random.nextInt(numAppearances - 1))
        ProposalScheme(awarded(0).award, other.award)
      case 0 =>
        ProposalScheme(appearances(random.nextInt(numAppearances)).award) // make something unawarded awarded
      case _ =>
        ProposalScheme(awarded(random.nextInt(awarded.length)).award)
    }
  }

  def main(args: Array[String]): Unit = {
  	// when we observe skillfulness then the lazy element will be defined, for the rest it is defined at the time of inference
    actor3.skillful.observe(true)
    movie2.quality.observe('high)

    // We first make sure the initial state satisfies the unique award condition, and then guide all
    // subsequent proposals to keep that condition.
    appearances.foreach(_.award.randomness = 0.0)
    appearances(random.nextInt(numAppearances)).award.randomness = 1.0
    appearances.foreach(appearance =>
      appearance.award.value = appearance.award.generateValue(appearance.award.randomness))
    allAwards.generate()

    val alg = Importance(1000, appearance1.award, appearance2.award, appearance3.award, appearance4.award)
    util.timed(alg.start(), "Inference")
    alg.stop()
    println(alg.probability(appearance1.award, true))
    println(alg.probability(appearance2.award, true))
    println(alg.probability(appearance3.award, true))
    println(alg.probability(appearance4.award, true))
    alg.kill()
  }
}


//------------------------------
// CarAndEngine.scala
// CarAndEngine – Models the speed of a car based on the power of its engine using a probabilistic relational model (PRM). 
// PRM in which we are uncertaint about the value of an attribute whose value is itself an instance of another class (which is called reference uncertainty) 
//------------------------------
/*
 * CarAndEngine.scala
 * A probabilistic relational model example with reference uncertainty.
 * 
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.example

import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.algorithm.factored._
import com.cra.figaro.language._
import com.cra.figaro.library.compound._
import com.cra.figaro.library.atomic.discrete.Uniform
import com.cra.figaro.library.atomic.continuous.Normal

/**
 * A probabilistic relational model example with reference uncertainty.
 */
object CarAndEngine {

  abstract class Engine extends ElementCollection {
    val power: Element[Symbol]
  }

  private class V8 extends Engine {
    val power: Element[Symbol] = Select(0.8 -> 'high, 0.2 -> 'medium)("power", this)
  }

  private class V6 extends Engine {
    val power: Element[Symbol] = Select(0.2 -> 'high, 0.5 -> 'medium, 0.3 -> 'low)("power", this)
  }

  private object MySuperEngine extends V8 {
    override val power: Element[Symbol] = Constant('high)("power", this)
  }

  // car class inherit from ElementCollection (every instance of car is an element collection)
  class Car extends ElementCollection {
  	// the speed of the car depends ont he power of its engine (engine.power)
  	// we are uncertain over what the engine actually is could be either case
  	// engine is Element[Engine] and not instance of Engine, so we can not directly use engine.power
  	// Figaro helps with names and element collections: every element has a name and belongs to an element collection
  	// give the engine a name and make it belong to the car as an element collection
  	// make the abstract Engine class inherit element collections and assign power the name "power" within V8, V6, and MySuperEngine within each subclass of Engine
  	// finally we assign engine the name "engine" and add it to the instance of Car
    val engine = Uniform[Engine](new V8, new V6, MySuperEngine)("engine", this)

    val speed = CPD(
      get[Symbol]("engine.power"),
      'high -> Constant(90.0),
      'medium -> Constant(80.0),
      'low -> Constant(70.0))
  }

  def main(args: Array[String]) {
    val car = new Car
    val alg = VariableElimination(car.speed)
    alg.start()
    alg.stop()
    println(alg.expectation(car.speed)(d => d))
    alg.kill()
  }
}

//-----------------------------
// Spam and Normal email classification
//-----------------------------
/*
 * Dictionary.scala 
 * Book example unit test.
 * 
 * Created By:      Michael Reposa (mreposa@cra.com), Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2016
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.test.book.chap03

import com.cra.figaro.language.Universe
import scala.collection.mutable.Map
import org.scalatest.Matchers
import org.scalatest.WordSpec
import com.cra.figaro.test.tags.BookExample

class Dictionary(initNumEmails: Int) {
  val counts: Map[String, Int] = Map()
  var numEmails = initNumEmails

  def addWord(word: String) {
    counts += word -> (getCount(word) + 1)
  }

  def addEmail(email: Email) {
    numEmails += 1
    for { word <- email.allWords } {
      addWord(word)
    }
  }

  object OrderByCount extends Ordering[String] {
    def compare(a: String, b: String) = getCount(b) - getCount(a)
  }
  def words = counts.keySet.toList.sorted(OrderByCount)

  def nonStopWords = words.dropWhile(counts(_) >= numEmails * Dictionary.stopWordFraction)
  def featureWords = nonStopWords.take(Dictionary.numFeatures)

  def getCount(word: String) =
    counts.getOrElse(word, 0)

  def isUnusual(word: String, learning: Boolean) =
    if (learning) getCount(word) <= 1
    else getCount(word) <= 0
}

object Dictionary {
  def fromEmails(emails: Traversable[Email]) = {
    val result = new Dictionary(0)
    for { email <- emails } { result.addEmail(email) }
    result
  }

  val stopWordFraction = 0.15
  val numFeatures = 100

  def main(args: Array[String]) = {
    val emails = LearningComponent.readEmails("src/test/resources/BookData/Test")
    val dict = Dictionary.fromEmails(emails.map(_._2))
    println("Total number of words: " + dict.words.length)
    println("Number of feature words: " + dict.featureWords.length)
    println("\nAll words and counts:\n")
    println(dict.words.map(word => word + " " + dict.getCount(word)).mkString("\n"))
    println("\nFeature words and counts:\n")
    println("Feature words:\n")
    println(dict.featureWords.map(word => word + " " + dict.getCount(word)).mkString("\n"))
  }
}

class DictionaryTest extends WordSpec with Matchers {
  Universe.createNew()
  val emails = LearningComponent.readEmails("src/test/resources/BookData/Test")
  val dict = Dictionary.fromEmails(emails.map(_._2))

  "Dictionary" should {
    "have a total number of words equal to 12922" taggedAs (BookExample) in {
      dict.words.length should be(12922)
    }
    "have a number of feature words equal to 100" taggedAs (BookExample) in {
      dict.featureWords.length should be(100)
    }
  }
}

/*
 * Email.scala 
 * Book example unit test.
 * 
 * Created By:      Michael Reposa (mreposa@cra.com), Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2016
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.test.book.chap03

import com.cra.figaro.language.Universe
import java.io.File
import scala.io.Source
import org.scalatest.Matchers
import org.scalatest.WordSpec
import com.cra.figaro.test.tags.BookExample

class Email(file: File) {
  def getAllWords() = {
    def getWords(line: String): List[String] = {
      for {
        rawWord <- line.split(Array(' ', '\t', '\n')).toList
        word = rawWord.filter((c: Char) => c.isLetterOrDigit)
        if !word.isEmpty
      } yield word.toLowerCase()
    }

    val source = Source.fromFile(file)("ISO-8859-1")
    val allLines = source.getLines().toList

    val allWordsWithRepeats =
      for {
        line <- allLines
        word <- getWords(line)
      } yield word

    allWordsWithRepeats.toSet
  }

  val allWords: Set[String] = getAllWords()

  def observeEvidence(model: Model, label: Option[Boolean], learning: Boolean) {
    label match {
      case Some(b) => model.isSpam.observe(b)
      case None => ()
    }

    for {
      (word, element) <- model.hasWordElements
    } {
      element.observe(allWords.contains(word))
    }

    val obsNumUnusualWords =
      allWords.filter((word: String) => model.dictionary.isUnusual(word, learning)).size
    val unusualWordFraction = obsNumUnusualWords * Model.binomialNumTrials / allWords.size
    model.numUnusualWords.observe(unusualWordFraction)
  }
}

object Email {
  def main(args: Array[String]) {
    val email = new Email(new File("src/test/resources/BookData/Test/TestEmail_9.txt"))
    println(email.allWords)
  }
}

class EmailTest extends WordSpec with Matchers {
  Universe.createNew()
  val email = new Email(new File("src/test/resources/BookData/Test/TestEmail_9.txt"))

  "Email" should {
    "have a total number of words equal to 358" taggedAs (BookExample) in {
      email.allWords.size should be(358)
    }
  }
}

/*
 * Evaluator.scala 
 * Book example unit test.
 * 
 * Created By:      Michael Reposa (mreposa@cra.com), Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2016
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.test.book.chap03

import com.cra.figaro.language.Universe
import org.scalatest.Matchers
import org.scalatest.WordSpec
import com.cra.figaro.test.tags.BookExample

object Evaluator {
  def main(args: Array[String]) = {
    val testDirectoryName = "src/test/resources/BookData/Test"
    val labelFileName = "src/test/resources/BookData/Labels.txt"
    val kbFileName = "src/test/resources/BookData/LearnedModel.txt"
    val threshold = 0.5

    val emails = LearningComponent.readEmails(testDirectoryName)
    val labels = LearningComponent.readLabels(labelFileName)
    val (dictionary, learningResults) = ReasoningComponent.loadResults(kbFileName)

    var truePositives = 0
    var falseNegatives = 0
    var falsePositives = 0
    var trueNegatives = 0

    for { (fileName, email) <- emails } {
      println(fileName)
      Universe.createNew()
      val isSpamProbability = ReasoningComponent.classify(dictionary, learningResults, testDirectoryName + "/" + fileName)
      val prediction = isSpamProbability >= threshold
      (labels.get(fileName), prediction) match {
        case (Some(true), true) => truePositives += 1
        case (Some(true), false) => falseNegatives += 1
        case (Some(false), true) => falsePositives += 1
        case (Some(false), false) => trueNegatives += 1
        case _ => ()
      }
    }

    val accuracy = (truePositives + trueNegatives).toDouble / (truePositives + falseNegatives + falsePositives + trueNegatives)
    val precision = truePositives.toDouble / (truePositives + falsePositives)
    val recall = truePositives.toDouble / (truePositives + falseNegatives)

    println("True positives: " + truePositives)
    println("False negatives: " + falseNegatives)
    println("False positives: " + falsePositives)
    println("True negatives: " + trueNegatives)
    println("Threshold: " + threshold)
    println("Accuracy: " + accuracy)
    println("Precision: " + precision)
    println("Recall: " + recall)
  }
}

class EvaluatorTest extends WordSpec with Matchers {
  Universe.createNew()
  val testDirectoryName = "src/test/resources/BookData/Test"
  val labelFileName = "src/test/resources/BookData/Labels.txt"
  val kbFileName = "src/test/resources/BookData/LearnedModel.txt"
  val threshold = 0.5
  
  val emails = LearningComponent.readEmails(testDirectoryName)
  val labels = LearningComponent.readLabels(labelFileName)
  val (dictionary, learningResults) = ReasoningComponent.loadResults(kbFileName)
  
  var truePositives = 0
  var falseNegatives = 0
  var falsePositives = 0
  var trueNegatives = 0
  
  for { (fileName, email) <- emails } {
    Universe.createNew()
    val isSpamProbability = ReasoningComponent.classify(dictionary, learningResults, testDirectoryName + "/" + fileName)
    val prediction = isSpamProbability >= threshold
    (labels.get(fileName), prediction) match {
      case (Some(true), true) => truePositives += 1
      case (Some(true), false) => falseNegatives += 1
      case (Some(false), true) => falsePositives += 1
      case (Some(false), false) => trueNegatives += 1
      case _ => ()
    }
  }
  val accuracy = (truePositives + trueNegatives).toDouble / (truePositives + falseNegatives + falsePositives + trueNegatives)
  val precision = truePositives.toDouble / (truePositives + falsePositives)
  val recall = truePositives.toDouble / (truePositives + falseNegatives)

  "Evaluator" should {
    "have true positives equal to 39" taggedAs (BookExample) in {
      truePositives should be(39)
    }
    "have false negatives equal to 0" taggedAs (BookExample) in {
      falseNegatives should be(0)
    }
    "have false positives equal to 0" taggedAs (BookExample) in {    
      falsePositives should be(0)
    }
    "have true negatives equal to 61" taggedAs (BookExample) in {
      trueNegatives should be(61)
    }
    "have an accuracy equal to 1.0" taggedAs (BookExample) in {    
      accuracy should be(1.0)
    }
    "have a precision equal to 1.0" taggedAs (BookExample) in {    
      precision should be(1.0)
    }
    "have a recall equal to 1.0" taggedAs (BookExample) in {    
      recall should be(1.0)
    }
  }
}

/*
 * LearningComponent.scala 
 * Book example unit test.
 * 
 * Created By:      Michael Reposa (mreposa@cra.com), Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2016
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.test.book.chap03

import java.nio.file.{Files,Paths,Path}
import java.io._
import scala.io.Source
import com.cra.figaro.language.{Universe, Constant}
import com.cra.figaro.library.atomic.continuous.{Beta, AtomicBeta}
import com.cra.figaro.algorithm.learning._
import org.scalatest.Matchers
import org.scalatest.WordSpec
import com.cra.figaro.test.tags.BookExample

// MXR (10-MAR-2016):
//  Some println statements commented out to minimize testing output
// MXR (11-MAR-2016):
//  Calls to saveResults() were commented out to preserve the integrity
//  of the LearnedModels.txt file, which is used by other tests.
object LearningComponent {

  def readEmails(directoryName: String): Map[String, Email] = {
    val directory = Paths.get(directoryName)
    val directoryIterator = Files.newDirectoryStream(directory).iterator()

    var result: Map[String, Email] = Map()
    while (directoryIterator.hasNext()) {
      val nextFile = directoryIterator.next().toFile()
      val fileName = nextFile.getName
      // println("Reading " + fileName)
      result += fileName ->  new Email(nextFile)
    }
    result
  }

  def readLabels(labelFileName: String): Map[String, Boolean] = {
    val source = Source.fromFile(labelFileName)
    var result: Map[String, Boolean] = Map()
    for {
      line <- source.getLines()
    } {
      val parts = line.split(' ')
      val isSpam = parts(0) == "1"
      val emailFileName = parts(1)
      result += emailFileName -> isSpam
    }
    result
  }

  def learnMAP(params: PriorParameters): LearnedParameters = {
println("Beginning training")
println("Number of elements: " + Universe.universe.activeElements.length)
    val algorithm = EMWithBP(params.fullParameterList:_*)
val time0 = System.currentTimeMillis()
    algorithm.start()
val time1 = System.currentTimeMillis()
println("Training time: " + ((time1 - time0) / 1000.0))
    val spamProbability = params.spamProbability.MAPValue
    val hasUnusualWordsGivenSpamProbability = params.hasManyUnusualWordsGivenSpamProbability.MAPValue
    val hasUnusualWordsGivenNormalProbability = params.hasManyUnusualWordsGivenNormalProbability.MAPValue
    val unusualWordGivenHasUnusualProbability = params.unusualWordGivenManyProbability.MAPValue
    val unusualWordGivenNotHasUnusualProbability = params.unusualWordGivenFewProbability.MAPValue
    val wordGivenSpamProbabilities =
      for { (word, param) <- params.wordGivenSpamProbabilities }
      yield (word, param.MAPValue)
    val wordGivenNormalProbabilities =
      for { (word, param) <- params.wordGivenNormalProbabilities }
      yield (word, param.MAPValue)
    algorithm.kill()
    new LearnedParameters(
      spamProbability,
      hasUnusualWordsGivenSpamProbability,
      hasUnusualWordsGivenNormalProbability,
      unusualWordGivenHasUnusualProbability,
      unusualWordGivenNotHasUnusualProbability,
      wordGivenSpamProbabilities.toMap,
      wordGivenNormalProbabilities.toMap
    )
  }

  def saveResults(
      fileName: String,
      dictionary: Dictionary,
      learningResults: LearnedParameters
   ) = {
    val file = new File(fileName)
    val output = new PrintWriter(new BufferedWriter(new FileWriter(file)))

    output.println(dictionary.numEmails)
    output.println(learningResults.spamProbability)
    output.println(learningResults.hasManyUnusualWordsGivenSpamProbability)
    output.println(learningResults.hasManyUnusualWordsGivenNormalProbability)
    output.println(learningResults.unusualWordGivenManyProbability)
    output.println(learningResults.unusualWordGivenFewProbability)
    output.println(dictionary.words.length)
    output.println(dictionary.featureWords.length)

    for {
      word <- dictionary.words
    } {
      output.println(word)
      output.println(dictionary.getCount(word))
    }

    for {
      word <- dictionary.featureWords
    } {
      output.println(word)
      output.println(learningResults.wordGivenSpamProbabilities(word))
      output.println(learningResults.wordGivenNormalProbabilities(word))
    }

    output.close()
  }

  def main(args: Array[String]) {
    val trainingDirectoryName = "src/test/resources/BookData/Training"
    val labelFileName = "src/test/resources/BookData/Labels.txt"
    val learningFileName = "src/test/resources/BookData/LearnedModel.txt"

    val emails = readEmails(trainingDirectoryName)
    val labels = readLabels(labelFileName)
    val dictionary = Dictionary.fromEmails(emails.values)

    val params = new PriorParameters(dictionary)
    val models =
      for { (fileName, email) <- emails }
      yield {
        val model = new LearningModel(dictionary, params)
        email.observeEvidence(model, labels.get(fileName), true)
        model
      }

    val results = learnMAP(params)
    // saveResults(learningFileName, dictionary, results)
    println("Done!")
  }
}

class LearningComponentTest extends WordSpec with Matchers {
  Universe.createNew()
  val trainingDirectoryName = "src/test/resources/BookData/Training"
  val labelFileName = "src/test/resources/BookData/Labels.txt"
  val learningFileName = "src/test/resources/BookData/LearnedModel.txt"

  "Learning Component" should {
    "produce the correct results" taggedAs (BookExample) in {
      val emails = LearningComponent.readEmails(trainingDirectoryName)
      val labels = LearningComponent.readLabels(labelFileName)
      val dictionary = Dictionary.fromEmails(emails.values)
    
      val params = new PriorParameters(dictionary)
      val models =
        for { (fileName, email) <- emails }
        yield {
          val model = new LearningModel(dictionary, params)
          email.observeEvidence(model, labels.get(fileName), true)
          model
        }
    
      val results = LearningComponent.learnMAP(params)
      results should not be(null)
      // LearningComponent.saveResults(learningFileName, dictionary, results)
    }
  }
}


/*
 * Model.scala 
 * Book example unit test support file.
 * 
 * Created By:      Michael Reposa (mreposa@cra.com), Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2016
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.test.book.chap03

import com.cra.figaro.language.{Element, Constant, Flip, Universe}
import com.cra.figaro.library.compound.If
import com.cra.figaro.library.atomic.continuous.{Beta, AtomicBeta}
import com.cra.figaro.library.atomic.discrete.Binomial
import com.cra.figaro.algorithm.ProbQueryAlgorithm
import scala.collection.Map

class PriorParameters(dictionary: Dictionary) {
    val spamProbability = Beta(2,3)
    val wordGivenSpamProbabilities = dictionary.featureWords.map(word => (word, Beta(2,2)))
    val wordGivenNormalProbabilities = dictionary.featureWords.map(word => (word, Beta(2,2)))
    val hasManyUnusualWordsGivenSpamProbability = Beta(2,2)
    val hasManyUnusualWordsGivenNormalProbability = Beta(2, 21)
    val unusualWordGivenManyProbability = Beta(2,2)
    val unusualWordGivenFewProbability = Beta(2,7)
    val fullParameterList =
      spamProbability ::
      hasManyUnusualWordsGivenSpamProbability ::
      hasManyUnusualWordsGivenNormalProbability ::
      unusualWordGivenManyProbability ::
      unusualWordGivenFewProbability ::
      wordGivenSpamProbabilities.map(pair => pair._2) :::
      wordGivenNormalProbabilities.map(pair => pair._2)
  }

class LearnedParameters(
  val spamProbability: Double,
  val hasManyUnusualWordsGivenSpamProbability: Double,
  val hasManyUnusualWordsGivenNormalProbability: Double,
  val unusualWordGivenManyProbability: Double,
  val unusualWordGivenFewProbability: Double,
  val wordGivenSpamProbabilities: Map[String, Double],
  val wordGivenNormalProbabilities: Map[String, Double]
)

abstract class Model(val dictionary: Dictionary) {
  val isSpam: Element[Boolean]

  val hasWordElements: List[(String, Element[Boolean])]

  val hasManyUnusualWords: Element[Boolean]

  val numUnusualWords: Element[Int]
}

class LearningModel(dictionary: Dictionary, parameters: PriorParameters) extends Model(dictionary) {
  val isSpam = Flip(parameters.spamProbability)

  val hasWordElements = {
    val wordGivenSpamMap = Map(parameters.wordGivenSpamProbabilities:_*)
    val wordGivenNormalMap = Map(parameters.wordGivenNormalProbabilities:_*)
    for { word <- dictionary.featureWords } yield {
      val givenSpamProbability = wordGivenSpamMap(word)
      val givenNormalProbability = wordGivenNormalMap(word)
      val hasWordIfSpam = Flip(givenSpamProbability)
      val hasWordIfNormal = Flip(givenNormalProbability)
      (word, If(isSpam, hasWordIfSpam, hasWordIfNormal))
    }
  }

  val hasManyUnusualIfSpam = Flip(parameters.hasManyUnusualWordsGivenSpamProbability)
  val hasManyUnusualIfNormal = Flip(parameters.hasManyUnusualWordsGivenNormalProbability)
  val hasManyUnusualWords = If(isSpam, hasManyUnusualIfSpam, hasManyUnusualIfNormal)

  val numUnusualIfHasMany = Binomial(Model.binomialNumTrials, parameters.unusualWordGivenManyProbability)
  val numUnusualIfHasFew = Binomial(Model.binomialNumTrials, parameters.unusualWordGivenFewProbability)
  val numUnusualWords = If(hasManyUnusualWords, numUnusualIfHasMany, numUnusualIfHasFew)
}

class ReasoningModel(dictionary: Dictionary, parameters: LearnedParameters) extends Model(dictionary) {
  val isSpam = Flip(parameters.spamProbability)

  val hasWordElements = {
    for { word <- dictionary.featureWords } yield {
      val givenSpamProbability = parameters.wordGivenSpamProbabilities(word)
      val givenNormalProbability = parameters.wordGivenNormalProbabilities(word)
      val hasWordIfSpam = Flip(givenSpamProbability)
      val hasWordIfNormal = Flip(givenNormalProbability)
      (word, If(isSpam, hasWordIfSpam, hasWordIfNormal))
    }
  }

  val hasManyUnusualIfSpam = Flip(parameters.hasManyUnusualWordsGivenSpamProbability)
  val hasManyUnusualIfNormal = Flip(parameters.hasManyUnusualWordsGivenNormalProbability)
  val hasManyUnusualWords = If(isSpam, hasManyUnusualIfSpam, hasManyUnusualIfNormal)

  val numUnusualIfHasMany = Binomial(Model.binomialNumTrials, parameters.unusualWordGivenManyProbability)
  val numUnusualIfHasFew = Binomial(Model.binomialNumTrials, parameters.unusualWordGivenFewProbability)
  val numUnusualWords = If(hasManyUnusualWords, numUnusualIfHasMany, numUnusualIfHasFew)
}

object Model {
  val binomialNumTrials = 20
}

/*
 * ReasoningComponent.scala 
 * Book example unit test.
 * 
 * Created By:      Michael Reposa (mreposa@cra.com), Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2016
 * 
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 * 
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.test.book.chap03

import scala.io.Source
import java.io.File
import com.cra.figaro.language.{Constant, Element, Universe}
import com.cra.figaro.algorithm.sampling.Importance
import com.cra.figaro.algorithm.factored.VariableElimination
import com.cra.figaro.algorithm.factored.beliefpropagation.BeliefPropagation
import org.scalatest.Matchers
import org.scalatest.WordSpec
import com.cra.figaro.test.tags.BookExample

// MXR (10-MAR-2016): some println statements commented out to minimize testing output
object ReasoningComponent {
  def loadResults(fileName: String) = {
    val source = Source.fromFile(fileName)
    val lines = source.getLines().toList
    val (numEmailsLine :: spamLine :: hasManyUnusualWordsGivenSpamLine :: hasManyUnusualWordsGivenNormalLine ::
        unusualWordGivenManyLine :: unusualWordGivenFewLine :: numWordsLine :: numFeatureWordsLine :: rest) = lines
    val numEmails = numEmailsLine.toInt
    val spamProbability = spamLine.toDouble
    val hasUnusualWordsGivenSpamProbability = hasManyUnusualWordsGivenSpamLine.toDouble
    val hasUnusualWordsGivenNormalProbability = hasManyUnusualWordsGivenNormalLine.toDouble
    val unusualWordGivenHasUnusualProbability = unusualWordGivenManyLine.toDouble
    val unusualWordGivenNotHasUnusualProbability = unusualWordGivenFewLine.toDouble
    val numWords = numWordsLine.toInt
    val numFeatureWords = numFeatureWordsLine.toInt

    var linesRemaining = rest
    var wordsGivenSpamProbabilities = Map[String, Double]()
    var wordsGivenNormalProbabilities = Map[String, Double]()
    var wordsAndCounts = List[(String, Int)]()

    for { i <- 0 until numWords } {
      val word :: countLine :: rest = linesRemaining
      linesRemaining = rest
      wordsAndCounts ::= (word, countLine.toInt)
    }

    for { i <- 0 until numFeatureWords } {
      val word :: givenSpamLine :: givenNormalLine :: rest = linesRemaining
      linesRemaining = rest
      wordsGivenSpamProbabilities += word -> givenSpamLine.toDouble
      wordsGivenNormalProbabilities += word -> givenNormalLine.toDouble
    }

    val dictionary = new Dictionary(numEmails)
    for {
      (word, count) <- wordsAndCounts
      i <- 0 until count
    } {
      dictionary.addWord(word)
    }

    val params = new LearnedParameters(
      spamProbability,
      hasUnusualWordsGivenSpamProbability,
      hasUnusualWordsGivenNormalProbability,
      unusualWordGivenHasUnusualProbability,
      unusualWordGivenNotHasUnusualProbability,
      wordsGivenSpamProbabilities,
      wordsGivenNormalProbabilities
    )
    (dictionary, params)
  }

  def classify(dictionary: Dictionary, parameters: LearnedParameters, fileName: String) = {
    val file = new File(fileName)
    val email = new Email(file)
    val model = new ReasoningModel(dictionary, parameters)
    email.observeEvidence(model, None, false)
    val algorithm = VariableElimination(model.isSpam)
    algorithm.start()
    val isSpamProbability = algorithm.probability(model.isSpam, true)
    // println("Spam probability: " + isSpamProbability)
    algorithm.kill()
    isSpamProbability
  }

  def main(args: Array[String]) {
    val emailFileName = "src/test/resources/BookData/Test/TestEmail_9.txt"
    val learningFileName = "src/test/resources/BookData/LearnedModel.txt"
    val (dictionary, parameters) = loadResults(learningFileName)
    classify(dictionary, parameters, emailFileName)
    println("Done!")
  }
}

class ReasoningComponentTest extends WordSpec with Matchers {
  Universe.createNew()
  val emailFileName = "src/test/resources/BookData/Test/TestEmail_9.txt"
  val learningFileName = "src/test/resources/BookData/LearnedModel.txt"
  
  "Reasoning Component" should {
    "produce a spam probability of 0.999999999632511" taggedAs (BookExample) in {
      val (dictionary, parameters) = ReasoningComponent.loadResults(learningFileName)
      val isSpamProbability = ReasoningComponent.classify(dictionary, parameters, emailFileName)
      isSpamProbability should be(0.999999999632511)
    }
  }
}

//------------------------------------------------------------
MultiValuedReferenceUncertainty – Models the sum over a container of integers using multi-valued references and aggregates. 
//------------------------------------------------------------
/*
 * MultiValuedReferenceUncertainty.scala
 * A simple model example with multi-valued reference uncertainty and aggregates.
 *
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Jan 1, 2009
 *
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 *
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.example

import com.cra.figaro.algorithm.factored._
import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.language._
import com.cra.figaro.library.compound._
import com.cra.figaro.util.MultiSet

/**
 * A simple model example with multi-valued reference uncertainty and aggregates.
 */
object MultiValuedReferenceUncertainty {

	// create Component class with element named "f"
  class Component extends ElementCollection {
    val f = Select(0.2 -> 2, 0.3 -> 3, 0.5 -> 5)("f", this)
  }

  // two specific instances of Component
  val specialComponent1 = new Component
  val specialComponent2 = new Component

  // define makeComponent function that either produces one of the specific instances or a new instance of Component that is distinct from all other instances
  def makeComponent() = Select(0.1 -> specialComponent1, 0.2 -> specialComponent2, 0.7 -> new Component)

  //  Container class contains components
  // the contained components are a list that has either one or two components, each produced by makeComponent
  // then we create a sum component that aggregates the values of all elements referred to by "components.f"
  // 	this will include the value of elements named "f" in all the values of the element named "components"
  class Container extends ElementCollection {
    val components = MakeList(Select(0.5 -> 1, 0.5 -> 2), makeComponent)("components", this)

    val sum = getAggregate((xs: MultiSet[Int]) => (0 /: xs)(_ + _))("components.f")
  }
  // mutli-valued references have "set semantics"
  // if the same element appears more than once as the target of the reference, it only contributes one value to the aggregate
  // so if the component list has two components, both of which are specialComponent1 (with value 2) and the value of the aggregate will be 2, not 4
  // But if two different target elements both have the same value, both values contribute to the aggregate (e.g. specialComponent1, special Component2)
  //		both with values equal to 2, the value of aggregte is 4

  def main(args: Array[String]): Unit = {
    val c = new Container
    val alg = Importance(100000, c.sum)
    alg.start()
    println(alg.distribution(c.sum).toList)
    alg.kill
  }
}

//------------------------------
LazyList – Models the likelihood that an infinite list of symbols contains a particular symbol using lazy variable elimination. 
//------------------------------
/*
 * LazyList.scala
 * A lazy list.
 *
 * Created By:      Avi Pfeffer (apfeffer@cra.com)
 * Creation Date:   Feb 26, 2014
 *
 * Copyright 2013 Avrom J. Pfeffer and Charles River Analytics, Inc.
 * See http://www.cra.com or email figaro@cra.com for information.
 *
 * See http://www.github.com/p2t2/figaro for a copy of the software license.
 */

package com.cra.figaro.example

import com.cra.figaro.language._
import com.cra.figaro.library.compound.If
import com.cra.figaro.algorithm.lazyfactored.LazyVariableElimination
import com.cra.figaro.algorithm.lazyfactored.LazyValues

object LazyList {
  val universe = Universe.createNew()

  class L
  case object Empty extends L
  case class Cons(head: Element[Symbol], tail: Element[L]) extends L

  def contains(target: Symbol, el: Element[L]): Element[Boolean] = {
    Chain(el, (l: L) => {
      l match {
        case Empty => Constant(false)
        case Cons(head, tail) => If(head === target, Constant(true), contains(target, tail))
      }
    })
  }

  def generate(): Element[L] = {
    Apply(Flip(0.5), (b: Boolean) => if (b) Empty; else Cons(Select(0.6 -> 'a, 0.4 -> 'b), generate()))
  }

  def main(args: Array[String]) {

    val el = generate()
    val cb = contains('b, el)
    val ca = contains('a, el)
    ca.observe(true)
    val alg = new LazyVariableElimination(cb)

    println("DEPTH " + 1)
    alg.start()
    println(alg.currentResult.toReadableString)
    for { i <- 2 to 20 } {
      println("DEPTH " + i)
      alg.pump()
      println(alg.currentResult.toReadableString)
    }
    println("Correct probability of true is " + (3.0 / 7.0))
  }
}

































//------------------------------
// Annealing Smokers
//  Models the likelihood that someone will smoke, based on their friends’ smoking habits, using a simulated annealing algorithm. 
//------------------------------
// Constraints are also useful for expressing undirected models such
// as relational Markov networks or Markov logic networks. To illustrate,
// we will use a version of the friends and smokers example. This
// example involves a number of people and their smoking habits. People
// have some propensity to smoke, and people are likely to have the
// same smoking habit as their friends.
// function takes pair of boolean and returns 3.0 if they are the same, and 1.0 if different: 
//		compare smoking habit of two friends and say same smoking habit three times likely than different smoking habbit
// Iterates through all pairs of people in the friend list and executes "do something" for each pair
//    do something is add constraint on smoking habits to the pair of friends

import com.cra.figaro.language.Flip
import com.cra.figaro.library.compound.^^
class Person {
	val smokes = Flip(0.6)
}
val alice, bob, clara = new Person
val friends = List((alice, bob), (bob, clara))
clara.smokes.observe(true)
def smokingInfluence(pair: (Boolean, Boolean)) =
	if (pair._1 == pair._2) 3.0; else 1.0
	for { (p1, p2) <- friends } {
	^^(p1.smokes, p2.smokes).setConstraint(smokingInfluence)
}






//======================================
// An example of PGM in Java
//=====================================
// Define the greetings
class HelloWorldJava {
  static String greeting1 = "Hello, world!";
  static String greeting2 = "Howdy, universe!";
  static String greeting3 = "Oh no, not again";
￼￼static Double pSunnyToday = 0.2;
// Specify the numerical parameters of the model
	static Double pNotSunnyToday = 0.8;
	static Double pSunnyTomorrowIfSunnyToday = 0.8;
	static Double pNotSunnyTomorrowIfSunnyToday = 0.2;
	static Double pSunnyTomorrowIfNotSunnyToday = 0.05;
	static Double pNotSunnyTomorrowIfNotSunnyToday = 0.95;
	static Double pGreeting1TodayIfSunnyToday = 0.6;
	static Double pGreeting2TodayIfSunnyToday = 0.4;
	static Double pGreeting1TodayIfNotSunnyToday = 0.2;
	static Double pGreeting3IfNotSunnyToday = 0.8;
	static Double pGreeting1TomorrowIfSunnyTomorrow = 0.5;
	static Double pGreeting2TomorrowIfSunnyTomorrow = 0.5;
	static Double pGreeting1TomorrowIfNotSunnyTomorrow = 0.1;
	static Double pGreeting3TomorrowIfNotSunnyTomorrow = 0.95;
	static void predict() {
   Double pGreeting1Today =
// Predict today’s greeting using the rules of probabilistic inference
       pSunnyToday * pGreeting1TodayIfSunnyToday +
       pNotSunnyToday * pGreeting1TodayIfNotSunnyToday;
	System.out.println("Today's greeting is " + greeting1 +
	   "with probability " + pGreeting1Today + ".");
}
// Infer today’s weather given the observation that today’s greeting is “Hello, world!” using the rules of probabilistic inference
static void infer() {
   Double pSunnyTodayAndGreeting1Today =
          pSunnyToday * pGreeting1TodayIfSunnyToday;
   Double pNotSunnyTodayAndGreeting1Today =
          pNotSunnyToday * pGreeting1TodayIfNotSunnyToday;
   Double pSunnyTodayGivenGreeting1Today =
          pSunnyTodayAndGreeting1Today /
          (pSunnyTodayAndGreeting1Today +
           pNotSunnyTodayAndGreeting1Today);
   System.out.println("If today's greeting is " + greeting1 +
       ", today's weather is sunny with probability " +
       pSunnyTodayGivenGreeting1Today + ".");
}
// Learn from observing that today’s greeting is “Hello, world!” to predict tomorrow’s greeting using the rules of probabilistic inference
static void learnAndPredict() {
   Double pSunnyTodayAndGreeting1Today =
          pSunnyToday * pGreeting1TodayIfSunnyToday;
   Double pNotSunnyTodayAndGreeting1Today =
          pNotSunnyToday * pGreeting1TodayIfNotSunnyToday;
   Double pSunnyTodayGivenGreeting1Today =
          pSunnyTodayAndGreeting1Today /
          (pSunnyTodayAndGreeting1Today +
               pNotSunnyTodayAndGreeting1Today);
   Double pNotSunnyTodayGivenGreeting1Today =
          1 - pSunnyTodayGivenGreeting1Today;
   Double pSunnyTomorrowGivenGreeting1Today =
          pSunnyTodayGivenGreeting1Today *
               pSunnyTomorrowIfSunnyToday +
          pNotSunnyTodayGivenGreeting1Today *
               pSunnyTomorrowIfNotSunnyToday;
   Double pNotSunnyTomorrowGivenGreeting1Today =
          1 - pSunnyTomorrowGivenGreeting1Today;
   Double pGreeting1TomorrowGivenGreeting1Today =
          pSunnyTomorrowGivenGreeting1Today *
               pGreeting1TomorrowIfSunnyTomorrow +
          pNotSunnyTomorrowGivenGreeting1Today *
               pGreeting1TomorrowIfNotSunnyTomorrow;
   System.out.println("If today's greeting is " + greeting1 +
￼", tomorrow's greeting will be " + greeting1 +
	" with probability " +
	pGreeting1TomorrowGivenGreeting1Today);
	}
// Main method that performs all the tasks
  public static void main(String[] args) {
    predict();
    infer();
    learnAndPredict();
} }

Scala Cheat Sheet
------------------------
PACKAGE
Java style:
package com.mycompany.mypkg
applies across the entire file scope
Package "scoping" approach: curly brace delimited
package com
{
package mycompany
{
package scala
{
package demo
{
object HelloWorld
{
import java.math.BigInteger
// just to show nested importing
def main(args : Array[String]) :
Unit =
{ Console.println("Hello there!")
}
}
}
}
}
}

IMPORT
import p._ // imports all members of p
// (this is analogous to import p.* in Java)
import p.x // the member x of p
import p.{x => a} // the member x of p renamed
// as a
import p.{x, y} // the members x and y of p
import p1.p2.z // the member z of p2,
// itself member of p1
import p1._, p2._ // is a shorthand for import
// p1._; import p2._
implicit imports:
the package java.lang
the package scala
and the object scala.Predef
Import anywhere inside the client Scala file, not just
at the top of the file, for scoped relevance, see
example in Package section.
VARIABLE
var var_name: type = init_value;
eg. var i : int = 0;
default values:
private var myvar: T = _ // "_" is a default
value
scala.Unit is similar to void in Java, except
Unit can be assigned the () value.
unnamed2: Unit = ()
default values:
0 for numeric types
false for the Boolean type
() for the Unit type
null for all object types
CONSTANT
Prefer val over var.
form: val var_name: type = init_value;
val i : int = 0;
STATIC
No static members, use Singleton, see Object
CLASS
Every class inherits from scala.Any
2 subclass categories:
scala.AnyVal (maps to java.lang.Object)
scala.AnyRef
form: abstract class(pName: PType1,
pName2: PType2...) extends SuperClass
with optional constructor in the class definition:
class Person(name: String, age: int) extends
Mammal {
// secondary constructor
def this(name: String) {
// calls to the "primary" constructor
this(name, 1);
}
// members here
}
predefined function classOf[T] returns Scala
class type T
OBJECT
A concrete class instance and is a singleton.
object RunRational extends Application
{
// members here
}
MIXIN CLASS COMPOSITION
Mixin:
trait RichIterator extends AbsIterator {
def foreach(f: T => Unit) {
while (hasNext) f(next)
}
}
Mixin Class Composition:
The first parent is called the superclass of Iter,
whereas the second (and every other, if present)
parent is called a mixin.
object StringIteratorTest {
def main(args: Array[String]) {
class Iter extends StringIterator(args(0))
with RichIterator
val iter = new Iter
iter foreach println
}
}
note the keyword "with" used to create a mixin
composition of the parents StringIterator and
RichIterator.
TRAITS
Like Java interfaces, defines object types by
specifying method signatures, can be partially
implemented. See example in Mixin.
GENERIC CLASS
class Stack[T] {
// members here
}
Usage:
object GenericsTest extends Application {
val stack = new Stack[Int]
// do stuff here
}
note: can also define generic methods
INNER CLASS
example:
class Graph {
class Node {
var connectedNodes: List[Node] = Nil
def connectTo(node: Node) {
if
(connectedNodes.find(node.equals).isEmpty) {
connectedNodes = node :: connectedNodes
}
}
}
// members here
}
usage:
object GraphTest extends Application {
val g: Graph = new Graph
val n1: g.Node = g.newNode
val n2: g.Node = g.newNode
n1.connectTo(n2) // legal
val h: Graph = new Graph
val n3: h.Node = h.newNode
n1.connectTo(n3) // illegal!
}
Inner classes are bound to the outer object, so a
node type is prefixed with its outer instance and
can't mix instances.
CASE CLASSES
See http://www.scala-lang.org/node/107 for info.
METHODS/FUNCTIONS
Methods are Functional Values and Functions are
Objects
form: def name(pName: PType1, pName2:
PType2...) : RetType
use override to override a method
override def toString() = "" + re + (if (im <
0) "" else "+") + im + "i"
Can override for different return type.
“=>” separates the function's argument list from its
body
def re = real // method without arguments
Anonymous:
(function params) | rt. arrow | function body
(x : int, y : int) => x + y
OPERATORS
All operators are functions on a class.
Have fixed precedences and associativities:
(all letters)
|
^
&
< >
= !
:
+ -
/ %
*
(all other special characters)
Operators are usually left-associative, i.e. x + y + z
is interpreted as (x + y) + z,
except operators ending in colon ':' are treated as
right-associative.
An example is the list-consing operator “::”. where,
x :: y :: zs is interpreted as x :: (y ::
zs).
eg.
def + (other: Complex) : Complex = {
//....
}
Infix Operator:
Any single parameter method can be used :
System exit 0
Thread sleep 10
unary operators - prefix the operator name with
"unary_"
def unary_~ : Rational = new Rational(denom,
numer)
The Scala compiler will try to infer some meaning
out of the "operators" that have some
predetermined meaning, such as the += operator.
ARRAYS
arrays are classes
Array[T]
access as function:
a(i)
parameterize with a type
val hellos = new Array[String](3)
MAIN
def main(args: Array[String])
return type is Unit
ANNOTATIONS
See http://www.scala-lang.org/node/106
ASSIGNMENT
=
protected var x = 0
<-
val x <- xs is a generator which produces a
sequence of values
SELECTION
The else must be present and must result in the
same kind of value that the if block does
val filename =
if (options.contains("configFile"))
options.get("configFile")
else
"default.properties"
ITERATION
Prefer recursion over looping.
while loop: similar to Java
for loop:
// to is a method in Int that produces a Range
object
for (i <- 1 to 10; i % 2 == 0) // the leftarrow
means "assignment" in Scala
System.out.println("Counting " + i)
i <- 1 to 10 is equivalent to:
for (i <- 1.to(10))
i % 2 == 0 is a filter, optional
for (val arg <- args)
maps to args foreach (arg => ...)
More to come...
functions
GOOD def f(x: Int) = { x*x
}
BAD def f(x: Int) { x*x }
define function
hidden error: without = it’s a Unitreturning
procedure; causes havoc
GOOD def f(x: Any) =
println(x)
BAD def f(x) = println(x)
define function
syntax error: need types for every arg.
type R = Double type alias
def f(x: R) vs.
def f(x: => R)
callbyvalue
callbyname
(lazy parameters)
(x:R) => x*x anonymous function
(1 to 5).map(_*2) vs.
(1 to 5).reduceLeft( _+_ )
anonymous function: underscore is positionally matched arg.
(1 to 5).map( x => x*x ) anonymous function: to use an arg twice, have to name it.
GOOD (1 to 5).map(2*)
BAD (1 to 5).map(*2)
anonymous function: bound infix method. Use 2*_ for sanity’s sake instead.
(1 to 5).map { x => val
y=x*2; println(y); y }
anonymous function: block style returns last expression.
(1 to 5) filter {_%2 == 0}
map {_*2}
anonymous functions: pipeline style. (or parens too).
def compose(g:R=>R, h:R=>R)
= (x:R) => g(h(x))
val f = compose({_*2},
{_1})
anonymous functions: to pass in multiple blocks, need outer parens.
val zscore = (mean:R, sd:R)
=> (x:R) => (xmean)/
sd
currying, obvious syntax.
def zscore(mean:R, sd:R) =
(x:R) => (xmean)/
sd
currying, obvious syntax
def zscore(mean:R, sd:R)
(x:R) = (xmean)/
sd
currying, sugar syntax. but then:
val normer = zscore(7, 0.4)
_
need trailing underscore to get the partial, only for the sugar version.
def mapmake[T](g:T=>T)(seq:
List[T]) = seq.map(g)
generic type.
5.+(3); 5 + 3
(1 to 5) map (_*2)
infix sugar.
def sum(args: Int*) =
args.reduceLeft(_+_)
varargs.
packages
import scala.collection._ wildcard import.
import
scala.collection.Vector
import scala.collection.
{Vector, Sequence}
selective import.
import scala.collection.
{Vector => Vec28}
renaming import.
import java.util.{Date =>
_, _}
import all from java.util except Date.
package pkg at start of file
package pkg { ... }
declare a package.
data structures
(1,2,3) tuple literal. ( Tuple3 )
var (x,y,z) = (1,2,3) destructuring bind: tuple unpacking via pattern matching.
BAD var x,y,z = (1,2,3) hidden error: each assigned to the entire tuple.
var xs = List(1,2,3) list (immutable).
xs(2) paren indexing. (slides)
1 :: List(2,3) cons.
1 to 5 same as 1 until 6
1 to 10 by 2
range sugar.
() (empty parens) sole member of the Unit type (like C/Java void).
control
constructs
if (check) happy else sad conditional.
if (check) happy same as
if (check) happy else ()
conditional sugar.
while (x < 5) { println(x);
x += 1}
while loop.
do { println(x); x += 1}
while (x < 5)
do while loop.
import
scala.util.control.Breaks._
breakable {
for (x <xs)
{
if (Math.random < 0.1)
break
}}
break. (slides)
for (x <xs
if x%2 == 0)
yield x*10 same as
xs.filter(_%2 ==
0).map(_*10)
for comprehension: filter/map
for ((x,y) <xs
zip ys)
yield x*y same as
(xs zip ys) map { case
(x,y) => x*y }
for comprehension: destructuring bind
for (x <xs;
y <ys)
yield x*y same as
xs flatMap {x => ys map {y
=> x*y}}
for comprehension: cross product
for (x <xs;
y <ys)
{ for comprehension: imperativeish
println("%d/%d =
%.1f".format(x,y, x*y))
}
sprintfstyle
for (i <1
to 5) {
println(i)
}
for comprehension: iterate including the upper bound
for (i <1
until 5) {
println(i)
}
for comprehension: iterate omitting the upper bound
pattern
matching
GOOD (xs zip ys) map {
case (x,y) => x*y }
BAD (xs zip ys) map( (x,y)
=> x*y )
use case in function args for pattern matching.
BAD
val v42 = 42
Some(3) match {
case Some(v42) =>
println("42")
case _ => println("Not
42")
}
“v42” is interpreted as a name matching any Int value, and “42” is printed.
GOOD
val v42 = 42
Some(3) match {
case Some(`v42`) =>
println("42")
case _ => println("Not
42")
}
”`v42`” with backticks is interpreted as the existing val v42 , and “Not 42” is printed.
GOOD
val UppercaseVal = 42
Some(3) match {
case Some(UppercaseVal) =>
println("42")
case _ => println("Not
42")
}
UppercaseVal is treated as an existing val, rather than a new pattern variable, because it
starts with an uppercase letter. Thus, the value contained within UppercaseVal is
checked against 3 , and “Not 42” is printed.
object
orientation
class C(x: R) same as
class C(private val x: R)
var c = new C(4)
constructor params private
class C(val x: R)
var c = new C(4)
c.x
constructor params public
class C(var x: R) {
assert(x > 0, "positive
please")
var y = x
val readonly = 5
private var secret = 1
def this = this(42)
constructor is class body
declare a public member
declare a gettable but not settable member
declare a private member
alternative constructor
}
new{ ... } anonymous class
abstract class D { ... } define an abstract class. (noncreateable)
class C extends D { ... } define an inherited class.
class D(var x: R)
class C(x: R) extends D(x)
inheritance and constructor params. (wishlist: automatically passup
params by default)
object O extends D { ... } define a singleton. (modulelike)
trait T { ... }
class C extends T { ... }
class C extends D with T {
... }
traits.
interfaceswithimplementation.
no constructor params. mixinable.
trait T1; trait T2
class C extends T1 with T2
class C extends D with T1
with T2
multiple traits.
class C extends D {
override def f = ...}
must declare method overrides.
new java.io.File("f") create object.
BAD new List[Int]
GOOD List(1,2,3)
type error: abstract type
instead, convention: callable factory shadowing the type
classOf[String] class literal.
x.isInstanceOf[String] type check (runtime)
x.asInstanceOf[String] type cast (runtime)
x: String ascription (compile time)



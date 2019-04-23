// Mapper
public class LineIndexMapper
extends MapReduceBase
implements Mapper<LongWritable,
Text, Text, Text> {
public void map(LongWritable k,
Text v, OutputCollector<Text, Text> o,
Reporter r) throws IOException { /* implementation here
*/ }
}
// Reducer/ Combiner
public class LineIndexReducer
extends MapReduceBase
implements Reducer<Text,
Text, Text, Text> {
public void reduce(Text k,
Iterator<Text> v,
OutputCollector<Text, Text> o,
Reporter r) throws IOException {
/* implementation */ }

}
// Job Driver
public class Driver {
public static void main(String… argV) {
Job job = new Job(new Configuration(), “test”);
job.setMapper(LineIndexMapper.class);
job.setCombiner(LineIndexReducer.class);
job.setReducer(LineIndexReducer.class);
job.waitForCompletion(true);
}
} // Driver
hadoop jar shakespeare_indexer.jar

public HashMap<Integer, Student> buildMap(Student[] students) {
	HashMap<Integer, Student> map = new HashMap<Integer, 	Student>();
	for (Student s : students) map.put(s.getId(), s);
	return map;
}

// ArrayList (Dynamically Resizing Array):
public ArrayList<String> merge(String[] words, String[] more) {
	ArrayList<String> sentence = new ArrayList<String>();
	for (String w : words) sentence.add(w);
	for (String w : more) sentence.add(w);
	return sentence;
}

// String buffer with O of (n square) and string builder can avoid this problem
public String makeSentence(String[] words) {
	StringBuffer sentence = new StringBuffer();
	for (String w : words) sentence.append(w);
	return sentence.toString();
}

// Creating a linked list
class Node {
	Node next = null;
	int data;
	public Node(int d) { data = d; }
	void appendToTail(int d) {
	Node end = new Node(d);
	Node n = this;
	while (n.next != null) { n = n.next; }
	n.next = end;
	}
}

// Deleting a Node from a Singly Linked List
 Node deleteNode(Node head, int d) {
	 Node n = head;
	 if (n.data == d) {
 	return head.next; /* moved head */
	 }
		 while (n.next != null) {
			 if (n.next.data == d) {
 			n.next = n.next.next;
 			return head; /* head didn’t change */
		 }
 		n = n.next;
 	}
 }

// Implementing a Stack
 class Stack {
	Node top;
	Node pop() {
	if (top != null) {
		Object item = top.data;
		top = top.next;
		return item;
	}
	return null;
 	}
	void push(Object item) {
	Node t = new Node(item);
	t.next = top;
	top = t;
	}
}

// Implementing a Queue
class Queue{
	Node first, last;
	void enqueue(Object item){
		if (!first){
			back = new Node(item)
			first = black;
		} else {
			back.next = new Node(item)
			back = back.next;
		}
	}
	Node dequeue(Node n){
		if (front != null){
			Object item = front.data;
			front = front.next;
			return item;
		}
		return null;
	}
}


public static void main(String args[]){...}
interface Foo{
	void abc();
}
class Foo extends Bar implements Foo {...}
// final class, final method, final variable
// static method, static variable
// abstract class, abstract interface, abstract method


class Foo implements Runnable {
	public void run() {
		while (true) beep();
	}
}
Foo foo = new Foo();
Thread myThread = new Thread(foo);
myThread.start();

Java Source File (*.java)
Java Compiler (javac)
Java Bytecode File (*.class)
Java Virtual Machine (java)
public static void main(String args[])
class HelloWorld
{
public static void main(String [] args)
{
System.out.println(“Hello World!”);
}
}

Compile:
– javac HelloWorld.java
• Run:
– java HelloWorld
• Output:
– “Hello World”

Java arrays are supported as classes. E.g.,
• int[] i = new int[9]
• size of an array i.length

Standard Java data types:
– byte 1 byte
– boolean 1 byte
– char 2 byte (Unicode)
– short 2 byte
– int 4 byte
– long 8 byte
– float 4 byte
– double 8 byte

Variables
• Variables may be tagged as constants (final
keyword).
• Variables may be initialized at creation time
– final variables must be initialized at creation time
• Objects are variables in Java and must be
dynamically allocated with the new keyword.
– E.g., a = new ClassA();
• Objects are freed by assigning them to null, or when
they go out of scope (automatic garbage collection).
– E.g., a = null;

int n = 1;
char ch = ‘A’;
String s = “Hello”;
Long L = new Long(100000);
boolean done = false;
final double pi = 3.14159265358979323846;
Employee joe = new Employee();
char [] a = new char[3];
Vector v = new Vector();

int x,y,z;
x = 0;
x++;
y = x + 10;
y = y % 5;
z = 9 / 5;

int i = 8;
if ((i >= 0) && (i < 10))
System.out.println(i + “ is between 0 and 9”);
else
System.out.println(i + “ is larger than 9 or less than 0”);

for (int i = 0; i < 10; i++)
{
System.out.println(i);
}
int i = 0;
while(i < 10)
{
System.out.println(i++); //prints i before
} //applying i++
int i = 0;
do
{
System.out.println(i++);
} while(i < 10)

try {
statement-list1
} catch (exception-class1 variable1) {
statement-list2
} catch (exception-class2 variable2) {
statement-list3
} catch ….

class Demo {
static public void main (String[] args) {
Exception_Scope demo = new Exception_Scope();
System.out.println(“Program beginning”);
demo.L1( );
System.out.println(“Program ending”);
}
}
class Exception_Scope {
public void L3 ( ) {
System.out.println(“Level3 beginning”);
System.out.println(10/0);
System.out.println(“Level3 ending”);
}
public void L2 ( ) {
System.out.println(“Level2 beginning”);
L3( );
System.out.println(“Level2 ending”);
}
public void L1 ( ) {
System.out.println(“Level1 beginning”);
try { L2 ();
} catch (ArithmeticException problem) {
System.out.println(problem.getMessage( ));
problem.printStackTrace ( );
}
System.out.println(“Level1 ending”);
}
}

Throwing an Exception
import java.io.IOException;
public class Demo {
public static void main (String[] args) throws Doh {
Doh problem = new Doh (“Doh!”);
throw problem;
// System.out.println(“Dead code”);
}
}
class Doh extends IOException {
Doh (String message) {
super(message);
}
}

try {
statement-list1
} catch (exception-class1 variable1) {
statement-list2
} catch …
} finally {
statement-list3
}

int i, j;
i = 1;
j = 7;
System.out.println(“i = “ + i + “ j = “ + j);

import java.io.*;
public class X {
public static void main(String args[])
{
try{
BufferedReader dis = new BufferedReader(
new InputStreamReader(System.in));
System.out.println("Enter x ");
String s = dis.readLine();
double x= Double.valueOf(s.trim()).doubleValue();
// trim removes leading/trailing whitespace and ASCII control chars.
System.out.println("x = " + x);
} catch (Exception e) {
System.out.println("ERROR : " + e) ;
e.printStackTrace(System.out);
}
}

import java.io.*;
import java.util.*;
// Program that reads from a file with space delimited name-pairs and
// writes to another file the same name-pairs delimited by a tab.
class P
{
public static void main(String [] args)
{
BufferedReader reader_d;
int linecount = 0;
Vector moduleNames = new Vector();
try {
reader_d = new BufferedReader(new FileReader(args[0]));
// continued on next page

// … continued from previous page.
while (true) {
String line = reader_d.readLine();
if (line == null) {
break;
}
StringTokenizer tok = new StringTokenizer(line, " ");
String module1 = tok.nextToken();
String module2 = tok.nextToken();
moduleNames.addElement(module1 + "\t" + module2);
linecount++;
} // end while

// … continued from previous page.
catch (Exception e) {
e.printStackTrace();
System.exit(1);
}
BufferedWriter writer_d;
try {
writer_d = new BufferedWriter(new FileWriter(args[0] + ".tab"));

for(int i = 0; i < moduleNames.size(); i++) {
String modules = (String) moduleNames.elementAt(i);
writer_d.write(modules, 0, modules.length()-1);
writer_d.newLine();
} // end for
writer_d.close();
} // end try
catch (Exception e) {
e.printStackTrace();
System.exit(1);
}
System.out.println("Number of lines: " + linecount);
} // end main
} // end P

String s = new String(“This is a test”)
if (s.startsWith(“This”) == true)
System.out.println(“Starts with This”);
else
System.out.println(“Does not start with This”);

All classes are derived from a single root
class called Object.
• Every class (except Object) has exactly
one immediate super class.
• Only single inheritance is supported.
Class Dot {
float x, y;
}
class Dot extends Object {
float x, y;
}

class Arithmetic
{
int add(int i, int j){
return i + j;
}
int sub(int i, int j){
return i - j;
}
}
…
Arithmetic a = new Arithmetic();
System.out.println(a.add(1,2));
System.out.println(a.sub(5,3));

Anatomy of a Method
• Visibility identifier:
– public: Accessible anywhere by anyone.
– private: Accessible only from within the class where
they are declared.
– protected: Accessible only to subclasses, or other
classes in the same package.
– Unspecified: Access is public in the class’s package and
private elsewhere.
• Return type:
– Must specify a data type of the data that the method
returns.
– Use the return keyword.
– Use void if the method does not return any data

class Add
{
int i; // class variable
int j; // class variable
// scope public in the package, private
// elsewhere.
int add(){
return i + j;
}
}
…
Add a = new Add();
System.out.println(a.add(4,6));

class Incrementor
{
private static int i = 0;
void incrCount(){
i++;
}
int getCount() {
return i;
}
}
Incrementor f1, f2;
f1 = new Incrementor();
f2 = new Incrementor();
f1.incrCount();
System.out.println(f1.getCount());
f2.incrCount();
System.out.println(f1.getCount());

this and super
• Inside a method, the name this represents
the current object.
• When a method refers to its instance
variables or methods, this is implied.
• The super variable contains a reference
which has the type of the current object’s
super class.

Constants
• In C++, constants are defined using const or
#define.
• In Java, it is somewhat more complicated:
– Define a class data element as:
• public final <static> <datatype> <name> = <value>;
– Examples:
• public final static double PI = 3.14;
• public final static int NumStudents = 60;
• Constants may be referenced but not modified.

Arrays
• Arrays in Java are objects.
• Arrays must be allocated.
• Arrays are passed by reference.
• Arrays are 0-based.
int [] i = new int[10];
double [] j = new double[50];
String [] s = new String[10];
int a[][] = new int [10][3];
println(a.length); // prints 10
println(a[0].length); // prints 3	

Arrays (Cont’d)
Object
Array A
int[ ] float[ ] A[ ]
// You can assign an array to an Object
// (implicit upcast)
Object o;
int a[ ] = new int [10];
o = a;
// You can cast an Object to an array
// (explicit downcast)
Object o = new Object();
a = (int [ ]) o;

ethod Overloading (Cont’d)
class Adder
{
int add(int i, int j) {
return i + j;
}
double add(double i, double j) {
return i + j;
}
}
…
int i = 4, j = 6; double l = 2.1, m = 3.39;
Adder a = new Adder();
System.out.println(a.add(i, j) + “,” + a.add(l,m));

Class Constructors
• Each class may have one or more
constructors.
• A constructor is a “method” (cannot invoke,
does not return anything) that is defined
with the same name as its class.
• A constructor is automatically called when
an object is created using new.
• Constructors are valuable for initialization
of class variables.

Class Constructors (Cont’d)
• By default, the super class constructor with
no parameters is invoked.
• If a class declares no constructors, the
compiler generates the following:
Class MyClass extends OtherClass {
MyClass () {
super(); // automatically generated
}
}

Class Constructors (Cont’d)
class Batter extends Player {
float slugging;
Batter (float slugging) {
// super is called here
this.slugging = slugging;
}
Batter () {
this((float).450); // does not call super first
}
}
class Pitcher extends Batter {
float era;
Pitcher(float era) {
super((float).300);
this.era = era;
}
}

Packages
• A package is a loose collection of classes.
• Packages are like libraries.
• Packages may be created using the
package keyword.
• Packages are located by the CLASSPATH
environment variable.
• In order to use a package you use the
import keyword.

Some Common Java Packages
• java.applet
• java.javax
• java.io
• java.lang
• java.net
• java.util
• java.math
• java.security

Importing a Package is
Convenient
import java.io.*;
DataInputStream dis = new DataInputStream();
or
java.io.DataInputStream dis = new java.io.DataInputStream();

The String Class
• Used to create and manipulate strings in
Java.
• Better than a null terminated sequence of
characters.
• Automatically sized (automatic storage
management).

The String Class (Cont’d)
• Rich set of functions:
– Concatenation
– Lowercase/Uppercase data conversion
– Sub-strings
– Strip leading and trailing characters
– Length
– Data conversion to/from an array of character
representation

The Vector Class
• The vector class may be used as a dynamic
array.
• The vector class can hold any Java object.
import java.util.Vector;
Vector v = new Vector();
v.removeAllElements();
v.addElement(new String(“1”));
v.addElement(new String(“2”));
v.addElement(new String(“3”));
v.addElement(new String(“4”));
for (int i = 0; i < v.size(); i++)
System.out.println(“Data = “ + v.elementAt(i));

Data Conversion Functions
• Java contains a robust set of classes to
convert from one data type to another.
• There is a data encapsulation class for each
scalar type:
– Long for long
– Integer for int
– Float for float
– Double for double
– Boolean for boolean

package Hello;
import java.util.Vector;
import java.util.Enumeration;
public class claculator {
private int prog;
public claculator() {
prog = 0;
}
public void work()
{
for(int i=1;i<11;i++)
{
for (int j=1;j<11;j++) {
prog = i*j;
notifyListeners(prog, false);
}
}
}

package Hello;
public class Hello_main
{
public static void main(String args[])
{
Hello_main hm = new Hello_main();
System.out.println("Start");
hm.workNoThread();
System.out.println("End");
}
public Hello_main() {
}
public void workNoThread()
{
final claculator cc = new claculator();
System.out.println("No Thread");
cc.work();
}
}

Adding the Event
• The next step is to add an event. The event object
will carry the information from the worker to the
main program.
• The event should be customized to fit your needs.
• Our event includes:
– Progress: let the main program know the progress of the
worker.
– Finished flag: let the main program know when the
worker is done.

package Hello;
public class IterationEvent {
private int value_;
private boolean finished_;
public IterationEvent(int value, boolean finished) {
value_ = value;
finished_ = finished;
}
public int getValue()
{
return value_;
}
public boolean isFinished()
{
return finished_;
}
}

Adding the Listener
• Now that we have an event object we can
build an interface of a listener.
• A listerner will be any object that can
receive events.
• The interface should include any function
interface that will be implemented in the
actual listening object.

package Hello;
public interface IterationListener {
public void nextIteration(IterationEvent e);
}

The Main Program Revisited
• Now that we have the listener interface we
should change the main program to
implement the interface.
• We need to add the implementation of the
interface and all the functions that we
declared.
Note: don’t try to run the new program before you change the worker as well.

package Hello;
public class Hello_main
implements IterationListener
{
public static void main(String args[])
{
Hello_main hm = new Hello_main();
System.out.println("Start");
hm.workNoThread();
System.out.println("End");
}
public Hello_main() {
}
public void workNoThread()
{
final claculator cc = new claculator();
cc.addListener(this);
System.out.println("No Thread");
cc.work();
cc.removeListener(this);
}
public void nextIteration(IterationEvent e)
{
System.out.println("From Main: "+e.getValue());
if (e.isFinished()) {
System.out.println("Finished");
}
}
}

The Worker Revisited
• As you might have noticed there are new functions
that we need to add to the worker object:
– addListener(IterationListener listener)
• Add a new listener to the worker the listener will receive
messages from the worker (you might want more than one).
– removeListener(IterationListener listener)
• Remove a listener from the worker.
– notifyListeners(int value, boolean finished)
• The function that will actually notify the listener

package Hello;
import java.util.Vector;
import java.util.Enumeration;
public class claculator {
private int prog;
private Vector listeners_ = new Vector();
public claculator() {
prog = 0;
}
public void work()
{
for(int i=1;i<11;i++)
{
for (int j=1;j<11;j++) {
prog = i*j;
notifyListeners(prog, false);
}
}
notifyListeners(prog, true);
}
public void addListener(IterationListener listener)
{
listeners_.addElement(listener);
}
public void removeListener(IterationListener listener)
{
listeners_.removeElement(listener);
}
private void notifyListeners(int value, boolean finished)
{
IterationEvent e = new IterationEvent(value, finished);
for (Enumeration listeners = listeners_.elements();
listeners.hasMoreElements(); )
{
IterationListener l = (IterationListener) listeners.nextElement();
l.nextIteration(e);
}
}
}

package Hello;
import java.util.Vector;
import java.util.Enumeration;
public class claculator {
private int prog;
private Vector listeners_ = new Vector();
public claculator() {
prog = 0;
}
public void work()
{
for(int i=1;i<11;i++)
{
for (int j=1;j<11;j++) {
prog = i*j;
notifyListeners(prog, false);
}
}
notifyListeners(prog, true);
}
public void addListener(IterationListener listener)
{
listeners_.addElement(listener);
}
public void removeListener(IterationListener listener)
{
listeners_.removeElement(listener);
}
private void notifyListeners(int value, boolean finished)
{
IterationEvent e = new IterationEvent(value, finished);
for (Enumeration listeners = listeners_.elements();
listeners.hasMoreElements(); )
{
IterationListener l = (IterationListener) listeners.nextElement();
l.nextIteration(e);
}
}
}

I Am Confused...
• Lets see what are the new things mean:
– addListener(IterationListener listener).
• This function adds a new vector element to the listeners vector (you may have
as many listeners as you wish).
– removeListener(IterationListener listener).
• This function removes a listener from the listeners vector this will free the
listener object once you don’t need it anymore.
– notifyListeners(int value, boolean finished).
• This function is the function that sends the information to the main
program.
• The for loop runs through all the listener elements in the listeners
vector and uses the nextIteration(e) function that is implemented in
the listener it self.
• When the worker call the notifyListeners function the main program
runs the nextIteration(e) function and updates it self.

How About Another Listener
• As was said before we can have more than
one listener, lets see how we can do that.
• Remember that the listener needs to
implement the interface and the functions of
that interface.

package Hello;
import java.util.Calendar;
import java.io.*;
public class Printer
implements IterationListener
{
public void nextIteration(IterationEvent e) {
Calendar Now = Calendar.getInstance();
try {
FileWriter fos = new FileWriter("C:\\Ron Projects\\EvensInSwting\\printer.log",true);
fos.write("From Printer - " + Now.getTime() + " Value: "+ e.getValue()+"\n");
//System.out.println("From Printer - " + Now.getTime() + " Value: "+ e.getValue());
if (e.isFinished()) {
fos.write("From Printer - "+Now.getTime()+" Finished\n");
//System.out.println("Finished");
}
fos.close();
} catch (java.io.IOException ex) {
System.out.println("Opps: " + ex);
}
}
}

The Printer Object
• The printer object is just another listener
that will update a log file for the main
program.
• Notice that this listener should be added
from the main program but is completely independed
from the main program
– cc.addListener(new Printer());

Threading the Worker
• If you want to thread the worker without
changing it the next code segment that is
part of the main program shows how to
thread the worker from within the main
program.
• We add the function workThread() to the
main program.

public void workThread()
{
final claculator cc = new claculator();
cc.addListener(this);
cc.addListener(new Printer());
System.out.println("With Thread");
Thread t = new Thread() {
public void run() {
cc.work();
}
};
t.start();
try {
t.join();
}
catch (Exception e) {
}
cc.removeListener(this);
}

Adding GUI:
--
Lets see how we can add a nice graphical
user interface to out little example.
• The UI will need to display:
– Start button:
– Progress bar:
– Current value:
– Status bar:
Creating Main Frame
• The Main Frame is extending Swing
Jframe.
• We will implement IterationListener again
to get the information from the worker.

Main Frame Cont.
• The following code segments show how to
declare the frame:
– Create the content pane
– Create the layout
– Create different fields (buttons, text,
progressbar etc.)

package Hello;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
import java.io.File;
import javax.swing.UIManager;
public class Hello_Frame1
extends JFrame implements IterationListener
{
JPanel contentPane;
JLabel statusBar = new JLabel();
BorderLayout borderLayout1 = new
BorderLayout();
JPanel jPanel1 = new JPanel();
GridBagLayout gridBagLayout1 = new
GridBagLayout();
JLabel jLabel1 = new JLabel();
JButton jButtonRun = new JButton();
JLabel jLabelCurrentValue = new JLabel();
JProgressBar jProgressBar = new
JProgressBar(0,100);
JLabel jLabelProgress = new JLabel();
JLabel jLabel2 = new JLabel();
public Hello_Frame1() {
contentPane = (JPanel) this.getContentPane();
contentPane.setLayout(borderLayout1);
this.setSize(new Dimension(400, 300));
this.setTitle("Hello GUI");
statusBar.setOpaque(true);
statusBar.setText("Ready");
jPanel1.setLayout(gridBagLayout1);
jLabel1.setText("Click here to start the process:");
jLabelCurrentValue.setText("Not Running");
jButtonRun.setText("Run");
jProgressBar.setValue(0);
jLabelProgress.setText((String)
(new Integer(jProgressBar.getValue())).toString()+"%");
jLabel2.setText("Current Value:");

contentPane.add(statusBar, BorderLayout.SOUTH);
contentPane.add(jPanel1, BorderLayout.CENTER);
jPanel1.add(jLabel1, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
jPanel1.add(jButtonRun, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
jPanel1.add(jProgressBar, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
jPanel1.add(jLabelProgress, new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
jPanel1.add(jLabel2, new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
jPanel1.add(jLabelCurrentValue, new GridBagConstraints(1, 2, 1, 1, 0.0, 0.0
,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
}

Button Functionality
• We have only one button and we need to
add a listener to it.
• We can add an addActionListener and
implement it later.
• The following code segments show how to
add the listener, create the class and
implement the function.

Button Functionality Cont.
• After the declaration of the listener we
implement the actionPerformed function in
a new function:
– jButtonRun_actionPerformed.
• In this function we will run the calculator in
a similar way to the non-GUI way.
• We add the Frame as the listener and
implement how it will listen later.

jButtonRun.addActionListener(new java.awt.event.ActionListener()
{
public void actionPerformed(ActionEvent e)
{
jButtonRun_actionPerformed(e);
}
};
void jButtonRun_actionPerformed(ActionEvent e)
{
change_status(Color.red, "Working Please wait...");
final claculator cc = new claculator();
final IterationListener listener = this;
//cc.addListener(new Printer());
Thread t = new Thread() {
public void run() {
cc.addListener(listener);
cc.work();
cc.removeListener(listener);
}
};
t.start();
}

GUI nextIteration
Implementation
• The new function will need to update the
GUI with the status of the worker:
– Change the status bar to a working mode.
– Update:
• Current value field.
• Status Bar.
• Complete percentage.
– When done open the ‘Done’ dialog box and
reset everything to the starting state.

public void nextIteration(IterationEvent e)
{
//System.out.println(e.getProgress());
jProgressBar.setValue(e.getProgress());
jLabelProgress.setText((String) (new Integer(jProgressBar.getValue())).toString()+"%");
jLabelCurrentValue.setText((String) (new Integer(e.getValue()).toString() ));
if (e.isFinished()) {
change_status(Color.getColor("204,204,204"), "Ready");
//Start the finished dialogBox
Hello_FrameAbout dlg = new Hello_FrameAbout(this);
Dimension dlgSize = dlg.getPreferredSize();
Dimension frmSize = getSize();
Point loc = getLocation();
dlg.setLocation((frmSize.width - dlgSize.width) / 2 + loc.x, (frmSize.height - dlgSize.height) / 2 + loc.y);
dlg.setModal(true);
dlg.show();
jProgressBar.setValue(0);
jLabelProgress.setText("0%");
jLabelCurrentValue.setText("Not Running");
}
}


Summary
• I hope you gained some knowledge of how to
create and manage Swing applications and events.
• Source code the complete example as well as the
compiled version is available to download.
• Usage:
– Java –classpath Hello.jar Hello.Hello_main filename
– Java –classpath Hello.jar Hello.Hello_GUI

public class HelloWorld {.
    public static void main(String[] args) { .
        System.out.println("Hello, World");.
    }.
}.
# install java in Ubunto.
sudo apt-get install openjdk-7-jdk.
.
# check java compiler version.
javac -version.
C:\Users\username>cd C:\Users\username\introcs\hello.
C:\Users\username\introcs\hello>javac HelloWorld.java.
C:\Users\username\introcs>javac-introcs TestIntroCS.java.
java HelloWorld .

package org.acme;.
.
import java.rmi.RemoteException;.
import javax.ejb.*;.
.
public class HelloBean implements SessionBean {.
  private SessionContext sessionContext;.
  public void ejbCreate() {.
  }.
  public void ejbRemove() {.
  }.
  public void ejbActivate() {.
  }.
  public void ejbPassivate() {.
  }.
  public void setSessionContext(SessionContext sessionContext) {.
    this.sessionContext = sessionContext;.
  }.
  public String sayHello() throws java.rmi.RemoteException {.
    return "Hello World!!!!!";.
  }.
}.
Create the EJB Home interface.
.
c:\my\app\org\acme\HelloHome.java.
package org.acme;.
.
import java.rmi.*;.
import javax.ejb.*;.
import java.util.*;.
.
public interface HelloHome extends EJBHome {.
  public HelloObject create() throws RemoteException, CreateException;.
}.
.
Create the EJB Object interface.
.
c:\my\app\org\acme\HelloObject.java.
package org.acme;.
.
import java.rmi.*;.
import javax.ejb.*;.
import java.util.*;.
.
public interface HelloObject extends EJBObject {.
  public String sayHello() throws RemoteException;.
}.
.
Create the ejb-jar.xml.
.
Create a META-INF directory to put your ejb-jar.xml into..
.
Windows:.
c:\my\app> mkdir META-INF.
.
Linux/Unix:.
[user@host app]# mkdir META-INF.
Create am ejb-jar.xml file in your META-INF directory..
.
c:\my\app\META-INF\ejb-jar.xml.
<?xml version="1.0" encoding="UTF-8"?>.
<ejb-jar>.
  <enterprise-beans>.
    <session>.
      <ejb-name>Hello</ejb-name>.
      <home>org.acme.HelloHome</home>.
      <remote>org.acme.HelloObject</remote>.
      <ejb-class>org.acme.HelloBean</ejb-class>.
      <session-type>Stateless</session-type>.
      <transaction-type>Container</transaction-type>.
    </session>.
  </enterprise-beans>.
  <assembly-descriptor>.
    <container-transaction>.
      <method>.
        <ejb-name>Hello</ejb-name>.
        <method-name>*</method-name>.
      </method>.
      <trans-attribute>Required</trans-attribute>.
    </container-transaction>.
  </assembly-descriptor>.
</ejb-jar>.
.
Compile the EJB.
.
Compile your bean..
.
Windows:.
c:\my\app> javac org\acme\*.java.
.
Linux/Unix:.
[user@host app]# javac org/acme/*.java.
Package the EJB.
.
Now, package your EJB classes and your META-INF directory into a jar..
.
Windows:.
C:\my\app> jar cvf myHelloEjb.jar org META-INF.
.
Linux/Unix:.
[user@host app]# jar cvf myHelloEjb.jar org META-INF.
Deploy the EJB jar.
.
Use the OpenEJB Deploy Tool to deploy your jar..
.
Windows:.
C:\my\app> cd C:\openejb.
C:\openejb> openejb.bat deploy -a -m c:\my\app\myHelloEjb.jar.
.
inux/Unix:.
[user@host app]# cd /openejb.
[user@host openejb]# ./openejb.sh deploy -a -m /my/app/myHelloEjb.jar.
.
A basic client application.
.
Create a basic client application to access your HelloWorld bean..
.
c:\my\app\org\acme\HelloWorld.java.
package org.acme;.
.
import javax.rmi.*;.
import javax.naming.*;.
import java.util.*;.
.
public class HelloWorld {.
.
 public static void main( String args[]) {.
  try{.
    .
    Properties p = new Properties();.
    .
    //The JNDI properties you set depend.
    //on which server you are using..
    //These properties are for the Remote Server..
    p.put("java.naming.factory.initial", "org.openejb.client.RemoteInitialContextFactory");.
    p.put("java.naming.provider.url", "127.0.0.1:4201");.
    p.put("java.naming.security.principal", "myuser");.
    p.put("java.naming.security.credentials", "mypass");    .
    .
    //Now use those properties to create.
    //a JNDI InitialContext with the server..
    InitialContext ctx = new InitialContext( p );.
    .
    //Lookup the bean using it's deployment id.
    Object obj = ctx.lookup("/Hello");.
    .
    //Be good and use RMI remote object narrowing.
    //as required by the EJB specification..
    HelloHome ejbHome = (HelloHome).
        PortableRemoteObject.narrow(obj,HelloHome.class);.
.
    //Use the HelloHome to create a HelloObject.
    HelloObject ejbObject = ejbHome.create();.
    .
    //The part we've all been wainting for....
    String message = ejbObject.sayHello();.
.
    //A drum roll please..
    System.out.println( message );.
    .
  } catch (Exception e){.
    e.printStackTrace();.
  }.
 }.
}.
JNDI properties for the Local Server would look like the following. Be sure to read the Local Server documentation if you run into any problems..
.
 Properties p = new Properties();.
.
p.put("java.naming.factory.initial", .
    "org.openejb.client.LocalInitialContextFactory");.
p.put("openejb.home", "c:\\openejb");.
    .
InitialContext ctx = new InitialContext(p);.
.
JNDI properties for the Remote Server would look like the following. Be sure to start the Remote Server before running your application. See the Remote Server documentation for more information on using the Remote Server..
.
 Properties p = new Properties();.
p.put("java.naming.factory.initial", "org.openejb.client.RemoteInitialContextFactory");.
p.put("java.naming.provider.url", "127.0.0.1:4201");.
p.put("java.naming.security.principal", "myuser");.
p.put("java.naming.security.credentials", "mypass");.




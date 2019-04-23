int *p; // Defines pointer.
p = & q; // Sets p to address of q.
v = *p; // Set v to value of q.
Foo *f = new Foo(); // Initialize f.
int k = f -> x; // sets k equal to value of f's member variable.
class MyClass{
	private:
		double var;
	public:
		MyClass(double v) { var = v;}
		~MyClass() {};
		double Update(double v);
};
double Complex::Update(double v){
	var = v; return v;
}
void *malloc(size_t sz)
void free(void * p)

C/C++ Cheat Sheet
For your reference; this sheet will also be included in exams
CISC 124, fall 2004
Sample C++ Program:
#include <stdio.h>
#include <string.h>
class Employee {
private:
char name[51];
double wage; // hourly wage
protected:
double payOwed;
public:
Employee(char n[], double w) {
strcpy(name, n);
setWage(w);
payOwed = 0;
} // end constructor
virtual void pay(double hours) {
payOwed += wage * hours;
} // end pay
double amountToPay() {
return payOwed;
} // end amountToPay
void setWage(double wage) {
this->wage = wage;
}
void zero() {
payOwed = 0;
} // end zero
// prints employee
virtual void print() {
printf("name = %s, ", name);
printf("wage = $%.2f, ", wage);
printf("payOwed = $%.2f",
payOwed);
} // end print
void println() {
print();
printf("\n");
} // end println
}; // end class Employee
class Salesperson: public Employee {
private:
double rate;
public:
Salesperson(char name[],
double wage,
double rate)
: Employee(name, wage) {
this->rate = rate;
} // end constructor
void payForSale(double amount) {
payOwed += amount * rate;
} // end payForSale
void print() {
printf("Salesperson ");
Employee::print();
printf(", rate: $%.2f\n", rate);
} // end print
}; // end Salesperson
int main(void) {
Employee mickey("Mickey Mouse", 20);
mickey.setWage(21);
mickey.println();
Salesperson *donald =
new Salesperson("Donald Duck",
10, 0.15);
donald->payForSale(100);
donald->println();
Employee *company[2];
company[0] = &mickey;
company[1] = donald;
for (int i = 0; i < 2; i++) {
company[i]->pay(10);
company[i]->println();
} // end for
} // end main
printf formats:
%d: integer
%f: float or double
%s: string (char array)
%c: char (single character)
scanf formats:
%d: integer
%f: float
%lf: double (first character is L, not one!)
%s: string (char array)
%c: char (single character)
string methods:
/* to use these methods, you
must include <string.h> */
strcpy(char dest[], char src[])
copies src into dest
int strlen(char s[])
returns length of s
int strcmp(char s1[], char s2[])
returns negative if s1 < s2,
0 if s1 == s2
positive if s1 > s2
strcat(char dest[], char src[])
adds src to the end of dest
abstract classes and methods:
virtual void sound(char s[]) = 0;
// Reminder: no "abstract" keyword.
// Class headers do not indicate
// whether the class is abstract or
// not. A class is abstract if it
// contains any abstract methods.

STL Reference
---------
STL Quick Reference – Version 1.29 [A4] April 20, 2007 1
1 Notations
• The symbol const for const.
• The symbol x for function returned value.
• Template class parameters lead by outlined
character. For example: T, Key, Compare.
Interpreted in template definition context.
• Sometimes class, typename dropped.
• Template class parameters dropped,
thus C sometimes used instead of ChTi.
• “See example” by +, its output by 'à.
2 Containers
2.1 Pair
#include <utility>
templatehclass T1, class T2i
struct pair {
T1 first; T2 second;
pair() {}
pair(const T1& a, const T2& b):
first(a), second(b) {} };
2.1.1 Types
pair::first type
pair::second type
2.1.2 Functions & Operators
See also 2.2.3.
pairhT1,T2i
make pair(const T1&, const T2&);
2.2 Containers — Common
Here X is any of
{vector, deque, list,
set, multiset, map, multimap}
2.2.1 Types
X::value type
X::reference
X::const reference
X::iterator
X::const iterator
X::reverse iterator
X::const reverse iterator
X::difference type
X::size type
Iterators reference value type (See 6).
2.2.2 Members & Operators
X::X();
X::X(const X&);
X::~X();
X& X::operator=(const X&);
X::iterator X::begin();
X::const iterator X::begin() const ;
X::iterator X::end();
X::const iterator X::end() const ;
X::reverse iterator X::rbegin();
X::const reverse iterator X::rbegin() const ;
X::reverse iterator X::rend();
X::const reverse iterator X::rend() const ;
X::size type X::size() const ;
X::size type X::max size() const ;
bool X::empty() const ;
void X::swap(X& x);
void X::clear();
2.2.3 Comparison Operators
Let, X v, w. X may also be pair (2.1).
v == w v != w
v < w v > w
v <= w v >= w
All done lexicographically and xbool.
2.3 Sequence Containers
S is any of {vector, deque, list}
2.3.1 Constructors
S::S(S::size type n,
const S::value type& t);
S::S(S::const iterator first,
S::const iterator last); +7.2, 7.3
2.3.2 Members
S::iterator // inserted copy
S::insert(S::iterator before,
const S::value type& val);
S::iterator // inserted copy
S::insert(S::iterator before,
S::size type nVal,
const S::value type& val);
S::iterator // inserted copy
S::insert(S::iterator before,
S::const iterator first,
S::const iterator last);
S:iterator S::erase(S::iterator position);
S:iterator S::erase(S::const iterator first,
x post erased S::const iterator last);
void S::push back(const S::value type& x);
void S::pop back();
S::reference S::front();
S::const reference S::front() const ;
S::reference S::back();
S::const reference S::back() const ;
2.4 Vector
#include <vector>
templatehclass T,
class Alloc=allocatori
class vector;
See also 2.2 and 2.3.
size type vector::capacity() const ;
void vector::reserve(size type n);
vector::reference
vector::operator[](size type i );
vector::const reference
vector::operator[](size type i) const ;
+ 7.1.
2.5 Deque
#include <deque>
templatehclass T,
class Alloc=allocatori
class deque;
Has all of vector functionality (see 2.4).
void deque::push front(const T& x);
void deque::pop front();
2.6 List
#include <list>
templatehclass T,
class Alloc=allocatori
class list;
See also 2.2 and 2.3.
void list::pop front();
void list::push front(const T& x);
void // move all x (&x 6= this) before pos
list::splice(iterator pos, listhTi& x); +7.2
void // move x’s xElemPos before pos
list::splice (iterator pos,
listhTi& x,
iterator xElemPos); +7.2
void // move x’s [xFirst,xLast) before pos
list::splice (iterator pos,
listhTi& x,
iterator xFirst,
iterator xLast); +7.2
void list::remove(const T& value);
void list::remove if (Predicate pred);
// after call: 8 this iterator p,  p 6=  (p + 1)
void list::unique(); // remove repeats
void // as before but, ¬binPred( p,  (p + 1))
list::unique(BinaryPredicate binPred);
// Assuming both this and x sorted
void list::merge(listhTi& x);
// merge and assume sorted by cmp
void list::merge(listhTi& x, Compare cmp);
void list::reverse();
void list::sort();
void list::sort(Compare cmp);
2.7 Sorted Associative
Here A any of
{set, multiset, map, multimap}.
2.7.1 Types
For A=[multi]set, columns are the same
A::key type A::value type
A::keycompare A::value compare
2.7.2 Constructors
A::A(Compare c=Compare())
A::A(A::const iterator first,
A::const iterator last,
Compare c=Compare());
2.7.3 Members
A::keycompare A::key comp() const ;
A::value compare A::value comp() const ;
A::iterator
A::insert(A::iterator hint,
const A::value type& val);
void A::insert(A::iterator first,
A::iterator last);
A::size type // # erased
A::erase(const A::key type& k);
void A::erase(A::iterator p);
void A::erase(A::iterator first,
A::iterator last);
A::size type
A::count(const A::key type& k) const ;
A::iterator A::find(const A::key type& k) const ;
A::iterator
A::lower bound(const A::key type& k) const ;
A::iterator
A::upper bound(const A::key type& k) const ;
pairhA::iterator, A::iteratori // see 4.3.1
A::equal range(const A::key type& k) const ;
2.8 Set
#include <set>
templatehclass Key,
class Compare=lesshKeyi,
class Alloc=allocatori
class set;
See also 2.2 and 2.7.
set::set(const Compare& cmp=Compare());
pairhset::iterator, booli // bool = if new
set::insert(const set::value type& x);
2.9 Multiset
#include <multiset.h>
templatehclass Key,
class Compare=lesshKeyi,
class Alloc=allocatori
class multiset;
See also 2.2 and 2.7.
multiset::multiset(
constCompare& cmp=Compare());
multiset::multiset(
InputIterator first,
InputIterator last,
constCompare& cmp=Compare());
multiset::iterator // inserted copy
multiset::insert(constmultiset::value type& x);
2.10 Map
#include <map>
templatehclass Key, class T,
class Compare=lesshKeyi,
class Alloc=allocatori
class map;
See also 2.2 and 2.7.
2.10.1 Types
map::value type // pairhconstKey,Ti
2.10.2 Members
map::map(
const Compare& cmp=Compare());
pairhmap::iterator, booli // bool = if new
map::insert(const map::value type& x);
T& map:operator[](const map::key type&);
map::const iterator
map::lower bound(
const map::key type& k) const ;
map::const iterator
map::upper bound(
const map::key type& k) const ;
pairhmap::const iterator, map::const iteratori
map::equal range(
const map::key type& k) const ;
Example
typedef map<string, int> MSI;
MSI nam2num;
nam2num.insert(MSI::value_type("one", 1));
nam2num.insert(MSI::value_type("two", 2));
nam2num.insert(MSI::value_type("three", 3));
int n3 = nam2num["one"] + nam2num["two"];
cout << n3 << " called ";
for (MSI::const_iterator i = nam2num.begin();
i != nam2num.end(); ++i)
if ((*i).second == n3)
{cout << (*i).first << endl;}
'à 3 called three
2.11 Multimap
#include <multimap.h>
templatehclass Key, class T,
class Compare=lesshKeyi,
class Alloc=allocatori
class multimap;
See also 2.2 and 2.7.
2.11.1 Types
multimap::value type // pairhconstKey,Ti
2.11.2 Members
multimap::multimap(
constCompare& cmp=Compare());
multimap::multimap(
InputIterator first,
InputIterator last,
constCompare& cmp=Compare());
multimap::const iterator
multimap::lower bound(
const multimap::key type& k) const ;
multimap::const iterator
multimap::upper bound(
const multimap::key type& k) const ;
pairhmultimap::const iterator,
multimap::const iteratori
multimap::equal range(
const multimap::key type& k) const ;
3 Container Adaptors
3.1 Stack Adaptor
#include <stack>
templatehclass T,
class Container=dequehTi i
class stack;
Default constructor. Container must have
back(), push back(), pop back(). So vector,
list and deque can be used.
bool stack::empty() const ;
Container::size type stack::size() const ;
void
stack::push(const Container::value type& x);
void stack::pop();
constContainer::value type&
stack::top() const ;
void Container::value type& stack::top();
Comparision Operators
bool operator==(const stack& s0,
const stack& s1);
bool operator<(const stack& s0,
const stack& s1);
3.2 Queue Adaptor
#include <queue>
templatehclass T,
class Container=dequehTi i
class queue;
Default constructor. Container must have
empty(), size(), back(), front(), push back()
and pop front(). So list and deque can be
used.
bool queue::empty() const ;
Container::size type queue::size() const ;
void
queue::push(const Container::value type& x);
void queue::pop();
const Container::value type&
queue::front() const ;
Container::value type& queue::front();
const Container::value type&
queue::back() const ;
Container::value type& queue::back();
Comparision Operators
bool operator==(const queue& q0,
const queue& q1);
bool operator<(const queue& q0,
const queue& q1);
3.3 Priority Queue
#include <queue>
templatehclass T,
class Container=vectorhTi,
class Compare=lesshTi i
class priority queue;
Container must provide random access iterator
and have empty(), size(), front(), push back()
and pop back(). So vector and deque can be
used.
Mostly implemented as heap.
3.3.1 Constructors
explicit priority queue::priority queue(
constCompare& comp=Compare());
priority queue::priority queue(
InputIterator first,
InputIterator last,
constCompare& comp=Compare());
3.3.2 Members
bool priority queue::empty() const ;
Container::size type
priority queue::size() const ;
const Container::value type&
priority queue::top() const ;
Container::value type& priority queue::top();
void priority queue::push(
const Container::value type& x);
void priority queue::pop();
No comparision operators.
4 Algorithms
#include <algorithm>
STL algorithms use iterator type parameters.
Their names suggest their category (See 6.1).
For abbreviation, the clause —
template hclass Foo, ...i is dropped. The
outlined leading character can suggest the
template context.
Note: When looking at two sequences:
S1 = [first1, last1) and S2 = [first2, ?) or
S2 = [?, last2) — caller is responsible that
function will not overflow S2.
4.1 Query Algorithms
Function // f not changing [first, last)
for each(InputIterator first,
InputIterator last,
Function f ); +7.4
InputIterator // first i so i==last or *i==val
find(InputIterator first,
InputIterator last,
const T val); +7.2
InputIterator // first i so i==last or pred(i)
find if (InputIterator first,
InputIterator last,
Predicate pred); +7.7
ForwardIterator // first duplicate
adjacent find(ForwardIterator first,
ForwardIterator last);
ForwardIterator // first binPred-duplicate
adjacent find(ForwardIterator first,
ForwardIterator last,
BinaryPredicate binPred);
void // n = # equal val
count(ForwardIterator first,
ForwardIterator last,
const T val,
Size& n);
void // n = # satisfying pred
count if (ForwardIterator first,
ForwardIterator last,
Predicate pred,
Size& n);
// x bi-pointing to first !=
pairhInputIterator1, InputIterator2i
mismatch(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2);
// x bi-pointing to first binPred-mismatch
pairhInputIterator1, InputIterator2i
mismatch(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
BinaryPredicate binPred);
bool
equal(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2);
bool
equal(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
BinaryPredicate binPred);
// [first2, last2) v [first1, last1)
ForwardIterator1
search(ForwardIterator1 first1,
ForwardIterator1 last1,
ForwardIterator2 first2,
ForwardIterator2 last2);
// [first2, last2) vbinPred [first1, last1)
ForwardIterator1
search(ForwardIterator1 first1,
ForwardIterator1 last1,
ForwardIterator2 first2,
ForwardIterator2 last2,
BinaryPredicate binPred);
4.2 Mutating Algorithms
OutputIterator // x first2 + (last1 - first1)
copy(InputIterator first1,
InputIterator last1,
OutputIterator first2);
// x last2 - (last1 - first1)
BidirectionalIterator2
copy backward(
BidirectionalIterator1 first1,
BidirectionalIterator1 last1,
BidirectionalIterator2 last2);
void swap(T& x, T& y);
ForwardIterator2 // x first2 + #[first1, last1)
swap ranges(ForwardIterator1 first1,
ForwardIterator1 last1,
ForwardIterator2 first2);
OutputIterator // x result + (last1 - first1)
transform(InputIterator first,
InputIterator last,
OutputIterator result,
UnaryOperation op); +7.6
OutputIterator // 8ski
2 Sk ri = bop(s1i
, s2i
)
transform(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
OutputIterator result,
BinaryOperation bop);
void replace(ForwardIterator first,
ForwardIterator last,
const T& oldVal,
const T& newVal);
void
replace if (ForwardIterator first,
ForwardIterator last,
Predicate& pred,
const T& newVal);
OutputIterator // x result2 + #[first, last)
replace copy(InputIterator first,
InputIterator last,
OutputIterator result,
const T& oldVal,
const T& newVal);
OutputIterator // as above but using pred
replace copy if (InputIterator first,
InputIterator last,
OutputIterator result,
Predicate& pred,
const T& newVal);
void fill(ForwardIterator first,
ForwardIterator last,
const T& value);
void fill n(ForwardIterator first,
Size n,
const T& value);
void // by calling gen()
generate(ForwardIterator first,
ForwardIterator last,
Generator gen);
void // n calls to gen()
generate n(ForwardIterator first,
Size n,
Generator gen);
All variants of remove and unique return
iterator to new end or past last copied.
ForwardIterator // [x,last) is all value
remove(ForwardIterator first,
ForwardIterator last,
const T& value);
ForwardIterator // as above but using pred
remove if (ForwardIterator first,
ForwardIterator last,
Predicate pred);
OutputIterator // x past last copied
remove copy(InputIterator first,
InputIterator last,
OutputIterator result,
const T& value);
OutputIterator // as above but using pred
remove copy if (InputIterator first,
InputIterator last,
OutputIterator result,
Predicate pred);
All variants of unique template functions
remove consecutive (binPred-) duplicates. Thus
usefull after sort (See 4.3).
ForwardIterator // [x,last) gets repetitions
unique(ForwardIterator first,
ForwardIterator last);
ForwardIterator // as above but using binPred
unique(ForwardIterator first,
ForwardIterator last,
BinaryPredicate binPred);
OutputIterator // x past last copied
unique copy(InputIterator first,
InputIterator last,
OutputIterator result,
const T& result);
OutputIterator // as above but using binPred
unique copy(InputIterator first,
InputIterator last,
OutputIterator result,
BinaryPredicate binPred);
void
reverse(BidirectionalIterator first,
BidirectionalIterator last);
OutputIterator // x past last copied
reverse copy(BidirectionalIterator first,
BidirectionalIterator last,
OutputIterator result);
void // with first moved to middle
rotate(ForwardIterator first,
ForwardIterator middle,
ForwardIterator last);
OutputIterator // first to middle position
rotate copy(ForwardIterator first,
ForwardIterator middle,
ForwardIterator last,
OutputIterator result);
void
random shuffle(
RandomAccessIterator first,
RandomAccessIterator result);
void // rand() returns double in [0, 1)
random shuffle(
RandomAccessIterator first,
RandomAccessIterator last,
RandomGenerator rand);
BidirectionalIterator // begin with true
partition(BidirectionalIterator first,
BidirectionalIterator last,
Predicate pred);
BidirectionalIterator // begin with true
stable partition(
BidirectionalIterator first,
BidirectionalIterator last,
Predicate pred);
4.3 Sort and Application
void sort(RandomAccessIterator first,
RandomAccessIterator last);
void sort(RandomAccessIterator first,
RandomAccessIterator last,
+7.3 Compare comp);
void
stable sort(RandomAccessIterator first,
RandomAccessIterator last);
void
stable sort(RandomAccessIterator first,
RandomAccessIterator last,
Compare comp);
void // [first,middle) sorted,
partial sort( // [middle,last) eq-greater
RandomAccessIterator first,
RandomAccessIterator middle,
RandomAccessIterator last);
void // as above but using comp(ei, ej )
partial sort(
RandomAccessIterator first,
RandomAccessIterator middle,
RandomAccessIterator last,
Compare comp);
RandomAccessIterator // post last sorted
partial sort copy(
InputIterator first,
InputIterator last,
RandomAccessIterator resultFirst,
RandomAccessIterator resultLast);
RandomAccessIterator
partial sort copy(
InputIterator first,
InputIterator last,
RandomAccessIterator resultFirst,
RandomAccessIterator resultLast,
Compare comp);
Let n = position - first, nth element
partitions [first, last) into: L = [first, position),
en, R = [position + 1, last) such that
8l 2 L, 8r 2 R l 6> en   r.
void
nth element(
RandomAccessIterator first,
RandomAccessIterator position,
RandomAccessIterator last);
void // as above but using comp(ei, ej )
nth element(
RandomAccessIterator first,
RandomAccessIterator position,
RandomAccessIterator last,
Compare comp);
4.3.1 Binary Search
bool
binary search(ForwardIterator first,
ForwardIterator last,
const T& value);
bool
binary search(ForwardIterator first,
ForwardIterator last,
const T& value,
Compare comp);
ForwardIterator
lower bound(ForwardIterator first,
ForwardIterator last,
const T& value);
ForwardIterator
lower bound(ForwardIterator first,
ForwardIterator last,
const T& value,
Compare comp);
ForwardIterator
upper bound(ForwardIterator first,
ForwardIterator last,
const T& value);
ForwardIterator
upper bound(ForwardIterator first,
ForwardIterator last,
const T& value,
Compare comp);
equal range returns iterators pair that
lower bound and upper bound return.
pairhForwardIterator,ForwardIteratori
equal range(ForwardIterator first,
ForwardIterator last,
const T& value);
pairhForwardIterator,ForwardIteratori
equal range(ForwardIterator first,
ForwardIterator last,
const T& value,
Compare comp);
+ 7.5
4.3.2 Merge
Assuming S1 = [first1, last1) and
S2 = [first2, last2) are sorted, stably merge them
into [result, result + N) where N = |S1| + |S2|.
OutputIterator
merge(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result);
OutputIterator
merge(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result,
Compare comp);
void // ranges [first,middle) [middle,last)
inplace merge( // into [first,last)
BidirectionalIterator first,
BidirectionalIterator middle,
BidirectionalIterator last);
void // as above but using comp
inplace merge(
BidirectionalIterator first,
BidirectionalIterator middle,
BidirectionalIterator last,
Compare comp);
4.3.3 Functions on Sets
Can work on sorted associcative containers (see
2.7). For multiset the interpretation of —
union, intersection and difference is by:
maximum, minimum and substraction of
occurrences respectably.
Let Si = [firsti, lasti) for i = 1, 2.
bool // S1   S2
includes(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2);
bool // as above but using comp
includes(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
Compare comp);
OutputIterator // S1 [ S2, xpast end
set union(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result);
OutputIterator // as above but using comp
set union(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result,
Compare comp);
OutputIterator // S1 \ S2, xpast end
set intersection(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result);
OutputIterator // as above but using comp
set intersection(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result,
Compare comp);
OutputIterator // S1 \ S2, xpast end
set difference(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result);
OutputIterator // as above but using comp
set difference(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result,
Compare comp);
OutputIterator // S1
MS2, xpast end
set symmetric difference(
InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result);
OutputIterator // as above but using comp
set symmetric difference(
InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
OutputIterator result,
Compare comp);
4.3.4 Heap
void // (last - 1) is pushed
push heap(RandomAccessIterator first,
RandomAccessIterator last);
void // as above but using comp
push heap(RandomAccessIterator first,
RandomAccessIterator last,
Compare comp);
void // first is popped
pop heap(RandomAccessIterator first,
RandomAccessIterator last);
void // as above but using comp
pop heap(RandomAccessIterator first,
RandomAccessIterator last,
Compare comp);
void // [first,last) arbitrary ordered
make heap(RandomAccessIterator first,
RandomAccessIterator last);
void // as above but using comp
make heap(RandomAccessIterator first,
RandomAccessIterator last,
Compare comp);
void // sort the [first,last) heap
sort heap(RandomAccessIterator first,
RandomAccessIterator last);
void // as above but using comp
sort heap(RandomAccessIterator first,
RandomAccessIterator last,
Compare comp);
4.3.5 Min and Max
const T& min(const T& x0, const T& x1);
const T& min(const T& x0,
const T& x1,
Compare comp);
const T& max(const T& x0, const T& x1);
const T& max(const T& x0,
const T& x1,
Compare comp);
ForwardIterator
min element(ForwardIterator first,
ForwardIterator last);
ForwardIterator
min element(ForwardIterator first,
ForwardIterator last,
Compare comp);
ForwardIterator
max element(ForwardIterator first,
ForwardIterator last);
ForwardIterator
max element(ForwardIterator first,
ForwardIterator last,
Compare comp);
4.3.6 Permutations
To get all permutations, start with ascending
sequence end with descending.
bool // x iff available
next permutation(
BidirectionalIterator first,
BidirectionalIterator last);
bool // as above but using comp
next permutation(
BidirectionalIterator first,
BidirectionalIterator last,
Compare comp);
bool // x iff available
prev permutation(
BidirectionalIterator first,
BidirectionalIterator last);
bool // as above but using comp
prev permutation(
BidirectionalIterator first,
BidirectionalIterator last,
Compare comp);
4.3.7 Lexicographic Order
bool lexicographical compare(
InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2);
bool lexicographical compare(
InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
InputIterator2 last2,
Compare comp);
4.4 Computational
#include <numeric>
T //
P
[first,last) +7.6
accumulate(InputIterator first,
InputIterator last,
T initVal);
T // as above but using binop
accumulate(InputIterator first,
InputIterator last,
T initVal,
BinaryOperation binop);
T //
P
i e1i
× e2i
for eki
2 Sk, (k = 1, 2)
inner product(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
T initVal);
T // Similar, using
P(sum) and ×mult
inner product(InputIterator1 first1,
InputIterator1 last1,
InputIterator2 first2,
T initVal,
BinaryOperation sum,
BinaryOperation mult);
OutputIterator // rk =
Pfirst+k
i=first
ei
partial sum(InputIterator first,
InputIterator last,
OutputIterator result);
OutputIterator // as above but using binop
partial sum(
InputIterator first,
InputIterator last,
OutputIterator result,
BinaryOperation binop);
OutputIterator // rk = sk - sk-1 for k > 0
adjacent difference( // r0 = s0
InputIterator first,
InputIterator last,
OutputIterator result);
OutputIterator // as above but using binop
adjacent difference(
InputIterator first,
InputIterator last,
OutputIterator result,
BinaryOperation binop);
5 Function Objects
#include <functional>
templatehclass Arg, class Resulti
struct unary function {
typedef Arg argument type;
typedef Result result type;}
Derived unary objects:
struct negatehTi;
struct logical nothTi;
+ 7.6
templatehclass Arg1, class Arg2,
class Resulti
struct binary function {
typedef Arg1 first argument type;
typedef Arg2 second argument type;
typedef Result result type;}
Following derived template objects accept two
operands. Result obvious by the name.
struct plushTi;
struct minushTi;
struct multiplieshTi;
struct divideshTi;
struct modulushTi;
struct equal tohTi;
struct not equal tohTi;
struct greaterhTi;
struct lesshTi;
struct greater equalhTi;
struct less equalhTi;
struct logical andhTi;
struct logical orhTi;
5.1 Function Adaptors
5.1.1 Negators
templatehclass Predicatei
class unary negate : public
unary functionhPredicate::argument type,
booli;
unary negate::unary negate(
Predicate pred);
bool // negate pred
unary negate::operator()(
Predicate::argument type x);
unary negatehPredicatei
not1(const Predicate pred);
templatehclass Predicatei
class binary negate : public
binary functionh
Predicate::first argument type,
Predicate::second argument typei;
booli;
binary negate::binary negate(
Predicate pred);
bool // negate pred
binary negate::operator()(
Predicate::first argument type x
Predicate::second argument type y);
binary negatehPredicatei
not2(const Predicate pred);
5.1.2 Binders
templatehclass Operationi
class binder1st: public
unary functionh
Operation::second argument type,
Operation::result typei;
binder1st::binder1st(
const Operation& op,
const Operation::first argument type y);
// argument type from unary function
Operation::result type
binder1st::operator()(
const binder1st::argument type x);
binder1sthOperationi
bind1st(constOperation& op, const T& x);
templatehclass Operationi
class binder2nd: public
unary functionh
Operation::first argument type,
Operation::result typei;
binder2nd::binder2nd(
const Operation& op,
const Operation::second argument type y);
// argument type from unary function
Operation::result type
binder2nd::operator()(
const binder2nd::argument type x);
binder2ndhOperationi
bind2nd(constOperation& op, const T& x);
+ 7.7.
5.1.3 Pointers to Functions
templatehclass Arg, class Resulti
class pointer to unary function :
public unary functionhArg, Resulti;
pointer to unary functionhArg, Resulti
ptr fun(Result(*x)(Arg));
template<class Arg1, class Arg2,
class Result>
class pointer to binary function :
public binary functionhArg1, Arg2,
Resulti;
pointer to binary functionhArg1, Arg2,
Resulti
ptr fun(Result(*x)(Arg1, Arg2));
6 Iterators
#include <iterator>
6.1 Iterators Categories
Here, we will use:
X iterator type.
a, b iterator values.
r iterator reference (X& r).
t a value type T.
Imposed by empty struct tags.
6.1.1 Input, Output, Forward
struct input iterator tag {}+ 7.8
struct output iterator tag {}
struct forward iterator tag {}
In table follows requirements check list for
Input, Output and Forward iterators.
Expression; Requirements I O F
X()
X u
might be singular •
X(a) )X(a) == a • •
*a=t , *X(a)=t •
X u(a)
X u=a
) u == a • •
u copy of a •
a==b equivalence relation • •
a!=b ,!(a==b) • •
r = a ) r == a •
*a convertible to T.
a==b , *a==*b
• •
*a=t (for forward, if X mutable) • •
++r result is dereferenceable or
past-the-end. &r == &++r
• • •
convertible to const X& • •
convertible to X&
r==s, ++r==++s
•
r++ convertible to X&
,{X x=r;++r;return x;}
• • •
*++r
*r++
convertible to T • • •
+ 7.7.
6.1.2 Bidirectional Iterators
struct bidirectional iterator tag {}
The forward requirements and:
--r Convertible to const X&. If 9 r=++s then
--r refers same as s. &r==&--r.
--(++r)==r. (--r == --s ) r==s.
r-- , {X x=r; --r; return x;}.
6.1.3 Random Access Iterator
struct random access iterator tag {}
The bidirectional requirements and
(m,n iterator’s distance (integral) value):
r+=n , {for (m=n; m-->0; ++r);
for (m=n; m++<0; --r);
return r;} //but time = O(1).
a+n , n+a , {X x=a; return a+=n]}
r-=n , r += -n.
a-n , a+(-n).
b-a Returns iterator’s distance value n, such
that a+n == b.
a[n] , *(a+n).
a<b Convertible to bool, < total ordering.
a<b Convertible to bool, > opposite to <.
a<=b , !(a>b).
a>=b , !(a<b).
6.2 Stream Iterators
templatehclass T,
class Distance=ptrdiff ti
class istream iterator :
pubic iteratorhinput iterator tag, T, Distancei;
// end of stream +7.4
istream iterator::istream iterator();
istream iterator::istream iterator(
istream& s); +7.4
istream iterator::istream iterator(
const istream iteratorhT, Distancei&);
istream iterator::~istream iterator();
const T& istream iterator::operator*() const ;
istream iterator& // Read and store T value
istream iterator::operator++() const ;
bool // all end-of-streams are equal
operator==(const istream iterator,
const istream iterator);
templatehclass Ti
class ostream iterator :
public iteratorhoutput iterator tag, void, . . . i;
// If delim 6= 0 add after each write
ostream iterator::ostream iterator(
ostream& s,
const char* delim=0);
ostream iterator::ostream iterator(
const ostream iterator s);
ostream iterator& // Assign & write (*o=t)
ostream iterator::operator*() const ;
ostream iterator&
ostream iterator::operator=(
const ostream iterator s);
ostream iterator& // No-op
ostream iterator::operator++();
ostream iterator& // No-op
ostream iterator::operator++(int);
+ 7.4.
6.3 Typedefs & Adaptors
templatehCategory, T,
Distance=ptrdiff t,
Pointer=T*, Reference= T&i
class iterator {
Category iterator category;
T value type;
Distance difference type;
Pointer pointer;
Reference reference;}
6.3.1 Traits
templatehIi
class iterator traits {
I::iterator category
iterator category;
I::value type value type;
I::difference type difference type;
I::pointer pointer;
I::reference reference;}
Pointer specilaizations: + 7.8
templatehTi
class iterator traitshT*i {
random access iterator tag
iterator category ;
T value type;
ptrdiff t difference type;
T* pointer;
T& reference;}
templatehTi
class iterator traitshconst T*i {
random access iterator tag
iterator category ;
T value type;
ptrdiff t difference type;
const T* pointer;
const T& reference;}
6.3.2 Reverse Iterator
Transform [i%, j) 7! [j - 1,&i - 1).
templatehIteri
class reverse iterator : public iteratorh
iterator traitshIteri::iterator category,
iterator traitshIteri::value type,
iterator traitshIteri::difference type,
iterator traitshIteri::pointer,
iterator traitshIteri::referencei;
Denote
RI = reverse iterator
AI = RandomAccessIterator.
Abbreviate:
typedef RI<AI, T,
Reference, Distancei self ;
// Default constructor ) singular value
self::RI();
explicit // Adaptor Constructor
self::RI(AIi );
AI self::base(); // adpatee’s position
// so that: &*(RI(i)) == &*(i-1) Reference
self::operator*();
self // position to & return base()-1
RI::operator++();
self& // return old position and move
RI::operator++(int); // to base()-1
self // position to & return base()+1
RI::operator--();
self& // return old position and move
RI::operator--(int); // to base()+1
bool // , s0.base() == s1.base()
operator==(const self& s0, const self& s1);
reverse iterator Specific
self // returned value positioned at base()-n
reverse iterator::operator+(
Distance n) const ;
self& // change & return position to base()-n
reverse iterator::operator+=(Distance n);
self // returned value positioned at base()+n
reverse iterator::operator-(
Distance n) const ;
self& // change & return position to base()+n
reverse iterator::operator-=(Distance n);
Reference // *(*this + n)
reverse iterator::operator[](Distance n);
Distance // r0.base() - r1.base()
operator-(const self& r0, const self& r1);
self // n + r.base()
operator-(Distance n, const self& r);
bool // r0.base() < r1.base()
operator<(const self& r0, const self& r1);
6.3.3 Insert Iterators
templatehclass Containeri
class back insert iterator :
public output iterator;
templatehclass Containeri
class front insert iterator :
public output iterator;
templatehclass Containeri
class insert iterator :
public output iterator;
Here T will denote the Container::value type.
Constructors
explicit // 9 Container::push back(const T&)
back insert iterator::back insert iterator(
Container& x);
explicit // 9 Container::push front(const T&)
front insert iterator::front insert iterator(
Container& x);
// 9 Container::insert(const T&)
insert iterator::insert iterator(
Container x,
Container::iterator i);
Denote
InsIter = back insert iterator
insFunc = push back
iterMaker = back inserter +7.4
or
InsIter = front insert iterator
insFunc = push front
iterMaker = front inserter
or
InsIter = insert iterator
insFunc = insert
Member Functions & Operators
InsIter& // calls x.insFunc(val)
InsIter::operator=(const T& val);
InsIter& // return *this
InsIter::operator*();
InsIter& // no-op, just return *this
InsIter::operator++();
InsIter& // no-op, just return *this
InsIter::operator++(int);
Template Function
InsIter // return InsIterhContaineri(x)
iterMaker(Container& x);
// return insert iteratorhContaineri(x, i)
insert iteratorhContaineri
inserter(Container& x, Iterator i);
7 Examples
7.1 Vector
// safe get
int vi(const vector<unsigned>& v, int i)
{ return(i < (int)v.size() ? (int)v[i] : -1);}
// safe set
void vin(vector<int>& v, unsigned i, int n) {
int nAdd = i - v.size() + 1;
if (nAdd>0) v.insert(v.end(), nAdd, n);
else v[i] = n;
}
7.2 List Splice
void lShow(ostream& os, const list<int>& l) {
ostream_iterator<int> osi(os, " ");
copy(l.begin(), l.end(), osi); os<<endl;}
void lmShow(ostream& os, const char* msg,
const list<int>& l,
const list<int>& m) {
os << msg << (m.size() ? ":\n" : ": ");
lShow(os, l);
if (m.size()) lShow(os, m); } // lmShow
list<int>::iterator p(list<int>& l, int val)
{ return find(l.begin(), l.end(), val);}
static int prim[] = {2, 3, 5, 7};
static int perf[] = {6, 28, 496};
const list<int> lPrimes(prim+0, prim+4);
const list<int> lPerfects(perf+0, perf+3);
list<int> l(lPrimes), m(lPerfects);
lmShow(cout, "primes & perfects", l, m);
l.splice(l.begin(), m);
lmShow(cout, "splice(l.beg, m)", l, m);
l = lPrimes; m = lPerfects;
l.splice(l.begin(), m, p(m, 28));
lmShow(cout, "splice(l.beg, m, ^28)", l, m);
m.erase(m.begin(), m.end()); // <=>m.clear()
l = lPrimes;
l.splice(p(l, 3), l, p(l, 5));
lmShow(cout, "5 before 3", l, m);
l = lPrimes;
l.splice(l.begin(), l, p(l, 7), l.end());
lmShow(cout, "tail to head", l, m);
l = lPrimes;
l.splice(l.end(), l, l.begin(), p(l, 3));
lmShow(cout, "head to tail", l, m);
'à
primes & perfects:
2 3 5 7
6 28 496
splice(l.beg, m): 6 28 496 2 3 5 7
splice(l.beg, m, ^28):
28 2 3 5 7
6 496
5 before 3: 2 5 3 7
tail to head: 7 2 3 5
head to tail: 3 5 7 2
Yotam Medini 
c 1998-2007 d http://www.medini.org/stl/stl.html ) yotam.
7.3 Compare Object Sort
class ModN {
public:
ModN(unsigned m): _m(m) {}
bool operator ()(const unsigned& u0,
const unsigned& u1)
{return ((u0 % _m) < (u1 % _m));}
private: unsigned _m;
}; // ModN
ostream_iterator<unsigned> oi(cout, " ");
unsigned q[6];
for (int n=6, i=n-1; i>=0; n=i--)
q[i] = n*n*n*n;
cout<<"four-powers: ";
copy(q + 0, q + 6, oi);
for (unsigned b=10; b<=1000; b *= 10) {
vector<unsigned> sq(q + 0, q + 6);
sort(sq.begin(), sq.end(), ModN(b));
cout<<endl<<"sort mod "<<setw(4)<<b<<": ";
copy(sq.begin(), sq.end(), oi);
} cout << endl;
'à
four-powers: 1 16 81 256 625 1296
sort mod 10: 1 81 625 16 256 1296
sort mod 100: 1 16 625 256 81 1296
sort mod 1000: 1 16 81 256 1296 625
7.4 Stream Iterators
void unitRoots(int n) {
cout << "unit " << n << "-roots:" << endl;
vector<complex<float> > roots;
float arg = 2.*M_PI/(float)n;
complex<float> r, r1 = polar((float)1., arg);
for (r = r1; --n; r *= r1)
roots.push_back(r);
copy(roots.begin(), roots.end(),
ostream_iterator<complex<float> >(cout,
"\n"));
} // unitRoots
{ofstream o("primes.txt"); o << "2 3 5";}
ifstream pream("primes.txt");
vector<int> p;
istream_iterator<int> priter(pream);
istream_iterator<int> eosi;
copy(priter, eosi, back_inserter(p));
for_each(p.begin(), p.end(), unitRoots);
'à
unit 2-roots:
(-1.000,-0.000)
unit 3-roots:
(-0.500,0.866)
(-0.500,-0.866)
unit 5-roots:
(0.309,0.951)
(-0.809,0.588)
(-0.809,-0.588)
(0.309,-0.951)
7.5 Binary Search
// first 5 Fibonacci
static int fb5[] = {1, 1, 2, 3, 5};
for (int n = 0; n <= 6; ++n) {
pair<int*,int*> p =
equal_range(fb5, fb5+5, n);
cout<< n <<":["<< p.first-fb5 <<’,’
<< p.second-fb5 <<") ";
if (n==3 || n==6) cout << endl;
}
'à
0:[0,0) 1:[0,2) 2:[2,3) 3:[3,4)
4:[4,4) 5:[4,5) 6:[5,5)
7.6 Transform & Numeric
template <class T>
class AbsPwr : public unary_function<T, T> {
public:
AbsPwr(T p): _p(p) {}
T operator()(const T& x) const
{ return pow(fabs(x), _p); }
private: T _p;
}; // AbsPwr
template<typename InpIter> float
normNP(InpIter xb, InpIter xe, float p) {
vector<float> vf;
transform(xb, xe, back_inserter(vf),
AbsPwr<float>(p > 0. ? p : 1.));
return( (p > 0.)
? pow(accumulate(vf.begin(), vf.end(), 0.),
1./p)
: *(max_element(vf.begin(), vf.end())));
} // normNP
float distNP(const float* x, const float* y,
unsigned n, float p) {
vector<float> diff;
transform(x, x + n, y, back_inserter(diff),
minus<float>());
return normNP(diff.begin(), diff.end(), p);
} // distNP
float x3y4[] = {3., 4., 0.};
float z12[] = {0., 0., 12.};
float p[] = {1., 2., M_PI, 0.};
for (int i=0; i<4; ++i) {
float d = distNP(x3y4, z12, 3, p[i]);
cout << "d_{" << p[i] << "}=" << d << endl;
}
'à
d_{1}=19
d_{2}=13
d_{3.14159}=12.1676
d_{0}=12
7.7 Iterator and Binder
// self-refering int
class Interator : public
iterator<input_iterator_tag, int, size_t> {
int _n;
public:
Interator(int n=0) : _n(n) {}
int operator*() const {return _n;}
Interator& operator++() {
++_n; return *this; }
Interator operator++(int) {
Interator t(*this);
++_n; return t;}
}; // Interator
bool operator==(const Interator& i0,
const Interator& i1)
{ return (*i0 == *i1); }
bool operator!=(const Interator& i0,
const Interator& i1)
{ return !(i0 == i1); }
struct Fermat: public
binary_function<int, int, bool> {
Fermat(int p=2) : n(p) {}
int n;
int nPower(int t) const { // t^n
int i=n, tn=1;
while (i--) tn *= t;
return tn; } // nPower
int nRoot(int t) const {
return (int)pow(t +.1, 1./n); }
int xNyN(int x, int y) const {
return(nPower(x)+nPower(y)); }
bool operator()(int x, int y) const {
int zn = xNyN(x, y), z = nRoot(zn);
return(zn == nPower(z)); }
}; // Fermat
for (int n=2; n<=Mp; ++n) {
Fermat fermat(n);
for (int x=1; x<Mx; ++x) {
binder1st<Fermat>
fx = bind1st(fermat, x);
Interator iy(x), iyEnd(My);
while ((iy = find_if(++iy, iyEnd, fx))
!= iyEnd) {
int y = *iy,
z = fermat.nRoot(fermat.xNyN(x, y));
cout << x << ’^’ << n << " + "
<< y << ’^’ << n << " = "
<< z << ’^’ << n << endl;
if (n>2)
cout << "Fermat is wrong!" << endl;
}
}
}
'à
3^2 + 4^2 = 5^2
5^2 + 12^2 = 13^2
6^2 + 8^2 = 10^2
7^2 + 24^2 = 25^2
7.8 Iterator Traits
template <class Itr>
typename iterator_traits<Itr>::value_type
mid(Itr b, Itr e, input_iterator_tag) {
cout << "mid(general):\n";
Itr bm(b); bool next = false;
for ( ; b != e; ++b, next = !next) {
if (next) { ++bm; }
}
return *bm;
} // mid<input>
template <class Itr>
typename iterator_traits<Itr>::value_type
mid(Itr b, Itr e,
random_access_iterator_tag) {
cout << "mid(random):\n";
Itr bm = b + (e - b)/2;
return *bm;
} // mid<random>
template <class Itr>
typename iterator_traits<Itr>::value_type
mid(Itr b, Itr e) {
typename
iterator_traits<Itr>::iterator_category t;
mid(b, e, t);
} // mid
template <class Ctr>
void fillmid(Ctr& ctr) {
static int perfects[5] =
{6, 14, 496, 8128, 33550336},
*pb = &perfects[0];
ctr.insert(ctr.end(), pb, pb + 5);
int m = mid(ctr.begin(), ctr.end());
cout << "mid=" << m << "\n";
} // fillmid
list<int> l; vector<int> v;
fillmid(l); fillmid(v);
'à
mid(general):
mid=496
mid(random):
mid=496


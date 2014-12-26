#include <iostream>
#include <string.h>
#include <stack>
#include <list>
#include <vector>
using namespace std;
void print(string, string,int,string);
void printa(string, string,string,int,string);
int searchv(string);
int searchk(string);
void addk(string,string);
void addka(string,string,string);
void addv(string, string);
void printst();
int quadCount=0;
int tempcount=-1;
//list <float>	parameters;// this stack is for parameters
struct id{
	char *name;// name of id or expression
	int length; //length of name
//	int iValue;//int value
//	float rValue;// flaut value
	string *place;// code that is generated
	list<int> *truelist;
	list<int> *falselist;
	list<int> *nextlist;	
	list<int> *returnlist;
	list<int> *returnpointlist;
	int quad; //next quadruple
	int lastQuad;
	string *type;// it would be arithmetic or boolean expression
	string *bid;
	string *bidAssign;
	int pushedVar;
	string *valType;// integer or real
};
string itoa(int num);
string quadruple[4000];// quadruple for code generation
class symbolTable;
stack <symbolTable*> tblPtr;
stack <int> offset;
class attribute{
public:
	virtual int getLowerLimit(){
		return 0;
	}
	virtual void setLowerLimit(int ll){
	}
	virtual int getHigherLimit(){
		return 0;
	}
	virtual void setHigherLimit(int hl){
	}
	virtual string getType(){
		return "";
	}
	virtual void setType(string s){
	}
	virtual string getReturnType(){
		return "";
	}
	virtual void setReturnType(string rt){
	}
	virtual int getArgumentCount(){
		return 0;
	}
	virtual void setArgumentCount(int an){
	}
};
class arrayAttribute: public attribute{
public:
	int lowerLimit;
	int higherLimit;
	string type;
	arrayAttribute(int lowerLimit, int higherLimit,string type){
		this ->lowerLimit = lowerLimit;
		this->higherLimit = higherLimit;
		this->type= type;
	}
		virtual int getLowerLimit(){
		return lowerLimit;
	}
	virtual void setLowerLimit(int ll){
		lowerLimit = ll;
	}
	virtual int getHigherLimit(){
		return higherLimit;
	}
	virtual void setHigherLimit(int hl){
		higherLimit = hl;
	}
	virtual string getType(){
		return type;
	}
	virtual void setType(string s){
		type=s;
	}
};
class procedureAttribute: public attribute{
public:
	int argumentCount;
	string returnType;
	int start;
	procedureAttribute(int argumentCount,string returnType,int start){
		setReturnType(returnType);
		setArgumentCount(argumentCount);
		this->start=start;
	}
	virtual string getReturnType(){
		return returnType;
	}
	virtual void setReturnType(string rt){
		returnType=rt;
	}
	virtual int getArgumentCount(){
		return argumentCount;
	}
	virtual void setArgumentCount(int an){
		argumentCount = an;
	}
	
};
class symbolTableNode{
public:
	string name;
	string type;
	string	idType;// this is for precedures to check wether this identifier is local or it is parameter
	int	alias;// for procedures that returns order in the stack
	attribute *Attribute;
	int offset;
	symbolTable *forwardPointer;
	symbolTableNode *next;
	symbolTableNode *prev;
	};
//class procatt{
//	int nArgument;
//	string typeReturned;
//};
class symbolTable{
public:
	symbolTableNode *first;
	symbolTableNode *last;
	symbolTable(){
		size = 0;
	}
	int header;
	int size ;
	symbolTable *backwardPointer;
	symbolTableNode *enter(string name,int length,string type,attribute *attribute1, int offset,int alias,string idType)// we use lenght for resolve the problem in sending the name of id
	{
		name = name.substr(0, length);
		symbolTableNode *nstn= new symbolTableNode();
		nstn->name = name;
		nstn->type = type;
		nstn->alias=alias;
		nstn->idType=idType;
		nstn->Attribute = attribute1;
		nstn->forwardPointer = NULL;
		if (size == 0)
		{
			this->first = nstn;
			this->first->next=NULL;
			this->first->prev=NULL;
			this->last=this->first;
		}
		else{
			nstn->next= this->last->next;
			this->last->next= nstn;
			nstn->prev= this->last;
			this->last = nstn;
		}
		size++;
		return nstn;
	}
	void enterProc(string name,int length,procedureAttribute *attribute1,symbolTable *newtable){
		name = name.substr(0, length);
		symbolTableNode *nstn= new symbolTableNode();
		nstn->name = name;
		nstn->type = "PROC";
		nstn->Attribute = attribute1;
		nstn->forwardPointer = newtable;
		if (size == 0)
		{
			this->first = nstn;
			this->first->next=NULL;
			this->first->prev=NULL;
			this->last=this->first;
		}
		else{
			nstn->next= this->last->next;
			this->last->next= nstn;
			nstn->prev= this->last;
			this->last = nstn;
		}
		size++;
	}
	int lookup(string name,int length){
	name = name.substr(0,length);
	symbolTable *s = this;
	//cout << "BEGIN COMPARING" <<endl;
	while(s){
	//cout <<"IN THE WHILE"<<endl;
		if (s->first)
			for (symbolTableNode *stn= s->last; stn ; stn= stn->prev){
				if (!stn) break;
		//		cout << "COMPARING ..."<< stn->name <<"WITH..." << name << endl;
				if ( !stn->name.compare(name))
					return 1;
		//		cout <<"IN THE FOR"<<endl;
			}
	//	cout <<"NEXT WHILE"<< endl;
		s = s->backwardPointer;
	}
//	cout << "OUT OF WHILE"<<endl;
		return 0;
	}
	symbolTableNode *lookupNode(string name,int length){
	name = name.substr(0,length);
	symbolTable *s = this;
	//cout << "BEGIN COMPARING" <<endl;
	while(s){
	//cout <<"IN THE WHILE"<<endl;
		if (s->first)
			for (symbolTableNode *stn= s->last; stn ; stn= stn->prev){
				if (!stn) break;
		//		cout << "COMPARING ..."<< stn->name <<"WITH..." << name << endl;
				if ( !stn->name.compare(name))
					return stn;
		//		cout <<"IN THE FOR"<<endl;
			}
	//	cout <<"NEXT WHILE"<< endl;
		s = s->backwardPointer;
	}
//	cout << "OUT OF WHILE"<<endl;
		return NULL;
	}
	attribute *lookupAttribute(string name,int length){
	name = name.substr(0,length);
	symbolTable *s = this;
//	cout << "BEGIN COMPARING" <<endl;
	while(s){
//	cout <<"IN THE WHILE"<<endl;
		if (s->first)
			for (symbolTableNode *stn= s->last; stn ; stn= stn->prev){
				if (!stn) break;
		//		cout << "COMPARING ..."<< stn->name <<"WITH..." << name << endl;
				if ( !stn->name.compare(name))
					return stn->Attribute;
		//		cout <<"IN THE FOR"<<endl;
			}
	//	cout <<"NEXT WHILE"<< endl;
		s = s->backwardPointer;
	}
	//cout << "OUT OF WHILE"<<endl;
		return NULL;
	}	
	string lookupType(string name,int length){
	name = name.substr(0,length);
	symbolTable *s = this;
	//cout << "BEGIN COMPARING" <<endl;
	while(s){
	//cout <<"IN THE WHILE"<<endl;
		if (s->first)
			for (symbolTableNode *stn= s->last; stn ; stn= stn->prev){
				if (!stn) break;
		//		cout << "COMPARING ..."<< stn->name <<"WITH..." << name << endl;
				if ( !stn->name.compare(name))
					return stn->type;
		//		cout <<"IN THE FOR"<<endl;
			}
	//	cout <<"NEXT WHILE"<< endl;
		s = s->backwardPointer;
	}
	//cout << "OUT OF WHILE"<<endl;
		return "";
	}
};
symbolTable *makeTable(symbolTable *s){
	symbolTable *news = new symbolTable();
	news->backwardPointer = s;
	news->first = NULL;
	news->last = NULL;
	return news;
}

int addWidth(symbolTable *s,int width){
	s->header = width;
}

/*
int searchv(string name){
	symbolTableNode *current; // fuer suchen
	current = stv.first;
	int index = 0;
	while( current!= NULL){
		if ( !current->name.compare(name))
			return index;
		else
			current= current->next;
		index++;
	}
	return -1; // it is not existed
}
int searchk(string name){
	symbolTableNode *current; // fuer suchen
	current = stk.first;
	int index = 0;
	while( current!= NULL){
		if ( !current->name.compare(name)) //when it is the same it returns 0
			return index;
		else
			current= current->next;
		index++;
	}
	return -1; // it is not existed
}
void addv(string name,int length, string type){
	name = name.substr(0, length);
	int i= searchv(name);
	if ( i != -1 ){
		print(name, type, i, "founded");
		return;
	}
	symbolTableNode *current;
	current = new symbolTableNode;
	current->name= name;
	current->type= type;
	current->next= stv.last->next;
	stv.last->next= current;
	current->prev= stv.last;
	stv.last = current;
	stv.lastindex++;
	current->index= stv.lastindex;
	print(name, type, stv.lastindex,"added");
	return;
}
void addk(string name, string type){
	int i= searchk(name);
	if ( i != -1 ){
		print(name, type, i,"founded");
		return;
	}
	symbolTableNode *current;
	current = new symbolTableNode;
	current->name= name;
	current->type= type;
	current->next= stk.last->next;
	stk.last->next= current;
	current->prev= stk.last;
	stk.last = current;
	stk.lastindex++;
	current->index=stk.lastindex;
	current->attribute = "";
	print(name, type, stk.lastindex,"added");
	return;
}
void addka(string name, string type, string attribute){
	int i= searchk(name);
	if ( i != -1 ){
		print(name, type, i,"founded");
		return;
	}
	symbolTableNode *current;
	current = new symbolTableNode;
	current->name= name;
	current->type= type;
	current->next= stk.last->next;
	stk.last->next= current;
	current->prev= stk.last;
	stk.last = current;
	stk.lastindex++;
	current->index=stk.lastindex;
	current->attribute = attribute;
	printa(name, type, attribute,stk.lastindex,"added");
	return;
}
void printst(){
	symbolTableNode *current;
	current = stk.first;
	cout << "Symbol Table:"<< endl;
	while(current!= NULL){
		cout <<current->index<<"	";
		cout<< current->name.c_str() << "	";
		cout<<"Token: "<< current->type.c_str();
		if ( current->attribute.compare(""))
			cout <<"\t\t Attribute" <<" " << current->attribute.c_str();
		cout<< endl;
		current = current->next;
	}
	current=stv.first;
	while(current!= NULL){
		cout <<current->index+ stk.lastindex<<"	"<< current->name.c_str() << "	" <<"Token: "<< current->type.c_str()<< endl;
		current = current->next;
	}
} */
list<int> makeList(int label){
	list<int> l;
	l.push_back(label);
	return l;
	
}
list<int> merge(list<int> l1,list<int> l2){
	l1.merge(l2);
	return l1;
}
list<int> merge(list<int> l1,list<int> l2,list<int> l3){
	l1.merge(l2);
	l1.merge(l3);
	return l1;
}
list<int> merge(list<int> l1,list<int> l2,list<int> l3,list<int> l4){
	l1.merge(l2);
	l1.merge(l3);
	l1.merge(l4);
	return l1;
}
list<int> merge(list<int> l1,list<int> l2,list<int> l3,list<int> l4,list<int> l5){
	l1.merge(l2);
	l1.merge(l3);
	l1.merge(l4);
	l1.merge(l5);
	return l1;
}
void backpatch(list<int> l,int lable)
{
	int cur;
	while(l.size()!=0)
	{
		cur = l.front();
		cout << cur << endl;
		l.pop_front();
		char *temp = (char*) malloc(100);
		sprintf(temp,"a%i",lable);
		quadruple[cur]+=temp;
	}
}
void backpatch(list<int> l,string s)
{
	int cur;
	while(l.size()!=0)
	{
		cur = l.front();
		l.pop_front();
		quadruple[cur]+=s;
	}
}

string newtemp()
{
	//char *temp=(char *)malloc(100);
	//sprintf(temp, "T%i", ++tempcount);
	string temp;
	temp="";
	temp=temp.substr(0,0);
	temp=temp+"parameters.at(";
	temp=temp+itoa(++tempcount+5);
	temp=temp+")";
	return temp;
}
string getTemp(int i)
{
	//char *temp=(char *)malloc(100);
	//sprintf(temp, "T%i", ++tempcount);
	string temp;
	temp="";
	temp=temp.substr(0,0);
	temp=temp+"parameters.at(";
	temp=temp+itoa(i+5);
	temp=temp+")";
	return temp;
}
int getTempCount(){
	return tempcount+1;// for the first one is used is tempcount +5 +1
}
void setTempCount(){
	tempcount=0;
}
void emit(string stmt0 ,string stmt1,string stmt2,string stmt3,string stmt4,string stmt5)
{
	stmt0=stmt0.substr(0,stmt0.length());
	stmt1=stmt1.substr(0,stmt1.length());
	stmt2=stmt2.substr(0,stmt2.length());
	stmt3=stmt3.substr(0,stmt3.length());
	stmt4=stmt4.substr(0,stmt4.length());
	stmt5=stmt5.substr(0,stmt5.length());
	quadruple[quadCount]=stmt0+stmt1+stmt2+stmt3+stmt4+stmt5;
	quadCount ++ ;
}
string concatstring(string stmt0 ,string stmt1,string stmt2,string stmt3,string stmt4,string stmt5){
	stmt0=stmt0.substr(0,stmt0.length());
	stmt1=stmt1.substr(0,stmt1.length());
	stmt2=stmt2.substr(0,stmt2.length());
	stmt3=stmt3.substr(0,stmt3.length());
	stmt4=stmt4.substr(0,stmt4.length());
	stmt5=stmt5.substr(0,stmt5.length());
	return stmt0+stmt1+stmt2+stmt3+stmt4+stmt5;
}
int getquadCount(){
	return quadCount;
}

void notArrayType(string name, int length){
	name = name.substr(0,length);
	cout <<"ERROR !!  "<< name << "   is not array type"<<endl;
}
void keywordError(string name,int length){
	name = name.substr(0,length);
	cout <<"ERROR !! "<<name << " is keyword, you are not allowed to use it!"<<endl;
}
void writeName(string name,int length){
	name = name.substr(0,length);
	cout << name;
}
string getName(string name,int length){
	name=name.substr(0,length);
	return name;
}
string *stringReturn(string name,int length){
	string *s=new string(name.substr(0,length));
	return s;
}
string itoa(int num)
{
	char c;
	string s = "";
	int digit;
	if (num==0)
		return "0";
	while(num > 0)
	{
		digit = num % 10;
		num = num / 10;
		c = digit + 48;
		s = c + s ;
	}
	return s;
}
string ftoa(double num)
{
	char c;
	string s = "";
	s.substr(0,0);
	char *temp = (char*) malloc(100);
	sprintf(temp,"%e",num);
	s+=temp;
/*	int digit;
	float temp=num;
	int cast;
	if (num==0)
		return "0";
	while(num > 0)
	{
		digit = (int)num % 10;
		num = num / 10;
		c = digit + 48;
		s = c + s ;
	}
	num=temp;
	cast=(int)num;
//	num=num-(float)atoi(s.c_str);
	num=num-cast;
	s=s+'.';

	while(num > 0)
	{
		digit = (int)(num*10) % 10;
		num= (num*10.0)-digit;
		c=digit+48;
		s=s+c;
	}*/
	return s;
}
string *procedureParameter(string name,int length,symbolTable *t,int localCount,int parameterCount){// we use local count to understand how much local variable is pushed until now
	name=name.substr(0,length);
	symbolTableNode *stn=t->lookupNode(name,length);// we found a node that has this name
	string s;
	string temp;
	string temp1;
	//cout << "procedureParameter enter"<<endl;
	if (!stn->idType.compare("local")){
		temp = string(newtemp());
		emit(temp," = ",itoa(localCount)," - ",itoa(stn->alias-1),"");
		temp1= string(newtemp());
		emit(temp1, " = ","parameters.size() -",temp,"","");
		emit(temp," = ","parameters.at( ",temp1," )","");
		s=temp;
		return new string(s);//with this you have the local parameter
	}else if (!stn->idType.compare("parameter")){
		temp = string(newtemp());
		emit(temp," = ",itoa(localCount+4+parameterCount)," - ",itoa(stn->alias-1),"");
		temp1= string(newtemp());
		emit(temp1, " = ","parameters.size() -",temp,"","");
		emit(temp," = ","parameters.at( ",temp1," )","");
		s=temp;
		return new string(s);
	}
	else return NULL;
}
string *procedureParameterArray(string name,int length,symbolTable *t,int localCount,int parameterCount){// we use local count to understand how much local variable is pushed until now
	name=name.substr(0,length);
	symbolTableNode *stn=t->lookupNode(name,length);// we found a node that has this name
	string s;
	string temp;
	string temp1;
	//cout << "procedureParameter enter"<<endl;
	if (!stn->idType.compare("local")){
		temp = string(newtemp());
		emit(temp," = ",itoa(localCount)," - ",itoa(stn->alias-1),"");
		temp1= string(newtemp());
		emit(temp1, " = ","parameters.size() -",temp,"","");
		s=temp1;
		return new string(s);//with this you have the local parameter
	}else if (!stn->idType.compare("parameter")){
		temp = string(newtemp());
		emit(temp," = ",itoa(localCount+4+parameterCount)," - ",itoa(stn->alias-1),"");
		temp1= string(newtemp());
		emit(temp1, " = ","parameters.size() -",temp,"","");
		s=temp1;
		return new string(s);
	}
	else return NULL;
}
string *procedureParameterAssign(string name,int length,symbolTable *t,int localCount,int parameterCount){// we use local count to understand how much local variable is pushed until now
	name=name.substr(0,length);
	symbolTableNode *stn=t->lookupNode(name,length);// we found a node that has this name
	string s;
	string temp;
	string temp1;
	//cout << "procedureParameter enter"<<endl;
	if (!stn->idType.compare("local")){
		temp = string(newtemp());
		emit(temp," = ",itoa(localCount)," - ",itoa(stn->alias-1),"");
		temp1= string(newtemp());
		emit(temp1, " = ","parameters.size() -",temp,"","");
		s="parameters.at( ";
		s.substr(0,15);
		s=s+temp1;
		s=s+" )";
		return new string(s);//with this you have the local parameter
	}else if (!stn->idType.compare("parameter")){
		temp = string(newtemp());
		emit(temp," = ",itoa(localCount+4+parameterCount)," - ",itoa(stn->alias-1),"");
		temp1= string(newtemp());
		emit(temp1, " = ","parameters.size() -",temp,"","");
		s="parameters.at( ";
		s.substr(0,15);
		s=s+temp1;
		s=s+" )";
		return new string(s);
	}
	else return NULL;
}
string	*parameterStackAt(int i,int sp){// sp is offset if you are using top then is 0 for sp uses sp
	string s="";
	s=s.substr(0,0);
	string temp;
	temp = string(newtemp());
	emit(temp, " = ","parameters.size() -",itoa(sp+i),"","");
	s=s+"parameters.at( ";
	s=s+temp;
	s=s+" )";
	s=s+'\0';
	s=s.substr(0,s.length()-1);
	return new string(s);
	
}
string *changeTop(int i){ // with this string you pop from the vector n times 
	string s="\nparameters.pop_back()";
	s=s.substr(0,23);
	string temp=";\nparameters.pop_back()";
	temp=temp.substr(0,24);
	for (int j=1; j<i; j++)
		s=s+temp;
	s=s+'\0';
	s=s.substr(0,s.length()-1);
	return new string(s);
}
string *returnString(list<int> l){
	string s="";
	s=s.substr(0,0);
	int cur;
	while(l.size()!=0)
	{
		cur = l.front();
		l.pop_front();
		s=";"+s;
		s=itoa(cur+5)+s;
		s= " ) goto a"+s;
		s=itoa(cur+5)+s;
		s=" == "+s;
		s="parameters.at(2)"+s;
		s="\nif ( "+s;	
	}
		s=s+"\n";
		s=s.substr(0,s.length()-2);
	return new string(s);
}
void print(string lexeme, string token, int index, string action){
	cout<<"Lexeme: "<<lexeme.c_str()<<"\t\tToken: "<<token.c_str() <<" "<< index<<"	"<<action.c_str() <<endl;
}
void printa(string lexeme, string token,string attribute, int index, string action){
	cout<<"Lexeme: "<<lexeme.c_str()<<"\t\tToken: "<<token.c_str() <<"\t\t Attribute:"<<" "<<attribute.c_str()<<" "<< index<<"	"<<action.c_str() <<endl;
}
void declerationError(string name, int length){
	name = name.substr(0,length);
	cout << "ERROR !!  error in decleration:  " << name<<"  !!please declare it first" << endl;
}
void errorArgument(string name, int length){
	name = name.substr(0,length);
	cout << "ERROR !!  error in number of arguments of   :" <<name<<"  !!" << endl;
}
void redeclerationError(string name, int length){
	name = name.substr(0,length);
	cout << "ERROR !!  error in redeclaration  "<< name <<" !!"<< endl;
}
void arrayBounderyError(string name, int length){
	name = name.substr(0,length);
	cout << "aERROR !!  rray out of boundary  " << name <<"   !!"<<endl;	
}

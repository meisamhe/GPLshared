%{
	#include <iostream>
	#include <string.h>
	#include <stdlib.h>
	#include "symboltable.cpp"
	using namespace std;
	int yylex(void);
	void yyerror(char *);
	list <symbolTableNode*> tblNodePtr;
	int arrayLowerLimit, arrayHigherLimit;
	string type;
	int parameterCount;
	int raviyeh; // whether we are in parameter_list reducing or not
	int raviyehCall;
	int argumentCount;
	string returnType;
	int procedureStart;
	int alias;
	string idType;
	int localCount;
	int raviyehStart;
	string *tempstr;
	string currentProcedure;
	int lowertemp;
	int hightemp;
	string bid,bidAssign;
//	stack<float>	parameter;
%}
%union	{
	double dval;
	int ival;
	struct id *sid;
}
%token	BARNAMEH
%token	<sid> ID
%token	MOTAGHAYER
%token	SAHIH
%token	ASHARI
%token	RAVIEH
%token	SHOROO
%token	KHATEMEH
%token	BARAYE
%token	DAR
%token	HALGHEH
%token	ENTEHAYE_HALGHEH
%token	<ival> SAHIH_CONST	
%token	<dval> ASHARI_CONST
%token	TAGHSIM_BAR
%token	BAGHIMANDEH
%token	VA
%token	YA
%token	NA
%token	ARAYEH
%token	AZ
%token	TA
%token	MAKOOS
%token	KHOROOJ
%token	VAGHTI_KEH
%token	KHATEMEH_AGAR
%token	GHEYR
%token	GHEYR_AGAR
%token	ANGAH
%token 	AGAR
%token	GE;
%token	NE;
%token	LE;
%token 	BEKHAN;
%token	BENEVIS;
%token 	ASSIGN;
%token	VAPAS;
%token	YAGHEYR;
%token INVALIDTOKEN;
%token RETURN;

%left VA YA YAGHEYR VAPAS
%left GE NE LE '>' '<' '=' 
%right NA
%left '-' '+'
%left '*' '/'
%left TAGHSIM_BAR BAGHIMANDEH

%type <sid> expression ME gheir gheir_main 
%type <sid> gheiragar arrayAssign
%type <sid> gheiragar_main statement 
%type <sid> statement_main compound_statement statement_list_main
%type <sid>	statement_list compound_statement_main
%type <sid> AM1 AM2 AN declarations BMD BID BMDM MBS
%type <sid> loop_statement loop_statement_main break_statement break_statement_main 
%type <sid> SLMM PM1 procedure_list procedure actual_parameter actual_parameter_list arguments program N4 N3

%%
	program: 
		BARNAMEH M1 ID ';'  procedure_list PM1 compound_statement_main '.' {cout <<  "program --> BARNAMEH ID declarations procedure_list_main compund_statement"<<endl;
																	//code back patch generation
																	$$= new struct id;
																	$$->returnlist= new list<int>(merge(*$5->returnlist,*$7->returnlist));
																	string temp=string(*returnString(*$$->returnlist));
																	backpatch(*$5->returnpointlist,temp);
																	cout << "#include <fstream.h>"  << endl; 
																	cout << "#include <string>"  << endl; 
																	cout << "#include <stdio.h>"  << endl; 
																	cout << "#include <vector>"<<endl;
																	cout << "#include <iostream.h>"<<endl;
																	cout << "using namespace std;"<<endl;
																	cout <<"vector <double>	parameters;"<<endl;// this is stack of parameters
																	addWidth(tblPtr.top(),offset.top());
																	//code generation
																	backpatch(*$7->nextlist,getquadCount());
																	symbolTable *st = tblPtr.top();
																	/*for(symbolTableNode *stn=st->first; stn ; stn= stn->next)
																	{
																		if (!stn->type.compare("SAHIH"))  
																		{
																			cout << "int " << stn->name << ";" <<  endl ; 
																		}
																		else if (!stn->type.compare("ASHARI")) 
																		{
																			cout << "float "<<stn->name<< ";" <<  endl ; 
																		}
																	}*/
																	cout << "int main()" << endl; 
																	cout <<  "{ " << endl ;
																	/*sp(0)*/			cout <<"parameters.push_back(0);"<<endl;// this id is for parameter stack  is (int sp)
													/*returnValue(1)*/	cout <<"parameters.push_back(0);"<<endl;	//value that is returned from the procedure is pushed here (float returnValue)
													/*returnAddress(2)*/	cout <<"parameters.push_back(0);"<<endl;	// for saving the comming back address(int returnAddress;)
													/*lowertemp(3)*/		cout <<"parameters.push_back(0);"<<endl;	// for the lowerbound of pushing back temp identifiers
													/*lowertemp(4)*/		cout <<"parameters.push_back(0);"<<endl;	// for the higherbound of pushing back temp identifiers
																	/*temp(5+i)*/		for (int i=0; i<tempcount+1;i++)
																		cout << "parameters.push_back(0);"<<endl;
																	cout << "goto a"<< itoa($6->quad)<<" ; "<<endl;// goto to the first line of program
																	int i = 0 ; 
																	for(i=0; i<quadCount; i++)
																		if (quadruple[i] [0]!='}' && quadruple[i][0]!='{')
																			cout << "a" << i << " : " <<quadruple[i] << ";" << endl;
																	cout << "a" << i  << " : " <<"return 0;" << endl ; 
																	cout <<"}" <<endl;
																	tblPtr.pop();
																	offset.pop();
																	raviyehStart=0;
																//	addk("BARNAMEH","BARNAMEH");
																//	addv($2->name,$2->length,"IDENTIFIER");
																//	cout << $2->name<<endl;
															}
		;
	M1 :
	{
		cout << "M1 --> "<<endl;
		symbolTable * t = makeTable(NULL) ;
		tblPtr.push(t);
		tblPtr.top()->enter("NA",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("VA",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("YA",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("GE",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("LE",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("NE",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("YAGHEYR",7,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("VAPAS",5,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BARNAMEH",8,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("MOTAGHAYER",10,"KEYWORD",NULL,0,-1,"");		
		tblPtr.top()->enter("SAHIH",5,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("ASHARI",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("RAVIEH",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("SHOROO",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("KHATEMEH",8,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BARAYE",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("DAR",3,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("HALGHEH",7,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("ENTEHAYE_HALGHEH",16,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("TAGHSIM_BAR",11,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BAGHIMANDEH",11,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BARNAMEH",8,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("ARAYEH",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("AZ",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("TA",2,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("MAKOOS",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("KHOROOJ",7,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("VAGHTI_KEH",10,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("KHATEMEH_AGAR",13,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("GHEYR",5,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("GHEYR_AGAR",10,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("ANGAH",5,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("AGAR",4,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BEKHAN",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BENEVIS",7,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("ASSIGN",6,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("VAPAS",5,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("YAGHEYR",7,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("TAGHSIM_BAR",11,"KEYWORD",NULL,0,-1,"");
		tblPtr.top()->enter("BAGHIMANDEH",11,"KEYWORD",NULL,0,-1,"");
	//	cout <<"tblPtr.top() is:"<<tblPtr.top()<<endl;
	//	cout << " LOOKUP AKBAR IS: " << tblPtr.top()->lookup("AKBAR",5)<< endl;
	//	cout <<"tblPtr.top() is:"<<tblPtr.top()<<endl;
	//	cout << " LOOKUP MEISAM IS: "<< tblPtr.top()->lookup("MEISAM",6)<<endl;
	//	cout <<"tblPtr.top() is:"<<tblPtr.top()<<endl;
		offset.push(0);
	}
	;
	declarations:
		 declaration_list 	{cout << "declarations  -->  declarations_list"<<endl;
							$$= new struct id;
							$$->nextlist=new list<int>();
							$$->returnlist=new list<int>();
							}
		;
	
	declaration_list:
		identifier_list ':' type	{ cout << "declaration_list --> identifier_list ':' type"<<endl;
									}
		;
	ravieh_declist:
		 ravieh_declist ';' identifier_list ':' type {cout << "declaration_list --> ';' identifier_list ':' type"<<endl;}
		 | identifier_list ':' type{ cout << "declaration_list --> identifier_list ':' type"<<endl;
									}
		 ;
	
		
	identifier_list:
		ID				{cout << "identifer_list --> ID"<<endl;
					//	cout << "checking meisam" << endl;
					/*	if ( raviyeh == 1){
							parameterCount++;
							idType="parameter";
							alias=parameterCount;
						}else if (raviyehStart==1){
							localCount++;
							idType="local";
							alias=localCount;
						}*/
					//	cout <<"tblPtr.top() is:"<<tblPtr.top()<<endl;
					//	cout << " LOOKUP MEISAM IS: "<< tblPtr.top()->lookup("MEISAM",6)<<endl;
					//	addv($1->name,$1->length,"MOTAGHAYER");
						if (tblPtr.top()->lookup($1->name,$1->length) == 1)
							redeclerationError($1->name,$1->length);
						else
							{
								tblNodePtr.push_back(tblPtr.top()->enter($1->name,$1->length,"",NULL,0,0,"local"));
							//	tblPtr.top()->enter($1->name,$1->length,"ONGOING",NULL,0,alias,idType);
							}
						}
		| identifier_list ',' ID	{cout << "identifer_list --> identifeir_list ',' ID"<<endl;
									//	addv($3->name,$3->length,"MOTAGHAYER");
									/*	if ( raviyeh == 1){
											parameterCount++;
											idType="parameter";
											alias=parameterCount;
										}else if (raviyehStart==1){
											localCount++;
									//		emit("parameters.push_back( ",itoa(0)," )","","",""); // for this localCount
											idType="local";
											alias=localCount;
										}*/
										if (tblPtr.top()->lookup($3->name,$3->length) == 1)
											redeclerationError($3->name,$3->length);
										else
										{
									//		tblPtr.top()->enter($3->name,$3->length,"ONGOING",NULL,0,alias,idType);
											tblNodePtr.push_back(tblPtr.top()->enter($3->name,$3->length,"",NULL,0,0,"local"));
										}
									}
		;
		
	type: 
		SAHIH		{cout << "type --> SAHAIH"<<endl;
					//addk("SAHIH","SAHIH");
					while( !tblNodePtr.empty()){
						if ( raviyeh == 1){
							parameterCount++;
							tblNodePtr.front()->idType="parameter";
							tblNodePtr.front()->alias=parameterCount;
						}else if (raviyehStart==1){
							localCount++;
							tblNodePtr.front()->idType="local";
							tblNodePtr.front()->alias=localCount;
							emit("parameters.push_back( ",itoa(0)," )","","",""); // for this localCount
							}
						tblNodePtr.front()->type= "SAHIH";
						tblNodePtr.front()->offset= offset.top();
					/*	if (raviyehStart!=1 && raviyeh!=1)
							emit("int ",tblNodePtr.front()->name,"","","","");*/
						int top = offset.top();
						offset.pop();
						top = top+2;
						offset.push(top);
						tblNodePtr.pop_front();
						}
					returnType="SAHIH";
					}
		| ASHARI	{cout << "type --> ASHARI"<<endl;
					//addk("ASHARI","ASHARI");
					while( !tblNodePtr.empty()){
							if ( raviyeh == 1){
							parameterCount++;
							tblNodePtr.front()->idType="parameter";
							tblNodePtr.front()->alias=parameterCount;
						}else if (raviyehStart==1){
							localCount++;
							tblNodePtr.front()->idType="local";
							tblNodePtr.front()->alias=localCount;
							emit("parameters.push_back( ",itoa(0)," )","","",""); // for this localCount
							}
							tblNodePtr.front()->type= "ASHARI";
							tblNodePtr.front()->offset= offset.top();
						/*	if (raviyehStart!=1 && raviyeh!=1)
								emit("float ",tblNodePtr.front()->name,"","","","");*/
							int top = offset.top();
							offset.pop();
							top = top+4;
							offset.push(top);
							tblNodePtr.pop_front();
						}
					returnType="ASHARI";
					}
		| array_type	{cout << "type --> array_type"<<endl;
						}
		;
	array_type:
		ARAYEH arraytype '[' range ']'	{cout << "array_type --> ARAYEH '[' range ']' AZ type"<<endl;
									//	addk("ARAYEH","ARAYEH");
									//	addk("AZ","AZ");
									arrayAttribute *arrA = new arrayAttribute(arrayLowerLimit,arrayHigherLimit,type);
									while( !tblNodePtr.empty()){
										if ( raviyeh == 1){
												parameterCount++;
												tblNodePtr.front()->idType="parameter";
												tblNodePtr.front()->alias=parameterCount;
												parameterCount+=(arrayHigherLimit-arrayLowerLimit);
											}else if (raviyehStart==1){
												localCount++;
												emit("parameters.push_back( ",itoa(0)," )","","",""); // for this localCount
												tblNodePtr.front()->idType="local";
												tblNodePtr.front()->alias=localCount;
												for (int i=arrayLowerLimit;i< arrayHigherLimit;i++){// one time is done in above
														emit("parameters.push_back( ",itoa(0)," )","","",""); // for this localCount
														localCount++;
												}
											}
										tblNodePtr.front()->type= "ARRAYE";
										
										tblNodePtr.front()->offset= offset.top();
										int top = offset.top();
										offset.pop();
										if ( !type.compare("SAHIH"))// setting offset
											top = top+2;
										else
											top = top+4;
										offset.push(top);// setting offset
										arrayAttribute *ara = new arrayAttribute(arrayLowerLimit,arrayHigherLimit,type);
										tblNodePtr.front()->Attribute = ara;
										tblNodePtr.pop_front();
										}
									}
		;
		
	procedure_list:
		procedure_list procedure	{cout << "procedure_list --> procedure_list procedure"<<endl;
										$$ = new struct id;
										$$->returnlist= new list<int>(merge(*$1->returnlist,*$2->returnlist));
										$$->returnpointlist= new list<int>(merge(*$1->returnpointlist,*$2->returnpointlist));
									} 
		|	{cout << "procedure_list --> empty "<<endl;
				$$ = new struct id;
				$$->returnlist= new list<int>();
				$$->returnpointlist= new list<int>();
			} 
		;
	
	procedure:
		type RAVIEH PID N1 parameters N2 ';' compound_statement	{cout << "procedure --> type RAVIEH ID parameters ';' compound_statement ';'"<<endl;
															//		addk("RAVIEH","RAVIEH");
															//		addv($2->name,$2->length,"MOTAGHAYER");
																	//code generation
																	backpatch(*$8->nextlist,getquadCount());
																	addWidth(tblPtr.top(),offset.top());
																	symbolTable *t = tblPtr.top();
																	tblPtr.pop();
																	offset.pop();
																	procedureAttribute *pa= new procedureAttribute(parameterCount,returnType,procedureStart);
																	tblPtr.top()->enterProc(currentProcedure,currentProcedure.length(),pa,t);
																	raviyehStart=0;
																	$$= new struct id;
																	$$->returnlist= $8->returnlist;
																	$$->returnpointlist= $8->returnpointlist;
																	currentProcedure="-1";// means that we go out of this procedure
																	}
		;
			
	PID :
			ID {
				currentProcedure= getName($1->name,$1->length);
			}
			;
			
	N1:
		{
			cout << "N1 --> "<<endl;
			raviyeh = 1;
			parameterCount = 0;
			localCount=0;
			tblPtr.push(makeTable(tblPtr.top()));
			offset.push(0);
			procedureStart=getquadCount();
		}
	;
	N2 :
		{
			cout << "N2 -->"<<endl;
			raviyeh = 0;
			raviyehStart=1;
			lowertemp=getTempCount();
		}
	;
	
	PM1:
		{
			cout << "PM1-->"<<endl;
			parameterCount = 0;
			localCount=0;
			raviyehStart=1;
			$$= new struct id;
			$$->quad=getquadCount();
			lowertemp=getTempCount();
		}
	;
	
	parameters:
		'('  ravieh_declist ')'	{cout << "parameters --> '(' ravieh_declist ')'"<<endl;}
		|'(' ')'	{cout << "parameters --> '('')'"<<endl;} 
		;
	compound_statement_main:
		N5 SHOROO statement_list_main KHATEMEH 	{cout << "compound_statement_main --> SHOROO statement_list_main KHATEMEH"<<endl;
									//	addk("SHOROO","SHOROO");
									//	addk("KHATEMEH","KHATEMEH");
									//	emit("}","","","","","");
										addWidth(tblPtr.top(),offset.top());
										symbolTable *t = tblPtr.top();
										tblPtr.pop();
										offset.pop();
										tblPtr.top()->enterProc("Compound_statement",18,NULL,t);
									//	emit("}","","","","","");
										$$= new struct id;
										$$->nextlist=$3->nextlist;
										$$->returnlist=$3->returnlist;
										}
		;	
	compound_statement:
		N5 SHOROO statement_list KHATEMEH 	{cout << "compound_statement --> SHOROO statement_list KHATEMEH"<<endl;
									//	addk("SHOROO","SHOROO");
									//	addk("KHATEMEH","KHATEMEH");
										addWidth(tblPtr.top(),offset.top());
										symbolTable *t = tblPtr.top();
										tblPtr.pop();
										offset.pop();
										tblPtr.top()->enterProc("Compound_statement",18,NULL,t);
										$$= new struct id;
										$$->nextlist=$3->nextlist;
										$$->returnlist=$3->returnlist;
										$$->returnpointlist= $3->returnpointlist;
										}
		;
	
	N5:
	{
		cout << "N5 --> "<<endl;
		tblPtr.push(makeTable(tblPtr.top()));
		offset.push(0);
	}
	;
	
	statement_list_main:
		 statement_list_main  SLMM statement_main  	{cout << "statement_list_main --> statement_list_main ';' statement_main "<<endl;
												$$= new struct id;
												$$->nextlist=$3->nextlist;// the last statement next is set to statement_list 's last
												backpatch(*$1->nextlist,$2->quad);// For the next statement is this statement
												$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
												}
		| {cout << "statement_list --> empty"<<endl;
			$$= new struct id;
			$$->nextlist=new list<int>();
			$$->returnlist=new list<int>();
			}
		;
	
	statement_list:
		 statement_list  SLMM statement  	{cout << "statement_list --> statement_list ';' statement "<<endl;
										$$= new struct id;
										$$->nextlist=$3->nextlist;// the last statement next is set to statement_list 's last
										backpatch(*$1->nextlist,$2->quad);// For the next statement is this statement
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->returnpointlist= new list<int>(merge(*$1->returnpointlist,*$3->returnpointlist));
										}
		| {cout << "statement_list --> empty"<<endl;
			$$= new struct id;
			$$->nextlist=new list<int>();
			$$->returnlist=new list<int>();
			$$->returnpointlist= new list<int>();
			}
		;
	SLMM:
		{
			$$= new struct id;
			$$->quad=getquadCount();
		}
		;
	statement_main:
		declarations 	';'	{cout << "statement --> declarations"<<endl;
							$$= new struct id;
							$$->nextlist= new list<int>();
							$$->returnlist=$1->returnlist;
							}
		| ID ASSIGN expression ';'		{cout << "statement --> ID ASSIGN expression"<<endl;
										//	cout << $1->name <<"is the best"<<endl;
										if (tblPtr.top()->lookup($1->name,$1->length)== 0)
											declerationError($1->name,$1->length);
										else
										if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
												keywordError($1->name,$1->length);
								//		addv($1->name,$1->length,"MOTAGHAYER");
										else{	//code generation
											if (!$3->type->compare("boolean")){
												backpatch(*$3->truelist,getquadCount());
												backpatch(*$3->falselist,getquadCount()+2);
												$3->place=new string(newtemp());
												emit(*$3->place," = 1","","","","");
												emit("goto a",itoa(getquadCount()+2),"","","","");
												emit(*$3->place," = 0","","","","");
											}
											if(raviyehStart==1){ //we are in a procedur
												$1->place = procedureParameterAssign($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
												emit(*($1->place)," = ",*($3->place),"","","");
											}
											else{
												$1->place =new string($1->name,0,$1->length);
												emit(*($1->place)," = ",*($3->place),"","","");
											}
											$$= new struct id;
											$$->nextlist=new list<int>();
											$$->returnlist=$3->returnlist;
										}
								}
		| arrayAssign ASSIGN expression ';'{
											if (!$3->type->compare("boolean")){
													backpatch(*$3->truelist,getquadCount());
													backpatch(*$3->falselist,getquadCount()+2);
													$3->place=new string(newtemp());
													emit(*$3->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$3->place," = 0","","","","");
												}
											emit(*($1->place)," = ",*($3->place),"","","");
											$$= new struct id;
											$$->nextlist=new list<int>();
											$$->returnlist=$3->returnlist;
											$$->returnpointlist= new list<int>();
									}
		| compound_statement_main	{cout << "statement_main --> compound_statement_main"<<endl;
									$$=new struct id;
									$$->nextlist= $1->nextlist;
									$$->returnlist=$1->returnlist;
									}
		| ID N3 arguments N4	';'	{cout << "statement --> ID argument"<<endl;
							//addv($1->name,$1->length,"MOTAGHAYER");
						//	cout <<"tblptr calculation"<<endl;
							int temp = tblPtr.top()->lookup($1->name,$1->length);
						//	cout <<"going into if"<<endl;
						//	cout << $1->name << temp <<endl;
						/*	if (temp== 0 )
							{
								declerationError($1->name,$1->length);
							}*///For we have problem in recursive understanding
							if(1){
						//	cout<<"first is : "<<(!(tblPtr.top()->lookupAttribute($1->name,$1->length)))<<endl;
						//		cout << ((procedureAttribute *)(tblPtr.top()->lookupAttribute($1->name,$1->length)))->argumentCount<<endl;
							if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
								keywordError($1->name,$1->length);
							else
							if((tblPtr.top()->lookupAttribute($1->name,$1->length)))
								if (((procedureAttribute *)(tblPtr.top()->lookupAttribute($1->name,$1->length)))->argumentCount != argumentCount)
									errorArgument($1->name,$1->length);
												$$= new struct id;
												}
									cout << "enter"<<endl;	
													localCount-=$2->pushedVar;									
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(argumentCount)," )","","","");// argument count
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(getquadCount()+4)," )","","","");// return address
													cout << $3->returnlist->front()<<"front"<<endl;
													cout <<(getquadCount()-2)<<"quadcount"<<endl;
													$$->returnlist=new list<int>(merge(*(new list<int>(makeList(getquadCount()-2))),*$3->returnlist));
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(0)," )","","","");// for dynamic link
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(0)," )","","",""); // for return value
													emit("goto","	a",itoa((((procedureAttribute*)(tblPtr.top()->lookupNode($1->name,$1->length))->Attribute))->start),"","","");// for dynamic goto
													
										/*NEW*/		emit("parameters.at( 3 ) = ","parameters.back()","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("parameters.at( 4 ) = ","parameters.back()","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("if ( parameters.at( 3 ) == parameters.at( 4 ) ) goto	a",
															itoa(getquadCount()+5),"","","","");
													emit("parameters.at(parameters.at(3)+5) = parameters.back()","","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("parameters.at( 3 )= parameters.at( 3 ) + 1","","","","","");
										/*NEW*/		emit("goto","  a",itoa(getquadCount()-4),"","","");
									cout << "exit"<<endl;				
													$$->nextlist= new list<int>();
							}
		| BARAYE BID DAR '<' range '>' BMD HALGHEH loop_statement_main ENTEHAYE_HALGHEH ';'	{cout << "statement --> BARAYE ID DAR range HALGHEH loop_statement_main ENTEHAYE_HALGHE"<<endl;
																//		addk("BARAYE","BARAYE");
																//		addv($2->name,$2->length,"MOTAGHAYER");
																//		addk("DAR","DAR");
																//		addk("HALGHEH","HALGHEH");
																//		addk("ENTEHAYE_HALGHEH","ENTEHAYE_HALGHEH");
																/*if (tblPtr.top()->lookup($2->name,$2->length)== 0)
																			declerationError($2->name,$2->length);
																else
																	if(!tblPtr.top()->lookupType($2->name,$2->length).compare("KEYWORD"))
																		keywordError($2->name,$2->length);*/
																//code generation
																$$=new struct id;
																emit(*($2->bid)," = ",*($2->bidAssign),"","","");
																emit(*($2->bid)," = ", *($2->bid)," + 1 ","","");
																//backpatch(*$9->nextlist,getquadCount());//transfered to down
																emit(*($2->bidAssign),"=",*($2->bid),"","","");
																emit("goto a",itoa($7->nextlist->front()),"","","","");
																$$->nextlist=new list<int>(merge(*$7->nextlist,*$9->nextlist));
																$$->returnlist=$9->returnlist;
															//	backpatch(*$7->nextlist,getquadCount());
																}
		| BARAYE BID  DAR MAKOOS '<' range '>' BMDM HALGHEH loop_statement_main ENTEHAYE_HALGHEH ';'	{cout << "statement --> BARAYE ID  DAR DAR_MAKOOS '<' range '>' HALGHEH loop_statement_main ENTEHAYE_HALGHEH"<<endl;
																		//		addk("BARAYE","BARAYE");
																		//		addv($2->name,$2->length,"MOTAGHAYER");
																		//		addk("DAR_MAKOOS","DAR_MAKOOSW");
																		//		addk("HALGHEH","HALGHEH");
																		//		addk("ENTEHAYE_HALGHEH","ENTEHAYE_HALGHEH");
																		/*if (tblPtr.top()->lookup($2->name,$2->length)== 0)
																			declerationError($2->name,$2->length);
																		else if(!tblPtr.top()->lookupType($2->name,$2->length).compare("KEYWORD"))
																		keywordError($2->name,$2->length);*/
																		//code generation
																		$$=new struct id;
																		emit(*($2->bid)," = ",*($2->bidAssign),"","","");
																		emit(*($2->bid)," = ", *($2->bid)," - 1 ","","");
																		emit(*($2->bidAssign),"=",*($2->bid),"","","");
																		//backpatch(*$10->nextlist,getquadCount());//transfered to down
																		emit("goto a",itoa($8->nextlist->front()),"","","","");
																		$$->nextlist=new list<int>(merge(*$8->nextlist,*$10->nextlist));
																	//	backpatch(*$8->nextlist,getquadCount());
																		$$->returnlist=$10->returnlist;
																				}
		| AGAR expression ANGAH AM1 statement_main AN  AM2 gheiragar_main gheir_main KHATEMEH_AGAR ';'	{cout << "statement --> AGAR expression ANGAH statement gheiragar_main gheir_main KHATEMEH_AGAR"<<endl;
															//			addk("AGAR","AGAR");
															//			addk("ANGAH","ANGAH");
															//			addk("KHATEMEH_AGAR","KHATEMEH_AGAR");
																		if (!$2->type->compare("arithmetic")){
																			$2->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$2->place, " == 0 ) goto ","","","");
																			$2->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
																		$$=new struct id;
																		backpatch(*$2->truelist,$4->quad);
																		backpatch(*$2->falselist,$7->quad);
																		$$->nextlist=new list<int>(merge(*$5->nextlist,*$6->nextlist,
																								*$8->nextlist,*$9->nextlist));
																		$$->returnlist=new list<int>(merge(*$2->returnlist,*$5->returnlist,*$8->returnlist,*$9->returnlist));
																		}
		| AGAR expression ANGAH AM1 AN AM2 gheiragar_main  gheir_main KHATEMEH_AGAR ';'	{cout << "statement --> AGAR expression ANGAH gheiragar_main gheir_main KHATEMEH_AGAR"<<endl;
															//			addk("AGAR","AGAR");
															//			addk("ANGAH","ANGAH");
															//			addk("KHATEMEH_AGAR","KHATEMEH_AGAR");
																		if (!$2->type->compare("arithmetic")){
																			$2->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$2->place, " == 0 ) goto ","","","");
																			$2->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
																		$$=new struct id;
																		backpatch(*$2->truelist,$4->quad);
																		backpatch(*$2->falselist,$6->quad);
																		$$->nextlist=new list<int>(merge(*$5->nextlist,
																								*$7->nextlist,*$8->nextlist));
																		$$->returnlist=new list<int>(merge(*$2->returnlist,*$7->returnlist,*$8->returnlist));
																		}
		| BEKHAN '(' ID ')' ';'	{cout << "statement --> BEKHAN '(' ID ')'"<<endl;
						//	addv($3->name,$3->length,"MOTAGHAYER");
						//	addk("BEKHAN","BEKHAN");
							if (tblPtr.top()->lookup($3->name,$3->length)== 0)
								declerationError($3->name,$3->length);
							else if(!tblPtr.top()->lookupType($3->name,$3->length).compare("KEYWORD"))
										keywordError($3->name,$3->length);
							else if(raviyehStart==1) //we are in a procedur
									$3->place = procedureParameterAssign($3->name,$3->length,tblPtr.top(),localCount,parameterCount);
							else
									$3->place =new string($3->name,0,$3->length);
							emit("cin >> ",*$3->place," ","","","");
							$$= new struct id;
							$$->nextlist= new list<int>();
							$$->returnlist= new list<int>();
							}
		| BEKHAN '(' arrayAssign ')' ';'{
							emit("cin >> ",*$3->place," ","","","");
							$$= new struct id;
							$$->nextlist= new list<int>();
							$$->returnlist= new list<int>();
							}
		| BENEVIS '(' expression ')' ';' {cout << "BENEVIS '(' expression ')'"<<endl;
								//	addk("BENEVIS","BENEVIS");
								if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
									emit("cout << ",*$3->place," ","","","");
									$$= new struct id;
									$$->nextlist= new list<int>();
									$$->returnlist=$3->returnlist;
									}
		;
		
		statement:
		
		declarations 	';'	{cout << "statement --> declarations"<<endl;
							$$= new struct id;
							$$->nextlist= new list<int>();
							$$->returnlist=$1->returnlist;
							$$->returnpointlist= new list<int>();
							}
		| ID ASSIGN expression ';'		{cout << "statement --> ID ASSIGN expression"<<endl;
										//	cout << $1->name <<"is the best"<<endl;
										if (tblPtr.top()->lookup($1->name,$1->length)== 0)
											declerationError($1->name,$1->length);
										else
										if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
												keywordError($1->name,$1->length);
								//		addv($1->name,$1->length,"MOTAGHAYER");
										else{	//code generation
											if (!$3->type->compare("boolean")){
													backpatch(*$3->truelist,getquadCount());
													backpatch(*$3->falselist,getquadCount()+2);
													$3->place=new string(newtemp());
													emit(*$3->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$3->place," = 0","","","","");
												}
											if(raviyehStart==1){ //we are in a procedur
												$1->place = procedureParameterAssign($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
												emit(*($1->place)," = ",*($3->place),"","","");
											}
										else{
												$1->place =new string($1->name,0,$1->length);
												emit(*($1->place)," = ",*($3->place),"","","");
											}
											$$= new struct id;
											$$->nextlist=new list<int>();
											$$->returnlist=$3->returnlist;
											$$->returnpointlist= new list<int>();
										}
									}
		| arrayAssign ASSIGN expression ';'{
											if (!$3->type->compare("boolean")){
													backpatch(*$3->truelist,getquadCount());
													backpatch(*$3->falselist,getquadCount()+2);
													$3->place=new string(newtemp());
													emit(*$3->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$3->place," = 0","","","","");
												}
											emit(*($1->place)," = ",*($3->place),"","","");
											$$= new struct id;
											$$->nextlist=new list<int>();
											$$->returnlist=$3->returnlist;
											$$->returnpointlist= new list<int>();
									}
		| compound_statement	{cout << "statement_main --> compound_statement"<<endl;
								$$=new struct id;
								$$->nextlist= $1->nextlist;
								$$->returnlist=$1->returnlist;
								$$->returnpointlist= $1->returnpointlist;
								}
		| ID N3 arguments N4	';'	{cout << "statement --> ID argument"<<endl;
							//addv($1->name,$1->length,"MOTAGHAYER");
						//	cout <<"tblptr calculation"<<endl;
							int temp = tblPtr.top()->lookup($1->name,$1->length);
						//	cout <<"going into if"<<endl;
						//	cout << $1->name << temp <<endl;
						/*	if (temp== 0 )
							{
								declerationError($1->name,$1->length);
							}*///For we have problem in recursive understanding
							if(1){
						//	cout<<"first is : "<<(!(tblPtr.top()->lookupAttribute($1->name,$1->length)))<<endl;
						//		cout << ((procedureAttribute *)(tblPtr.top()->lookupAttribute($1->name,$1->length)))->argumentCount<<endl;
							if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
								keywordError($1->name,$1->length);
							else
							if((tblPtr.top()->lookupAttribute($1->name,$1->length)))
								if (((procedureAttribute *)(tblPtr.top()->lookupAttribute($1->name,$1->length)))->argumentCount != argumentCount)
									errorArgument($1->name,$1->length);
							}
									localCount-=$2->pushedVar;
												$$= new struct id;
							cout << "enter"<<endl;					
								/*MEISAM*/ 	emit("parameters.push_back( ",itoa(argumentCount)," )","","","");// argument count
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(getquadCount()+4)," )","","","");// return address
													cout << $3->returnlist->front()<<"front"<<endl;
													cout <<(getquadCount()-2)<<"quadcount"<<endl;
													$$->returnlist=new list<int>(merge(*(new list<int>(makeList(getquadCount()-2))),*$3->returnlist));
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(0)," )","","","");// for dynamic link
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(0)," )","","",""); // for return value
													if (!currentProcedure.compare(getName($1->name,$1->length)))// if it is recursive point of procedure
														emit("goto","  a",itoa(procedureStart),"","","");
													else
										/*MEISAM*/ 		emit("goto","	a",itoa((((procedureAttribute*)(tblPtr.top()->lookupNode($1->name,$1->length))->Attribute))->start),"","","");// for dynamic goto
													
										/*NEW*/		emit("parameters.at( 3 ) = ","parameters.back()","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("parameters.at( 4 ) = ","parameters.back()","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("if ( parameters.at( 3 ) == parameters.at( 4 ) ) goto	a",
															itoa(getquadCount()+5),"","","","");
													emit("parameters.at(parameters.at(3)+5) = parameters.back()","","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("parameters.at( 3 )= parameters.at( 3 ) + 1","","","","","");
										/*NEW*/		emit("goto","  a",itoa(getquadCount()-4),"","","");
													
													$$->nextlist= new list<int>();
													$$->returnpointlist= new list<int>();
							cout <<"exit"<<endl;
							}
		| BARAYE BID DAR '<' range '>' BMD HALGHEH loop_statement ENTEHAYE_HALGHEH ';'	{cout << "statement --> BARAYE ID DAR range HALGHEH loop_statement ENTEHAYE_HALGHE"<<endl;
																//		addk("BARAYE","BARAYE");
																//		addv($2->name,$2->length,"MOTAGHAYER");
																//		addk("DAR","DAR");
																//		addk("HALGHEH","HALGHEH");
																//		addk("ENTEHAYE_HALGHEH","ENTEHAYE_HALGHEH");
															/*	if (tblPtr.top()->lookup($2->name,$2->length)== 0)
																			declerationError($2->name,$2->length);
																else	if(!tblPtr.top()->lookupType($2->name,$2->length).compare("KEYWORD"))
																		keywordError($2->name,$2->length);*/
																//code generation
																$$=new struct id;
																emit(*($2->bid)," = ",*($2->bidAssign),"","","");
																emit(*($2->bid)," = ", *($2->bid)," + 1 ","","");
																emit(*($2->bidAssign),"=",*($2->bid),"","","");
																//backpatch(*$9->nextlist,getquadCount());  //transfered to down
																emit("goto a",itoa($7->nextlist->front()),"","","","");
																$$->nextlist=new list<int>(merge(*$7->nextlist,*$9->nextlist));
																$$->returnlist=$9->returnlist;
																$$->returnpointlist= $9->returnpointlist;
																		}
		| BARAYE BID  DAR MAKOOS '<' range '>' BMDM HALGHEH loop_statement ENTEHAYE_HALGHEH ';'	{cout << "statement --> BARAYE ID  DAR DAR_MAKOOS '<' range '>' HALGHEH loop_statement ENTEHAYE_HALGHEH"<<endl;
																		//		addk("BARAYE","BARAYE");
																		//		addv($2->name,$2->length,"MOTAGHAYER");
																		//		addk("DAR_MAKOOS","DAR_MAKOOSW");
																		//		addk("HALGHEH","HALGHEH");
																		//		addk("ENTEHAYE_HALGHEH","ENTEHAYE_HALGHEH");
																/*		if (tblPtr.top()->lookup($2->name,$2->length)== 0)
																			declerationError($2->name,$2->length);
																		else	if(!tblPtr.top()->lookupType($2->name,$2->length).compare("KEYWORD"))
																		keywordError($2->name,$2->length);*/
																//code generation
																emit(*($2->bid)," = ",*($2->bidAssign),"","","");
																$$=new struct id;
																emit(*($2->bid)," = ", *($2->bid)," - 1 ","","");
																emit(*($2->bidAssign),"=",*($2->bid),"","","");
																//backpatch(*$10->nextlist,getquadCount());// transfered to down
																emit("goto a",itoa($8->nextlist->front()),"","","","");
																$$->nextlist=new list<int>(merge(*$8->nextlist,*$10->nextlist));
																//	backpatch(*$8->nextlist,getquadCount());
																$$->returnlist=$10->returnlist;
																$$->returnpointlist= $10->returnpointlist;
																				}
		| AGAR expression ANGAH AM1 statement   AN AM2 gheiragar gheir KHATEMEH_AGAR ';'	{cout << "statement --> AGAR expression ANGAH statement gheiragar gheir KHATEMEH_AGAR"<<endl;
															//			addk("AGAR","AGAR");
															//			addk("ANGAH","ANGAH");
															//			addk("KHATEMEH_AGAR","KHATEMEH_AGAR");
																		if (!$2->type->compare("arithmetic")){
																			$2->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$2->place, " == 0 ) goto ","","","");
																			$2->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
																		$$=new struct id;
																		backpatch(*$2->truelist,$4->quad);
																		backpatch(*$2->falselist,$7->quad);
																		$$->nextlist=new list<int>(merge(*$5->nextlist,*$6->nextlist,
																								*$8->nextlist,*$9->nextlist));
																		$$->returnlist=new list<int>(merge(*$2->returnlist,*$5->returnlist,*$8->returnlist,*$9->returnlist));
																		$$->returnpointlist= new list<int>(merge(*$5->returnpointlist,
																						*$8->returnpointlist,*$9->returnpointlist));
																		}
		| AGAR expression ANGAH AM1 AN  AM2 gheiragar  gheir KHATEMEH_AGAR ';'	{cout << "statement --> AGAR expression ANGAH gheiragar gheir KHATEMEH_AGAR"<<endl;
															//			addk("AGAR","AGAR");
															//			addk("ANGAH","ANGAH");
															//			addk("KHATEMEH_AGAR","KHATEMEH_AGAR");
																		if (!$2->type->compare("arithmetic")){
																			$2->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$2->place, " == 0 ) goto ","","","");
																			$2->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
																		$$=new struct id;
																		backpatch(*$2->truelist,$4->quad);
																		backpatch(*$2->falselist,$6->quad);
																		$$->nextlist=new list<int>(merge(*$5->nextlist,
																		*$7->nextlist,*$8->nextlist));
																		$$->returnlist=new list<int>(merge(*$2->returnlist,*$7->returnlist,*$8->returnlist));
																		$$->returnpointlist= new list<int>(merge(*$7->returnpointlist,*$8->returnpointlist));
																		}
		| BEKHAN '(' ID ')' ';'	{cout << "statement --> BEKHAN '(' ID ')'"<<endl;
						//	addv($3->name,$3->length,"MOTAGHAYER");
						//	addk("BEKHAN","BEKHAN");
							if (tblPtr.top()->lookup($3->name,$3->length)== 0)
								declerationError($3->name,$3->length);
							else
								if(!tblPtr.top()->lookupType($3->name,$3->length).compare("KEYWORD"))
										keywordError($3->name,$3->length);
							else	if(raviyehStart==1) //we are in a procedur
										$3->place = procedureParameterAssign($3->name,$3->length,tblPtr.top(),localCount,parameterCount);
									else
										$3->place =new string($3->name,0,$3->length);
							emit("cin >> ",*$3->place," ","","","");
							$$= new struct id;
							$$->nextlist= new list<int>();
							$$->returnlist=new list<int>();
							$$->returnpointlist= new list<int>();
							}
		| BENEVIS '(' expression ')' ';' {cout << "BENEVIS '(' expression ')'"<<endl;
								//	addk("BENEVIS","BENEVIS");
								if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
								emit("cout << ",*$3->place," ","","","");
								$$= new struct id;
								$$->nextlist= new list<int>();
								$$->returnlist=$3->returnlist;
								$$->returnpointlist= new list<int>();
									}
		| RETURN  expression  ';' {cout << "RETURN  expression  ';'"<<endl;
								//	addk("BENEVIS","BENEVIS");
									$$= new struct id;
									$$->nextlist=new list<int>();
									if (!$2->type->compare("boolean")){
											backpatch(*$2->truelist,getquadCount());
											backpatch(*$2->falselist,getquadCount()+2);
											$2->place=new string(newtemp());
											emit(*$2->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$2->place," = 0","","","","");
										}
						/*MEISAM*/	emit("parameters.at(1)"," = ",*($2->place),"","","");// for having return value as global parameter
						/*MEISAM*/	emit(*parameterStackAt(2,localCount)," = ",*($2->place),"","",""); // for putting return value in its place
									emit("parameters.at(2)","=",*parameterStackAt(3,localCount),"","","");// for having returnAddress
									// each time I used sp I had it in my compiler so in my point of view it was static and just I need to hav top so I don't change it
									// I don't need to load even number of arguments from the stack , For I have it in my compiler in static mode so I use it
										string *s1=new string(*changeTop(localCount+parameterCount+4));
									//	s1=s1->substr(0,s1->length()-1);
										emit(*s1,"","","","","");
										//emit("Goto","	","returnAddress","","","");// for dynamic goto
										//emit("Goto","	","dynamicGoto","","","");// for dynamic goto
										$$->returnlist=$2->returnlist;
										$$->returnpointlist= new list<int>(makeList(getquadCount()));
										emit("","","","","","");
									}
		;
		
	BMD:{
		$$= new struct id;
		emit(bid," = ",itoa(arrayLowerLimit),"","","");
		emit(bidAssign,"=",bid,"","","");
		$$->nextlist=new list<int>(makeList(getquadCount()));
		emit("if ( ",bid, " > ", itoa(arrayHigherLimit)," ) goto ","");
	}
	;
	BMDM:{
		$$= new struct id;
		emit(bid," = ",itoa(arrayHigherLimit),"","","");
		$$->nextlist=new list<int>(makeList(getquadCount()));
		emit("if ( ",bid, " < ", itoa(arrayLowerLimit)," ) goto ","");
	}
	;
	BID: ID{
		$$=new struct id;
		if (tblPtr.top()->lookup($1->name,$1->length)== 0)
				declerationError($1->name,$1->length);
		else	if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
			keywordError($1->name,$1->length);
		if(raviyehStart==1){ //we are in a procedur
			$$->bid =new string(*(procedureParameter($1->name,$1->length,tblPtr.top(),localCount,parameterCount)));
			$$->bidAssign=new string(*(procedureParameterAssign($1->name,$1->length,tblPtr.top(),localCount,parameterCount)));
		}else{
			$$->bid =new string($1->name,0,$1->length);
			$$->bidAssign=new string(*(procedureParameterAssign($1->name,$1->length,tblPtr.top(),localCount,parameterCount)));
		}
		bid=*$$->bid;
		bidAssign=*$$->bidAssign;
	}
	;
	
	N3:
	{
		int pushedVar=0;
		cout << "N3 -->" << endl;
		hightemp=getTempCount();
	/*NEW*/		for (int i=hightemp-1; i>=lowertemp ; i--){
	/*push temp	*/		emit("parameters.push_back( ",getTemp(i)," )","","","");
						pushedVar++;
				}	
	/*NEW*/		emit("parameters.push_back( ",itoa(getTempCount())," )","","","");
	/*NEW*/		emit("parameters.push_back( ",itoa(lowertemp)," )","","","");
				pushedVar+=2;
				localCount+=pushedVar;
		raviyehCall = 1;
		argumentCount = 0;
		$$=new struct id;
		$$->pushedVar=pushedVar;
	}
	;
	N4:
	{
		$$= new struct id;
		$$->quad= getquadCount();
		cout << "N4 -->" << endl;
		raviyehCall = 0;
	}
	;
	arguments:
		'(' actual_parameter_list ')'	{cout << "arguments --> '(' actual_parameter_list ')'"<<endl;
											$$= new struct id;
											$$->returnlist=$2->returnlist;
											cout << $$->returnlist->front()<<"actual"<<endl;
										}
		|'(' ')' 	{cout << "arguments --> '(' ')'"<<endl;
					$$= new struct id;
					$$->returnlist=new list<int>();
					}
		;
			
	actual_parameter_list:
		actual_parameter_list ',' actual_parameter	{cout << "actual_parameter_list --> actual_parameter_list ',' actual_parameter"<<endl;
													if (raviyehCall == 1)
														argumentCount++;
													$$= new struct id;
													$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
													}
		| actual_parameter	{cout << "actual_parameter_list --> actual_parameter"<<endl;
							if (raviyehCall == 1)
								argumentCount++;
								float f;
							/*	while( !parameter.empty()){
									f=parameter.top();
									parameter.pop();
									emit("parameters.push_back(",itoa(),")","","","");
								}*/
								$$= new struct id;
								$$->returnlist=$1->returnlist;
								cout << $$->returnlist->front()<<"actual"<<endl;
							}
		;
			

	actual_parameter:
		expression	{cout << "actual_parameter --> expression"<<endl;
					 //	parameter.push($1->rValue);				
						if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
										}
						emit("parameters.push_back( ",*$1->place," )","","","");
						$$= new struct id;
						$$->returnlist=$1->returnlist;
						cout << $$->returnlist->front()<<"actual"<<endl;
					}
		| ID	{cout << "actual_parameter --> ID"<<endl;
			//	addv($1->name,$1->length,"MOTAGHAYER");
				if (tblPtr.top()->lookup($1->name,$1->length)== 0)
					declerationError($1->name,$1->length);
				else	if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
							keywordError($1->name,$1->length);
				else if(raviyehStart==1){ //we are in a procedur
							//+hightemp-lowertemp+2
							/*$1->place =*/ tempstr=procedureParameter($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
						// it is defferent for it is pushed highertemp-lowertempL+2 entry before
						//	$1->place =tempstr;
						//	tempstr=$1->place;
							$1->place=new string(*tempstr);
						//	cout << *tempstr<<" is the value of palce"<<endl;
						}else
							$1->place =new string($1->name,0,$1->length);
						if (tblPtr.top()->lookupType($1->name,$1->length).compare("ARRAYE"))
							/*MEISAM*/ 	emit("parameters.push_back( ",*$1->place," )","","","");
						else{	// if type is array
							symbolTableNode *s=tblPtr.top()->lookupNode($1->name,$1->length);
							int lower=((arrayAttribute*)s->Attribute)->lowerLimit;
							int higher=((arrayAttribute*)s->Attribute)->higherLimit;
							string temp;
							temp = newtemp();
							emit(temp, " = ",*$1->place," - ",itoa(1),"");
							for (int i=lower; i<higher+1;i++){	
								emit(temp, " = ",temp," + ",itoa(1),"");
								emit("parameters.push_back( ",temp, " )","","","");
							//	emit("parameters.push_back( ",$1->place->substr(0,$1->place->length()-2)," + ",itoa(i-lower)," )))","");
								}
						}
						
						//parameter.push($1->rValue);
				$$= new struct id;
				$$->returnlist=new list<int>();
				}
		;
	arrayAssign:
	 ID '[' expression ']'	{	cout << "expression -->ID '[' expression ']'"<<endl;
										//	addv($1->name,$1->length,"MOTAGHAYER");
									if (tblPtr.top()->lookup($1->name,$1->length)== 0)
										declerationError($1->name,$1->length);
									else{
									if (tblPtr.top()->lookupType($1->name,$1->length).compare("ARRAYE"))
										notArrayType($1->name,$1->length);
									else
										if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
											keywordError($1->name,$1->length);
									else{
											//cout << "begin else"<<endl;
										/*	arrayAttribute *a=(arrayAttribute*)tblPtr.top()->lookupAttribute($1->name,$1->length);	*/
										//	cout <<"Done"<<endl;
										//	cout << $3<< endl;
										//	cout << a->lowerLimit<<endl;
										/*	if (a->lowerLimit > $3 || a->higherLimit < $3)
												arrayBounderyError($1->name,$1->length);*/ //when we use expression then we can not evaluate it in compile time
										//	cout<< "end else"<<endl;
										/*	if(raviyehStart==1) //we are in a procedur
												$1->place = procedureParameter($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
											else
												$1->place =new string($1->name,0,$1->length);*/
											symbolTableNode *s=tblPtr.top()->lookupNode($1->name,$1->length);
											int lower=((arrayAttribute*)s->Attribute)->lowerLimit;
											$$=new struct id;
											$1->place = procedureParameterArray($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
											string temp1=string(newtemp());
											emit(temp1, " = ",*$3->place," - ",itoa(lower),"");
											string temp2=string(newtemp());
											emit(temp2," = ",temp1," + ",*$1->place,"");
											$$->place=new string(concatstring("parameters.at( ",temp2, " )","","",""));
									//		concatstring(*$1->place,
									//				" + ",*$3->place," - ",itoa(lower),"))"));
										//	$$->returnlist=$3->returnlist;
											$$->truelist=new list<int>();
											$$->falselist= new list<int>();
											$$->returnlist= $3->returnlist;
											$$->type=new string("number");
										}
									}
				}
		;
	expression:
		SAHIH_CONST	{cout << "expression --> SAHIH_CONST"<<endl;
				//	addv($1->name,"SAHIH_CONST");
					//code generation
					$$=new struct id;
					$$->place = new string(itoa($1));
					$$->returnlist=new list<int>();
					$$->truelist=new list<int>();
					$$->falselist= new list<int>();
					$$->type=new string("number");
					$$->valType=new string("SAHIH");
					}
		| ID N3 arguments N4	{cout << "experession --> ID argument"<<endl;
							//addv($1->name,$1->length,"MOTAGHAYER");
						//	cout <<"tblptr calculation"<<endl;
							int temp = tblPtr.top()->lookup($1->name,$1->length);
						//	cout <<"going into if"<<endl;
						//	cout << $1->name << temp <<endl;
						/*	if (temp== 0 )
							{
								declerationError($1->name,$1->length);
							}*///For we have problem in recursive understanding
							if(1){
						//	cout<<"first is : "<<(!(tblPtr.top()->lookupAttribute($1->name,$1->length)))<<endl;
						//		cout << ((procedureAttribute *)(tblPtr.top()->lookupAttribute($1->name,$1->length)))->argumentCount<<endl;
							if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
								keywordError($1->name,$1->length);
							else
							if((tblPtr.top()->lookupAttribute($1->name,$1->length)))
								if (((procedureAttribute *)(tblPtr.top()->lookupAttribute($1->name,$1->length)))->argumentCount != argumentCount)
									errorArgument($1->name,$1->length);
								}
													localCount-=$2->pushedVar;
													$$= new struct id;
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(argumentCount)," )","","","");// argument count
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(getquadCount()+4)," )","","","");// return address
													$$->returnlist=new list<int>(merge(*(new list<int>(makeList(getquadCount()-2))),*$3->returnlist));
													cout << getquadCount()-2<<endl;
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(0)," )","","","");// for dynamic link
										/*MEISAM*/ 	emit("parameters.push_back( ",itoa(0)," )","","",""); // for return value
													if (!currentProcedure.compare(getName($1->name,$1->length)))// if it is recursive point of procedure
														emit("goto","  a",itoa(procedureStart),"","","");
													else
										/*MEISAM*/ 		emit("goto","	a",itoa((((procedureAttribute*)(tblPtr.top()->lookupNode($1->name,$1->length))->Attribute))->start),"","","");// for dynamic goto
											
										/*NEW*/		emit("parameters.at( 3 ) = ","parameters.back()","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("parameters.at( 4 ) = ","parameters.back()","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("if ( parameters.at( 3 ) == parameters.at( 4 ) ) goto	a",
															itoa(getquadCount()+5),"","","","");
													emit("parameters.at(parameters.at(3)+5) = parameters.back()","","","","","");
													emit("parameters.pop_back()","","","","","");
													emit("parameters.at( 3 )= parameters.at( 3 ) + 1","","","","","");
										/*NEW*/		emit("goto","  a",itoa(getquadCount()-4),"","","");
													
													$$->place=new string(newtemp());
													emit(*($$->place)," = ","","parameters.at(1)","","");
													$$->truelist=new list<int>();
													$$->falselist= new list<int>();
													$$->type=new string("number");
													$$->valType=new string((((procedureAttribute*)(tblPtr.top()->lookupNode($1->name,$1->length))->Attribute)->returnType));
							}
		| ASHARI_CONST	{cout << "expression --> ASHARI_CONST"<<endl;
					//	addv($1->name,"ASHARI_CONST");
						//code generation
						$$=new struct id;
						$$->place = new string(ftoa($1));
						$$->truelist=new list<int>();
						$$->falselist= new list<int>();
						$$->returnlist=new list<int>();
						$$->type=new string("number");
						$$->valType=new string("ASHARI");
						}
		| ID	{cout << "expression --> ID"<<endl;
			//	sprintf($$->place, "%s",$1);
				$$->place=stringReturn($1->name,$1->length);
			//	addv($1->name,$1->length,"MOTAGHAYER");
				if (tblPtr.top()->lookup($1->name,$1->length)== 0)
					declerationError($1->name,$1->length);
				else
					if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
						keywordError($1->name,$1->length);
						//code generation
				else{	
						$$=new struct id;
						//+hightemp-lowertemp+2
						if (raviyehCall==1 && raviyehStart==1)
							$$->place = procedureParameter($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
						else
						if(raviyehStart==1) //we are in a procedur
							$$->place = procedureParameter($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
						else
							$$->place =new string($1->name,0,$1->length);
						//code generation
						$$->truelist=new list<int>();
						$$->falselist= new list<int>();
						$$->returnlist=new list<int>();
						$$->type=new string("number");
						$$->valType=new string(tblPtr.top()->lookupType($1->name,$1->length));
					}
				}
		| ID '[' expression ']'	{	cout << "expression -->ID '[' expression ']'"<<endl;
										//	addv($1->name,$1->length,"MOTAGHAYER");
									if (tblPtr.top()->lookup($1->name,$1->length)== 0)
										declerationError($1->name,$1->length);
									else{
									if (tblPtr.top()->lookupType($1->name,$1->length).compare("ARRAYE"))
										notArrayType($1->name,$1->length);
									else
										if(!tblPtr.top()->lookupType($1->name,$1->length).compare("KEYWORD"))
											keywordError($1->name,$1->length);
									else{
											//cout << "begin else"<<endl;
										/*	arrayAttribute *a=(arrayAttribute*)tblPtr.top()->lookupAttribute($1->name,$1->length);	*/
										//	cout <<"Done"<<endl;
										//	cout << $3<< endl;
										//	cout << a->lowerLimit<<endl;
										/*	if (a->lowerLimit > $3 || a->higherLimit < $3)
												arrayBounderyError($1->name,$1->length);*/ //when we use expression then we can not evaluate it in compile time
										//	cout<< "end else"<<endl;
										/*	if(raviyehStart==1) //we are in a procedur
												$1->place = procedureParameter($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
											else
												$1->place =new string($1->name,0,$1->length);*/
											symbolTableNode *s=tblPtr.top()->lookupNode($1->name,$1->length);
											int lower=((arrayAttribute*)s->Attribute)->lowerLimit;
											$$=new struct id;
											//+hightemp-lowertemp+2
											if (raviyehCall==1 && raviyehStart==1)
												$$->place = procedureParameterArray($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
											else
												$1->place = procedureParameterArray($1->name,$1->length,tblPtr.top(),localCount,parameterCount);
											string temp1=string(newtemp());
											emit(temp1, " = ",*$3->place," - ",itoa(lower),"");
											string temp2=string(newtemp());
											emit(temp2," = ",temp1," + ",*$1->place,"");
											emit(temp1," = ","parameters.at( ",temp2, " )","");
											$$->place=new string(temp1);
									//		concatstring(*$1->place,
									//				" + ",*$3->place," - ",itoa(lower),"))"));
										//	$$->returnlist=$3->returnlist;
											$$->truelist=new list<int>();
											$$->falselist= new list<int>();
											$$->returnlist= $3->returnlist;
											$$->type=new string("number");
											$$->valType=new string(tblPtr.top()->lookupType($1->name,$1->length));
										}
									}
				}
		| expression '+' expression	{cout << "expression --> expression '+' expression"<<endl;
										$$=new struct id;
										$$->place=new string(newtemp());
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										emit(*($$->place)," = ",*($1->place)," + ",*($3->place),"");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("arithmetic");
										if (!$1->valType->compare("SAHIH") &&!$3->valType->compare("SAHIH"))
											$$->valType=new string("SAHIH");
										else{
													$$->valType=new string("ASHARI");
										}
									}
		| expression '-' expression	{cout << "expression --> expression '-' expression"<<endl;
										$$=new struct id;
										$$->place=new string(newtemp());
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										emit(*($$->place)," = ",*($1->place)," - ",*($3->place),"");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("arithmetic");
										if (!$1->valType->compare("SAHIH") &&!$3->valType->compare("SAHIH"))
											$$->valType=new string("SAHIH");
											else{
													$$->valType=new string("ASHARI");
													}
									}
		| expression '*' expression	{cout << "expression --> expression '*' expression"<<endl;
										$$=new struct id;
										$$->place=new string(newtemp());
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										emit(*($$->place)," = ",*($1->place)," * ",*($3->place),"");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("arithmetic");
										if (!$1->valType->compare("SAHIH") &&!$3->valType->compare("SAHIH"))
											$$->valType=new string("SAHIH");
										else{
											$$->valType=new string("ASHARI");
										}
									}
		| expression '/' expression	{cout << "expression --> expression '/' expression"<<endl;
										$$=new struct id;
										$$->place=new string(newtemp());
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										emit(*($$->place)," = ",*($1->place)," / ",*($3->place),"");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("arithmetic");
										if (!$1->valType->compare("SAHIH") &&!$3->valType->compare("SAHIH")){
											$$->valType=new string("SAHIH");
											emit(*($$->place)," = (int)",*($$->place),"","","");
											}else{
													$$->valType=new string("ASHARI");
													}
									}
		| '-' expression		{cout << "expression --> '-' expression"<<endl;
										$$=new struct id;
										$$->place=new string(newtemp());
										if (!$2->type->compare("boolean")){
											backpatch(*$2->truelist,getquadCount());
											backpatch(*$2->falselist,getquadCount()+2);
											$2->place=new string(newtemp());
											emit(*$2->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$2->place," = 0","","","","");
										}
										emit(*($$->place)," = "," - ",*($2->place),"","");
										$$->returnlist=$2->returnlist;
										$$->type=new string("arithmetic");
										if (!$2->valType->compare("SAHIH") )
											$$->valType=new string("SAHIH");
										else{
													$$->valType=new string("ASHARI");
													}
								}
		| expression TAGHSIM_BAR expression	{cout << "expression --> expression TAGHSIM_BAR expression"<<endl;
												$$=new struct id;
												$$->place=new string(newtemp());
												if (!$1->type->compare("boolean")){
													backpatch(*$1->truelist,getquadCount());
													backpatch(*$1->falselist,getquadCount()+2);
													$1->place=new string(newtemp());
													emit(*$1->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$1->place," = 0","","","","");
													emit("goto a",itoa(getquadCount()-5),"","","","");
												}
												if (!$3->type->compare("boolean")){
													backpatch(*$3->truelist,getquadCount());
													backpatch(*$3->falselist,getquadCount()+2);
													$3->place=new string(newtemp());
													emit(*$3->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$3->place," = 0","","","","");
												}
												if (!$1->valType->compare("SAHIH") &&!$3->valType->compare("SAHIH")){
													$$->valType=new string("SAHIH");
													emit(*($$->place)," = (int)",*($1->place)," /(int) ",*($3->place),"");
													}else{
													$$->valType=new string("ASHARI");
													emit(*($$->place)," = ",*($1->place)," /(int) ",*($3->place),"");
													}
												$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
												$$->type=new string("arithmetic");
											}
		| expression BAGHIMANDEH expression	{cout << "expression --> expression BAGHIMANDEH expression"<<endl;
												$$=new struct id;
												$$->place=new string(newtemp());
												if (!$1->type->compare("boolean")){
													backpatch(*$1->truelist,getquadCount());
													backpatch(*$1->falselist,getquadCount()+2);
													$1->place=new string(newtemp());
													emit(*$1->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$1->place," = 0","","","","");
													emit("goto a",itoa(getquadCount()-5),"","","","");
												}
												if (!$3->type->compare("boolean")){
													backpatch(*$3->truelist,getquadCount());
													backpatch(*$3->falselist,getquadCount()+2);
													$3->place=new string(newtemp());
													emit(*$3->place," = 1","","","","");
													emit("goto a",itoa(getquadCount()+2),"","","","");
													emit(*$3->place," = 0","","","","");
												}
												if (!$1->valType->compare("SAHIH") &&!$3->valType->compare("SAHIH")){
												$$->valType=new string("SAHIH");
												emit(*($$->place)," = (int)",*($1->place)," % ",*($3->place),"");
												}else{
												$$->valType=new string("ASHARI");
												emit(*($$->place)," = ",*($1->place)," % (int)",*($3->place),"");
												}
												$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
												$$->type=new string("arithmetic");
											}
		| expression '<'  expression	{cout << "expression --> expression '<' expression"<<endl;
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										$$=new struct id;
										$$->truelist=new list<int>(makeList(getquadCount()));//for true list
										emit(" if ( ",*$1->place," < ",*$3->place," ) goto ","");
										$$->falselist=new list<int>(makeList(getquadCount()));// for false list									 
										emit("goto ","","","","","");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("boolean");
										$$->lastQuad=getquadCount();
										$$->valType=new string("SAHIH");
									}
		| expression LE  expression	{cout << "expression --> expression LE expression"<<endl;
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										$$=new struct id;
										$$->truelist=new list<int>(makeList(getquadCount()));//for true list
										emit(" if ( ",*$1->place," <= ",*$3->place," ) goto ","");
										$$->falselist=new list<int>(makeList(getquadCount()));// for false list									 
										emit("goto ","","","","","");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("boolean");
										$$->lastQuad=getquadCount();
										$$->valType=new string("SAHIH");
									}
		| expression '=' expression	{cout << "expression --> expression '=' expression"<<endl;
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										$$=new struct id;
										$$->truelist=new list<int>(makeList(getquadCount()));//for true list
										emit("if ( ",*$1->place," == ",*$3->place," ) goto ","");
										$$->falselist=new list<int>(makeList(getquadCount()));// for false list										 
										emit("goto ","","","","","");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("boolean");
										$$->lastQuad=getquadCount();
										$$->valType=new string("SAHIH");
									}
		| expression NE  expression	{cout << "expression --> expression NE expression"<<endl;
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										$$=new struct id;
										$$->truelist=new list<int>(makeList(getquadCount()));//for true list
										emit("if ( ",*$1->place," <> ",*$3->place," ) goto ","");
										$$->falselist=new list<int>(makeList(getquadCount()));// for false list										 
										emit("goto ","","","","","");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("boolean");
										$$->lastQuad=getquadCount();
										$$->valType=new string("SAHIH");
									}
		| expression '>' expression	{cout << "expression --> expression '>' expression"<<endl;
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										$$=new struct id;
										$$->truelist=new list<int>(makeList(getquadCount()));//for true list
										emit("if ( ",*$1->place," > ",*$3->place," ) goto ","");
										$$->falselist=new list<int>(makeList(getquadCount()));// for false list										 
										emit("goto ","","","","","");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("boolean");
										$$->lastQuad=getquadCount();
										$$->valType=new string("SAHIH");
									}
		| expression GE  expression	{cout << "expression --> expression GE expression"<<endl;
										if (!$1->type->compare("boolean")){
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											$1->place=new string(newtemp());
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa(getquadCount()-5),"","","","");
										}
										if (!$3->type->compare("boolean")){
											backpatch(*$3->truelist,getquadCount());
											backpatch(*$3->falselist,getquadCount()+2);
											$3->place=new string(newtemp());
											emit(*$3->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$3->place," = 0","","","","");
										}
										$$=new struct id;
										$$->truelist=new list<int>(makeList(getquadCount()));//for true list
										emit("if ( ",*$1->place," >= ",*$3->place," ) goto ","");
										$$->falselist=new list<int>(makeList(getquadCount()));// for false list										 
										emit("goto ","","","","","");
										$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
										$$->type=new string("boolean");
										$$->lastQuad=getquadCount();
										$$->valType=new string("SAHIH");
									}
		| expression VA ME expression	{cout << "expression --> expression VA expression"<<endl;
											$$=new struct id;
											$1->place= new string(newtemp());
											$4->place= new string(newtemp());
											$$->place=new string(newtemp());
											if (!$1->type->compare("arithmetic")){
																			$1->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$1->place, " == 0 ) goto ","","","");
																			$1->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
											if (!$4->type->compare("arithmetic")){
																			$4->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$4->place, " == 0 ) goto ","","","");
																			$4->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																			$4->lastQuad=getquadCount();
																		}
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa($1->lastQuad),"","","","");
											
											backpatch(*$4->truelist,getquadCount());
											backpatch(*$4->falselist,getquadCount()+2);
											emit(*$4->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$4->place," = 0","","","","");
																						
											emit(*$$->place," = ",*$1->place, " && ",*$4->place,"");
											$$->truelist=new list<int>(makeList(getquadCount()));
											emit("if ( ", *$$->place," == 1 )goto ","","","");
											$$->falselist=new list<int>(makeList(getquadCount()));
											emit("goto ","","","","","");
											$$->returnlist=new list<int>(merge(*$1->returnlist,*$4->returnlist));
											$$->type=new string("boolean");
											$$->lastQuad=$4->lastQuad;
											$$->valType=new string("SAHIH");
									}
		| expression VAPAS ME expression	{cout << "expression --> expression VAPAS expression"<<endl;
											if (!$1->type->compare("arithmetic")){
																			$1->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$1->place, " == 0 ) goto ","","","");
																			$1->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
											if (!$4->type->compare("arithmetic")){
																			$4->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$4->place, " == 0 ) goto ","","","");
																			$4->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																			$4->lastQuad=getquadCount();
																		}
											$$=new struct id;
											backpatch(*$1->truelist,$3->quad);
											$$->truelist= $4->truelist;
											$$->falselist=new list<int>(merge(*($1->falselist),*($4->falselist)));
											$$->returnlist=new list<int>(merge(*$1->returnlist,*$4->returnlist));
											$$->type=new string("boolean");
											$$->lastQuad=$4->lastQuad;
											$$->valType=new string("SAHIH");
										}
		| expression YAGHEYR ME expression	{cout << "expression --> expression YAGHEYR expression"<<endl;
											if (!$1->type->compare("arithmetic")){
																			$1->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$1->place, " == 0 ) goto ","","","");
																			$1->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
											if (!$4->type->compare("arithmetic")){
																			$4->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$4->place, " == 0 ) goto ","","","");
																			$4->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																			$4->lastQuad=getquadCount();
																		}
											$$=new struct id;
											backpatch(*$1->falselist,$3->quad);
											$$->truelist=new list<int>(merge(*($1->truelist),*($4->truelist)));
											$$->falselist=$4->falselist;
											$$->returnlist=new list<int>(merge(*$1->returnlist,*$4->returnlist));
											$$->type=new string("boolean");
											$$->lastQuad=$4->lastQuad;
											$$->valType=new string("SAHIH");
										}
		| expression YA ME expression	{cout << "expression --> expression YA expression"<<endl;
																					$$=new struct id;
											$1->place= new string(newtemp());
											$4->place= new string(newtemp());
											$$->place=new string(newtemp());
											
											if (!$1->type->compare("arithmetic")){
																			$1->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$1->place, " == 0 ) goto ","","","");
																			$1->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																		}
											if (!$4->type->compare("arithmetic")){
																			$4->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$4->place, " == 0 ) goto ","","","");
																			$4->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																			$4->lastQuad=getquadCount();
																		}
											backpatch(*$1->truelist,getquadCount());
											backpatch(*$1->falselist,getquadCount()+2);
											emit(*$1->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$1->place," = 0","","","","");
											emit("goto a",itoa($1->lastQuad),"","","","");
											
											backpatch(*$4->truelist,getquadCount());
											backpatch(*$4->falselist,getquadCount()+2);
											emit(*$4->place," = 1","","","","");
											emit("goto a",itoa(getquadCount()+2),"","","","");
											emit(*$4->place," = 0","","","","");
																						
											emit(*$$->place," = ",*$1->place, " || ",*$4->place,"");
											$$->truelist=new list<int>(makeList(getquadCount()));
											emit("if ( ", *$$->place," == 1 )goto ","","","");
											$$->falselist=new list<int>(makeList(getquadCount()));
											emit("goto ","","","","","");
											$$->returnlist=new list<int>(merge(*$1->returnlist,*$4->returnlist));
											$$->type=new string("boolean");
											$$->lastQuad=$4->lastQuad;
											$$->valType=new string("SAHIH");
									}
		| NA expression			{cout << "expression --> NA expression"<<endl;
									if (!$2->type->compare("arithmetic")){
																			$2->falselist= new list<int>(makeList(getquadCount()));
																			emit("if ( ",*$2->place, " == 0 ) goto ","","","");
																			$2->truelist= new list<int>(makeList(getquadCount()));
																			emit ("goto ","","","","","");
																			$2->lastQuad=getquadCount();
																		}
									$$->truelist=$2->falselist;
									$$->falselist=$2->truelist;
									$$->returnlist=$2->returnlist;
									$$->type=new string("boolean");
									$$->lastQuad=$2->lastQuad;
									$$->valType=new string("SAHIH");
								}
		| '(' expression ')'		{cout << "expression --> '(' expression ')'"<<endl;
										$$=new struct id;
										$$->place=$2->place;
										$$->truelist=$2->truelist;
										$$->falselist=$2->falselist;
										$$->returnlist=$2->returnlist;
										$$->type= $2->type;
										$$->lastQuad=$2->lastQuad;
										$$->valType=$2->valType;
									}
		;
	
	ME :
		{
			$$->quad = getquadCount();// the next is set
		}
	;
	
	loop_statement :
		loop_statement break_statement {cout << "loopstatement --> loop_statement break_statement"<<endl ; 
										$$= new struct id;
										$$->nextlist=$2->nextlist;
										$$->returnlist = new list<int>(merge(*$1->returnlist,*$2->returnlist));
										backpatch(*$1->nextlist,getquadCount());// For we put two statement for decrement and check after it
										$$->returnpointlist= new list<int>(merge(*$1->returnpointlist,*$2->returnpointlist));
										}
		| SHOROO loop_statement KHATEMEH 	{cout << "loop_statement --> SHOROO statement_list KHATEMEH"<<endl;
									//	addk("SHOROO","SHOROO");
									//	addk("KHATEMEH","KHATEMEH");
										$$=new struct id;
										backpatch(*$2->nextlist,getquadCount());// For we put two statement for decrement and check after it
										$$->nextlist=new list<int>();
										$$->returnlist=$2->returnlist;
										$$->returnpointlist= $2->returnpointlist;
										}
		| statement_list {cout << "loop_statment --> statement_list"<<endl;
							$$= new struct id;
							backpatch(*$1->nextlist,getquadCount());// For we put two statement for decrement and check after it
							$$->nextlist=new list<int>();
							$$->returnlist= $1->returnlist;
							$$->returnpointlist= $1->returnpointlist;
						}
		;
	loop_statement_main :
		loop_statement_main break_statement_main {cout << "loopstatement --> loop_statement break_statement"<<endl ; 
												$$= new struct id;
												$$->nextlist=$2->nextlist;
												$$->returnlist = new list<int>(merge(*$1->returnlist,*$2->returnlist));
												backpatch(*$1->nextlist,getquadCount());// For we put two statement for decrement and check after it
												}
		| SHOROO loop_statement_main KHATEMEH 	{cout << "loop_statement --> SHOROO statement_list KHATEMEH"<<endl;
									//	addk("SHOROO","SHOROO");
									//	addk("KHATEMEH","KHATEMEH");
										$$=new struct id;
										backpatch(*$2->nextlist,getquadCount());// For we put two statement for decrement and check after it
										$$->nextlist=new list<int>();
										$$->returnlist= $2->returnlist;
										}
		| statement_list_main {cout << "loop_statment --> statement_list"<<endl;
								$$= new struct id;
								backpatch(*$1->nextlist,getquadCount());// For we put two statement for decrement and check after it
								$$->nextlist=new list<int>();
								$$->returnlist= $1->returnlist;
								}
		;
	break_statement:
		KHOROOJ VAGHTI_KEH '(' expression ')' ';'MBS loop_statement	{cout << "break_statement --> KHOROOJ VAGHTI_KEH expression ';' loop_statement"<<endl;
															//addk("KHOROOJ VAGHTIKEH","KHOROOJ VAGHTIKEH");
															if (!$4->type->compare("arithmetic")){
																$4->falselist= new list<int>(makeList(getquadCount()));
																emit("if ( ",*$4->place, " == 0 ) goto ","","","");
																$4->truelist= new list<int>(makeList(getquadCount()));
																emit ("goto ","","","","","");
															}
															backpatch(*$4->falselist,$7->quad);// for go furthure for doing loop_statement
															$$=new struct id;
															$$->nextlist=$4->truelist;
															$$->returnlist=new list<int>(merge(*$4->returnlist,*$8->returnlist));
															backpatch(*$8->nextlist,getquadCount()+1);// For we put two statement for decrement and check after it
															$$->returnpointlist=$8->returnpointlist;
															}
		;
	break_statement_main:
		KHOROOJ VAGHTI_KEH '(' expression ')' ';' MBS loop_statement_main	{cout << "break_statement --> KHOROOJ VAGHTI_KEH expression ';' loop_statement"<<endl;
															//addk("KHOROOJ VAGHTIKEH","KHOROOJ VAGHTIKEH");
															if (!$4->type->compare("arithmetic")){
																$4->falselist= new list<int>(makeList(getquadCount()));
																emit("if ( ",*$4->place, " == 0 ) goto ","","","");
																$4->truelist= new list<int>(makeList(getquadCount()));
																emit ("goto ","","","","","");
															}
															backpatch(*$4->falselist,$7->quad);// for go furthure for doing loop_statement
															$$=new struct id;
															$$->nextlist=$4->truelist;	
															$$->returnlist=new list<int>(merge(*$4->returnlist,*$8->returnlist));
															backpatch(*$8->nextlist,getquadCount()+1);// For we put two statement for decrement and check after it
															}
		;
	MBS:
		{
			$$=new struct id;
			$$->quad=getquadCount();
		}
		;
		
	gheiragar:
		gheiragar GHEYR_AGAR expression  ANGAH AM1 statement AN AM2 {cout << "gheiragar --> GHEYR_AGAR expression ANGAH statement gheiragar"<<endl;
													//	addk("GHEYR_AGAR","GHEYR_AGAR");
														if (!$3->type->compare("arithmetic")){
															$3->falselist= new list<int>(makeList(getquadCount()));
															emit("if ( ",*$3->place, " == 0 ) goto ","","","");
															$3->truelist= new list<int>(makeList(getquadCount()));
															emit ("goto ","","","","","");
														}
														$$= new struct id;
														backpatch(*$3->truelist,$6->quad);
														backpatch(*$3->falselist,$8->quad);
														$$->nextlist=new list<int>(merge(*$1->nextlist,*$5->nextlist,*$6->nextlist));
														$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist,*$6->returnlist));
														$$->returnpointlist= new list<int>(merge(*$1->returnpointlist,*$6->returnpointlist));
														}
		|gheiragar GHEYR_AGAR   expression ANGAH  AN AM2 {cout << "gheiragar --> GHEYR_AGAR ANGAH statement gheiragar"<<endl;
													//	addk("GHEYR_AGAR","GHEYR_AGAR");
														if (!$3->type->compare("arithmetic")){
															$3->falselist= new list<int>(makeList(getquadCount()));
															emit("if ( ",*$3->place, " == 0 ) goto ","","","");
															$3->truelist= new list<int>(makeList(getquadCount()));
															emit ("goto ","","","","","");
														}
														$$= new struct id;
														backpatch(*$3->truelist,$6->quad);
														backpatch(*$3->falselist,$6->quad);
														$$->nextlist=new list<int>(merge(*$1->nextlist,*$5->nextlist));
														$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
														$$->returnpointlist= $1->returnpointlist;
														}
		| 		{cout << "gheiragar --> empty"<<endl;
				$$= new struct id;
				$$->nextlist=new list<int>();
				$$->returnlist=new list<int>();
				$$->returnpointlist= new list<int>();
				}
		;
	gheiragar_main:
		gheiragar_main GHEYR_AGAR  expression  ANGAH AM1 statement_main AN AM2  {cout << "gheiragar --> GHEYR_AGAR expression ANGAH statement gheiragar"<<endl;
													//	addk("GHEYR_AGAR","GHEYR_AGAR");
														if (!$3->type->compare("arithmetic")){
															$3->falselist= new list<int>(makeList(getquadCount()));
															emit("if ( ",*$3->place, " == 0 ) goto ","","","");
															$3->truelist= new list<int>(makeList(getquadCount()));
															emit ("goto ","","","","","");
														}
														$$= new struct id;
														backpatch(*$3->truelist,$6->quad);
														backpatch(*$3->falselist,$8->quad);
														$$->nextlist=new list<int>(merge(*$1->nextlist,*$5->nextlist,*$6->nextlist));
														$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist,*$6->returnlist));
														}
		|gheiragar_main GHEYR_AGAR  expression ANGAH AN AM2  {cout << "gheiragar --> GHEYR_AGAR ANGAH statement gheiragar"<<endl;
													//	addk("GHEYR_AGAR","GHEYR_AGAR");
														if (!$3->type->compare("arithmetic")){
															$3->falselist= new list<int>(makeList(getquadCount()));
															emit("if ( ",*$3->place, " == 0 ) goto ","","","");
															$3->truelist= new list<int>(makeList(getquadCount()));
															emit ("goto ","","","","","");
														}
														$$= new struct id;
														backpatch(*$3->truelist,$6->quad);
														backpatch(*$3->falselist,$6->quad);
														$$->nextlist=new list<int>(merge(*$1->nextlist,*$5->nextlist));
														$$->returnlist=new list<int>(merge(*$1->returnlist,*$3->returnlist));
														}
		| 		{cout << "gheiragar --> empty"<<endl;
				$$= new struct id;
				$$->nextlist=new list<int>();
				$$->returnlist=new list<int>();
				}
		;	
	gheir:
		GHEYR  statement {cout << "gheir --> GHEYR statement"<<endl;
					//	addk("GHEYR","GHEYR");
					$$= new struct id;
					$$->nextlist=$2->nextlist;
					$$->returnlist=$2->returnlist;
					$$->returnpointlist= $2->returnpointlist;
					}
		|GHEYR	{cout << "gheir --> GHEYR "<<endl;
					//	addk("GHEYR","GHEYR");
					$$= new struct id;
					$$->nextlist=new list<int>();
					$$->returnlist= new list<int>();
					$$->returnpointlist= new list<int>();
					}
		| 	{cout << "gheir --> empty"<<endl;
			$$= new struct id;
			$$->nextlist=new list<int>();
			$$->returnlist= new list<int>();
			$$->returnpointlist= new list<int>();
			}
		;
	gheir_main:
		GHEYR   statement_main {cout << "gheir --> GHEYR statement"<<endl;
					//	addk("GHEYR","GHEYR");
					$$= new struct id;
					$$->nextlist=$2->nextlist;
					$$->returnlist=$2->returnlist;
					}
		|GHEYR 	 {cout << "gheir --> GHEYR "<<endl;
					//	addk("GHEYR","GHEYR");
					$$= new struct id;
					$$->nextlist=new list<int>();
					$$->returnlist= new list<int>();
					}
		| 	{cout << "gheir --> empty"<<endl;
			$$= new struct id;
			$$->nextlist=new list<int>();
			$$->returnlist= new list<int>();
			}
		;
	AM1 :	{
				$$= new struct id;
				$$->quad=getquadCount();
			}
		;
	AM2 :	{
				$$= new struct id;
				$$->quad=getquadCount();
			}
		;
	AN	:	{
				$$= new struct id;
				$$->nextlist= new list<int>(makeList(getquadCount()));
				emit("goto ","","","","","");
			}
		;
	arraytype: 
		SAHIH		{cout << "arraytype --> SAHAIH"<<endl;
					type = "SAHIH";
					}
		| ASHARI	{cout << "arraytype --> ASHARI"<<endl;
					type = "ASHARI";
					}
	;	
	range:
		SAHIH_CONST TA SAHIH_CONST	{cout << "range --> SAHIH_CONS TA SAHIH_CONST"<<endl;
							//		addv($1,"SAHIH_CONST");
							//		addv($3,"SAHIH_CONST");
							//		addk("TA","TA");
									arrayLowerLimit = $1;
									arrayHigherLimit = $3;
									}
		;
%%

//comment for symbol table
//because we had to define type after the identifier is declared,
//we have stack that we push the address of the identifiers in it
//then when we are reducing the type we pop the stack and change the type
//and offset of it.
void yyerror(char *s) {
			cout << s;
	}
int main(){
		//initializing key symbol table
		//stk.first=new symbolTableNode;
		//stk.first->attribute="first";
		//stk.first->index=0;
		//stk.first->name="firstKeyNode";
		//stk.first->next=NULL;
		//stk.first->prev=NULL;
		//stk.first->type="null";
		//stk.last=stk.first;
		//stk.lastindex=0;
		//initializing variable symbol table
		//stv.first=new symbolTableNode;
		//stv.first->attribute="first";
		//stv.first->index=0;
		//stv.first->name="firstVariableNode";
		//stv.first->next=NULL;
		//stv.first->prev=NULL;
		//stv.first->type="null";
		//stv.last=stv.first;
		//stv.lastindex=0;
		yyparse();
		//printst();
		return 0;
	}

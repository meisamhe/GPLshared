%option noyywrap
%{
#include "parse.tab.h"
#include <iostream>
#include <math.h>
using namespace std;
struct id{
	char *name;
	int length;
};
%}
letter [A-Za-z_]
digit [0-9]
nzdigit [1-9]
ws [\ \t\n\r\f]
%%
{ws} {}
برنامه {return BARNAMEH;}
متغير {return MOTAGHAYER;}
; 	{return *yytext;}
: {return *yytext;}
صحيح {return SAHIH;}
حقيقي {return ASHARI;}
آرايه {return ARAYEH;}
\.\. {return TA;}
از {return AZ;}
رويه  {return RAVIEH;}
شروع {return SHOROO;}
حلقه {return HALGHEH;}
پايان {return KHATEMEH;}
بخوان {return BEKHAN;}
بنويس {return BENEVIS;}
آخرحلقه {return ENTEHAYE_HALGHEH;}
آخراگر {return KHATEMEH_AGAR;}
اگر {return AGAR;}
آنگاه {return ANGAH;}
غير {return GHEYR;}
غير\ اگر {return GHEYR_AGAR;}
براي {return BARAYE;}
\+ {return *yytext;}
- {return *yytext;}
\* {return *yytext;}
\/ {return *yytext;}
\>= {return GE;}
\<= {return LE;}
\= {return *yytext;}
\<> {return NE;}
\< {return *yytext;}
\> {return *yytext;}
و {return VA;}
يا { return YA;}
ياغير {return YAGHEYR;}
نه { return NA;}
\( {return *yytext;}
\) {return *yytext;}
\[ {return *yytext;}
\] {return *yytext;}
در { return DAR;}
معکوس {return MAKOOS;}
:= { return ASSIGN;}
وپس {return VAPAS;}
بخش\ بر {return TAGHSIM_BAR;}
خروج {return KHOROOJ;}
وقتي {return VAGHTI_KEH;}
باقيمانده {return BAGHIMANDEH;}
بازگردان {return RETURN;}
, {return *yytext;}
{letter}({digit}|{letter})* {
					struct id *temp= new struct id;
					temp->name = yytext;
					temp->length=strlen(yytext);
					yylval.sid=temp;
				//	yylval.sid->name= yytext;
				//	yylval.sid->length=strlen(yytext);
				//	*(yytext+strlen(yytext))='\0';
				//	cout << yytext<<" this is false"<<endl;
					return ID;
					}
(0\.{digit}+)([eE][+-]?{digit}+)? {
	yylval.dval = atof(yytext);
	return ASHARI_CONST;
}
({nzdigit}+{digit}*\.{digit}+)([eE][+-]?{digit}+)? {
				yylval.dval = atof(yytext);
				return ASHARI_CONST;
				}
\. {return *yytext;}
({nzdigit}+{digit}*)|0 {
		yylval.ival = atoi(yytext);
		return SAHIH_CONST;
		}
. { return INVALIDTOKEN;}
%%
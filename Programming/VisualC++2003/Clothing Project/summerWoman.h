#ifndef SUMMERWOMAN_H
#define SUMMERWOMAN_H
#include "summer.h"
//---------------------------------------------------
enum zerafat {low, medium, high};
enum tangi (low, medium, high);
enum clothKind {shalvar, shalvarak, pirahan, tshirt, kolah, kot, daman, mantow, top};
//---------------------------------------------------
class summerWoman : public summer
{
        private:
                zerafat ZerafateLebas;
                tangi tangieLebas;
                clothKind cKind;
        public:
                summerWoman (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, cooling cd, lenght l, zerafat z, tangi t, clothKind ck): summer ( size s, int q, int d, int bp, int sp, color cc, kind ck, int vq, int long c, int sd, cooling cd, lenght l)
                {
                        long int tempCode;
                        tempcode=13;
                        tempcode=tempcode*10+getColor()+1;
                        tempcode=tempcode*10+getKind()+1;
                        tempcode=tempcode*10+getSize()+1;
                        tempcode=tempcode*10+getCooling()+1;
                        tempcode=tempcode*10+getShortness()+1;
                        tempcode=tempcode*10+cKind+1;
                        tempcode=tempcode*10+zerafateLebas+1;
                        tempcode=tempcode*10+tangieLebas+1;
                        zerafateLebas=z;
                        tangieLebas=t;
                        cKind=ck;
                        setCode (tempCode);
                }
                zerafat getZerafat () {return (zerafateLebas);};
                tangi getTangi () {return (tangieLebas);};
                clothKind getClothKind () {return (cKind);};
                ~summerWoman();
};//end class summerWoman
//---------------------------------------------------
#endif

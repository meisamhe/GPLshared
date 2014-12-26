#ifndef WINTERWOMAN_H
#define WINTERWOMAN_H
#include "winter.h"
//---------------------------------------------------
enum zerafat {low, medium, high};
enum tangi (low, medium, high);
enum clothKind {shalvar, kapshan, pirahan, kolah, kot, daman, mantow, shaal, palto, blouse};
//---------------------------------------------------
class winterWoman : public winter
{
        private:
                zerafat ZerafateLebas;
                tangi tangieLebas;
                clothKind cKind;
        public:
                winterWoman (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming cd, lenght l, zerafat z, tangi t, clothKind ck): summer ( size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming cd, lenght l)
                {
                        long int tempCode;
                        tempcode=23;
                        tempcode=tempcode*10+getColor()+1;
                        tempcode=tempcode*10+getKind()+1;
                        tempcode=tempcode*10+getSize()+1;
                        tempcode=tempcode*10+getWarming()+1;
                        tempcode=tempcode*10+getLongness()+1;
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
                ~winterWoman();
};//end class winterWoman
//---------------------------------------------------
#endif


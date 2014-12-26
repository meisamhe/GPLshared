#ifndef SUMMERMAN_H
#define SUMMERMAN_H
#include "summer.h"
//---------------------------------------------------
enum trip {official, sport};
enum clothKind {shalvar, shalvarak, pirahan, tshirt, kolah, kot};
//---------------------------------------------------
class summerMan : public summer
{
        private:
                trip tip;
                clothKind cKind;
        public:
                summerMan (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, cooling cd, lenght l, trip t, clothKind ck): summer ( size s, int q, int d, int p, int c, color cc, kind ck, int vq,  int sd, cooling cd, lenght l)
                {
                        long int tempCode;
                        tempcode=11;
                        tempcode=tempcode*10+getColor()+1;
                        tempcode=tempcode*10+getKind()+1;
                        tempcode=tempcode*10+getSize()+1;
                        tempcode=tempcode*10+getCooling()+1;
                        tempcode=tempcode*10+getShortness()+1;
                        tempcode=tempcode*10+cKind+1;
                        tempcode=tempcode*10+tip+1;
                        tempcode=tempcode*10+1;
                        trip=t;
                        cKind=ck;
                        setCode (tempCode);
                }
                trip getTip () {return (tip);};
                clothKind getClothKind () {return (cKind);};
                ~summerMan();
};//end class summerMan
//---------------------------------------------------
#endif
#ifndef WINTERMAN_H
#define WINTERMAN_H
#include "winter.h"
//---------------------------------------------------
enum trip {official, sport};
enum clothKind {shalvar, kapshan, pirahan, blouse, kolah, kot, palto};
//---------------------------------------------------
class winterMan : public winter
{
        private:
                trip tip;
                clothKind cKind;
        public:
                winterMan (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming wd, lenght l, trip t, clothKind ck): winter ( size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming wd, lenght l)
                {
                        long int tempCode;
                        tempcode=21;
                        tempcode=tempcode*10+getColor()+1;
                        tempcode=tempcode*10+getKind()+1;
                        tempcode=tempcode*10+getSize()+1;
                        tempcode=tempcode*10+getWarming()+1;
                        tempcode=tempcode*10+getLongness()+1;
                        tempcode=tempcode*10+cKind+1;
                        tempcode=tempcode*10+tip+1;
                        tempcode=tempcode*10+1;
                        trip=t;
                        cKind=ck;
                        setCode (tempCode);
                }
                trip getTip () {return (tip);};
                clothKind getClothKind () {return (cKind);};
                ~winterMan();
};//end class winterMan
//---------------------------------------------------
#endif
 
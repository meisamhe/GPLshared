#ifndef WINTERCHILD_H
#define WINTERCHILD_H
#include "winter.h"
//---------------------------------------------------
enum clothKind {shalvar, Kapshan, pirahan, blouse, kolah, shaal};
//---------------------------------------------------
class winterChild : public winter
{
        private:
                bool picture;
                clothKind cKind;
        public:
                winterChild (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming cd, lenght l, bool p, clothKind ck): winter ( size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming cd, lenght l)
                {
                        long int tempCode;
                        tempcode=22;
                        tempcode=tempcode*10+getColor()+1;
                        tempcode=tempcode*10+getKind()+1;
                        tempcode=tempcode*10+getSize()+1;
                        tempcode=tempcode*10+getWarming()+1;
                        tempcode=tempcode*10+getLongness()+1;
                        tempcode=tempcode*10+cKind+1;
                        tempcode=tempcode*10+getPicture()+1;
                        tempcode=tempcode*10+1;
                        picture=true;
                        cKind=ck;
                        setCode (tempCode);
                }
                bool getPicture () {(picture==true) ? return (1) : return (0);};
                clothKind getClothKind () {return (cKind);};
                ~summerMan();
};//end class winterChild
//---------------------------------------------------
#endif

#ifndef SUMMERCHILD_H
#define SUMMERCHILD_H
#include "summer.h"
//---------------------------------------------------
enum clothKind {shalvar, shalvarak, pirahan, tshirt, kolah};
//---------------------------------------------------
class summerChild : public summer
{
        private:
                bool picture;
                clothKind cKind;
        public:
                summerChild (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  cooling cd, lenght l, bool p, clothKind ck): summer ( size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  cooling cd, lenght l)
                {
                        long int tempCode;
                        tempcode=12;
                        tempcode=tempcode*10+getColor()+1;
                        tempcode=tempcode*10+getKind()+1;
                        tempcode=tempcode*10+getSize()+1;
                        tempcode=tempcode*10+getCooling()+1;
                        tempcode=tempcode*10+getShortness()+1;
                        tempcode=tempcode*10+cKind+1;
                        tempcode=tempcode*10+getPicture()+1;
                        tempcode=tempcode*10+1;
                        picture=true;
                        cKind=ck;
                        setCode (tempCode);
                }
                bool getPicture () {return (picture);};
                clothKind getClothKind () {return (cKind);};
                ~summerMan();
};//end class summerChild
//---------------------------------------------------
#endif
 
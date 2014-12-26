#include "cloth.h"
//---------------------------------------------------------
cloth :: cloth (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq, int sd)
{
        setSeasonDiscount(sd);
        clothSize=s;
        (q>0) ? quantity=q : quantity=0;
        (d>=0 && d<=100) ? discount=d : discount=0;
        code=0;
        clothColor=cc;
        clothKind=ck;
        (vq>=0) ? validQuantity=vq : validQuantity=0;
        (sp>=0) ? sellPrice=sp : sellPrice=0;
        (bp>=0) ? buyPrice=bp : buyPrice=0;
}//end cloth constructor
//---------------------------------------------------------


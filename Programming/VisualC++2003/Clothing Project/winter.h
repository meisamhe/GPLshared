#ifndef WINTER_H
#define WINTER_H
#include "cloth.h"
//----------------------------------------------------
enum warming {low, medium, high};
enum lenght {low, medium, high};
//----------------------------------------------------
class winter : public cloth
{
        private:
                warming warmDegree;
                lenght longness;
        public:
                winter (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd, warming wd, lenght l): cloth (size s, int q, int d, int bp, int sp, color cc, kind ck, int vq,  int sd)
                {
                        warmDegree=wd;
                        longness=l;
                }
                warming getWarmDegree () {return (warmDegree);};
                lenght getLongness() {return (longness);};
                ~winter();
};//end class winter
#endif
 
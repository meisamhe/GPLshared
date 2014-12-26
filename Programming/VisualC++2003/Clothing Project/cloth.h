//--------------------------------------------------------
#ifndef CLOTH_H
#define CLOTH_H
//---------------------------------------------------------
enum color {Red, Blue, White, Black, Green, Yellow, Purple, Cream, Gray};
enum kind {Silk, Panbeh, Cotton, Nakh, Makhmal, Pashm, Leather};
enum size {Small, Medium, Large, Xlarge, XXlarge, XXXlarge};
//---------------------------------------------------------
class cloth {
        private:
                size clothSize;
                int quantity;
                int discount;
                int buyPrice;
                int sellPrice;
                color clothColor;
                kind clothKind;
                int validQuantity;
                long int code;
                int seasonDiscount;
        public:
                cloth (size, int, int, int, int, color, kind, int, int);
                void setSellPrice(int sp) {(sp>0) ? sellPrice=sp : sellPrice=0;};
                void setDiscount(int d) {(d>=0 && d<=100) ? discount=d : discount=0;};
                void setSeasonDiscount(int sd) {(sd>=0 && sd<=100) ? seasonDiscount=sd : seasonDiscount=0;};
                void setValidQuantity(int vq) { (vq>=0) ? validQuantity=vq : validQuantity=0;};
                void setCode (long int c) {code=c;};
                size getSize() {return (clothSize);};
                int getQuantity() {return (quantity);};
                int getDiscount() {return (discount);};
                int getSeasonDiscount() {return (seasonDiscount);};
                long int getCode() {return (code);};
                int getSellPrice() {return (sellPrice);};
                int getBuyPrice() {return (buyPrice);};
                color getColor() {return (clothColor);};
                kind getKind() {return (clothKind);};
                int getValidQuantity() {return (validQuantity);};
                virtual void sell()=0;
                ~cloth();
};//end class cloth
//---------------------------------------------------------
#endif

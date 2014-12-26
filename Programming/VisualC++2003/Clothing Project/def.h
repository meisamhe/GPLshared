#ifndef DEF_H
#define DEF_H
//---------------------------------------
#include <stdio.h>
#include <io.h>
#include "dateBst.h"
#include "codeBst.h"

//File haye mojood:
        FILE *sellFile;               //ettela'ate foroosh be tartibe tarikh
        FILE *incomeFile;             //ettela'ate daramade har rooz be tartibe tarikh
        FILE *customerFile;           //ettela'ate khosoosie moshtari
        FILE *goodsFile;              //ettela'ate kalahaye mojood
        FILE *sourceFile;             //ettela'ate voroodi be anbar be tartibe rooz
//Derakht haye mojood:
        dateBst income;                 //file: income - gozareshe daramad dar bazeye zamani
        dateBst source;                 //file: source - gozarashe voroode pooshak be anbar
                                        //mablaghe pardakhtie anbar
        dateBst sell;                   //file: sell - gozareshe forooshe kol
                                        //forooshe yek kalaye moshakhas
                                        //forooshe yek kala dar soorathesabe moshtarian
        codeBst good;                   //file: goods - ettea'ate kalahaye mojood
//tarikh
        char systemDate[10];
#endif
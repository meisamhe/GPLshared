 #======================================================
 # Crawler code for Manga Project
 # Written by Meisam Hejazi Nia
 # May 20, 2014
 #========================================================
 # initialize imacro code
 #-----------------------------------------------------------
 # take the current working directory
  use Cwd;
  use POSIX;

  my $cwd = getcwd();
  print "current working directory is: $cwd\n";
  $cwd =~ tr/\//\\\\/;
  my $currentURL="";
  my $macro = "";

 # initialize iMacro
 use Win32::OLE;

 print "=================================================================================\n";
 print "=================*** MANGA PROJECT***=======================================\n" ;
 print "==================By: Mina Ameri, Meisam Hejazi Nia, Norris Bruce========================\n" ;
 print "====================Crawler By Meisam Hejazi Nia=================================\n";
 print "=====================Don't care about above warnings, they are irrelevant :D===========================\n";
 print "==========================================================================================\n";


 # =================================================
 #  crawl anime pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'Anime';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\AnimeScripts\\FirstSearchPagAnimeeSave.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+) results/){
    my $tempstring = $1;
    $tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/60);
 print "Total number of Anime to be saved Extraction ($totalNumCategPages Pages)..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\AnimeScripts\\NextPageSearchAnimeSave.iim";
 while  ( $animepageNum<$totalNumCategPages ){
      $b->iimInit();
      $animepageNum = $animepageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animepageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving anime page $animepageNum..........................Done\n";
      $b->iimExit();
 }

#-----------------------------------------------------------------
# save the manga's from the list by going through each one by one
#------------------------------------------------------------------
# read the csv file
use strict;
use warnings;

 my $URLLogFileName = 'CurrentURLLogFile.txt';
 my $resultURL = " ";
 my $resultnum = 0;
 my $numberOfPageTxt= " ";
 my $numberpageresults=0;
 my $resultpageNumerator=1;


my $MangaListFile = $cwd.'\\List\\MangaList.csv';
my $animeItemPage = 0;
my $MangaItem;
my $curMangaNumber  = 0;
my $curMangaName    = " ";
open(my $MangaList, '<', $MangaListFile) or die "Could not open '$MangaListFile' $!\n";
# open(my $URLLogFile, '>', $URLLogFileName) or die "Could not open file '$URLLogFileName' $!";


while (($MangaItem = <$MangaList>) ) {      #   && ($curMangaNumber<3)
  chomp $MangaItem;

  my @fields = split "," , $MangaItem;
  $curMangaNumber = $fields[0];
  $curMangaName = $fields[1];
  # add current realization name to search
  $curMangaName =  "$curMangaName  $realizationPath";
  $curMangaName =~ tr/ /+/;
  $curMangaName =~ tr/\///;
  $curMangaName =~ tr/\\//;
  $curMangaName =~ tr/\?//;
  $curMangaName =~ tr/://;
  $curMangaName =~ tr/\*//;
  $curMangaName =~ tr/"//;
  $curMangaName =~ tr/>//;
  $curMangaName =~ tr/<//;
  $curMangaName =~ tr/\|//;
  my $numberpageresults = 0;

  $animeItemPage = 0;


   while  ( $animeItemPage <1 ){
      $macro = "$cwd\\Modules\\AnimeScripts\\SearchAnime.iim";
      $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
      $b->{Visible} = 1;
      $b->iimInit();
      $animeItemPage = $animeItemPage + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animeItemPage);
      $b->iimSet('mangaName',  $curMangaName);
      $b->iimSet('mangaNumber',  $curMangaNumber);
      $b->iimPlay($macro);
      $numberOfPageTxt = $b ->iimGetLastExtract();
      # extract number of pages
      #1-16 of 19 results for Movies & TV :  "Hayate the Combat Butler Anime"
      #7 results for Movies & TV :   "Date A Live Anime"
      #print "the current string to search for item numbers in it is:\n $numberOfPageTxt\n";
      if ($numberOfPageTxt =~/([0-9]+) results/){
            $numberpageresults = $1;
            #print "from the text the extracted value is:   $numberpageresults";
      }
      print "Saving Search Anime page $animeItemPage..........................Done\n";
      print "Saving Search items of Anime page $animeItemPage ($numberpageresults items) ..........................InProcess\n";

     # $currentURL = $b ->iimGetLastExtract();
     # print "The Current URL is: $currentURL\n";
     # print $URLLogFile "The Current URL is: $currentURL\n";

      $macro = "$cwd\\Modules\\AnimeScripts\\InsideResultsPage.iim";
      $resultURL=" ";
      $resultnum = 0;
      $resultpageNumerator = 1;

      #while ($currentURL ne  $resultURL){
      while ($resultnum < $numberpageresults){

#                  $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
#                  $b->{Visible} = 1;
#                  $b->iimInit();
                 $macro = "$cwd\\Modules\\AnimeScripts\\InsideResultsPageNextPage.iim";
                 $b->iimSet('currworkDirect', $cwd  );
                 $b->iimSet('realizationPath', $realizationPath  );
                 $b->iimSet('pagenum',  $animeItemPage);
                 $b->iimSet('mangaName',  $curMangaName);
                 $b->iimSet('mangaNumber',  $curMangaNumber);
                 $b->iimSet('resultnum',  $resultnum);
                 $b->iimSet('nextPageNum',  $resultpageNumerator);
                 $b->iimPlay($macro);
                 $resultURL = $b ->iimGetLastExtract();
                # print "The Current URL is: $currentURL\n";
                 #print $URLLogFile "The Current URL is: $currentURL\n";
                 print "Saving Search Anime result item $resultnum ..........................Done\n";
                 $resultnum++;#+=6;
                 if (($resultnum % 16 == 0)) {          # || ($resultnum / 16 > 1)
                      # change macro to go to next page
                       $b->iimExit();
                       $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
                       $b->{Visible} = 1;
                       $b->iimInit();
                       $macro = "$cwd\\Modules\\AnimeScripts\\SearchAnimeNextPage.iim";
                       $resultpageNumerator++;
                       $b->iimSet('currworkDirect', $cwd  );
                       $b->iimSet('realizationPath', $realizationPath  );
                       $b->iimSet('pagenum',  $animeItemPage);
                       $b->iimSet('mangaName',  $curMangaName);
                       $b->iimSet('mangaNumber',  $curMangaNumber);
                       $b->iimSet('resultnum',  $resultnum);
                       $b->iimSet('nextPageNum',  $resultpageNumerator);
                       $b->iimPlay($macro);
                       print " move to next page of Anime..........................................Done\n";
                       # Next page
                       #http://www.amazon.com/s/ref=sr_pg_2?rh=n%3A2625373011%2Ck%3A{{mangaName}}&page={{nextPageNum}}
                       # change macro to be used in browsing the results
                 }
        }



      $b->iimExit();
 }

  print "All relevent data to anime of $curMangaName\t $curMangaNumber=====================================Done\n";
}

  print "=============================End of the Anime Crawling:==================================================\n"      ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"   ;
  print "=============================Great! All the Anime Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Anime crawling
# At this point all the search pages and all the 99 Manga's from the list are downloaded
#=======================================================================================

# =================================================
 #  crawl Manga pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'Manga';
 #====================================================================
 print "===============================================================================================\n";
 print "======================================Beginning to Crawl Manga Book Items============================\n";
  print "===============================================================================================\n";
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\mangaScripts\\FirstSearchPagMangaSave.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 my $mangapageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $mangapageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+) results/){
    my $tempstring = $1;
    $tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/60);
 print "Total number of Manga to be saved Extraction ($totalNumCategPages Pages), but due to problem for now we only crawl 20 pages..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\mangaScripts\\NextPageSearchMangaSave.iim";
 while  ( $mangapageNum< 20){       # $totalNumCategPages  # for now it is set to 20 until Amazon solves the problem
      $b->iimInit();
      $mangapageNum = $mangapageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $mangapageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving manga page $mangapageNum..........................Done\n";
      $b->iimExit();
 }

#-----------------------------------------------------------------
# save the manga's from the list by going through each one by one
#------------------------------------------------------------------
# read the csv file
use strict;
use warnings;

 my $URLLogFileName = 'CurrentURLLogFile.txt';
 my $resultURL = " ";
 my $resultnum = 0;
 my $numberOfPageTxt= " ";
 my $numberpageresults=0;
 my $resultpageNumerator=1;


my $MangaListFile = $cwd.'\\List\\MangaList.csv';
my $mangaItemPage = 0;
my $MangaItem;
my $curMangaNumber  = 0;
my $curMangaName    = " ";
open(my $MangaList, '<', $MangaListFile) or die "Could not open '$MangaListFile' $!\n";


while (($MangaItem = <$MangaList>) ) {      #   && ($curMangaNumber<3)
  chomp $MangaItem;

  my @fields = split "," , $MangaItem;
  $curMangaNumber = $fields[0];
  $curMangaName = $fields[1];
  # add current realization name to search
  $curMangaName =  "$curMangaName  $realizationPath";
  $curMangaName =~ tr/ /+/;
  $curMangaName =~ tr/\///;
  $curMangaName =~ tr/\\//;
  $curMangaName =~ tr/\?//;
  $curMangaName =~ tr/://;
  $curMangaName =~ tr/\*//;
  $curMangaName =~ tr/"//;
  $curMangaName =~ tr/>//;
  $curMangaName =~ tr/<//;
  $curMangaName =~ tr/\|//;
  my $numberpageresults = 0;

  $mangaItemPage = 0;


   while  ( $mangaItemPage <1 ){
      $macro = "$cwd\\Modules\\mangaScripts\\SearchManga.iim";
      $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
      $b->{Visible} = 1;
      $b->iimInit();
      $mangaItemPage = $mangaItemPage + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $mangaItemPage);
      $b->iimSet('mangaName',  $curMangaName);
      $b->iimSet('mangaNumber',  $curMangaNumber);
      $b->iimPlay($macro);
      $numberOfPageTxt = $b ->iimGetLastExtract();
      # extract number of pages
      #1-16 of 19 results for Movies & TV :  "Hayate the Combat Butler Anime"
      #7 results for Movies & TV :   "Date A Live Anime"
      #print "the current string to search for item numbers in it is:\n $numberOfPageTxt\n";
      if ($numberOfPageTxt =~/([0-9]+) results/){
            $numberpageresults = $1;
            #print "from the text the extracted value is:   $numberpageresults";
      }
      print "Saving Search Manga page $mangaItemPage..........................Done\n";
      print "Saving Search items of Manga page $mangaItemPage ($numberpageresults items) ..........................InProcess\n";

     # $currentURL = $b ->iimGetLastExtract();
     # print "The Current URL is: $currentURL\n";
     # print $URLLogFile "The Current URL is: $currentURL\n";

      $macro = "$cwd\\Modules\\mangaScripts\\InsideResultsPage.iim";
      $resultURL=" ";
      $resultnum = 0;
      $resultpageNumerator = 1;

      #while ($currentURL ne  $resultURL){
      while ($resultnum < $numberpageresults){

#                  $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
#                  $b->{Visible} = 1;
#                  $b->iimInit();
                 $macro = "$cwd\\Modules\\mangaScripts\\InsideResultsPageNextPage.iim";
                 $b->iimSet('currworkDirect', $cwd  );
                 $b->iimSet('realizationPath', $realizationPath  );
                 $b->iimSet('pagenum',  $mangaItemPage);
                 $b->iimSet('mangaName',  $curMangaName);
                 $b->iimSet('mangaNumber',  $curMangaNumber);
                 $b->iimSet('resultnum',  $resultnum);
                 $b->iimSet('nextPageNum',  $resultpageNumerator);
                 $b->iimPlay($macro);
                 $resultURL = $b ->iimGetLastExtract();
                # print "The Current URL is: $currentURL\n";
                 #print $URLLogFile "The Current URL is: $currentURL\n";
                 print "Saving Search Manga result item $resultnum ..........................Done\n";
                 $resultnum++;#+=6;
                 if (($resultnum % 12 == 0)) {          # || ($resultnum / 16 > 1)      #caution that each page has only 12 items
                      # change macro to go to next page
                       $b->iimExit();
                       $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
                       $b->{Visible} = 1;
                       $b->iimInit();
                       $macro = "$cwd\\Modules\\mangaScripts\\SearchMangaNextPage.iim";
                       $resultpageNumerator++;
                       $b->iimSet('currworkDirect', $cwd  );
                       $b->iimSet('realizationPath', $realizationPath  );
                       $b->iimSet('pagenum',  $mangaItemPage);
                       $b->iimSet('mangaName',  $curMangaName);
                       $b->iimSet('mangaNumber',  $curMangaNumber);
                       $b->iimSet('resultnum',  $resultnum);
                       $b->iimSet('nextPageNum',  $resultpageNumerator);
                       $b->iimPlay($macro);
                       print " move to next page of Mangas..........................................Done\n";
                       # Next page
                       #http://www.amazon.com/s/ref=sr_pg_2?rh=n%3A2625373011%2Ck%3A{{mangaName}}&page={{nextPageNum}}
                       # change macro to be used in browsing the results
                 }
        }

      $b->iimExit();
 }

  print "Manga item $curMangaName\t $curMangaNumber==============================================Done\n";
}

  print "=============================End of the Manga Book Crawling:================================================== \n"  ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"  ;
  print "=============================Great! All the Mangas Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Manga Book crawling
# At this point all the search pages and all the 99 Manga's from the list are downloaded
#=======================================================================================

# =================================================
 #  crawl  Anime Games pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'Anime Game';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\GameScripts\\FirstSearchPagAnimeeSave.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 my $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+) results/){
    my $tempstring = $1;
    $tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/60);
 print "Total number of Anime Game to be saved Extraction ($totalNumCategPages Pages)..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\GameScripts\\NextPageSearchAnimeSave.iim";
 while  ( $animepageNum<$totalNumCategPages ){
      $b->iimInit();
      $animepageNum = $animepageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animepageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving Anime Game page $animepageNum..........................Done\n";
      $b->iimExit();
 }

#-----------------------------------------------------------------
# save the manga's from the list by going through each one by one
#------------------------------------------------------------------
# read the csv file
use strict;
use warnings;

 my $URLLogFileName = 'CurrentURLLogFile.txt';
 my $resultURL = " ";
 my $resultnum = 0;
 my $numberOfPageTxt= " ";
 my $numberpageresults=0;
 my $resultpageNumerator=1;


my $MangaListFile = $cwd.'\\List\\MangaList.csv';
my $animeItemPage = 0;
my $MangaItem;
my $curMangaNumber  = 0;
my $curMangaName    = " ";
open(my $MangaList, '<', $MangaListFile) or die "Could not open '$MangaListFile' $!\n";
# open(my $URLLogFile, '>', $URLLogFileName) or die "Could not open file '$URLLogFileName' $!";


while (($MangaItem = <$MangaList>) ) {      #   && ($curMangaNumber<3)
  chomp $MangaItem;

  my @fields = split "," , $MangaItem;
  $curMangaNumber = $fields[0];
  $curMangaName = $fields[1];
  # add current realization name to search
  $curMangaName =  "$curMangaName  $realizationPath";
  $curMangaName =~ tr/ /+/;
  $curMangaName =~ tr/\///;
  $curMangaName =~ tr/\\//;
  $curMangaName =~ tr/\?//;
  $curMangaName =~ tr/://;
  $curMangaName =~ tr/\*//;
  $curMangaName =~ tr/"//;
  $curMangaName =~ tr/>//;
  $curMangaName =~ tr/<//;
  $curMangaName =~ tr/\|//;
  my $numberpageresults = 0;

  $animeItemPage = 0;


   while  ( $animeItemPage <1 ){
      $macro = "$cwd\\Modules\\GameScripts\\SearchAnime.iim";
      $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
      $b->{Visible} = 1;
      $b->iimInit();
      $animeItemPage = $animeItemPage + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animeItemPage);
      $b->iimSet('mangaName',  $curMangaName);
      $b->iimSet('mangaNumber',  $curMangaNumber);
      $b->iimPlay($macro);
      $numberOfPageTxt = $b ->iimGetLastExtract();
      # extract number of pages
      #1-16 of 19 results for Movies & TV :  "Hayate the Combat Butler Anime"
      #7 results for Movies & TV :   "Date A Live Anime"
      #print "the current string to search for item numbers in it is:\n $numberOfPageTxt\n";
      if ($numberOfPageTxt =~/([0-9]+) results/){
            $numberpageresults = $1;
            #print "from the text the extracted value is:   $numberpageresults";
      }
      print "Saving Search Anime Game page $animeItemPage..........................Done\n";
      print "Saving Search items of Anime Game page $animeItemPage ($numberpageresults items) ..........................InProcess\n";

     # $currentURL = $b ->iimGetLastExtract();
     # print "The Current URL is: $currentURL\n";
     # print $URLLogFile "The Current URL is: $currentURL\n";

      $macro = "$cwd\\Modules\\GameScripts\\InsideResultsPage.iim";
      $resultURL=" ";
      $resultnum = 0;
      $resultpageNumerator = 1;

      #while ($currentURL ne  $resultURL){
      while ($resultnum < $numberpageresults){

#                  $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
#                  $b->{Visible} = 1;
#                  $b->iimInit();
                 $macro = "$cwd\\Modules\\GameScripts\\InsideResultsPageNextPage.iim";
                 $b->iimSet('currworkDirect', $cwd  );
                 $b->iimSet('realizationPath', $realizationPath  );
                 $b->iimSet('pagenum',  $animeItemPage);
                 $b->iimSet('mangaName',  $curMangaName);
                 $b->iimSet('mangaNumber',  $curMangaNumber);
                 $b->iimSet('resultnum',  $resultnum);
                 $b->iimSet('nextPageNum',  $resultpageNumerator);
                 $b->iimPlay($macro);
                 $resultURL = $b ->iimGetLastExtract();
                # print "The Current URL is: $currentURL\n";
                 #print $URLLogFile "The Current URL is: $currentURL\n";
                 print "Saving Search Anime result item $resultnum ..........................Done\n";
                 $resultnum++;#+=6;
                 if (($resultnum % 16 == 0)) {          # || ($resultnum / 16 > 1)
                      # change macro to go to next page
                       $b->iimExit();
                       $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
                       $b->{Visible} = 1;
                       $b->iimInit();
                       $macro = "$cwd\\Modules\\GameScripts\\SearchAnimeNextPage.iim";
                       $resultpageNumerator++;
                       $b->iimSet('currworkDirect', $cwd  );
                       $b->iimSet('realizationPath', $realizationPath  );
                       $b->iimSet('pagenum',  $animeItemPage);
                       $b->iimSet('mangaName',  $curMangaName);
                       $b->iimSet('mangaNumber',  $curMangaNumber);
                       $b->iimSet('resultnum',  $resultnum);
                       $b->iimSet('nextPageNum',  $resultpageNumerator);
                       $b->iimPlay($macro);
                       print " move to next page of Anime Game..........................................Done\n";
                       # Next page
                       #http://www.amazon.com/s/ref=sr_pg_2?rh=n%3A2625373011%2Ck%3A{{mangaName}}&page={{nextPageNum}}
                       # change macro to be used in browsing the results
                 }
        }



      $b->iimExit();
 }

  print "All relevent data to anime game of $curMangaName\t $curMangaNumber=====================================Done\n";
}

  print "=============================End of the Anime Game Crawling:================================================== \n"      ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"   ;
  print "=============================Great! All the Anime Game Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Anime Game crawling
# At this point all the search pages and all the 99 Manga's from the list are downloaded
#=======================================================================================

# =================================================
 #  crawl  Anime Figures pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'Anime Figure';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\AnimeFiguresScript\\FirstSearchPagAnimeeSave.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+) results/){
    my $tempstring = $1;
    $tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/60);
 print "Total number of Anime Figure to be saved Extraction ($totalNumCategPages Pages)..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\AnimeFiguresScript\\NextPageSearchAnimeSave.iim";
 while  ( $animepageNum<$totalNumCategPages ){
      $b->iimInit();
      $animepageNum = $animepageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animepageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving Anime Figure page $animepageNum..........................Done\n";
      $b->iimExit();
 }

#-----------------------------------------------------------------
# save the manga's from the list by going through each one by one
#------------------------------------------------------------------
# read the csv file
use strict;
use warnings;

 my $URLLogFileName = 'CurrentURLLogFile.txt';
 my $resultURL = " ";
 my $resultnum = 0;
 my $numberOfPageTxt= " ";
 my $numberpageresults=0;
 my $resultpageNumerator=1;


my $MangaListFile = $cwd.'\\List\\MangaList.csv';
my $animeItemPage = 0;
my $MangaItem;
my $curMangaNumber  = 0;
my $curMangaName    = " ";
open(my $MangaList, '<', $MangaListFile) or die "Could not open '$MangaListFile' $!\n";
# open(my $URLLogFile, '>', $URLLogFileName) or die "Could not open file '$URLLogFileName' $!";


while (($MangaItem = <$MangaList>) ) {      #   && ($curMangaNumber<3)
  chomp $MangaItem;

  my @fields = split "," , $MangaItem;
  $curMangaNumber = $fields[0];
  $curMangaName = $fields[1];
  # add current realization name to search
  $curMangaName =  "$curMangaName  $realizationPath";
  $curMangaName =~ tr/ /+/;
  $curMangaName =~ tr/\///;
  $curMangaName =~ tr/\\//;
  $curMangaName =~ tr/\?//;
  $curMangaName =~ tr/://;
  $curMangaName =~ tr/\*//;
  $curMangaName =~ tr/"//;
  $curMangaName =~ tr/>//;
  $curMangaName =~ tr/<//;
  $curMangaName =~ tr/\|//;
  my $numberpageresults = 0;

  $animeItemPage = 0;


   while  ( $animeItemPage <1 ){
      $macro = "$cwd\\Modules\\AnimeFiguresScript\\SearchAnime.iim";
      $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
      $b->{Visible} = 1;
      $b->iimInit();
      $animeItemPage = $animeItemPage + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animeItemPage);
      $b->iimSet('mangaName',  $curMangaName);
      $b->iimSet('mangaNumber',  $curMangaNumber);
      $b->iimPlay($macro);
      $numberOfPageTxt = $b ->iimGetLastExtract();
      # extract number of pages
      #1-16 of 19 results for Movies & TV :  "Hayate the Combat Butler Anime"
      #7 results for Movies & TV :   "Date A Live Anime"
      #print "the current string to search for item numbers in it is:\n $numberOfPageTxt\n";
      if ($numberOfPageTxt =~/([0-9]+) results/){
            $numberpageresults = $1;
            #print "from the text the extracted value is:   $numberpageresults";
      }
      print "Saving Search Anime Figure page $animeItemPage..........................Done\n";
      print "Saving Search items of Anime Figure page $animeItemPage ($numberpageresults items) ..........................InProcess\n";

     # $currentURL = $b ->iimGetLastExtract();
     # print "The Current URL is: $currentURL\n";
     # print $URLLogFile "The Current URL is: $currentURL\n";

      $macro = "$cwd\\Modules\\AnimeFiguresScript\\InsideResultsPage.iim";
      $resultURL=" ";
      $resultnum = 0;
      $resultpageNumerator = 1;

      #while ($currentURL ne  $resultURL){
      while ($resultnum < $numberpageresults){

#                  $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
#                  $b->{Visible} = 1;
#                  $b->iimInit();
                 $macro = "$cwd\\Modules\\AnimeFiguresScript\\InsideResultsPageNextPage.iim";
                 $b->iimSet('currworkDirect', $cwd  );
                 $b->iimSet('realizationPath', $realizationPath  );
                 $b->iimSet('pagenum',  $animeItemPage);
                 $b->iimSet('mangaName',  $curMangaName);
                 $b->iimSet('mangaNumber',  $curMangaNumber);
                 $b->iimSet('resultnum',  $resultnum);
                 $b->iimSet('nextPageNum',  $resultpageNumerator);
                 $b->iimPlay($macro);
                 $resultURL = $b ->iimGetLastExtract();
                # print "The Current URL is: $currentURL\n";
                 #print $URLLogFile "The Current URL is: $currentURL\n";
                 print "Saving Search Anime result item $resultnum ..........................Done\n";
                 $resultnum++;#+=6;
                 if (($resultnum % 16 == 0)) {          # || ($resultnum / 16 > 1)
                      # change macro to go to next page
                       $b->iimExit();
                       $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
                       $b->{Visible} = 1;
                       $b->iimInit();
                       $macro = "$cwd\\Modules\\AnimeFiguresScript\\SearchAnimeNextPage.iim";
                       $resultpageNumerator++;
                       $b->iimSet('currworkDirect', $cwd  );
                       $b->iimSet('realizationPath', $realizationPath  );
                       $b->iimSet('pagenum',  $animeItemPage);
                       $b->iimSet('mangaName',  $curMangaName);
                       $b->iimSet('mangaNumber',  $curMangaNumber);
                       $b->iimSet('resultnum',  $resultnum);
                       $b->iimSet('nextPageNum',  $resultpageNumerator);
                       $b->iimPlay($macro);
                       print " move to next page of Anime Figure..........................................Done\n";
                       # Next page
                       #http://www.amazon.com/s/ref=sr_pg_2?rh=n%3A2625373011%2Ck%3A{{mangaName}}&page={{nextPageNum}}
                       # change macro to be used in browsing the results
                 }
        }



      $b->iimExit();
 }

  print "All relevent data to anime figure of $curMangaName\t $curMangaNumber=====================================Done\n";
}

  print "=============================End of the Anime Figure Crawling:================================================== \n"      ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"   ;
  print "=============================Great! All the Anime Figure Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Anime Figure crawling
# At this point all the search pages and all the 99 Manga's from the list are downloaded
#=======================================================================================

 # =================================================
 #  crawl Piracy Rating Ranking pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'PiracyRatingRank';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\PiracyWebsiteScripts\\FirstPageOfRanking.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+)[^0-9,]*/){
    my $tempstring = $1;
    #$tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/1);
 print "Total number of  $realizationPath Ranking Pages to be saved Extraction ($totalNumCategPages Pages)..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\PiracyWebsiteScripts\\NextPageOfRanking.iim";
 while  ( $animepageNum<$totalNumCategPages ){
      $b->iimInit();
      $animepageNum = $animepageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animepageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving $realizationPath page $animepageNum..........................Done\n";
      $b->iimExit();
 }
  print "=============================End of the $realizationPath Crawling:================================================== \n"      ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"   ;
  print "=============================Great! All the $realizationPath Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Piracy Rating Ranking pages
# At this point all the search pages
#=======================================================================================

 # =================================================
 #  crawl Piracy Popularity Ranking pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'PiracyPopularityRank';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\PiracyPopularityWebsiteScripts\\FirstPageOfRanking.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+)[^0-9,]*/){
    my $tempstring = $1;
    #$tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/1);
 print "Total number of  $realizationPath Ranking Pages to be saved Extraction ($totalNumCategPages Pages)..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\PiracyPopularityWebsiteScripts\\NextPageOfRanking.iim";
 while  ( $animepageNum<$totalNumCategPages ){
      $b->iimInit();
      $animepageNum = $animepageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animepageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving $realizationPath page $animepageNum..........................Done\n";
      $b->iimExit();
 }
  print "=============================End of the $realizationPath Crawling:================================================== \n"      ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"   ;
  print "=============================Great! All the $realizationPath Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Piracy Popularity Ranking pages
# At this point all the search pages
#=======================================================================================

# =================================================
 #  crawl Piracy Latest Chapter Ranking pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'PiracyLatestChapterRank';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\PiracyWebsiteLatestChapterScripts\\FirstPageOfRanking.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 #$currentURL = $b ->iimGetLastExtract();;
 my $totalnumberOfCategoryPagesTxt =   $b ->iimGetLastExtract();
 my $totalnumberofitemsOfCategory=0;
 if ($totalnumberOfCategoryPagesTxt =~/([0-9,]+)[^0-9,]*/){
    my $tempstring = $1;
    #$tempstring  =~ s/,//g;
    #print "tempstring conteint is $tempstring\n";
    $totalnumberofitemsOfCategory = $tempstring;
    #print "from the text the extracted value is:   $numberpageresults";
 }
 my $totalNumCategPages =  ceil($totalnumberofitemsOfCategory/1);
 print "Total number of  $realizationPath Ranking Pages to be saved Extraction ($totalNumCategPages Pages)..........................Done\n";

 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro

 $macro = "$cwd\\Modules\\PiracyWebsiteLatestChapterScripts\\NextPageOfRanking.iim";
 while  ( $animepageNum<$totalNumCategPages ){
      $b->iimInit();
      $animepageNum = $animepageNum + 1;
      $b->iimSet('currworkDirect', $cwd  );
      $b->iimSet('realizationPath', $realizationPath  );
      $b->iimSet('pagenum',  $animepageNum);
      $b->iimPlay($macro);
      $currentURL = $b ->iimGetLastExtract();
      #print "The Current URL is: $currentURL";

      print "Saving $realizationPath page $animepageNum..........................Done\n";
      $b->iimExit();
 }
  print "=============================End of the $realizationPath Crawling:================================================== \n"      ;
  print "--------------------At this point all the search pages and all the 99 Manga's from the list should have been downloaded --------------------------------\n"   ;
  print "=============================Great! All the $realizationPath Crawling is done :)===================================\n"   ;

#=======================================================================================================
# End of Piracy Latest Chapter Ranking pages
# At this point all the search pages
#=======================================================================================

# =================================================
 #  crawl Piracy Ranking Page and Alex website hit pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'PiracyRank Alexa';
 #====================================================================
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  $macro = "$cwd\\Modules\\PiracyRankAlexa\\FirstPageOfRanking.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);

 $b->iimExit();

#==============================================================
#                        Final Clean up
#=============================================================
# close $URLLogFile;
 close $MangaList;
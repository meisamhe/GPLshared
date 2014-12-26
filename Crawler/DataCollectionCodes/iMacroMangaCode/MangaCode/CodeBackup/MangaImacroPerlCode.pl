 #======================================================
 # Crawler code for Manga Project
 # Written by Meisam Hejazi Nia
 # May 20, 2014
 #========================================================
 # initialize imacro code
 #-----------------------------------------------------------
 # take the current working directory
  use Cwd;

  my $cwd = getcwd();
  print "current working directory is: $cwd\n";
  $cwd =~ tr/\//\\\\/;
  my $currentURL="";

 # initialize iMacro
 use Win32::OLE;



 # =================================================
 #  crawl anime pages
 # =================================================
 # set path to save  results   and the first page
 #-----------------------------------------------
 my $realizationPath = 'Anime';
 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;
  my $macro = "$cwd\\Modules\\FirstSearchPagAnimeeSave.iim";

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();
 $animepageNum    = 1;

 $b->iimSet('currworkDirect', $cwd  );
 $b->iimSet('realizationPath', $realizationPath  );
 $b->iimSet('pagenum',  $animepageNum);
 $b->iimPlay($macro);
 $currentURL = $b ->iimGetLastExtract();;
 print "Saving anime page $animepageNum..........................Done\n";
 $b->iimExit();

 #----------------------------------------------------
 # go to next page and save
 #----------------------------------------------------
 #change the macro to the next page macro
 $macro = "$cwd\\Modules\\NextPageSearchAnimeSave.iim";
 while  ( $animepageNum<5 ){
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


my $MangaListFile = 'C:\\Users\\Administrator\\Desktop\\MangaCode\\List\\MangaList.csv';
my $animeItemPage = 0;
my $MangaItem;
my $curMangaNumber  = 0;
my $curMangaName    = " ";
open(my $MangaList, '<', $MangaListFile) or die "Could not open '$MangaListFile' $!\n";
open(my $URLLogFile, '>', $URLLogFileName) or die "Could not open file '$URLLogFileName' $!";


while (($MangaItem = <$MangaList>) && ($curMangaNumber<3) ) {      #
  chomp $MangaItem;

  my @fields = split "," , $MangaItem;
  $curMangaNumber = $fields[0];
  $curMangaName = $fields[1];
  # add current realization name to search
  $curMangaName =  "$curMangaName  $realizationPath";
  $curMangaName =~ tr/ /+/;
  $animeItemPage = 0;


   while  ( $animeItemPage <1 ){
      $macro = "$cwd\\Modules\\SearchAnime.iim";
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
      $currentURL = $b ->iimGetLastExtract();
      $currentURL =~ tr/\[EXTRACT\]//;
     # print "The Current URL is: $currentURL\n";
      print $URLLogFile "The Current URL is: $currentURL\n";

      print "Saving Search Anime page $animeItemPage..........................Done\n";
      $b->iimExit();
 }

  print "$curMangaName\t $curMangaNumber\n";
}

 close $URLLogFile;
 close $MangaList;
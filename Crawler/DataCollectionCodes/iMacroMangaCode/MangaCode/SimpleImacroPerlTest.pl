use Win32::OLE;

 $b = Win32::OLE->new('imacros') or die "iMacros Browser could not be started by Win32:OLE\n";
 $b->{Visible} = 1;

 #Start the iMacros Browser - Use iimInit("-ie"/"-fx") to start iMacros for IE/Firefox instead.
 $b->iimInit();

 #Calling an iMacros macro ie;yahoo.iim . Write a Simple iim script to goto www.yahoo.com
 my $macro = "C:\\Users\\Administrator\\Desktop\\MangaCode\\YahooTest.iim";

 # PLEASE NOTE: if you want to pass iMacros a path to a macro, rather than the name of a macro that resides in default folder,
 # the path should be passed in this format:
 # 'C:\\Documents and Settings\\username\\My Documents\\Client scripts\\Perl\\iim.iim';
 # I.e. "\\" should be used as a path delimeter
 $b->iimPlay($macro);
 &err ();
 $b->iimExit();

 ########################################################################
 # Get the last message reported from iMacros upon macro completion status#
 ########################################################################
 sub err {
    $lastMessage = $b->iimGetLastErrorMessage();
        if ($lastMessage =~ /Macro completed/) {
            print("Success <$macro> $lastMessage\n");
            #write a logger here for Success $lastMessage
        }
         else{
              print("Failure <$macro> $lastMessage\n");
              #write a logger here for Failure $lastMessage
             }
 }
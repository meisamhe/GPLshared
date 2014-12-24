open( OutDate, '>1.Output/1.Date.txt' );
open( OutShares, '>1.Output/4.Shares.txt' );
open( Outlikes,  '>1.Output/2.likes.txt' );
open( OutComments,  '>1.Output/3.Comments.txt' );
open( Outtemp,  '>1.Output/temp.txt' );
$inputroot="microsoft\\";
$inputroot=$inputroot."";
$inputTrailer=".htm";
$subpath="_files\\";
#$n=<STDIN>;
$inputfilename=$inputroot."Microsoft";
$inputfilename=$inputfilename.$inputTrailer;
$inputfilename="Walmart\\2009.htm";
#print "$inputfilename\n";
open( FILE2, $inputfilename );
$i=0;
open( FILE2, $inputfilename );
$i=0;
@month = ("January","February","March","April","May","June","July","August","September","October","November","December");
while( $line = <FILE2> ) {
	#<div class="timelineUnitContainer"(.*)
	
	while ($line=~/.*?class="timelineUnitContainer(.*)/){
		$line=$1;
		$line=~/(.*?)<div class="fbTimelineFeedbackActions[^>]*>(.*?)<\/div>(.*)/;
		$line=$1;	
		$mainline=$3;
		$templine=$2;
		#print Outtemp "\n\n\n!!!!!!!!!!!!!Meisam, the section is: $line\n";
		#$test=<STDIN>;
		if ($line=~/.*?<a class="uiLinkSubtle" href="[^>]*"><abbr title="([a-zA-Z]*)[, ]*([a-zA-Z]*) ([0-9]*), ([0-9]*) at ([0-9]*:[0-9]*[a-zA-Z]*)" data-utime=[^>]*>(.*)/){	
			$weekday=$1;
			$ms=$2;
			$day=$3;
			$year=$4;
			$time=$5;
			$time=~/([0-9:]*)([pam]*)/;
			$time=$1." ";
			$time=$time.$2;
			#print "the date is: $weekday-$month-$day-$year-$5\n";
			for ($i=0;$i<12;$i++){
				if (@month[$i] eq $ms){
					$m=$i+1;
					#print @month[$i];
					#print "\n$1 $m\n";
				}
			}
			print OutDate "$m/$day/$year \t$weekday \t$time\n";
			$line=$6;
		}else{ #<abbr title="February 27, 2012" data-utime="1330383600">February 27, 2012</abbr>
			if ($line=~/.*?<a class="uiLinkSubtle" href="[^>]*"><abbr title="([a-zA-Z]*) ([0-9]*), ([0-9]*)" data-utime=[^>]*>(.*)/){	
			$ms=$1;
			$day=$2;
			$year=$3;
			#print "the date is: $weekday-$month-$day-$year-$5\n";
			for ($i=0;$i<12;$i++){
				if (@month[$i] eq $ms){
					$m=$i+1;
					#print @month[$i];
					#print "\n$1 $m\n";
				}
			}
			print OutDate "$m/$day/$year \t \t \n";
			$line=$4;
			}else{#<abbr title="May 2012" data-utime="1335855600">May 2012</abbr>
				if ($line=~/.*?<a class="uiLinkSubtle" href="[^>]*"><abbr title="([a-zA-Z]*) ([0-9]*)" data-utime=[^>]*>(.*)/){	
					$ms=$1;
					$year=$2;
					#print "the date is: $weekday-$month-$day-$year-$5\n";
					for ($i=0;$i<12;$i++){
						if (@month[$i] eq $ms){
							$m=$i+1;
							#print @month[$i];
							#print "\n$1 $m\n";
						}
					}
					print OutDate "$m/$year \t \t \n";
					$line=$3;
				}else{ #<abbr title="2011" data-utime="1293868800">2011</abbr>
					if ($line=~/.*?<a class="uiLinkSubtle" href="[^>]*"><abbr title="([0-9]*)" data-utime=[^>]*>(.*)/){	
						$year=$1;
						#print "the date is: $weekday-$month-$day-$year-$5\n";
						print OutDate "$year \t \t \n";
						$line=$2;
					}
				}
			}
		}
		
		$line=$mainline;
	}	
}	
open( FILE2, $inputfilename );
$i=0;
while( $line = <FILE2> ) {
	#<div class="timelineUnitContainer"(.*)
	while ($line=~/.?<div class="fbTimelineFeedbackActions[^>]*>(.*?)<\/div>(.*)/){
		$mainline=$2;
		$templine=$1;
		$line=$templine;
		#print "$line\n";
		#$test=<STDIN>;
		#.?<dt>([A-Za-z-_ ]*)(.*)
		#<i class=" UFIBlingBoxTimelineReshareIcon UFIBlingBoxSprite" id=".reactRoot[6048434].[0:0:0].[0:0].[1:0]">
		#<i class=" UFIBlingBoxTimelineReshareIcon UFIBlingBoxSprite" id="[^>*]"><\/i>
		#<span class="UFIBlingBoxText" id=".reactRoot[6048434].[0:0:0].[0:0].[1:1]">115</span></span></a></span></span>
	#	if ($line=~/.*?<span class="[^"]*" id="[^"]*">([0-9,]*)<\/span><\/span><\/a><\/span><\/span>(.*)/){	
	#		$shares=$1;
	#		#print "number of shares is: $shares\n";
	#		print OutShares "$shares\n";
	#		$line=$2;
	#	}else{
	#		print OutShares "\n";
	#	}
		if ($line=~/.*?<i class=" UFIBlingBoxTimelineReshareIcon[^>]*><\/i><span class="UFIBlingBoxText" [^>]*>([0-9,]*)<\/span>(.*)/){	
			$shares=$1;
		#	print "number of shares is: $shares\n";
			print OutShares "$shares\n";
			$line=$2;
		}else{
			print OutShares "0\n";
		}
		$line=$templine;
		#.?<dt>([A-Za-z-_ ]*)(.*)
		#<a rel="dialog" ajaxify="/ajax/browser/dialog/likes?id=10151519932978721" href="https://www.facebook.com/browse/likes?id=10151519932978721" data-hover="tooltip" data-tooltip-alignh="center" data-tooltip-uri="/ajax/like/tooltip.php?comment_fbid=10151519932978721&amp;comment_from=1432140998&amp;seen_user_fbids=true" id=".reactRoot[7882427].[0:0].[1:0].[4:0:1].[3:1].[1:1].[1:0].[3:0:0]">975 people</a>
		#<i class=" UFIBlingBoxTimelineLikeIcon UFIBlingBoxSprite" id=".reactRoot[9761297].[0:0:0].[0:0].[1:0]"></i><span class="UFIBlingBoxText" id=".reactRoot[9761297].[0:0:0].[0:0].[1:1]">3,982</span>
		#<a rel="dialog" ajaxify="[^"]*"[^>]*>([0-9,]*) people<\/a>
		if ($line=~/.*?<i class=" UFIBlingBoxTimelineLikeIcon[^>]*><\/i><span class="UFIBlingBoxText" [^>]*>([0-9,]*)<\/span>(.*)/){	
			$like=$1;
		#	print "number of likes is: $like\n";
			print Outlikes "$like\n";
			$line=$2;
		}else{
			$line=$mainline;
			if ($line=~/(.*?)<a class="uiLinkSubtle" href="[^>]*">/){
				$line=$1;
				$templine=$line;
				if ($line=~/.?<a rel="dialog" ajaxify="[^"]*"[^>]*>([0-9,]*) people<\/a>(.*)/){	
					$like=$1;
				#	print "number of likes is: $like\n";
					print Outlikes "$like\n";
					$line=$2;
				}else{
					print Outlikes "0\n";
				}
			}else{
				print Outlikes "0\n";
			}
		}
		$line=$templine;
		#.?<dt>([A-Za-z-_ ]*)(.*)
		#<span class="" id=".reactRoot[9001761].[0:4:0].[1:0].[4:0:1].[3:1].[4:0:1].[1:1].[1:0]">View 38 more comments</span>
		#<span class="" id=".reactRoot[8884100].[0:4:0].[1:0].[4:0:1].[3:1].[4:0:1].[1:1].[1:0]">View all 56 comments</span>
		#<span class="" id=".reactRoot[537762].[0:4:0].[1:0].[4:0:1].[3:1].[4:0:1].[1:1].[1:0]">View previous comments</span>
		#<span class="fcg" id=".reactRoot[537762].[0:4:0].[1:0].[4:0:1].[3:1].[4:0:0].[1:2]">2 of 51</span>
		#<span class="" id=".reactRoot[537762].[0:4:0].[1:0].[4:0:1].[3:1].[4:0:1].[1:1].[1:0]">View previous comments</span>
		#<span class="UFIBlingBoxText" id=".reactRoot[3306705].[0:0:1].[0:0].[1:1]">4,070</span>
		#$line=~/.?<span class="" id="[^"]*"[^>]*>View ([a-z0-9 ,]*) comments(.*)
		#<i class=" UFIBlingBoxTimelineCommentIcon UFIBlingBoxSprite" id=".reactRoot[9761297].[0:0:2].[0:0].[1:0]"></i><span class="UFIBlingBoxText" id=".reactRoot[9761297].[0:0:2].[0:0].[1:1]">79</span>
		#
		if ($line=~/.?<i class=" UFIBlingBoxTimelineCommentIcon[^>]*><\/i><span class="UFIBlingBoxText" [^>]*>([0-9,]*)<\/span>(.*)/){
			$comments=$1;
			print "number of comments is: $comments\n";
			print OutComments "$comments\n";
			$line=$2;
		
			#print "True\n";
	#		if ($1 eq "previous"){
	#			$temp=$2;
	#			if ($line=~/.?<span class="fcg" id="[^>]*>[0-9,]* of ([0-9,]*)(.*)/){
	#				$comments=$1;
	#				print "number of comments is(1): $comments\n";
	#				print OutComments "$comments\n";
	#				$line=$2;
	#			}
	#			$line=$temp;
	#		}else{
	#			$line=$2;
	#			if ($1=~/all (.*)/){
	#				$comments=$1;
	#				print "number of comments is(2): $comments\n";
	#				print OutComments "$comments\n";
	#			}
	#			else{
	#				if ($1=~/(.*) more/){
	#					$comments=$1;
	#					print "number of comments is(3): $comments\n";
	#					print OutComments "$comments\n";
	#				}
	#			}
	#		}
			
		}else{
			$line=$mainline;
			if ($line=~/(.*?)<a class="uiLinkSubtle" href="[^>]*">/){
				$line=$1;
				$templine=$line;
				if ($line=~/.?<span class="" id="[^"]*"[^>]*>View ([a-z0-9 ,]*) comments(.*)/){
					#print "True\n";
					if ($1 eq "previous"){
						$temp=$2;
						if ($line=~/.?<span class="fcg" id="[^>]*>[0-9,]* of ([0-9,]*)(.*)/){
							$comments=$1;
							print "number of comments is(1): $comments\n";
							print OutComments "$comments\n";
							$line=$2;
						}
						$line=$temp;
					}else{
						$line=$2;
						if ($1=~/all (.*)/){
							$comments=$1;
							print "number of comments is(2): $comments\n";
							print OutComments "$comments\n";
						}
						else{
							if ($1=~/(.*) more/){
								$comments=$1;
								print "number of comments is(3): $comments\n";
								print OutComments "$comments\n";
							}
						}
					}
					
				}else{
					print OutComments "0\n";
				}
			}else{
				print OutComments "0\n";
			}
		}
		$line=$mainline;
	}	
}	
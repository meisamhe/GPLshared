open( OUTCNO, '>Output\CountNameoutput.txt' );
open( OUTCFIPS, '>Output/CountyFIPSoutput.txt' );
open( OUTEMP, '>Output/Employeeoutput.txt' );
open( OUTGMB, '>Output/GeneralMedBedsoutput.txt' );
open( OUTLAT, '>Output/Lattitudeoutput.txt' );
open( OUTLONG, '>Output/Longitudeoutput.txt' );
open( OUTMBED, '>Output/MedicareBedsoutput.txt' );
open( OUTName, '>Output/Nameoutput.txt' );
open( OUTPD, '>Output/PatientDaysoutput.txt' );
open( OUTPR, '>Output/PatientRevenueoutput.txt' );
open( OUTSCB, '>Output/SpecCareBedsoutput.txt' );
open( OUTST, '>Output/StateOutput.txt' );
open( OUTSYSN, '>Output/SystemNameoutput.txt' );
open( OUTAcBed, '>Output/TotalAcuteBedoutput.txt' );
open( OUTAMed, '>Output/TotalAcuteMedicaidoutput.txt' );
open( OUTMec, '>Output/TotalAcuteMedicareoutput.txt' );
open( OUTOther, '>Output/TotalAcuteOtheroutput.txt' );
open( OUTTAcRev, '>Output/TotalAcuteRevenueoutput.txt' );
open( OUTTacT, '>Output/STotalAcuteTotaloutput.txt' );
open( OUTTDisc, '>Output/TotalDischargeoutput.txt' );
open( OUTTfac, '>Output/TypeFacilityoutput.txt' );
open( OUTUrbRur, '>Output/UrbanRuraloutput.txt' );
$inputroot="Input\\";
$inputroot=$inputroot."profile (";
$inputTrailer=").htm";
for ($k=0;$k<=9;$k++){
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/ - <a href.*>(.*), ..<\/a>/ && $i==0){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTCNO "$1\n";	
			}
		}			
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if($line=~/County .FIPS code../){
			$line = <FILE2> ;
			if ($line=~/<a href.*>(.*)<\/a> - /){	
				$i++;
				#print "$1\n";
				print OUTCFIPS "$1\n";
			}	
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Total Employees:.*/){
			$line=<FILE2>;
			if ($line=~/<td align="left">([0-9]*)<\/td>/){	
				$i++;
			#	print "$1\n";
				print OUTEMP "$1\n";
			}
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {	
		if ($line=~/.*General Med.Surg Beds:.*/){
			$line = <FILE2>;
			if ($line=~/<td align="left">([0-9]*)<\/td>/){	
				$i++;
			#	print "$1\n";
				print OUTGMB "$1\n";	
			}
		}			
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td align="left">([0-9]*)......(E)...([0-9]*)......(N)<\/td>/){	
			$i++;
			if (True){
			#	print "$3$4\n";
				print OUTLAT "$3$4\n";	
			}
		}	
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td align="left">([0-9]*)......(E)...([0-9]*)......(N)<\/td>/){	
			$i++;
			if (True){
			#	print "$1$2\n";
				print OUTLONG "$1$2\n";	
			}
		}	
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Medicare Certified Beds:.*/){
			$line = <FILE2>;
			if ($line=~/<td align="left">([0-9]*)<\/td>/){	
				$i++;
			#	print "$1\n";
				print OUTMBED "$1\n";
				
			}	
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/<b>([A-Za-z- 1-90]*)<\/b>/ && $i==0){
			$i=1;
		#	print "$1\n";
			print OUTName "$1\n";	
		}	
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Total Patient Days:.*/){
			$line = <FILE2>;
			if ($line=~/<td align="left">([0-9,]*)<\/td>/){	
				$i++;
			#	print "$1\n";
				print OUTPD "$1\n";	
			}
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td align="left">&#36;([0-9,]*)<\/td>/){	
			$i++;
			if (TRUE){
			#	print "$1\n";
				print OUTPR "$1\n";	
			}
		}	
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Special Care Beds:.*/){
			$line = <FILE2>;
			if ($line=~/<td align="left">([0-9]*)<\/td>/){	
				$i++;
			#	print "$1\n";
				print OUTSCB "$1\n";	
			}
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*CBSA.*/){
			$line = <FILE2>;
			if ($line=~/- <a href.*>(.*), (..)<\/a>/){	
				$i++;
				if (True){
				#	print "$2\n";
					print OUTST "$2\n";	
				}
			}
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Health Care System:.*/){
			$line = <FILE2>;
			if ($line=~/<a href=".*">(.*)<\/a>/){	
			#	print "$1\n";
				print OUTSYSN "$1\n";
				$i++;					
			}	
			
		}
	}
	if ($i==0){
		#	print "\n";
			print OUTSYSN "\n";
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	$sw=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td><b>Total Acute<\/b><\/td>/){
			$sw=1;	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==2){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTAcBed "$1\n";	
			}
		}
		$sw++;
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	$sw=0;	
	while( $line = <FILE2> ) {
		if ($line=~/<td><b>Total Acute<\/b><\/td>/){
			$sw=1;	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==2){	
			$i++;
		}
		if ($line=~/<td align="right"><b>&#36;([0-9,]*)<\/b><\/td>/ && $sw==3){	
		
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==4){
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==5){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTAMed "$1\n";	
			}
		}
		$sw++;
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	$sw=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td><b>Total Acute<\/b><\/td>/){
			$sw=1;	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==2){	
			$i++;
		}
		if ($line=~/<td align="right"><b>&#36;([0-9,]*)<\/b><\/td>/ && $sw==3){	
		
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==4){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTMec "$1\n";	
			}
		}
		$sw++;
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	$sw=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td><b>Total Acute<\/b><\/td>/){
			$sw=1;	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==2){	
			$i++;
		}
		if ($line=~/<td align="right"><b>&#36;([0-9,]*)<\/b><\/td>/ && $sw==3){	
		
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==4){
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==5){	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==6){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTOther "$1\n";	
			}
		}
		$sw++;
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	$sw=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td><b>Total Acute<\/b><\/td>/){
			$sw=1;	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==2){	
			$i++;
		}
		if ($line=~/<td align="right"><b>&#36;([0-9,]*)<\/b><\/td>/ && $sw==3){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTTAcRev "$1\n";	
			}
		}
		$sw++;
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	$sw=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td><b>Total Acute<\/b><\/td>/){
			$sw=1;	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==2){	
			$i++;
		}
		if ($line=~/<td align="right"><b>&#36;([0-9,]*)<\/b><\/td>/ && $sw==3){	
		
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==4){
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==5){	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==6){	
		}
		if ($line=~/<td align="right"><b>([0-9,]*)<\/b><\/td>/ && $sw==7){	
			$i++;
			if (True){
			#	print "$1\n";
				print OUTTacT "$1\n";	
			}
		}
		$sw++;
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Total Discharges:.*/){
			$line = <FILE2>;
			if ($line=~/<td align="left">([0-9,]*)<\/td>/){	
				$i++;
			#	print "$1\n";
				print OUTTDisc "$1\n";
			}	
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/.*Type of Facility:.*/){
			$line = <FILE2>;
			if ($line=~/<td align="left">([A-Za-z- 1-90]*)<\/td>/){
				$i=1;		
			#	print "$1\n";
				print OUTTfac "$1\n";	
			}
		}
	}
	$inputfilename=$inputroot.$k;
	$inputfilename=$inputfilename.$inputTrailer;
	open( FILE2, $inputfilename );
	$i=0;
	while( $line = <FILE2> ) {
		if ($line=~/<td align="left">([UR][a-z]*)<\/td>/){	
			$i++;
			if (True){
				print "$1\n";
				print OUTUrbRur "$1\n";	
			}
		}	
	}
	if ($i==0){
		print "\n";
		print OUTUrbRur "\n";	
	}
}

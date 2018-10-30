#!perl
# CutOff Converge Test Script
# Usage:
#		There are several palced can be changed
#		1. $name(line 17) means the name of your xsd file, no extension
#		2. $startEnergy(line 25) means the start of kpoint you need test
#		3. $endEnergy(line 26) means the end of kpoint you need test
#		4. $intervalEnergy(line 27) means step of kpoint
#		5. Calculation setting is list between line 34 to line 39
#			attention that: the list must be "CustomGrid"
#							ParameterA/B/C must be $kp
# Result:
#		There is a study table called kpoint-energy.std
#			energy unit eV
use strict;
use MaterialsScript qw(:all);
my $name = "Nb8Ti8V8Zr8";
my $xsdname = $name . ".xsd";
my $cstname = $name . ".castep";
my $myDoc=$Documents{$xsdname};
my $myStudyTable=Documents->new("kpoint-energy.std");
my $mySheet=$myStudyTable->ActiveSheet;
$mySheet->ColumnHeading(0)="KPoint";
$mySheet->ColumnHeading(1)="Final Enegy(eV)";
$mySheet->ColumnHeading(2)="dEnergy(eV)";
my $startkp=1;
my $endkp=6;
my $intervalkp=1;
my $sumIteration=($endkp-$startkp)/$intervalkp;
my $counter = 0;
for(my $counterA=0;$counterA<=$sumIteration;++$counterA){
			my $kp = $startkp + $intervalkp*$counterA;
			my $results = Modules->CASTEP->Energy->Run($myDoc, Settings(
				NonLocalFunctional => "PBE",
				Quality => "Fine",
				ParameterA => $kp,
				ParameterB => $kp,
				ParameterC => $kp,
				KPointDerivation => "CustomGrid"
				)
			);
        	foreach my $line (@{$Documents{$cstname}->Lines}) {
    			if ($line=~/^Final energy/){
            		my $finalEnergy = substr($line,31,15);
            		$mySheet->Cell($counter,1)=$finalEnergy;
            	}
            }
			$mySheet -> Cell($counter,0) = $kp;
			$counter = $counter + 1;
}
for(my $i=1;$i<=$sumIteration;++$i){
	my $dE = $mySheet->Cell($i,1) - $mySheet->Cell($i-1,1);
	$mySheet->Cell($i,2)=$dE;
}
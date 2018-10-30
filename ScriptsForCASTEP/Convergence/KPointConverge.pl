#!perl
# CutOff Converge Test Script
# Usage:
#		There are several palced can be changed
#		1. $name(line 17) means the name of your xsd file, no extension
#		2. $startEnergy(line 25) means the start of kpoint you need test
#		3. $endEnergy(line 26) means the end of kpoint you need test
#		4. $intervalEnergy(line 27) means step of kpoint
#		5. Calculation setting is list between line 38 to line 43
#			attention that: the list must be "CustomGrid"
#							ParameterA/B/C must be $kpA/B/C
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
	for(my $counterB=0; $counterB<=$sumIteration; ++$counterB){
		for(my $counterC=0; $counterC<=$sumIteration; ++$counterC){
			my $kpA = $startkp + $intervalkp*$counterA;
			my $kpB = $startkp + $intervalkp*$counterB;
			my $kpC = $startkp + $intervalkp*$counterC;
			my $results = Modules->CASTEP->Energy->Run($myDoc, Settings(
				NonLocalFunctional => "PBE",
				Quality => "Fine",
				ParameterA => $kpA,
				ParameterB => $kpB,
				ParameterC => $kpC,
				KPointDerivation => "CustomGrid"
				)
			);
        	foreach my $line (@{$Documents{$cstname}->Lines}) {
    			if ($line=~/^Final energy/){
            		my $finalEnergy = substr($line,31,15);
            		$mySheet->Cell($counter,1)=$finalEnergy;
            	}
            }
			$mySheet -> Cell($counter,0) = $kpA . "X" . $kpB . "X" . $kpC;
			$counter = $counter + 1;
		}
	}
}
for(my $i=1;$i<=$sumIteration;++$i){
	my $dE = $mySheet->Cell($i,1) - $mySheet->Cell($i-1,1);
	$mySheet->Cell($i,2)=$dE;
}
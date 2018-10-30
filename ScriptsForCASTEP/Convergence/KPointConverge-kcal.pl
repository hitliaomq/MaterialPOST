#!perl
# CutOff Converge Test Script
# Usage:
#		There are several palced can be changed
#		1. $name(line 17) means the name of your xsd file, with extension
#		2. $startEnergy(line 23) means the start of kpoint you need test
#		3. $endEnergy(line 24) means the end of kpoint you need test
#		4. $intervalEnergy(line 25) means step of kpoint
#		5. Calculation setting is list between line 36 to line 40
#			attention that: the list must be "CustomGrid"
#							ParameterA/B/C must be $kpA/B/C
# Result:
#		There is a study table called kpoint-energy.std
#			energy unit kcal
use strict;
use MaterialsScript qw(:all);
my $myDoc=$Documents{"bestsqs.xsd"};
my $myStudyTable=Documents->new("energy-encut.std");
my $mySheet=$myStudyTable->ActiveSheet;
$mySheet->ColumnHeading(0)="Enegy Cutoff(eV)";
$mySheet->ColumnHeading(1)="Final Enegy(eV)";
# castep single calculation
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
			my $totalEnergy = $results -> TotalEnergy;
			my $freeEnergy = $results -> FreeEnergy;
			$mySheet -> Cell($counter,0) = $counter;
			$mySheet -> Cell($counter,1) = $kpA . "X" . $kpB . "X" . $kpC;
			$mySheet -> Cell($counter,2) = $totalEnergy;
			$mySheet -> Cell($counter,3) = $freeEnergy;
			$counter = $counter + 1;
		}
	}
}

#!perl
# CutOff Converge Test Script
# Usage:
#		There are several palced can be changed
#		1. $name(line 17) means the name of your xsd file, with extension
#		2. $startEnergy(line 23) means the start of energy you need test
#		3. $endEnergy(line 24) means the end of energy you need test
#		4. $intervalEnergy(line 25) means step of energy
#		5. Calculation setting is list between line 33 to line 36
#			attention that: the UseCustomEnergyCutoff must be "Yes"
#							EnergyCutoff must be energyCutoff
# Result:
#		There is a study table called energy-encut.std
#			energy unit kcal
use strict;
use MaterialsScript qw(:all);
my $myDoc=$Documents{"bestsqs.xsd"};
my $myStudyTable=Documents->new("energy-encut.std");
my $mySheet=$myStudyTable->ActiveSheet;
$mySheet->ColumnHeading(0)="Enegy Cutoff(eV)";
$mySheet->ColumnHeading(1)="Final Enegy(kcal)";
my $castep=Modules->CASTEP;
my $startEnergy=200;
my $endEnergy=500;
my $intervalEnergy=20;
my $sumIteration=($endEnergy-$startEnergy)/$intervalEnergy;
for(my $counter=0;$counter<=$sumIteration;++$counter){
        my $energyCutoff=$startEnergy+$intervalEnergy*$counter;
        my $results = Modules->CASTEP->Energy->Run($myDoc, Settings(
                Quality=>"Fine",
                UseCustomEnergyCutoff=>"Yes",
                EnergyCutoff=>$energyCutoff
			)
		);
        $mySheet->Cell($counter,0)=$energyCutoff;
        my $finalEnergy = $results->TotalEnergy;
        $mySheet->Cell($counter,1)=$finalEnergy;
}

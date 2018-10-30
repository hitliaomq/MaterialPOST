#!perl
# CutOff Converge Test Script
# Usage:
#		There are several palced can be changed
#		1. $name(line 17) means the name of your xsd file, no extension
#		2. $startEnergy(line 25) means the start of energy you need test
#		3. $endEnergy(line 26) means the end of energy you need test
#		4. $intervalEnergy(line 27) means step of energy
#		5. Calculation setting is list between line 33 to line 36
#			attention that: the UseCustomEnergyCutoff must be "Yes"
#							EnergyCutoff must be energyCutoff
# Result:
#		There is a study table called energy-encut.std
#			energy unit eV
use strict;
use MaterialsScript qw(:all);
my $name = "Nb8Ti8V8Zr8";
my $xsdname = $name . ".xsd";
my $cstname = $name . ".castep";
my $myDoc=$Documents{$xsdname};
my $myStudyTable=Documents->new("energy-encut.std");
my $mySheet=$myStudyTable->ActiveSheet;
$mySheet->ColumnHeading(0)="Enegy Cutoff(eV)";
$mySheet->ColumnHeading(1)="Final Enegy(eV)";
my $startEnergy=100;
my $endEnergy=250;
my $intervalEnergy=10;
my $sumIteration=($endEnergy-$startEnergy)/$intervalEnergy;

for(my $counter=0;$counter<=$sumIteration;++$counter){
        my $energyCutoff=$startEnergy+$intervalEnergy*$counter;        
        my $results = Modules->CASTEP->Energy->Run($myDoc, Settings(
	       SCFConvergence => 1e-006, 
	       Quality => "Fine", 
	       UseCustomEnergyCutoff=>"Yes",
           EnergyCutoff=>$energyCutoff
           )
        );      
       
        $mySheet->Cell($counter,0)=$energyCutoff;
        foreach my $line (@{$Documents{$cstname}->Lines}) {
    		if ($line=~/^Final energy/){
            		my $finalEnergy = substr($line,31,15);
            		$mySheet->Cell($counter,1)=$finalEnergy;
			}
		}
}

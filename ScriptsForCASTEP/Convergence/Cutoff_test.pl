#!perl
# Purpose: Convergence test of CutOff.
# Usage:
#		1.Change the $myDoc(Line12) name into your documents' name.
#		2.Change the $startEnerge(Line22), $endEnergy(Line23) and $intervalEnergy(Line24) for your test.
#		3.Change the settings of your calculation(Line30-Line35).(Which can generate by MS)
# Author:Dr.Liao Mingqing   E-mai:liaomq1900127@163.com

use strict;
use MaterialsScript qw(:all);

my $name = "Nb8Ti8V8Zr8";
my $xsdname = $name . ".xsd";
my $cstname = $name . ".castep";
my $myStudyTable=Documents->new("energy-encut.std");
my $mySheet=$myStudyTable->ActiveSheet;
my $TotAtoms = 2;
$mySheet->ColumnHeading(0)="Enegy Cutoff(eV)";
$mySheet->ColumnHeading(1)="Final Enegy(eV)";
$mySheet->ColumnHeading(2)="lnE_cut(eV)";
$mySheet->ColumnHeading(3)="dE/dlnE_cut(eV/Atom)";

my $castep=Modules->CASTEP;
my $startEnergy=200;
my $endEnergy=600;
my $intervalEnergy=2;
my $sumIteration=($endEnergy-$startEnergy)/$intervalEnergy;

for(my $counter=0;$counter<=$sumIteration;++$counter){
    my $energyCutoff=$startEnergy+$intervalEnergy*$counter;
    my $results = Modules->CASTEP->Energy->Run($xsdname, Settings(
        UseCustomEnergyCutoff => "Yes", 
			  EnergyCutoff => $energyCutoff, 
			  FFTQuality => "Precise", 
			  FFTFineGrid => 1.5, 
			  SCFConvergence => 5e-007, 
			  KPointOverallQuality => "Fine", 
      )
    );
        
    $mySheet->Cell($counter,0)=$energyCutoff;
	foreach my $line (@{$Documents{$cstname}->Lines}) {
    		if ($line=~/^Final energy/){
            		my $finalEnergy = substr($line,31,15);
            		$mySheet->Cell($counter,1)=$finalEnergy;
			}
	}
	$mySheet->Cell($counter,2)=log($energyCutoff);
}
# calculate dE/dlnE_cut
for(my $i=1;$i<=$sumIteration;++$i){
	my $dE = $mySheet->Cell($i,1) - $mySheet->Cell($i-1,1);
	my $dlnE_cut = $mySheet->Cell($i,2) - $mySheet->Cell($i-1,2);
	$mySheet->Cell($i,3)=$dE/$dlnE_cut/$TotAtoms;
}
#!perl
#
# Purpose: Demonstrate processing each atomistic document in a project in turn

use strict;
use warnings;
use MaterialsScript qw(:all);

my $strname = "VZr";
my $stdname = $strname.".std";
my $myStudyTable = Documents->new($stdname);
my $mySheet = $myStudyTable->ActiveSheet;
$mySheet->ColumnHeading(0) = "Fomula";
$mySheet->ColumnHeading(1) = "Total Enegy(eV)";
$mySheet->Columnheading(2) = "Enthalpy(eV)";
my $count = 0;
#Filter out only the .xsd files in the Documents collection,then run the calculation
foreach my $key (keys %Documents) {
    my $doc = $Documents{$key}; 
    
    if ($doc->Type eq "3DAtomistic" ) { 

		my $results = Modules->CASTEP->GeometryOptimization->Run($doc, Settings(
				SCFConvergence => 5e-007, 
				OptimizeCell => "Yes", 
				EnergyConvergence => 5e-006, 
				Quality => "Coarse", 
				# PropertiesKPointQuality => "Fine"
			)
		);
		my $totalenergy = $results->TotalEnergy;
		my $enthalpy = $results->Enthalpy;
		$mySheet->Cell($count,1)=0.0433989 * $totalenergy;
		$mySheet->Cell($count,2)=0.0433989 * $enthalpy;
		$mySheet->Cell($count,0)=$doc->SymmetrySystem->CellFormula;
		$count += 1;

    }
}

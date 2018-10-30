#!/usr/bin/perl
#change the $dir and $cdir each run 
#only for .xsd file
#put this script at currunt folder
#changing the settings of calculation
use strict;
use MaterialsScript qw(:all);
use File::Basename;

my $dir = 'E:\Materials Studio Projects\LMQ\TiVNbZr-energy_Files\Documents\TiVZrX\TiVNbZr\\';
my $cdir = "VZr";
my $dir_name= $dir . $cdir; 
opendir(DIR, "$dir_name")   ||   die   "Cannot   open  $dir_name"; 

my @a=readdir DIR;
my $count = 0;
my $stdname = $cdir . ".std";
my $myStudyTable = Documents->new($stdname);
my $mySheet = $myStudyTable->ActiveSheet;
foreach (@a) {
	next if ($_=~/^\./);
	my ($name,$path,$ext) = fileparse($_, qr/\.[^.]*$/);
	if ($ext eq ".xsd"){
		my $xsdname = $name . ".xsd";
		print $xsdname;
		my $castepname = $name . ".castep";
		my $myDoc=$Documents{$xsdname};
		$mySheet->ColumnHeading(0) = "Fomula";
		$mySheet->ColumnHeading(1) = "Total Enegy(eV)";
		$mySheet->Columnheading(2) = "Enthalpy(eV)";
		#$mySheet->Columnheading(3) = "Fomula";
		#$mySheet->Cell($count,0) = $name;

		my $results = Modules->CASTEP->GeometryOptimization->Run($myDoc, Settings(
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
		$mySheet->Cell($count,0)=$myDoc->SymmetrySystem->CellFormula;
		$count += 1;

	}
	


	#print "$xsdname\n";
}

closedir   DIR;


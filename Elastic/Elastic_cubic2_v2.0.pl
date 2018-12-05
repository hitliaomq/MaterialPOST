#!perl
# New Feather:User defined Deform Mode and it is Modularizated
use strict;
use Getopt::Long;
use Math::Trig;
use Math::MatrixReal;
use MaterialsScript qw(:all);

my $name = "Nb";
my $xsdname = $name . ".xsd";
my $xsddoc = $Documents{$xsdname};
#max_strain means the max strain for energy calculation, 
#should be small enough to satisfy linear relationship between strain and stress
# Here, 1 means 1% strain
my $max_strain = 0.5;
#steps means the steps for single energy calculation
my $steps = 5;
my $N_Mode = 6;
#my $VConserv = "N";

my %Parameter = (
    "CutOff" => 320,
    "KPUser" => "Y",
    "KA" => 16,
    "KB" => 16,
    "KC" => 16,
    "Potentials" => "Ultrasoft",
    "Insulator" => "Yes",
    "GOrE" => "E",
);

my $pi = Math::Trig->pi;
my $step_strain = 2*$max_strain/($steps - 1);
my $start_strain = -$max_strain;
my @Strainlist;
for (my $k = 0; $k < $steps; $k++) {
	$Strainlist[$k] = ($start_strain + $k*$step_strain)/100;
}
if ($steps % 2 == 0) {
	splice @Strainlist, $steps/2, 0, 0;
	$steps = $steps + 1;
}
my $stdname = $name . "_Elastic.std";
my $stddoc = Documents->new($stdname);


#Part1: GeomOpt, get the energy without deform
print "Start calculate the energy of unstrained structure.\n";
$Parameter{"GOrE"} = "G";
my ($V0, $E0) = CASTEP_geom($xsddoc, %Parameter);
print "The energy is $E0 kcal/mol, and the volumn is $V0 A3\n";
my ($a0, $b0, $c0, $alpha0, $beta0, $gamma0) = GetABC($xsddoc, "d");

my @EHead = qw(E0(kcal/mol) V0(A3) Strain Strain2 V(A3) E(kcal/mol) dE(kcal/mol));
my @Data0 = ($E0, $V0, 0, 0, $V0, $E0, 0);
my $Base = Math::MatrixReal->new_diag([1, 1, 1]);

my $atomN0 = 0;
foreach my $atom (@{$xsddoc->UnitCell->Atoms}) {
    $atomN0 = $atomN0 + 1;
}

print "\nThere are $N_Mode modes to calculate.\n\n";
for (my $i = 1; $i <= $N_Mode; $i++) {
	print "Begin the calculation of $i th mode.\n";
	my $Sheeti;
	if ($i == 1) {
		$Sheeti = $stddoc->ActiveSheet;
	} else {
		$Sheeti = $stddoc->InsertSheet;
	}
	$Sheeti->Title = "$i";
	SheetWrite($Sheeti, 0, "H", @EHead);
	SheetWrite($Sheeti, 0, "D", @Data0);
	print "There are $steps steps in mode $i .\n";
	for (my $j = 0; $j < $steps; $j++) {
		print "Begin the $j step in mode $i . \n";
		my $xsdnamej = $name . "-" . $i . "-" . $j . ".xsd";
		my $xsddocj = Documents->New($xsdnamej);
		$xsddocj->CopyFrom($xsddoc);
		$xsddocj->MakeP1;

		my $Strainj = $Strainlist[$j];
		my $StrainMatrix = Vec2Matrix(DeformMode($i, $Strainj));
		## Pay attention here: this is for orth crystal		
		my $abc = Math::MatrixReal->new_diag([$a0, $b0, $c0]);
		##
		my $Matrix_new = $abc * ($StrainMatrix + $Base);
		my ($a, $b, $c, $alpha, $beta, $gamma) = Matrix2Ang($Matrix_new);

		SetABC($xsddocj, $a, $b, $c, $alpha, $beta, $gamma, "d");
		#Tools->Symmetry->ChangeSettings([PositionTolerance => 0.00001]);
		#Tools->Symmetry->FindSymmetry->Find($xsddocj);

		my $strain2 = $Strainj**2;
		$Parameter{"GOrE"} = "E";
		my ($V, $E) = CASTEP_geom($xsddocj, %Parameter);
		print "The end of step $j in mode $i. \n";
		print "\t The energy is $E kcal/mol, the volumn is $V A3.\n";
		#my $dE = $E/$V - $E0/$V0;
		my $dE = $E - $E0;

		my @Datai = ($E0, $V0, $Strainj, $strain2, $V, $E, $dE);
		SheetWrite($Sheeti, $j+1, "D", @Datai);
	}
	print "The end of the $i mode.\n\n";
}


sub VolumnCrystal {
	my ($a, $b, $c, $alpha, $beta, $gamma) = @_;
	my $V = $a*$b*$c*sqrt(1- (cos($alpha))**2 - (cos($beta))**2 - (cos($gamma))**2 + 2*cos($alpha)*cos($beta)*cos($gamma));
	return $V;
}

sub SheetWrite {
    #Write the content of sheet
    my ($mySheet, $row, $flag, @Out) = @_;
    if ($flag eq "H") {
    	for (my $i = 0; $i < $#Out + 1; $i++) {
        	$mySheet->ColumnHeading($i) = $Out[$i];
    	}
    } else {
    	for (my $i = 0; $i < $#Out + 1; $i++) {
        	$mySheet->Cell($row, $i) = $Out[$i];
    	}
    }
    
}

sub GetVolumn {
	my ($xsdfile) = @_; 
	my ($a, $b, $c, $alpha, $beta, $gamma) = GetABC($xsdfile, "r");
    my $V = VolumnCrystal($a, $b, $c, $alpha, $beta, $gamma);
}

sub SetABC {
	my ($xsdfile, $a, $b, $c, $alpha, $beta, $gamma, $flag) = @_;
	my $pi = Math::Trig->pi;
	$xsdfile->Lattice3D->LengthA = $a;
	$xsdfile->Lattice3D->LengthB = $b;
	$xsdfile->Lattice3D->LengthC = $c;
	if ($flag eq "r") {
		$alpha = $alpha/$pi*180;
		$beta = $beta/$pi*180;
		$gamma = $gamma/$pi*180;
	}	
	$xsdfile->Lattice3D->AngleAlpha = $alpha;
	$xsdfile->Lattice3D->AngleBeta = $beta;
	$xsdfile->Lattice3D->AngleGamma = $gamma;
}

sub GetABC {
	my ($xsdfile, $flag) = @_;
	my $pi = Math::Trig->pi;
	my $a = $xsdfile->Lattice3D->LengthA;
	my $b = $xsdfile->Lattice3D->LengthB;
	my $c = $xsdfile->Lattice3D->LengthC;		
	my $alpha = $xsdfile->Lattice3D->AngleAlpha;
	my $beta = $xsdfile->Lattice3D->AngleBeta;
	my $gamma = $xsdfile->Lattice3D->AngleGamma;
	if ($flag eq "r") {
		$alpha = $alpha*$pi/180;
		$beta = $beta*$pi/180;
		$gamma = $gamma*$pi/180;
	}
	my @abc = ($a, $b, $c, $alpha, $beta, $gamma);
	return @abc;
}

sub CASTEP_geom{
    #Do geomopt, and calculate the stress
    my ($xsdfile, %Parameter) = @_;
    my $pi = Math::Trig->pi;
    my $module = Modules->CASTEP;
    $module->ChangeSettings(Settings(
        Quality => "Fine",
        UseCustomEnergyCutoff => "Yes", 
        EnergyCutoff => $Parameter{"CutOff"}, 
        UseInsulatorDerivation => $Parameter{"Insulator"}, 
        Pseudopotentials => $Parameter{"Potentials"},         
        SCFConvergence => 1e-006,));
    #Y for User define Kpoint, N for use fine
    if ($Parameter{"KPUser"} eq "Y") {
        $module->ChangeSettings(Settings(
            KPointDerivation => "CustomGrid",
            ParameterA => $Parameter{"KA"}, 
            ParameterB => $Parameter{"KB"}, 
            ParameterC => $Parameter{"KC"},));
    }else{
        $module->ChangeSettings(Settings(
            PropertiesKPointQuality => "Fine",));
    }
    #G for GeomOpt, E for Energy
    my $CASTEPRun = $module->GeometryOptimization;
    if ($Parameter{"GOrE"} eq "G") {
        $CASTEPRun = $module->GeometryOptimization;
        $module->ChangeSettings(Settings(
            EnergyConvergence => 1e-005, 
            ForceConvergence => 0.03, 
            DisplacementConvergence => 0.001, 
            StressConvergence => 0.05,
            OptimizeCell => "Yes",));
    }elsif($Parameter{"GOrE"} eq "E"){
        $CASTEPRun = $module->Energy;
    }    
    my $result = $CASTEPRun->Run($xsdfile);
    #Get the calculation result
    my $TotalEnergy = $result->TotalEnergy;
    #get the structure result
    my $V = GetVolumn($xsdfile);
	my @Out = ($V, $TotalEnergy);
    return @Out;
}

sub DeformMode {
    #ref:Xiaoqing Li, Acta Mater., 142(2018), 29-36
    my ($flag, $strain) = @_;
    my @STRAIN;
    if ($flag == 1) {
        # for SOECs: C11; TOECs: C111
        @STRAIN = ($strain, 0, 0, 0, 0, 0);
    } elsif ($flag == 2) {
        # FOR SOEC: 2*C11 + 2*C12; TOEC: 2*C111 + 6*C112
        @STRAIN = ($strain, $strain, 0, 0, 0, 0);
    } elsif ($flag == 3) {
        # FOR SOEC: 3*C11 + 6*C12; TOEC: 3*C111 + 18*C112 + 6*C123
        @STRAIN = (0, 0, 0, 2*$strain, 0, 0);
    } elsif ($flag == 4) {
    	# FOR SOEC: C11 + 4*C44; TOEC: C111+12C166
    	@STRAIN = ($strain, 0, 0, 0, 2*$strain);
    } elsif ($flag == 5) {
    	# FOR SOEC: 12*C44; TOEC: 48*C456
    	@STRAIN = (0, 0, 0, 2*$strain, 2*$strain, 2*$strain);
    } elsif ($flag == 6) {
    	# FOR SOEC 2*C11+2*C12+4*C44; TOEC:2*C111+6*C112+12*C144+12*C166
    	@STRAIN = ($strain, $strain, 0, 2*$strain, 0, 0);
    } else {
        print "ERROR!";
    }
    return @STRAIN;
}

sub Vec2Matrix {
    my ($e1, $e2, $e3, $e4, $e5, $e6) = @_;
    $e4 = $e4/2;
    $e5 = $e5/2;
    $e6 = $e6/2;
    my $Strain_M = Math::MatrixReal->new_from_rows( [ [$e1, $e6, $e5], [$e6, $e2, $e4], [$e5, $e4, $e3] ] );
    return $Strain_M;
}

sub Matrix2Ang {
    # Convert the vector of crystal to length and angle
    my ($Matrix) = @_;
    my $pi = Math::Trig->pi;
    my $a_v = $Matrix->row(1);
    my $b_v = $Matrix->row(2);
    my $c_v = $Matrix->row(3);
    my $a = $a_v->norm_p(2);
    my $b = $b_v->norm_p(2);
    my $c = $c_v->norm_p(2);

    my $a_vT = $Matrix->col(1);
    $a_vT->transpose($a_v);
    my $b_vT = $Matrix->col(2);
    $b_vT->transpose($b_v);
    my $c_vT = $Matrix->col(3);
    $c_vT->transpose($c_v);

    my $bmc = $b_v*$c_vT;
    $bmc = $bmc->element(1,1);
    my $amc = $a_v*$c_vT;
    $amc = $amc->element(1,1);
    my $amb = $a_v*$b_vT;
    $amb = $amb->element(1,1);
    my $alpha = 180/$pi * acos($bmc/($b*$c));
    my $beta = 180/$pi * acos($amc/($a*$c));
    my $gamma = 180/$pi * acos($amb/($a*$b));
    return ($a, $b, $c, $alpha, $beta, $gamma);
}

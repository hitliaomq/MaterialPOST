#!perl
use Math::MatrixReal;
use Math::Trig;

sub DeformMode {
    #ref:Xiaoqing Li, Acta Mater., 142(2018), 29-36
    #p[E - E0] = 1/2*Cij*strain^2 + 1/6*Cijk*strain^3+O(strain^4)
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
        @STRAIN = ($strain, $strain, $strain, 0, 0, 0);
    } elsif ($flag == 4) {
        # FOR SOEC: C11 + 4*C44; TOEC: C111 + 12*C166
        @STRAIN = ($strain, 0, 0, 0, 0, 2*$strain);
    } elsif ($flag == 5) {
        #FOR SOEC: 12*C44; TOEC: 48*C456
        @STRAIN = (0, 0, 0, 2*$strain, 2*$strain, 2*$strain);
    } elsif ($flag == 6) {
        #FOR SOEC: 2*C11 + 2*C12 + 4*C44; TOEC: 2*C111 + 6*C112 + 12*C144 + 12*C166
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
    #$UnitMatrix = Math::MatrixReal->new_diag([1, 1, 1]);
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
    my $pi = Math::Trig->pi;
    my $a = $xsdfile->Lattice3D->LengthA;
    my $b = $xsdfile->Lattice3D->LengthB;
    my $c = $xsdfile->Lattice3D->LengthC;
    my $alpha = $xsdfile->Lattice3D->AngleAlpha;
    my $beta = $xsdfile->Lattice3D->AngleBeta;
    my $gamma = $xsdfile->Lattice3D->AngleGamma;
    my $alpha_r = $alpha*$pi/180;
    my $beta_r = $beta*$pi/180;
    my $gamma_r = $gamma*$pi/180;
    my $V = VolumnCrystal($a, $b, $c, $alpha_r, $beta_r, $gamma_r);
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

my $Matrix = Vec2Matrix(DeformMode(1, 0.03));
my $Base = Math::MatrixReal->new_diag([1, 1, 1]);
print $Base . "\n";
my $a0 = 3;
my $abc = Math::MatrixReal->new_diag([$a0, $a0, $a0]);
#print $abc;
my $Matrix_new = $abc * ($Matrix + $Base);
#print $Matrix;
my ($a, $b, $c, $alpha, $beta, $gamma) = Matrix2Ang($Matrix_new);
print "$a\n$b\n$c\n$alpha\n$beta\n$gamma";
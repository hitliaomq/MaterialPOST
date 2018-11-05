function output = Birch_Murnaghan_fitting(s)
% fitting signal V-E for Equation Of State
% s parameter for a-E fitting, s=='a'
clc
close
name = 'NbTiVZr-sqs.xlsx';
data = xlsread(name);
x = data(:,1);
if (s == 'l')
    x=x.^3;    
end
y = data(:,2);
x_min = x(1);
x_max = x(end);
myfittype = fittype('a + b*x^(-1/3) + c*x^(-2/3) + d*x^(-1)',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a','b','c','d'});
[myfit, gof] = fit(x,y,myfittype,'Start', [-20000, -2000, -10000, 60000]);
adjstR = gof.adjrsquare;  
fit_cv = coeffvalues(myfit);  
y_fit = feval(myfit,x); 
plot(x, y, x, y_fit);
n = 1000;
xlin = linspace(x_min, x_max, n);
ylin = feval(myfit, xlin);
[ymin, index] = min(ylin);
xmin = xlin(index);
lattice = xmin^(1/3);
output = [fit_cv, adjstR, xmin, ymin, lattice];
output_fit = [x, y, x, y_fit];
xlswrite(name, output_fit, 2);
xlswrite(name, output, 3);

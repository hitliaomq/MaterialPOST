function output = Multi_BM_fitting()
% clc
close
s = 'v';  %v or a, v for volume, a for lattice
name = 'VCA-NbTiVZr-BCC';
xlsname = [name '.xlsx'];
elename = {'Nb','Ti','V','Zr'};
n_sheet = length(elename);
header_result = {'a','b','c','d','adjustR','Vmin','Emin','Lattice'};
for i = 1:n_sheet
    data = xlsread(xlsname, i);
    newxlsname = cell2mat([name '-' elename(i) '.xlsx']);
    
    [~, n] = size(data);
    %     n_colum = n - 1;
    output = zeros(n/2,8);
    for j = 1:n/2
        x = data(:,2*(j - 1) + 1);
        if (s=='a')
           x=x.^3; 
        end
        m = length(x);
        y = data(:,2*j);
        x(isnan(y)) = [];
        y(isnan(y)) = [];
        x_min = x(1);
        x_max = x(end);
        myfittype = fittype('a + b*x^(-1/3) + c*x^(-2/3) + d*x^(-1)',...
            'dependent',{'y'},'independent',{'x'},...
            'coefficients',{'a','b','c','d'});
        [myfit, gof] = fit(x,y,myfittype,'Start', [-20000, -2000, -10000, 60000]);
        adjstR = gof.adjrsquare;
        fit_cv = coeffvalues(myfit);
        y_fit = feval(myfit,x);
%         plot(x, y, x, y_fit);
        n = 1000;
        xlin = linspace(x_min, x_max, n);
        ylin = feval(myfit, xlin);
        [ymin, index] = min(ylin);
        xmin = xlin(index);
        lattice = xmin^(1/3);
        output(j,:) = [fit_cv, adjstR, xmin, ymin, lattice];        
        %         xlswrite(xlsname, [header_result; output], 1);
        output_fit = [x, y, x, y_fit];
%         OUT = {'V','Energy','V','Energy_fit'; output_fit};
        header_fit = {'V','Energy','V','Energy_fit'};
        xlswrite(newxlsname, header_fit, num2str(0.2*(j-1)),'A1');
        xlswrite(newxlsname, output_fit, num2str(0.2*(j-1)),'A2');
    end
    xlswrite(newxlsname, header_result, 1, 'A1');
    xlswrite(newxlsname, output, 1, 'A2');
end

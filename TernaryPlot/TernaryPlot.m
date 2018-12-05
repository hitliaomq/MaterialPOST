function TernaryPlot(X0, Y0, Z0, PlotType, N, Grid, Label, Caxis)
%% Input
% X0, Y0, Z0: The data need to be drawn
%             They should be same in size, 1D or 2D
%             X0, Y0 [0, 1], Z0 no limit
% N: The number of grid, positive integer. 100 (default)
% PlotType: surf or s - for surface
%           contour or c - for countour
%           contourl or c+l - for contour + label
%           contourf or c+f - for contour with color
%           contourfl or c+f+l - for contour with color with label
% Grid: on or off(default)
% Label: {'A', 'B', 'C'}(default)
% Caxis: [cmin, cmax]
% 
% Author: Liao Mingqing(liaomq1900127@163.com)
% Acknowledge: The following is a reference. https://github.com/alchemyst/ternplot

%% For test
% X0 = 0:0.1:1;
% Y0 = 0:0.1:1;
% [X0, Y0] = meshgrid(X0, Y0);
% Z0 = X0.^2 + Y0.^2;
% N = 100;
% Grid = 'off';
% Label = {'Nb', 'Ti', 'V'};
% PlotType = 'surf';

if ~exist('N', 'var')
    N = 100;
end
if ~exist('Grid', 'var')
    Grid = 'off';
end
if ~exist('Label', 'var')
    Label  = {'A', 'B', 'C'};
end

maxX = max(max(X0));
minX = min(min(X0));
maxY = max(max(Y0));
minY = min(min(Y0));

XLim = [min([minX, minY]), max([maxX, maxY])];
Xi = linspace(maxX, minX, N);
Yi = linspace(minY, maxY, N);
% Z = Xi + Yi;
[Xi, Yi] = meshgrid(Xi, Yi);
Tri = delaunay(Xi, Yi);
% Tri = GetTri(N);

TZi = griddata(X0, Y0, Z0, Xi, Yi, 'v4');
for i = 1:N
    for j = (i+1):N
        TZi(j, i) = nan;
    end
end
[TXi, TYi] = XY2Ter(Xi, Yi);
% Tri = GetTri(N);
TernaryAxes(XLim, Grid, Label)
hold on
if strcmpi(PlotType, 'surf') || strcmp(PlotType, 's')
    trisurf(Tri, TXi, TYi, TZi, 'EdgeColor', 'interp');
    shading interp
    colorbar;
    view([0, 0, 1]);
elseif strcmpi(PlotType, 'contour') || strcmp(PlotType, 'c')
    contour(TXi, TYi, TZi, 'k');
elseif strcmpi(PlotType, 'contourl') || strcmpi(PlotType, 'c+l')
    contour(TXi, TYi, TZi, 'k', 'ShowText', 'on');
elseif strcmpi(PlotType, 'contourf') || strcmpi(PlotType, 'c+f')
    contourf(TXi, TYi, TZi); %, 'ShowText', 'on');
    colorbar;
elseif strcmpi(PlotType, 'contourfl') || strcmpi(PlotType, 'c+f+l')
    contourf(TXi, TYi, TZi, 'ShowText', 'on');
    colorbar;
    % colormapeditor;
end

axis equal
colormap('jet');
if ~exist('Caxis', 'var')
    cmin = min(min(Z0));
    cmax = max(max(Z0));
else
    cmin = Caxis(1);
    cmax = Caxis(2);
end
caxis([cmin, cmax]);
[minTX, minTY] = XY2Ter(minX, minY);
[maxTX, ~] = XY2Ter(maxX, minY);
[~, maxTY] = XY2Ter(minX, maxY);
dTX = maxTX - minTX; dTY = maxTY - minTY;
kLim = 0.01;
TXLim = [minTX - kLim*dTX, maxTX + kLim*dTX];
TYLim = [minTY - kLim*dTY, maxTY + kLim*dTY];
set(gca, 'XLim', TXLim, 'YLim', TYLim);

end


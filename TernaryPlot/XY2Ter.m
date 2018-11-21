function [TerX, TerY] = XY2Ter(x, y)
% convert x and y(in Cart) to Ter coord
TerY = y*sin(pi/3);
TerX = x + TerY*cot(pi/3);

end
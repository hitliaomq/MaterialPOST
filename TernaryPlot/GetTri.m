function Tri = GetTri(N)
T = 1:N^2;
T = reshape(T, N, N);
TL = T(1:end - 1, 1:end - 1); 
TL = TL(:);
BL = T(2:end, 1:end - 1); 
BL = BL(:);
TR = T(1:end - 1, 2:end); 
TR = TR(:);
BR = T(2:end, 2:end); 
BR = BR(:);
Tri = [TL, BL, BR; TL, TR, BR];
end
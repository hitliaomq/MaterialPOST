function TestForTP()
% isTerX_test()
close all
N = 25;
GetTri_test(N)
end

function isTerX_test()
% test for isTerX
x = [0.1, NaN, 0.5;
    0.2, 0.4, 0.1];
x = isTerX(x)
x = [0.1, -0.2, 0.5;
    0.2, 0.4, 0.1];
x = isTerX(x)
x = [0.1, 0.2, 0.5, 0.1;
    0.2, 0.4, 0.1, 0.1];
x = isTerX(x)
x = [0.1, 0.2;
    0.2, 0.4];
x = isTerX(x)
end

function GetTri_test(N)
% N = 15;
[x,y] = meshgrid(1:N,1:N);
tri = delaunay(x,y);
z = peaks(N);
subplot(1, 2, 1)
trisurf(tri,x,y,z)
for i = 1:N
    for j = i+1:N
        z(i, j) = nan;
    end
end
subplot(1, 2, 2);
trisurf(tri,x,y,z)
end
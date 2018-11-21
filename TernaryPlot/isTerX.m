function x = isTerX(x)
% if x satisfy the composition for TernaryPlot
%    yes, return x
%    no, return NaN
[x_row, x_col] = size(x);
if sum(sum(x < 0)) || sum(sum(isnan(x)))
    disp('ERROR: There is some negtive or NAN value in x.');
    x = nan(x_row, 3);
    return
end
if sum((sum(x(:, 1:2), 2) - ones(x_row, 1)) > 0)
    disp('ERROR: The sum of first two column is lager than 1.');
    x = nan(x_row, 3);
    return
end
if x_col == 1
    disp('ERROR: There is only 1 column.');
    x = nan(x_row, 3);
    return
end
if x_col > 3
    disp('WARNING: The number of column is lager than 3.');
    disp('Only first 3 columns are taken into consideration, and the others are neglected.')
    x = x(:, 1:3);
    x_col = 3;
end
if x_col == 3
    if sum(abs(sum(x, 2) - ones(x_row, 1))) > 0
        disp('WARNING: The sum of all three columns is not equal to 1.');
        disp('The third colomn is neglected.');
        x(:, 3) = 1 - x(:, 1) - x(:, 2);
    end
elseif x_col == 2
    x(:, 3) = 1 - sum(x, 2);
end
end
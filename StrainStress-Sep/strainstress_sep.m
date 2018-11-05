function strainstress_sep(filename)
%材料楼3楼拉伸数据分离程序
% 1.功能
%     由于拉伸数据太长，复制有点蛋疼，故写一小程序用于分离多组拉伸试验的数据的分离。
% 2.用法
%     在MATLAB命令窗口输入strainstress_sep('你完整的excel文件路径'）
%     如strainstress_sep('E:\MATLAB\tool-self\test\拉伸数据.xlsx')
%    （PS：可以将数据文件放入MATLAB当前路径就可以只要输入文件名就可以，要带后缀名）
%     如：strainstress_sep('拉伸数据.xlsx')
% 3.对数据的要求
%     将拉伸得到的数据用EXCEL 打开，选择逗号分隔，保存为.xlsx文件即可
%     理论上只要数据中间以空格或者中文分隔开就可以分离
%输入：
%   filename：拉伸数据另存为的EXCEL文件名，不在当前路径的话注意写绝对路径
%     如strainstress_sep('E:\MATLAB\tool-self\test\拉伸数据.xlsx')

%% version 2.0
%   每一列添加名称，单位，方便导入origin
%   优化代码，减少操作excel的次数，提高运行速度
%   样品的个数无限制
%   修改函数名为strainstress_sep
%% version 1.0
%   实现基本功能，分离数据
%   不足：多次操作EXCL，运行慢，且分离的样品个数有限制100个以内

%% Read data
a = xlsread(filename);
strastre = a(:,[3, 5]);% [ColumnForStrain, ColumnForStress], Please change the value for you data
[m, ~] = size(strastre);

%% 数据段数，以及开始结束位置的下标
k1 = 1;
k2 = 1;
a1 = strastre(:,1); 
for k = 2:m
    if isnan(a1(k))&&(~isnan(a1(k+1)))
        ds(k1) = k + 1;%数据开始位置（数据开始的位置比数据结束的位置多一个）
        k1 = k1+1;
    elseif isnan(a1(k))&&(~isnan(a1(k-1)))
        df(k2) = k-1;%数据结束位置
        k2 = k2+1;
    else
    end
end
df(k2) = m; %即最后一个位置一定是结束的位置
lenth_data = df - ds; %每一段数据的长度
m0 = max(lenth_data);
n0 = length(ds);%总数据的

%%  数据的写出
data_out = nan(m0-1,2*n0); 
for i = 1:n0
    data_out(1:(lenth_data(i)-1),(2*i-1):2*i) = strastre(ds(i):df(i)-2,:);
end
head1 = {'Strain','Stress';'%','MPa'};
head = repmat(head1,1,n0);
xlswrite(filename,head,'Sheet2','A1')
xlswrite(filename,data_out,'Sheet2','A3')

end

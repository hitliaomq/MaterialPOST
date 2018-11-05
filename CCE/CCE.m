function  CCE()
global B C f1r t

ele=[0.65,0.909,0,0,0.111,0,0,1.504,1.080];%元素成分
qunchT=100:2:230;%25:5:170;%淬火温度
partT = 100:2:240;%qunchT;%240:2:500;%配分温度
% partt%配分时间
roomT=25;  %室温

n = length(qunchT);  %淬火温度的个数
m = length(partT); %配分温度的个数

C=ele(1);       %得到碳含量
Mn=ele(2);      %得到Mn含量
Ni=ele(3);      %得到Ni含量
Mo=ele(4);      %得到Mo含量
Cr=ele(5);      %得到Cr含量
V=ele(6);       %得到V含量
Al=ele(7);      %得到Al含量
Si=ele(8);      %得到Si含量
W=ele(9);       %得到W含量
Fe=100-C-Mn-Ni-Mo-W-Si-Cr-Al-V;     %得到Fe含量

B=(100-C)/(Fe/56+Si/28+Mn/55+Ni/58.7+Mo/95.9+Cr/52.0+V/51.0+Al/27.0+W/184.0);%除去C外的平均想对分子质量

Ms=539-423*C-30.4*Mn-12.1*Cr-7.5*Mo;  %MS点,℃
% Ms = 550 - 350*C - 40*Mn - 35*V - 20*Cr - 17*Ni - Cu - 10*Mo - 5*W + 15*Co + 30*Al;
% Ms = 539 - 423*C - 30.4*Mn - 17.7*Ni - 12.1*Cr - 7.5*Mo;

% Bs = 830 - 270*C - 90*Mn - 37*Ni - 70*Cr - 83*Mo;
%黄春峰-钢的热处理工艺设计经验公式
disp(['基体Ms温度：' num2str(Ms)]);

phase1 = zeros(length(qunchT),3);

%不用循环了
f1r=exp(-1.1*10^(-2).*(Ms-qunchT));%注意，这里算出来的是mole分数
phase1(:,1)=qunchT;%phase1表第一次淬火各项比。第一列为淬火温度
phase1(:,2)=1-f1r;%phase1表第一次淬火各项比。第二列为马氏体量
phase1(:,3)=f1r;%phase1表第一次淬火各项比。第三列为奥氏体量

%算回火后各相比，各相元素含量
%计算公式
%% 以下是循环求解过程

%算每个淬火温度下，各温度回火后各相比，各相各元素含量
jieguo1 = zeros(n,m,4);
for i=1:n%每一个淬火温度
    %代入淬火结果参数
    f1r = phase1(i,3);%注意，这里应代入mole分数
    for j=1:m%每一个回火温度
        %代入回火温度参数
        t = partT(j)+273.15;
        %解方程计算回火后各相比，各相元素含量
        options=optimset('MaxFunEvals',1000);
        x1 = fsolve(@CCE_fun,[0.65,0.65],options);  %用拟牛顿法求解  %马，奥，马碳奥碳为Mole分数
        %         fval
        xr = x1(1);
        xa = x1(2);
        jieguo1(i,j,1:4)=[phase1(i,2), phase1(i,3), xa, xr];
        %保存回火结果的三维矩阵
    end
end
%算回火后殘留奥氏体的Ms温度
C=jieguo1(:,:,4)*100;
Msr = 539-423*C-30.4*Mn-17.7*Ni-12.1*Cr-7.5*Mo;


%算第二次淬火后生成的各相比
phase2 = zeros(n,m);
finalphase = zeros(n,m);
for i=1:n%每一个淬火温度
    for j=1:m%每一个回火温度
        %判定残奥的新Ms温度
        if Msr(i,j)<roomT
            f2r=1;
        else
            f2r=exp(-1.1*10^(-2)*(Msr(i,j)-roomT));
        end
        phase2r=f2r*phase1(i,3);%最终残余奥氏体
        phase2a=(1-f2r)*phase1(i,3); %新增马氏体
        phase2(i,j,1:2)=[phase2a,phase2r];
        finalphase(i,j,1:2)=[1-phase2r,phase2r];
    end
end
%返回所有计算结果
FM = zeros(n,m,11);
for i=1:n%每一个淬火温度
    for j=1:m%每一个回火温度
        %淬火温度1，第一次淬火马氏体2，残奥3，钢的MS点4
        %回火温度5，回火后马氏体内碳含量6，奥氏体碳含量7
        %第二次淬火Ms点8，新生马氏体量9，最终马氏体含量10，残奥含量11
        FM(i,j,1:11)=[phase1(i,1:3),Ms,partT(j),jieguo1(i,j,3)*100,...
            jieguo1(i,j,4)*100,Msr(i,j),phase2(i,j,1),finalphase(i,j,1),finalphase(i,j,2)];
    end
    
end
hds = {'淬火温度','第一次淬火马氏体','残奥', '钢的MS点','回火温度5',...
    '回火后马氏体内碳含量','奥氏体碳含量','第二次淬火Ms点','新生马氏体量','最终马氏体含量','残奥含量'};
if length(qunchT) == length(partT)
    if sum(abs(qunchT - partT)) == 0
        fileN = '一步Q&P数值解法.xlsx';
        values = num2cell([phase1(:,1:3),Ms*ones(length(phase1(:,1)),1),partT',...
            jieguo1(:,1,3)*100,jieguo1(:,1,4)*100,Msr(:,1),...
            phase2(:,1,1),finalphase(:,1,1),finalphase(:,1,2)]);
        xlswrite(fileN,[hds;values]);
    else
        fileN = '两步Q&P数值解法.xlsx';
        for k = 1:11
            xlswrite(fileN,FM(:,:,k),hds(k));
        end
    end
else
    fileN = '两步Q&P数值解法.xlsx';
    for k = 1:11
        xlswrite(fileN,FM(:,:,k),cell2mat(hds(k)));
    end
end

end
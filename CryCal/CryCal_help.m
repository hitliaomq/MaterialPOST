%% CryCal Version 1.0 帮助文档
% CryCal Version1.0  晶体计算器 V1.0版
%
%% 原理
% 
% CryCal中的计算公式
% 
%%
% * *晶面间距计算公式* 
% 
% 
%%
% _a,b,c_ 分别为晶体的晶格常数,
% $$\alpha,\beta,\gamma$
% 分别为 _bc,ac,ab_ 之间的夹角,{hkl}为晶面的晶面指数,d为晶面间距。
%
% 从而有：
%
% $$\frac{1}{d^2} = \frac{1}{V^2}(S_{11}h^2 + S_{22}k^2 + S_{33}l^2 
%   + 2S_{12}hk +2S_{23}kl + 2S_{13}lh)$$
% 
% 其中:
%
%   V为晶胞体积
%
% $$V=abc\sqrt{1 - cos^2 \alpha - cos^2 \beta - cos^2 \gamma + 2cos \alpha cos \beta cos \gamma}$$
% 
% $$S_{11} = b^2 c^2 sin^2 \alpha, S_{12} = abc^2 (cos \alpha cos \beta - cos \gamma)$$
% 
% $$S_{22} = a^2 c^2 sin^2 \beta, S_{23} = a^2 bc(cos \beta cos \gamma - cos \alpha)$$
% 
% $$S_{33} = a^2 b^2 sin^2 \gamma, S_{13} = ab^2 c(cos \alpha cos \gamma - cos \beta)$$
%
%% 
% * *晶面夹角计算公式* 
%%
% _a,b,c_ 分别为晶体的晶格常数,
% $$\alpha,\beta,\gamma$
% 分别为 _bc,ac,ab_ 之间的夹角,{
% $$h_1k_1l_1$
% }和{
% $$h_2k_2l_2$
% }为晶面的晶面指数,
% $$d_1,d_2$
% 分别为两晶面的晶面间距，
% $$\phi$
% 为两晶面的夹角。
%
% 从而有：
%
% $$cos \phi = \frac{d_{1}d_{2}}{V^{2}}[S_{11}h_{1}h_{2} + S_{22}k_{1}k_{2} 
%    + S_{33}l_{1}l_{2} + S_{23}(k_{1}l_{2} + k_{2}l_{1}) + S_{13}(l_{1}h_{2} 
%    + l_{2}h_{1}) + S_{12}(h_{1}k_{2} + h_{2}k_{1})]$$
%
% 其中:
%
%   V为晶胞体积
%
% $$V=abc\sqrt{1 - cos^2 \alpha - cos^2 \beta - cos^2 \gamma + 2cos \alpha cos \beta cos \gamma}$$
% 
% $$S_{11} = b^2 c^2 sin^2 \alpha, S_{12} = abc^2 (cos \alpha cos \beta - cos \gamma)$$
% 
% $$S_{22} = a^2 c^2 sin^2 \beta, S_{23} = a^2 bc(cos \beta cos \gamma - cos \alpha)$$
% 
% $$S_{33} = a^2 b^2 sin^2 \gamma, S_{13} = ab^2 c(cos \alpha cos \gamma - cos \beta)$$
%
% * *晶向长度计算公式* 
% 
% * *晶向夹角计算公式* 
% 
%% 用法
% DESCRIPTIVE TEXT
% 
% 
% 
% 

%% 关于作者
% 
% 作者：廖名情(Author:Liao Mingqing)
%
%       哈尔滨工业大学材料学院功能梯度与计算材料(FGMS)课题组 (FGMS @ Harbin Institute of Technology,HIT)
%
% 邮箱：liaomq1900127@163.com




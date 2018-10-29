function varargout = CryCal(varargin)
% CRYCAL MATLAB code for CryCal.fig
%      CRYCAL, by itself, creates a new CRYCAL or raises the existing
%      singleton*.
%
%      H = CRYCAL returns the handle to a new CRYCAL or the handle to
%      the existing singleton*.
%
%      CRYCAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRYCAL.M with the given input arguments.
%
%      CRYCAL('Property','Value',...) creates a new CRYCAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CryCal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CryCal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CryCal

% Last Modified by GUIDE v2.5 30-Oct-2018 00:48:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CryCal_OpeningFcn, ...
    'gui_OutputFcn',  @CryCal_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CryCal is made visible.
function CryCal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CryCal (see VARARGIN)

% Choose default command line output for CryCal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CryCal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CryCal_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in crytype.
function crytype_Callback(hObject, eventdata, handles)
% hObject    handle to crytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
% msgbox(num2str(ctype));

% Hints: contents = cellstr(get(hObject,'String')) returns crytype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crytype
function crytype(handles)  %晶体结构类型
ctype = get(handles.crytype,'Value');
switch ctype
    case 1 %立方晶系Cubic
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','off');
        set(handles.c_edit,'Enable','off');
        set(handles.al_edit,'Enable','off');
        set(handles.be_edit,'Enable','off');
        set(handles.ga_edit,'Enable','off');
        a = get(handles.a_edit,'String');
        set(handles.b_edit,'String',a);
        set(handles.c_edit,'String',a);
        set(handles.al_edit,'String',90);
        set(handles.be_edit,'String',90);
        set(handles.ga_edit,'String',90);
    case 2 %四方晶系Tetragonal
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','off');
        set(handles.c_edit,'Enable','on');
        set(handles.al_edit,'Enable','off');
        set(handles.be_edit,'Enable','off');
        set(handles.ga_edit,'Enable','off');
        a = get(handles.a_edit,'String');
        set(handles.b_edit,'String',a);
        set(handles.al_edit,'String',90);
        set(handles.be_edit,'String',90);
        set(handles.ga_edit,'String',90);
    case 3 %正交晶系Orthorhombic
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','on');
        set(handles.c_edit,'Enable','on');
        set(handles.al_edit,'Enable','off');
        set(handles.be_edit,'Enable','off');
        set(handles.ga_edit,'Enable','off');
        a = get(handles.a_edit,'String');
        set(handles.al_edit,'String',90);
        set(handles.be_edit,'String',90);
        set(handles.ga_edit,'String',90);
    case 4 %六方晶系Hexagonal
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','off');
        set(handles.c_edit,'Enable','on');
        set(handles.al_edit,'Enable','off');
        set(handles.be_edit,'Enable','off');
        set(handles.ga_edit,'Enable','off');
        a = get(handles.a_edit,'String');
        set(handles.b_edit,'String',a);
        set(handles.al_edit,'String',90);
        set(handles.be_edit,'String',90);
        set(handles.ga_edit,'String',120);
    case 5 %菱方晶系Rhombohedral
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','off');
        set(handles.c_edit,'Enable','off');
        set(handles.al_edit,'Enable','on');
        set(handles.be_edit,'Enable','off');
        set(handles.ga_edit,'Enable','off');
        a = get(handles.a_edit,'String');
        set(handles.b_edit,'String',a);
        set(handles.c_edit,'String',a);
        al = get(handles.al_edit,'String');
        set(handles.be_edit,'String',al);
        set(handles.ga_edit,'String',al);
    case 6 %单斜晶系Monoclinec
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','on');
        set(handles.c_edit,'Enable','on');
        set(handles.al_edit,'Enable','off');
        set(handles.be_edit,'Enable','on');
        set(handles.ga_edit,'Enable','off');
        a = get(handles.a_edit,'String');
        set(handles.al_edit,'String',90);
        set(handles.ga_edit,'String',90);
    case 7 %三斜晶系Triclinic
        set(handles.a_edit,'Enable','on');
        set(handles.b_edit,'Enable','on');
        set(handles.c_edit,'Enable','on');
        set(handles.al_edit,'Enable','on');
        set(handles.be_edit,'Enable','on');
        set(handles.ga_edit,'Enable','on');
end

function [a, b, c, al, be, ga] = abcabc(handles) %获取abc等参数
a = str2double(get(handles.a_edit,'String'));
b = str2double(get(handles.b_edit,'String'));
c = str2double(get(handles.c_edit,'String'));
al = pi/180*str2double(get(handles.al_edit,'String'));
be = pi/180*str2double(get(handles.be_edit,'String'));
ga = pi/180*str2double(get(handles.ga_edit,'String'));

function [V, S11, S22, S33, S12, S23, S13] = VS(handles)  %计算V和S等常数
[a, b, c, al, be, ga] =abcabc(handles);
V = a*b*c*sqrt(1-cos(al)^2-cos(be)^2-cos(ga)^2+2*cos(al)*cos(be)*cos(ga));
S11 = (b*c*sin(al))^2;
S22 = (a*c*sin(be))^2;
S33 = (a*b*sin(ga))^2;
S12 = a*b*c^2*(cos(al)*cos(be)-cos(ga));
S23 = a^2*b*c*(cos(be)*cos(ga)-cos(al));
S13 = a*b^2*c*(cos(al)*cos(ga)-cos(be));

function [h, k, l] = hkl(handles)  %读取hkl值
h = str2double(get(handles.hu_edit,'String'));
k = str2double(get(handles.kv_edit,'String'));
l = str2double(get(handles.lw_edit,'String'));

function [h1, k1, l1, h2, k2, l2]= hklhkl(handles) %读取hkl1和hkl2值
h1 = str2double(get(handles.hu1_edit,'String'));
k1 = str2double(get(handles.kv1_edit,'String'));
l1 = str2double(get(handles.lw1_edit,'String'));
h2 = str2double(get(handles.hu2_edit,'String'));
k2 = str2double(get(handles.kv2_edit,'String'));
l2 = str2double(get(handles.lw2_edit,'String'));


function [hkl1, hkl2] = OverIndex(hkl1_num, hkl2_num) %遍历hkl1和hkl2的组合
index = [1, 2, 3, 4, 5, 6];
n_index = length(index);
n_total = n_index*(n_index-2)*(n_index-4);
hkl = zeros(n_total,3);
count = 0;
hkl_index = zeros(1,3);
for i = 1:n_index
    hkl_index(1) = index(i);
    sub_index = [index(i), index(n_index + 1 -i)];
    index2 = setdiff(index, sub_index);
    n_index2 = length(index2);
    for j = 1:n_index2
        hkl_index(2) = index2(j);
        sub_index2 = [index2(j), index2(n_index2 + 1 - j)];
        index3 = setdiff(index2, sub_index2);
        n_index3 = length(index3);
        for k = 1:n_index3
            hkl_index(3) = index3(k);
            count = count + 1;
            hkl(count,:) = hkl_index;
        end
        
    end
    
end
for i = 1:n_total
    hkl1_index((i-1)*n_total+1:i*n_total,:) = repmat(hkl(i,:),n_total,1) ;
end
hkl2_index = repmat(hkl,n_total,1);
hkl1 = hkl1_num(hkl1_index);
hkl2 = hkl2_num(hkl2_index);

function [angf, out_str] = CalAng(handles, hkl1, hkl2) %计算晶面角度
[V, S11, S22, S33, S12, S23, S13] = VS(handles);
cal_unit = get(handles.deg,'Value');
h11 = hkl1(:,1); k11 = hkl1(:,2); l11 = hkl1(:,3);
h22 = hkl2(:,1); k22 = hkl2(:,2); l22 = hkl2(:,3);

d1 = V./sqrt(S11*h11.^2 + S22*k11.^2 + S33*l11.^2 + 2*S12*h11.*k11 ...
    + 2*S23*k11.*l11 + 2*S13*l11.*h11);
d2 = V./sqrt(S11*h22.^2 + S22*k22.^2 + S33*l22.^2 + 2*S12*h22.*k22 ...
    + 2*S23*k22.*l22 + 2*S13*l22.*h22);
cosf = d1.*d2./V^2.*(S11*h11.*h22 + S22*k11.*k22 + S33*l11.*l22 + ...
    S23*(k11.*l22 + k22.*l11) + S13*(l11.*h22 + l22.*h11) + ...
    S12*(h11.*k22 + h22.*k11));
if cal_unit
    angf = 180*acos(cosf)/pi;
    out_str = '角度';
else
    angf = acos(cosf);
    out_str = '弧度';
end

function [angf, out_str] = CalAngVer(handles, uvw1, uvw2)
cal_unit = get(handles.deg,'Value');
[~, ~, ~, al, be, ga] = abcabc(handles);
u11 = uvw1(:,1); v11 = uvw1(:,2); w11 = uvw1(:,3);
u22 = uvw2(:,1); v22 = uvw2(:,2); w22 = uvw2(:,3);
u33 = u11 - u22; v33 = v11 - v22; w33 = w11 - w22;

d1 = sqrt(u11.^2 + v11.^2 + w11.^2 + 2*u11.*v11*cos(ga) ...
    + 2*u11.*w11*cos(be) + 2*v11.*w11*cos(al));
d2 = sqrt(u22.^2 + v22.^2 + w22.^2 + 2*u22.*v22*cos(ga) ...
    + 2*u22.*w22*cos(be) + 2*v22.*w22*cos(al));
d3 = sqrt(u33.^2 + v33.^2 + w33.^2 + 2*u33.*v33*cos(ga) ...
    + 2*u33.*w33*cos(be) + 2*v33.*w33*cos(al));
cosf = (d1.^2 + d2.^2 - d3.^2)./(2*d1.*d2);
if cal_unit
    angf = 180*acos(cosf)/pi;
    out_str = '角度';
else
    angf = acos(cosf);
    out_str = '弧度';
end
set(handles.Re_Ang_Ver,'String',angf);

% --- Executes during object creation, after setting all properties.
function crytype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crytype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_edit_Callback(hObject, eventdata, handles)
% hObject    handle to a_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
abcabc(handles);
% Hints: get(hObject,'String') returns contents of a_edit as text
%        str2double(get(hObject,'String')) returns contents of a_edit as a double


% --- Executes during object creation, after setting all properties.
function a_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_edit_Callback(hObject, eventdata, handles)
% hObject    handle to c_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
abcabc(handles);
% Hints: get(hObject,'String') returns contents of c_edit as text
%        str2double(get(hObject,'String')) returns contents of c_edit as a double


% --- Executes during object creation, after setting all properties.
function c_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
abcabc(handles);
% Hints: get(hObject,'String') returns contents of b_edit as text
%        str2double(get(hObject,'String')) returns contents of b_edit as a double


% --- Executes during object creation, after setting all properties.
function b_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function al_edit_Callback(hObject, eventdata, handles)
% hObject    handle to al_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
abcabc(handles);
% Hints: get(hObject,'String') returns contents of al_edit as text
%        str2double(get(hObject,'String')) returns contents of al_edit as a double


% --- Executes during object creation, after setting all properties.
function al_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to al_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ga_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ga_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
abcabc(handles);
% Hints: get(hObject,'String') returns contents of ga_edit as text
%        str2double(get(hObject,'String')) returns contents of ga_edit as a double


% --- Executes during object creation, after setting all properties.
function ga_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ga_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function be_edit_Callback(hObject, eventdata, handles)
% hObject    handle to be_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crytype(handles);
abcabc(handles);
% Hints: get(hObject,'String') returns contents of be_edit as text
%        str2double(get(hObject,'String')) returns contents of be_edit as a double


% --- Executes during object creation, after setting all properties.
function be_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to be_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global
delete(handles.figure1);


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
publish('CryCal_help.m');
web('html/CryCal_help.html');


% --------------------------------------------------------------------
function Copyright_Callback(hObject, eventdata, handles)
% hObject    handle to Copyright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myicon = load('copyright.mat');
mydata = myicon.cyrt;
mymap = myicon.map;
msgbox({'晶体计算器CryCal Version1.0',...
    '版权(CopyRight):廖名情(Liao Mingqing)From 哈尔滨工业大学材料学FGMS组',...
    '邮箱e-mail:liaomq1900127@163.com'},'CopyRight',...
    'custom',mydata,mymap);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function hu_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hu_edit as text
%        str2double(get(hObject,'String')) returns contents of hu_edit as a double


% --- Executes during object creation, after setting all properties.
function hu_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lw_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lw_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lw_edit as text
%        str2double(get(hObject,'String')) returns contents of lw_edit as a double


% --- Executes during object creation, after setting all properties.
function lw_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lw_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kv_edit_Callback(hObject, eventdata, handles)
% hObject    handle to kv_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kv_edit as text
%        str2double(get(hObject,'String')) returns contents of kv_edit as a double


% --- Executes during object creation, after setting all properties.
function kv_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kv_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DisofPan.
function DisofPan_Callback(hObject, eventdata, handles)
% hObject    handle to DisofPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[V, S11, S22, S33, S12, S23, S13] = VS(handles);
[h, k, l] = hkl(handles);
d_p = V/sqrt(S11*h^2+S22*k^2+S33*l^2+2*S12*h*k+2*S23*k*l+2*S13*l*h);
set(handles.Re_Pan,'String',d_p)

% msgbox(h)

% --- Executes on button press in DisofVer.
function DisofVer_Callback(hObject, eventdata, handles)
% hObject    handle to DisofVer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a, b, c, al, be, ga] = abcabc(handles);
[u, v, w] = hkl(handles);
u_re = a*u;
v_re = b*v;
w_re = c*w;
d_v = sqrt(u_re^2 + v_re^2 +w_re^2 + 2*u_re*v_re*cos(ga) ...
    + 2*u_re*w_re*cos(be) + 2*v_re*w_re*cos(al));
set(handles.Re_Ver,'String',d_v);




function Re_Pan_Callback(hObject, eventdata, handles)
% hObject    handle to Re_Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Re_Pan as text
%        str2double(get(hObject,'String')) returns contents of Re_Pan as a double


% --- Executes during object creation, after setting all properties.
function Re_Pan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Re_Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Re_Ver_Callback(hObject, eventdata, handles)
% hObject    handle to Re_Ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Re_Ver as text
%        str2double(get(hObject,'String')) returns contents of Re_Ver as a double


% --- Executes during object creation, after setting all properties.
function Re_Ver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Re_Ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hu1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hu1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hu1_edit as text
%        str2double(get(hObject,'String')) returns contents of hu1_edit as a double


% --- Executes during object creation, after setting all properties.
function hu1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hu1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lw1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lw1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lw1_edit as text
%        str2double(get(hObject,'String')) returns contents of lw1_edit as a double


% --- Executes during object creation, after setting all properties.
function lw1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lw1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kv1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to kv1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kv1_edit as text
%        str2double(get(hObject,'String')) returns contents of kv1_edit as a double


% --- Executes during object creation, after setting all properties.
function kv1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kv1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hu2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hu2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hu2_edit as text
%        str2double(get(hObject,'String')) returns contents of hu2_edit as a double


% --- Executes during object creation, after setting all properties.
function hu2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hu2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lw2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to lw2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lw2_edit as text
%        str2double(get(hObject,'String')) returns contents of lw2_edit as a double


% --- Executes during object creation, after setting all properties.
function lw2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lw2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kv2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to kv2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kv2_edit as text
%        str2double(get(hObject,'String')) returns contents of kv2_edit as a double


% --- Executes during object creation, after setting all properties.
function kv2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kv2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ang_Pan.
function Ang_Pan_Callback(hObject, eventdata, handles)
% hObject    handle to Ang_Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global V S11 S22 S33 S12 S23 S13 h1 k1 l1 h2 k2 l2
% [V, S11, S22, S33, S12, S23, S13] = VS(handles);
LangType = handles.LangType;
if LangType == 1  %Chinese
    FileName = '晶面族间的夹角';
else
    FileName = 'Angle Between Crystal Plane';
end
[h1, k1, l1, h2, k2, l2]= hklhkl(handles);
cal_type = get(handles.Cal_One,'Value');

cal_out1 = get(handles.txt,'Value'); %the output is txt
cal_out2 = get(handles.mat,'Value'); %the output is mat  or the output is xlsx
cal_out3 = get(handles.xlsx,'Value');
% msgbox(num2str(cal_out2))
if cal_type  
    hkl1 = [h1, k1, l1];
    hkl2 = [h2, k2, l2];
    [angf, ~] = CalAng(handles, hkl1, hkl2);
    set(handles.Re_Ang_Pan,'String',angf);
else  %viw them as different[1 2 3 ;-1 -2 -3]
    hkl1_num = [h1, k1, l1, -l1, -k1, -h1];
    hkl2_num = [h2, k2, l2, -l2, -k2, -h1];
    
    [hkl1, hkl2] = OverIndex(hkl1_num, hkl2_num); 
    
    [angf, out_str] = CalAng(handles, hkl1, hkl2);  
    set(handles.Re_Ang_Pan,'String',angf);
    heading = {'h1', 'k1', 'l1', 'h2', 'k2', 'l2', out_str};
    out = [hkl1, hkl2, angf];
    if cal_out1  %txt
        fid = fopen([FileName, '.txt'], 'wt');
        fprintf(fid, '%4s %4s %4s %4s %4s %4s %4s\t\r\n\n', 'h1', 'k1', 'l1', 'h2', 'k2', 'l2', out_str);
        fprintf(fid, '%4d %4d %4d %4d %4d %4d %4.3f\t\r\n', out');
        fclose(fid);
%         save('晶面族间的夹角.txt', 'out', '-append','-ascii');
    elseif cal_out2  %mat
        out_mat0 = num2cell(out);
        out_mat = [heading; out_mat0];
        save([FileName, '.mat'],'out_mat');        
    elseif cal_out3 %excel
        out_xlsx0 = num2cell(out);
        out_xlsx = [heading; out_xlsx0];
        xlswrite([FileName, '.xlsx'],out_xlsx)
    end    
end


% --- Executes on button press in Ang_Ver.
function Ang_Ver_Callback(hObject, eventdata, handles)
% hObject    handle to Ang_Ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LangType = handles.LangType;
if LangType == 1  %Chinese
    FileName = '晶向族间的夹角';
else
    FileName = 'Angle Between Crystal Plane';
end
[a, b, c, ~, ~, ~] = abcabc(handles);
[u1, v1, w1, u2, v2, w2]= hklhkl(handles);
cal_type = get(handles.Cal_One,'Value');
cal_out1 = get(handles.txt,'Value'); %the output is txt
cal_out2 = get(handles.mat,'Value'); %the output is mat  or the output is xlsx
cal_out3 = get(handles.xlsx,'Value');
if cal_type
    uvw11 = [a*u1, b*v1, c*w1];
    uvw22 = [a*u2, b*v2, c*w2];
    [angf, ~] = CalAngVer(handles, uvw11, uvw22);
    set(handles.Re_Ang_Ver,'String',angf);
else
    uvw1_num = [u1, v1, w1, -w1, -v1, -u1];
    uvw2_num = [u2, v2, w2, -w2, -v2, -u2];    
    [uvw1, uvw2] = OverIndex(uvw1_num, uvw2_num); 
    [m1, ~] = size(uvw1);
    abc0 = [a, b, c];
    uvw0 = repmat(abc0, [m1,1]);
    uvw11 = uvw1.*uvw0;
    uvw22 = uvw2.*uvw0;
    
    [angf, out_str] = CalAngVer(handles, uvw11, uvw22);
    
    heading = {'u1', 'v1', 'w1', 'u2', 'v2', 'w2', out_str};
    out = [uvw1, uvw2, angf];
    if cal_out1  %txt
        fid = fopen([FileName, '.txt'], 'wt');
        fprintf(fid, '%4s %4s %4s %4s %4s %4s %4s\t\r\n\n', 'h1', 'k1', 'l1', 'h2', 'k2', 'l2', out_str);
        fprintf(fid, '%4d %4d %4d %4d %4d %4d %4.3f\t\r\n', out');
        fclose(fid);
%         save('晶面族间的夹角.txt', 'out', '-append','-ascii');
    elseif cal_out2  %mat
        out_mat0 = num2cell(out);
        out_mat = [heading; out_mat0];
        save([FileName, '.mat'],'out_mat');        
    elseif cal_out3 %excel
        out_xlsx0 = num2cell(out);
        out_xlsx = [heading; out_xlsx0];
        xlswrite([FileName '.xlsx'],out_xlsx)
    end
    
end



function Re_Ang_Pan_Callback(hObject, eventdata, handles)
% hObject    handle to Re_Ang_Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Re_Ang_Pan as text
%        str2double(get(hObject,'String')) returns contents of Re_Ang_Pan as a double


% --- Executes during object creation, after setting all properties.
function Re_Ang_Pan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Re_Ang_Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Re_Ang_Ver_Callback(hObject, eventdata, handles)
% hObject    handle to Re_Ang_Ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Re_Ang_Ver as text
%        str2double(get(hObject,'String')) returns contents of Re_Ang_Ver as a double


% --- Executes during object creation, after setting all properties.
function Re_Ang_Ver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Re_Ang_Ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Cal_Callback(hObject, eventdata, handles)
% hObject    handle to Cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function DisAng_Callback(hObject, eventdata, handles)
% hObject    handle to DisAng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
clear global
delete(hObject);


% --- Executes on button press in Cal_One.
function Cal_One_Callback(hObject, eventdata, handles)
% hObject    handle to Cal_One (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of Cal_One


% --- Executes on button press in Lang.
function Lang_Callback(hObject, eventdata, handles)
% hObject    handle to Lang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LangType = handles.LangType;
if LangType == 1
    set(handles.Lang, 'String', '中文');
    set(handles.crytype, 'String', {'Cubic', 'Tetragonal', 'Orthorhombic',...
        'Hexagonal', 'Rhombohedral', 'Monoclinec', 'Triclinic'});
    set(handles.ParaSet, 'Title', 'Crystal Parameters Setting');
    set(handles.DisCal, 'Title', 'Distance Calculation');
    set(handles.AngCal, 'Title', 'Angle Calculation');
    set(handles.CalType, 'Title', 'Calculation Type');
    set(handles.OutType, 'Title', 'Output Type');
    set(handles.Unit, 'Title', 'Unit');
    set(handles.DisofPan, 'String', 'Interplanar Spacing');
    set(handles.DisofVer, 'String', 'Length of Verctor');
    set(handles.Cal_One, 'String', 'Single');
    set(handles.Cal_Zu, 'String', 'Family');
    set(handles.Ang_Pan, 'String', 'Crystal Plane');
    set(handles.Ang_Ver, 'String', 'Crystal Orientation');
    set(handles.File, 'Label', 'File');
    set(handles.Exit, 'Label', 'Exit');
    set(handles.Cal, 'Label', 'Calculation');
    set(handles.DisAng, 'Label', 'Calculation for Distance and Angle');
    set(handles.About, 'Label', 'About');
    set(handles.Help, 'Label', 'Help');
    set(handles.Copyright, 'Label', 'Copyright');
    handles.LangType = 0;
else
    set(handles.Lang, 'String', 'English');
    set(handles.crytype, 'String', {'立方晶系Cubic', '四方晶系Tetragonal',...
        '正交晶系Orthorhombic', '六方晶系Hexagonal', '菱方晶系Rhombohedral',...
        '单斜晶系Monoclinec', '三斜晶系Triclinic'});
    set(handles.ParaSet, 'Title', '晶格参数设置');
    set(handles.DisCal, 'Title', '距离计算');
    set(handles.AngCal, 'Title', '夹角计算');
    set(handles.CalType, 'Title', '计算类型');
    set(handles.OutType, 'Title', '结果输出');
    set(handles.Unit, 'Title', '单位');
    set(handles.DisofPan, 'String', '计算晶面间距');
    set(handles.DisofVer, 'String', '计算矢量长度');
    set(handles.Cal_One, 'String', '单一计算');
    set(handles.Cal_Zu, 'String', '族计算');
    set(handles.Ang_Pan, 'String', '计算晶面夹角');
    set(handles.Ang_Ver, 'String', '计算晶向夹角');
    set(handles.File, 'Label', '文件');
    set(handles.Exit, 'Label', '退出Exit');
    set(handles.Cal, 'Label', '计算');
    set(handles.DisAng, 'Label', '面间距及夹角计算');
    set(handles.About, 'Label', '关于');
    set(handles.Help, 'Label', '帮助Help');
    set(handles.Copyright, 'Label', '版权Copyright');
    handles.LangType = 1;
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.LangType = 1;
% disp(handles.LangType);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Lang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% handles.LangType = 1;

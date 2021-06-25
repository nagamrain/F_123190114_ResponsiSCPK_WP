function varargout = F_123190114_ResponsiSCPK(varargin)
% F_123190114_RESPONSISCPK MATLAB code for F_123190114_ResponsiSCPK.fig
%      F_123190114_RESPONSISCPK, by itself, creates a new F_123190114_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = F_123190114_RESPONSISCPK returns the handle to a new F_123190114_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      F_123190114_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F_123190114_RESPONSISCPK.M with the given input arguments.
%
%      F_123190114_RESPONSISCPK('Property','Value',...) creates a new F_123190114_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F_123190114_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F_123190114_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F_123190114_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 14:35:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F_123190114_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @F_123190114_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before F_123190114_ResponsiSCPK is made visible.
function F_123190114_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F_123190114_ResponsiSCPK (see VARARGIN)

% Choose default command line output for F_123190114_ResponsiSCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F_123190114_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F_123190114_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = xlsread('data1.xlsx'); %Membaca file dataset
% mengambil data dalam dataset
data =[data(:,3) data(:,4) data(:,5) data(:,8)];
data = data(1:50,:);
set(handles.uitable1,'Data',data);

%Bobot kriteria
k = [0,0,1,0];
w = [3,5,4,1];

%tahapan pertama, perbaikan bobot
[m,n]=size(data); %inisialisasi ukuran data
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot
%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n
    if k(j)==0, w(j)=-1*w(j);
    end
end
for i=1:m
    S(i)=prod(data(i,:).^w,2);
end

%tahapan ketiga, proses perangkingan
V = S/sum(S);

%Menampilkan hasil proses
[maks, index] = maxk(V,50);
data = data(index);
data = transpose(num2cell(data));
maks = transpose(num2cell(maks));
hasil = [data maks];
set(handles.uitable2,'Data',hasil);


% --- Executes during object creation, after setting all properties.
function uitable2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

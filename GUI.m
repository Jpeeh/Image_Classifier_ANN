function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 25-May-2019 19:25:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

handles.rede_neuronal = [];

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)
% Divido e guardo os valores (divididos por espaços em branco ou vírgulas) representantes do numeros de neurónios por cada camada
% CADA NÚMERO REPRESENTA UMA CAMADA DE NEURÓNIOS
handles.neuronios = strsplit(get(hObject,'String'), {' ',','}, 'CollapseDelimiters', true);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
handles.neuronios = get(hObject, 'String');
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
f_activacao = cell(1,length(handles.idx));
for k = 1:length(handles.idx)
    f_activacao(k) = handles.contents(handles.idx(k));  % copia as strings das funções de activação para um cell array auxiliar
end

num = get(handles.listbox2, 'Value');                  % retorna o(s) indice(s) seleccinados da lista das fuções de activação
num2 = get(handles.listbox3, 'Value');                 % retorna o índice seleccionado da lista das funções de treino

[~, aux1] = size(handles.neuronios);  
[~, aux2] = size(num);
[~, aux3] = size(num2);

if isempty(handles.neuronios)
    errordlg('Introduza quantas camadas quer na rede neuronal!','ERRO');
elseif isempty(handles.idx)
    errordlg('Nº de funções de activação não correspondem à topologia da rede neuronal!', 'ERRO');
elseif aux3 > 1
    errordlg('Introduza só 1 função de treino!','ERRO');
elseif aux2 ~= aux1 + 1
    errordlg('Nº de funções de activação não correspondem à topologia da rede neuronal!', 'ERRO');
else
    handles.rede_neuronal = GUI_NN(handles.neuronios, f_activacao, handles.contents2(handles.idx2));
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
if isempty(handles.rede_neuronal)
     errordlg('Configure/treine primeiro a rede neuronal que quer guardar!', 'ERRO');
else
    net = handles.rede_neuronal;
    save net;
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[file, path] = uigetfile('C:\Users\Asus\Desktop\ISEC\CR\TP\*.mat');
aux = strcat(path,file);
temp = load(aux);
handles.rede_neuronal = temp;
guidata(hObject, handles);

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2

Listbox2Names = {'tansig', 'logsig', 'purelin', 'compet', 'hardlim', 'hardlims', 'netinv', 'poslin', 'radbas', 'radbasn', 'satlin', 'satlins', 'softmax', 'tribas'};
set(handles.listbox2, 'string', Listbox2Names);     % vai preencher a ListBox2 com a lista de strings acima mencionadas
handles.contents = cellstr(get(hObject,'String'));  % converte a lista de strings para cell array
handles.idx = get(hObject,'Value');                 % guardar os índices das strings seleccionadas
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
handles.idx = [];
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
Listbox3Names = {'trainbfg', 'trainbr', 'trainbu', 'trainc','traincgb', 'traincgf','traincgp','traingd','traingda','traingdm','traingdx','trainlm','trainoss', 'trainr', 'trainrp', 'trainru','trains', 'trainscg'};
set(handles.listbox3, 'string', Listbox3Names);
handles.contents2 = cellstr(get(hObject,'String'));
handles.idx2 = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
[file, path] = uigetfile('C:\Users\Asus\Desktop\ISEC\CR\TP\*.png');
aux = strcat(path,file);
classifica_imagem(aux);
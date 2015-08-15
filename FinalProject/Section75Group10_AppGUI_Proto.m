function varargout = Section75Group10_AppGUI_Proto(varargin)
% SECTION75GROUP10_APPGUI_PROTO MATLAB code for Section75Group10_AppGUI_Proto.fig
%      SECTION75GROUP10_APPGUI_PROTO, by itself, creates a new SECTION75GROUP10_APPGUI_PROTO or raises the existing
%      singleton*.
%
%      H = SECTION75GROUP10_APPGUI_PROTO returns the handle to a new SECTION75GROUP10_APPGUI_PROTO or the handle to
%      the existing singleton*.
%
%      SECTION75GROUP10_APPGUI_PROTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION75GROUP10_APPGUI_PROTO.M with the given input arguments.
%
%      SECTION75GROUP10_APPGUI_PROTO('Property','Value',...) creates a new SECTION75GROUP10_APPGUI_PROTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section75Group10_AppGUI_Proto_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section75Group10_AppGUI_Proto_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section75Group10_AppGUI_Proto

% Last Modified by GUIDE v2.5 11-Aug-2015 19:17:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section75Group10_AppGUI_Proto_OpeningFcn, ...
                   'gui_OutputFcn',  @Section75Group10_AppGUI_Proto_OutputFcn, ...
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


% --- Executes just before Section75Group10_AppGUI_Proto is made visible.
function Section75Group10_AppGUI_Proto_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section75Group10_AppGUI_Proto (see VARARGIN)

% Choose default command line output for Section75Group10_AppGUI_Proto
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section75Group10_AppGUI_Proto wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section75Group10_AppGUI_Proto_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calpress.
function calpress_Callback(hObject, eventdata, handles)
% hObject    handle to calpress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.comPort='COM6';
[handles.accelerometer.s, handles.serialFlag]=setupSerial(handles.comPort);


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial

% --- Executes on slider movement.
function aslide_Callback(hObject, eventdata, handles)
% hObject    handle to aslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function aslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tslide_Callback(hObject, eventdata, handles)
% hObject    handle to tslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function thresh_in_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_in as text
%        str2double(get(hObject,'String')) returns contents of thresh_in as a double


% --- Executes during object creation, after setting all properties.
function thresh_in_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

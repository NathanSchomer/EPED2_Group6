function varargout = LectureBhandlesdemo(varargin)
% LECTUREBHANDLESDEMO MATLAB code for LectureBhandlesdemo.fig
%      LECTUREBHANDLESDEMO, by itself, creates a new LECTUREBHANDLESDEMO or raises the existing
%      singleton*.
%
%      H = LECTUREBHANDLESDEMO returns the handle to a new LECTUREBHANDLESDEMO or the handle to
%      the existing singleton*.
%
%      LECTUREBHANDLESDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LECTUREBHANDLESDEMO.M with the given input arguments.
%
%      LECTUREBHANDLESDEMO('Property','Value',...) creates a new LECTUREBHANDLESDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LectureBhandlesdemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LectureBhandlesdemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LectureBhandlesdemo

% Last Modified by GUIDE v2.5 14-Jul-2015 14:19:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LectureBhandlesdemo_OpeningFcn, ...
                   'gui_OutputFcn',  @LectureBhandlesdemo_OutputFcn, ...
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


% --- Executes just before LectureBhandlesdemo is made visible.
function LectureBhandlesdemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LectureBhandlesdemo (see VARARGIN)

% Choose default command line output for LectureBhandlesdemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LectureBhandlesdemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LectureBhandlesdemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in savenum.
function savenum_Callback(hObject, eventdata, handles)
% hObject    handle to savenum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Num=get(handles.enternum,'String') % Save string in enternum to handles.Num
guidata(hObject, handles);% Update handles variables

% --- Executes on button press in recallnum.
function recallnum_Callback(hObject, eventdata, handles)
% hObject    handle to recallnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.numdisplay,'String',handles.Num)% Set numdisplay to saved numbers

% --- Executes on button press in disphand.
function disphand_Callback(hObject, eventdata, handles)
% hObject    handle to disphand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles % Display handles information
handles.numdisplay
handles.savenum




function enternum_Callback(hObject, eventdata, handles)
% hObject    handle to enternum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enternum as text
%        str2double(get(hObject,'String')) returns contents of enternum as a double


% --- Executes during object creation, after setting all properties.
function enternum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enternum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in toggle.
function toggle_Callback(hObject, eventdata, handles)
% hObject    handle to toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=zeros(1,100);

if strcmp(get(handles.toggle,'String'),'Red') %If button string is 'Red'
    set(handles.axes1,'Color','r')%Set Axes 1 to red
    set(handles.axes2,'Color','g')%Set Axes 2 to green
    set(handles.toggle,'String','Green');%Change button string to 'Green'
elseif strcmp(get(handles.toggle,'String'),'Green')
    set(handles.toggle,'String','Red');
    set(handles.axes1,'Color','g');
    set(handles.axes2,'Color','r')
end

while strcmp(get(handles.toggle,'String'),'Green') %While button string is 'Green'
   axes(handles.axes3)
    A=[A(2:end) rand]% Rolling plot of random numbers
    plot(A)
    drawnow
    
end

% --- Executes on button press in plotbut.
function plotbut_Callback(hObject, eventdata, handles)
% hObject    handle to plotbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
plot(rand(100,1))
axes(handles.axes2)
plot(rand(100,1))

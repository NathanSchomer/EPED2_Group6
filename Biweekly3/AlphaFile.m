function varargout = AlphaFile(varargin)
% ALPHAFILE MATLAB code for AlphaFile.fig
%      ALPHAFILE, by itself, creates a new ALPHAFILE or raises the existing
%      singleton*.
%
%      H = ALPHAFILE returns the handle to a new ALPHAFILE or the handle to
%      the existing singleton*.
%
%      ALPHAFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALPHAFILE.M with the given input arguments.
%
%      ALPHAFILE('Property','Value',...) creates a new ALPHAFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AlphaFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AlphaFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AlphaFile

% Last Modified by GUIDE v2.5 31-Jul-2015 00:56:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlphaFile_OpeningFcn, ...
                   'gui_OutputFcn',  @AlphaFile_OutputFcn, ...
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


% --- Executes just before AlphaFile is made visible.
function AlphaFile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlphaFile (see VARARGIN)

% Choose default command line output for AlphaFile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AlphaFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AlphaFile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editable1_Callback(hObject, eventdata, handles)
% hObject    handle to editable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editable1 as text
%        str2double(get(hObject,'String')) returns contents of editable1 as a double


% --- Executes during object creation, after setting all properties.
function editable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in RunAlphaGo.
function RunAlphaGo_Callback(hObject, eventdata, handles)
% hObject    handle to RunAlphaGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)    
ALPHA= str2double(get(handles.editable1,'String'));

tval=2;
while tval > 1  % make sure there is an angle inside parameters
if ALPHA > 1
set(handles.text1,'String',['Alpha is too small. Enter a larger value.']);
guidata(hObject, handles);% Update handles variables
break

elseif ALPHA < 0 
set(handles.text1,'String',['Alpha is too small. Enter a larger value.']);
guidata(hObject, handles);% Update handles variables
break

else
    tval=0; % if input is inside parameters, this lets program continue to next input step
end
end

s=zeros(200,1);
sfilt=zeros(200,1);

AlphaStyleRaw=plot(s);
AlphaStyleFilt=plot(sfilt);

axis([0 200 -1.3 1.3]); %Defines axes
axes(handles.axes1)
xlabel('Time')
ylabel('Signal')

while get(hObject, 'value') == 1
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo); %get data from accel

    xRead=gx; % raw data
    s=[s(2:end); xRead]; % raw data into set
    set(AlphaStyleRaw,'ydata',s); % plotting raw dataset
    
    % FILTERED AREA 51
    sfilt_new=(1-ALPHA)*sfilt(end)+ALPHA*gx; % calculating filtered value
    sfilt=[s(2:end); sfilt_new]; % entering filtered data into 
    set(AlphaStyleFilt,'ydata',s);% plotting filtered dataset
    drawnow
end

guidata(hObject, handles);% Update handles variables

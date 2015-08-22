function varargout = Section75Group10App(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Section75Group10App_OpeningFcn, ...
    'gui_OutputFcn',  @Section75Group10App_OutputFcn, ...
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


% --- Executes just before Section75Group10App is made visible.
function Section75Group10App_OpeningFcn(hObject, ~, handles, varargin)

global accelerometer calCo comPort
comPort = '/dev/tty.usbmodem1411';
[accelerometer.s, ~] = setupSerial(comPort);
calCo = calibrate(accelerometer.s);

axes(handles.videoFeed)
title('Video Feed')

axes(handles.cameraVisual)
title('Camera Visualization')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section75Group10App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section75Group10App_OutputFcn(~,~,handles)
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject,~,handles) %#ok<*DEFNU>
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global accelerometer calCo
set(handles.launchButton, 'Enable', 'on')

handles.mag_raw = zeros(1, 200);
handles.filter = zeros(1, 200);
handles.alphaValue = .8;
handles.gx_vector = zeros(1, 200);
handles.gy_vector = zeros(1, 200);

axes(handles.testAxes)
title('Rolling Data')
rollingX = plot(handles.gx_vector, 'color', 'r');
hold on 
rollingY = plot(handles.gy_vector, 'color', 'k');
% y_filtered = plot(handles.filter, 'g', 'Linewidth', 3);

axis([0 200 -3 3])

handles.str = get(hObject,'String'); % Recognizes start button

if strcmp(get(handles.start,'String'),'Start') %if the start button is clicked
    set(handles.start,'String','Stop');% the string inside it changes it to a "stop" button
    while strcmp(get(handles.start,'String'),'Stop')
        
        [handles.gx, handles.gy, handles.gz]=readAcc(accelerometer, calCo) ; % Read data from accelerometer
        handles.gx_vector = [handles.gx_vector(2:end) handles.gx];
        handles.gy_vector = [handles.gy_vector(2:end) handles.gy];
     
%         sFilter_new = (1 - handles.alphaValue) * sFilter(end) + handles.alphaValue * handles.mag_raw(end);
%         sFilter = [sFilter(2:end); sFilter_new];
        
%         handles.newFilter = (1 - handles.alphaValue) * handles.filter(end) + handles.alphaValue * handles.gy_vector(end);
%         handles.filter = [handles.newFilter(2:end); handles.newFilter];

        set(rollingX, 'ydata', handles.gx_vector)
        set(rollingY, 'ydata', handles.gy_vector)
%         set(y_filtered, 'ydata', handles.filter)
        drawnow
              
    end
    
elseif strcmp(get(handles.start, 'String'), 'Stop')
    set(handles.start, 'String', 'Start');
    cla
end
guidata(hObject, handles)


% --- Executes on button press in launchButton.
function launchButton_Callback(hObject, ~, handles)
% hObject    handle to launchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(~,~,~)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial

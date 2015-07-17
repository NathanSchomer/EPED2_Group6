function varargout = SecondTryGUI(varargin)
% SECONDTRYGUI MATLAB code for SecondTryGUI.fig
%      SECONDTRYGUI, by itself, creates a new SECONDTRYGUI or raises the existing
%      singleton*.
%
%      H = SECONDTRYGUI returns the handle to a new SECONDTRYGUI or the handle to
%      the existing singleton*.
%
%      SECONDTRYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECONDTRYGUI.M with the given input arguments.
%
%      SECONDTRYGUI('Property','Value',...) creates a new SECONDTRYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SecondTryGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SecondTryGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SecondTryGUI

% Last Modified by GUIDE v2.5 17-Jul-2015 02:06:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SecondTryGUI_OpeningFcn, ...
    'gui_OutputFcn',  @SecondTryGUI_OutputFcn, ...
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


% --- Executes just before SecondTryGUI is made visible.
function SecondTryGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SecondTryGUI (see VARARGIN)

% Choose default command line output for SecondTryGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SecondTryGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SecondTryGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.comPort = 'COM6';
% chandlers comport(/dev/cu.usbmodem1421)
% bobbys comport(com6)
if (~exist('serialFlag', 'var'))
    [handles.accelerometer.s, handles.serialFlag] = ...
        setupSerial(handles.comPort);
end
%set(handles.serialStartTextBox, 'String', 'Done!');
guidata(hObject, handles);


% --- Executes on button press in Calibrate.
function Calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to Calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~exist('handles.calCo', 'var'))
    handles.calCo = calibrate(handles.accelerometer.s);
end
% set(handles.calibrateTextBox, 'String', 'Done!');
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial
close all


% --- Executes on button press in Plot.
function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Gx=rand(1,50);
Gy=rand(1,50);
Gz=rand(1,50);
Rezult=rand(1,50);

tic;
while toc < 20
    cla
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo)
    result=sqrt((gx^2)+(gy^2)+(gz^2));
    Gx=[Gx(2:end) gx];
    Gy=[Gy(2:end) gy];
    Gz=[Gz(2:end) gz];
    Rezult=[Rezult(2:end) result];
    axes(handles.axes1)
    plot(Gx,'b')
    hold on
    plot(Gy,'r')
    plot(Gz,'g')
    plot(Rezult,'k')
    axis([0 50 -1.5 1.5])
    drawnow
    title('Rolling Plot')
    xlabel('time')
    ylabel('value')
    legend('x value','y value','z value','resultant value','location','best')
    grid on
end
guidata(hObject, handles);% Update handles variables


% --- Executes on button press in Plot_Circle.
function Plot_Circle_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
circle_vector = (0:360);
x = cosd(circle_vector);
y = sind(circle_vector);
axes(handles.axes2)
tic;
circle = fill(x, y, [0 0 1]);
while toc < 10
    axes(handles.axes2)
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo);
    fill( y-(10*gy),x-(10*gx), [0 0 1])
    axis([-10 10 -10 10])
    drawnow
    ylabel('y')
    xlabel('x')
    title('Cursor')
end





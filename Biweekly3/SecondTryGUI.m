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

% Last Modified by GUIDE v2.5 28-Jul-2015 00:42:47

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
handles.comPort = '/dev/cu.usbmodem1411';

if (~exist('serialFlag', 'var'))
    [handles.accelerometer.s, handles.serialFlag] = ...
        setupSerial(handles.comPort);
end

if(~exist('handles.calCo', 'var'))
    handles.calCo = calibrate(handles.accelerometer.s);
end
%set(handles.serialStartTextBox, 'String', 'Done!');
guidata(hObject, handles);


% --- Executes on button press in Plot.
function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject,'String','Stop');
handles.str = get(hObject, 'String');

while get(hObject, 'Value') ==  1 %strcmp(handles.str, 'Stop')
    %handles.str = get(hObject, 'Value');
    axes(handles.axes1)
    axis([ -1.5 1.5 -1.5 1.5 -1.5 1.5])
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo);
    cla %Slow way of replotting
    line([0 gx],[0 0],[0 0],'Linewidth',2, 'color', 'b')
    line([0 0],[0 gy],[0 0],'Linewidth',2, 'color', 'g')
    line([0 0],[0 0],[0 gz],'Linewidth',2, 'color', 'r')
    line([0 gx], [0 gy], [0 gz], 'Linewidth', 4, 'color', 'k');
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    drawnow;
end

set(hObject,'String','Start')
guidata(hObject, handles);% Update handles variables



% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial
close all

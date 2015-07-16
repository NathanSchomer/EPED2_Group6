function varargout = firstTryGUI(varargin)
% FIRSTTRYGUI MATLAB code for firstTryGUI.fig
%      FIRSTTRYGUI, by itself, creates a new FIRSTTRYGUI or raises the existing
%      singleton*.
%
%      H = FIRSTTRYGUI returns the handle to a new FIRSTTRYGUI or the handle to
%      the existing singleton*.
%
%      FIRSTTRYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTTRYGUI.M with the given input arguments.
%
%      FIRSTTRYGUI('Property','Value',...) creates a new FIRSTTRYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firstTryGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firstTryGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firstTryGUI

% Last Modified by GUIDE v2.5 16-Jul-2015 11:49:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @firstTryGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @firstTryGUI_OutputFcn, ...
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


% --- Executes just before firstTryGUI is made visible.
function firstTryGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firstTryGUI (see VARARGIN)

% Choose default command line output for firstTryGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes firstTryGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = firstTryGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Calibrate.
function Calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to Calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 comPort='COM6';
 [accelerometer.s,flag]=setupSerial(comPort);

 calCo = calibrate(accelerometer.s);
 guidata(hObject, handles);% Update handles variables




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
    axes(handles.axes1)
    [gx, gy, gz]=readAcc(accelerometer,calCo)
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
    
    
    guidata(hObject, handles);% Update handles variables

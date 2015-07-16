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

% Last Modified by GUIDE v2.5 14-Jul-2015 18:11:15

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


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.togglebutton1,'String'),'Red') %If button string is 'Red'
    set(handles.axes1,'Color','r')%Set Axes 1 to red
    set(handles.axes2,'Color','g')%Set Axes 2 to green
    set(handles.togglebutton1,'String','Green');%Change button string to 'Green'
elseif strcmp(get(handles.togglebutton1,'String'),'Green')
    set(handles.togglebutton1,'String','Red');
    set(handles.axes1,'Color','g');
    set(handles.axes2,'Color','r')
end

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

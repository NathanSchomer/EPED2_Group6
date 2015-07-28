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

% Last Modified by GUIDE v2.5 28-Jul-2015 17:46:08

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

set(handles.Plot, 'Enable', 'on')
set(handles.SMA, 'Enable', 'on')
%set(handles.serialStartTextBox, 'String', 'Done!');
guidata(hObject, handles);


% --- Executes on button press in SMA.
function SMA_Callback(hObject, eventdata, handles)
% hObject    handle to SMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject,'String','Stop');
handles.str = get(hObject, 'String');
cla

buffer=200; %Set buffer length
mag_raw=zeros(1,buffer); % Magnitude raw data
mag_filt=zeros(1,buffer); % Magnitude filtered data
index=1:buffer; % Index for plotting
taps=5; % Window size for SMA

P1=plot(index,mag_raw); % Initialize plots
hold on
P2=plot(index,mag_filt,'r','Linewidth',2);
legend('Raw Data','Filtered Data')

threshold=1.5; % Set threshold
plot([0, buffer],[threshold, threshold],'g','Linewidth',3) % Plot threshold line
while get(hObject, 'Value') ==  1
    
    count=0; % Variable to count threshold crossings
    tic % Start timer
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo) ; % Read data from accelerometer
    mag_raw_new=sqrt(gx^2+gy^2+gz^2); % Calculate raw magnitude
    mag_raw=[mag_raw(2:end) mag_raw_new]; % Shift raw data vector and add new data point for rolling plots
    
    mag_filt_new=mean(mag_raw(end-taps+1:end)); % Calculate average of last tap number of points for SMA
    mag_filt=[mag_filt(2:end) mag_filt_new]; % Shift filtered vector over and add new filtered data point
    
    set(P1,'ydata',mag_raw); % Update plots
    set(P2,'ydata',mag_filt);
    axis([0 buffer 0 2.5]); % Set axis limits
    
    if mag_filt_new>threshold && mag_filt(end-1)<threshold % If current point is above threshold, and last point was below threshold
        count=count+1; % Add to count
    end
    title(['Threshold Crossings = ' num2str(count)]) % Title displays threshold counts
    drawnow % Update the plots
    
end
set(hObject,'String','Start')





% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial
close all


function varargout = Section75Group10Biweekly3_Question2(varargin)
% SECTION75GROUP10BIWEEKLY3_QUESTION2 MATLAB code for Section75Group10Biweekly3_Question2.fig
%      SECTION75GROUP10BIWEEKLY3_QUESTION2, by itself, creates a new SECTION75GROUP10BIWEEKLY3_QUESTION2 or raises the existing
%      singleton*.
%
%      H = SECTION75GROUP10BIWEEKLY3_QUESTION2 returns the handle to a new SECTION75GROUP10BIWEEKLY3_QUESTION2 or the handle to
%      the existing singleton*.
%
%      SECTION75GROUP10BIWEEKLY3_QUESTION2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION75GROUP10BIWEEKLY3_QUESTION2.M with the given input arguments.
%
%      SECTION75GROUP10BIWEEKLY3_QUESTION2('Property','Value',...) creates a new SECTION75GROUP10BIWEEKLY3_QUESTION2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section75Group10Biweekly3_Question2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section75Group10Biweekly3_Question2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section75Group10Biweekly3_Question2

% Last Modified by GUIDE v2.5 31-Jul-2015 23:31:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section75Group10Biweekly3_Question2_OpeningFcn, ...
                   'gui_OutputFcn',  @Section75Group10Biweekly3_Question2_OutputFcn, ...
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


% --- Executes just before Section75Group10Biweekly3_Question2 is made visible.
function Section75Group10Biweekly3_Question2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section75Group10Biweekly3_Question2 (see VARARGIN)

% Choose default command line output for Section75Group10Biweekly3_Question2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section75Group10Biweekly3_Question2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section75Group10Biweekly3_Question2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in calibration.
function calibration_Callback(hObject, eventdata, handles)
% hObject    handle to calibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.comPort = 'COM6';
if (~exist('serialFlag', 'var'))
    [handles.accelerometer.s, handles.serialFlag] = ...
        setupSerial(handles.comPort);
end

if(~exist('handles.calCo', 'var'))
    handles.calCo = calibrate(handles.accelerometer.s);
end

set(handles.radar, 'Enable', 'on')
%set(handles.serialStartTextBox, 'String', 'Done!');
guidata(hObject, handles);

% --- Executes on button press in radarstart.
function radarstart_Callback(radar, eventdata, handles)
% hObject    handle to radarstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(radar,'String','Stop Scan');
handles.str = get(radar,'String');
cla

    Radarcoord = [0 -25 -19 -13 -6.5 0 6.5 13 19 25; 0 9 12 14.5 15.6 16 15.6 14.5 12 9];
    axis([-10 10 -10 10])
    hold on
    title('Radar Directional Field')
    xlabel('Distance Away, Meters')
    ylabel('Distance Away, Meters')
    % setup for the plot, will title the current axes, and label the axes,
    % as well as set the limits of the plot in x and y coordinates
    
    % establish the coordinates [x;y] for use in creating the signature
    % green rings familiar to radar displays, all based off a central ring
    % with radius 2.5
    radius = 5;
    angle = 0:0.01:2*pi;
    ring1 = [((0.5*radius)*cos(angle));((0.5*radius)*sin(angle))];
    ring2 = [(radius * cos(angle));(radius*sin(angle))];
    ring3 = [((1.5*radius)*cos(angle));((1.5*radius)*sin(angle))];
    
    % plot the radar rings
    plot(ring1(1,:),ring1(2,:),'g')
    plot(ring2(1,:),ring2(2,:),'g')
    plot(ring3(1,:),ring3(2,:),'g')
    
    % define limits of initial starting point
    line([0 25],[0 25],'Color',[0 1 0]);
    line([0 -25],[0 25],'Color',[0 1 0]);
    radar = fill(Radarcoord(1,:),Radarcoord(2,:),[0 1 0]);
    set(radar,'facealpha',0.25); % set 25% opacity
    set(radar,'edgecolor','none'); % remove edges
    hold on
    rotation(ang_deg) = [cosd(ang_deg) -sind(ang_deg); sind(ang_deg) cosd(ang_deg)];
    
    d = 2;
    angle = 0:0.01:2*pi;
    locator = [((0.5*d)*cos(angle));((0.5*d)*sin(angle))];
    cursor=plot(locator(1,:),locator(2,:),'g');
    hold on
    trans(gx,gy) = [1 0 dx; 0 1 dy; 0 0 1];
    
    % while the toggle is on Stop Scan, the loop will run
    while get(radar,'String','Stop Scan')
        clear(scan) % clear previous fill from screen
        [gx,gy,gz]=readAcc(handles.accelerometer,handles.calCo); % read accel
        result = sqrt((gx.^2)+(gy.^2)+(gz.^2)); % calculate resultant
        angle = arctan(result); % calculate angle
        rotRAD = rot2_2(angle)*Radarcoord; % calculate new coord based on rotation
        set(radar,'xdata',rotRAD(1,:)) % define new radar(x)
        set(radar,'ydata',rotRAD(2,:)) % define new radar(y)
        drawnow %fill new coordinates
        pause(0.05)
        
        [gx,gy,gz]=readAcc(handles.accelerometer,handles.calCo); % read accel
        newloc=locator*trans(gx,gy);
        set(cursor,'xData',newloc(1,:));
        set(cursor,'yData',newloc(2,:));
        drawnow        
    end
set(hObject,'String','Start Radar')

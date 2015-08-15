function varargout = quadAttempt(varargin)
% QUADATTEMPT MATLAB code for quadAttempt.fig
%      QUADATTEMPT, by itself, creates a new QUADATTEMPT or raises the existing
%      singleton*.
%
%      H = QUADATTEMPT returns the handle to a new QUADATTEMPT or the handle to
%      the existing singleton*.
%
%      QUADATTEMPT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUADATTEMPT.M with the given input arguments.
%
%      QUADATTEMPT('Property','Value',...) creates a new QUADATTEMPT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before quadAttempt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to quadAttempt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help quadAttempt

% Last Modified by GUIDE v2.5 14-Aug-2015 19:27:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @quadAttempt_OpeningFcn, ...
    'gui_OutputFcn',  @quadAttempt_OutputFcn, ...
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


% --- Executes just before quadAttempt is made visible.
function quadAttempt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to quadAttempt (see VARARGIN)

% Choose default command line output for quadAttempt
handles.output = hObject;
handles.alphaValue = .5;

set(handles.start, 'Enable', 'off')
set(handles.filterButton, 'Enable', 'off')
set(handles.histButton, 'Enable', 'off')
set(handles.velocityButton, 'Enable', 'off')
set(handles.close, 'Enable', 'off')
handles.gx = 0;
handles.gy = 0;
handles.gz = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes quadAttempt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = quadAttempt_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calibrate.
function calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global accelerometer calCo comPort serialFlag
comPort = '/dev/tty.usbmodem1411';

set(handles.start, 'Enable', 'on')

[accelerometer.s, serialFlag] = setupSerial(comPort);

calCo = calibrate(accelerometer.s);
guidata(hObject, handles)


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global accelerometer calCo

set(handles.filterButton,'Enable','on') % Enables the Filter Button
set(handles.histButton, 'Enable', 'on')
set(handles.velocityButton, 'Enable', 'on')

handles.str = get(handles.start,'String');% Recognizes start button
handles.mag_raw = zeros(1,200); % Vector of 200 zeros
guidata(hObject, handles);

sFilter = zeros(200,1); %creates a vector of zeros for the initial alpha filter data
gx_vect=zeros(1,200); % Vector for gx values
vx=zeros(1,200); % Vector for x velocities
t_vect=zeros(1,200); % Vector for times

handles.tnow = 0;
handles.vxnow = 0;
tic

% Initialize data reading
if strcmp(get(handles.start,'String'),'Start') %if the start button is clicked
    set(handles.start,'String','Stop');% the string inside it changes it to a "stop" button
    
    while strcmp(get(handles.start,'String'),'Stop')
        set(handles.close, 'Enable', 'off') % Attempt to idiot-proof

        cla % Clear axis with every iteration
        
        % Raw Data Plot
        axes(handles.rollingAxis)
        title('Rolling Axis')
        [handles.gx, handles.gy, handles.gz]=readAcc(accelerometer, calCo) ; % Read data from accelerometer
        handles.mag_raw_new=sqrt(handles.gx^2+handles.gy^2+handles.gz^2); % Calculate raw magnitude
        handles.mag_raw=[handles.mag_raw(2:end) handles.mag_raw_new]; % Shift raw data vector and add new data point for rolling plots
        rollingPlot = plot(handles.mag_raw);
        set(rollingPlot, 'Ydata', handles.mag_raw)
        axis([0 200 -.5 5])
        drawnow % Update the plots
        
        % Filter
        if strcmp(get(handles.filterButton, 'String'), 'Stop Filter') && strcmp(get(handles.start, 'String'), 'Stop')
            
            sFilter_new = (1 - handles.alphaValue) * sFilter(end) + handles.alphaValue * handles.mag_raw(end);
            sFilter = [sFilter(2:end); sFilter_new];
            
            hold on
            plot1 = plot(sFilter, 'g', 'Linewidth', 2);
            set(plot1, 'Ydata', sFilter);
            hold off
            drawnow % Go ahead and update that plot
        end
        
        % Velocity Plot
        if strcmp(get(handles.velocityButton, 'String'), 'Stop Velocity') && strcmp(get(handles.start, 'String'), 'Stop')
        handles.tnow = toc;
        axes(handles.velocityAxis)
        title('Velocity Plot')
        xlabel('Time')
        ylabel('X Velocity')

        delta_t = handles.tnow - t_vect(end); % width of trapazoid
        avg_height = (handles.gx + gx_vect(end))/2; % average height of trapazoid
        area_trap = delta_t * avg_height; % area of trapazoid
        handles.vxnow = vx(end) + area_trap; % add area to previous area
        
        gx_vect=[gx_vect(2:end) handles.gx]; % Rolling gx vector
        t_vect = [t_vect(2:end) handles.tnow]; % Rolling time vector
        vx = [vx(2:end) handles.vxnow]; % rolling velocity vector
        
        hold on
        velocityPlot = plot(t_vect, vx,'g');
        set(velocityPlot, 'Ydata', vx, 'Xdata', t_vect);
        hold off
        drawnow
        
        elseif strcmp(get(handles.velocityButton, 'String'), 'Start Velocity')
        gca
        cla
        end
        
        if strcmp(get(handles.histButton, 'String'), 'Stop Histogram') && strcmp(get(handles.start, 'String'), 'Stop')
            Avg=mean(handles.mag_raw);
            StDev=std(handles.mag_raw);
            Outliers=length(handles.mag_raw(handles.mag_raw>(Avg+2*StDev)))+...
                length(handles.mag_raw(handles.mag_raw<(Avg-2*StDev))); % Number of points more than 2 standard deviations from the mean
            axes(handles.histAxis)
            title(['Data Points More than Two Standard Deviations from Mean ' num2str(Outliers)])
            xlabel('Gx Value')
            ylabel('Counts')
            
            hold on
            hist(handles.mag_raw) % histogram of gx data
            xlim([0 2])
            ylim([0 200])
            hold off
            
            drawnow % Update plots
            
        elseif strcmp(get(handles.histButton, 'String'), 'Start Histogram')
            axes(handles.histAxis)
            cla
        end
    end
    
elseif strcmp(get(handles.start, 'String'), 'Stop')
    set(handles.start, 'String', 'Start');
    set(handles.close, 'Enable', 'on')
    set(handles.filterButton, 'Enable', 'off')
    set(handles.histButton, 'Enable', 'off')
    set(handles.velocityButton, 'Enable', 'off')
end
guidata(hObject, handles);


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.str = get(handles.close,'String');
closeSerial


% --- Executes on button press in filterButton.
function filterButton_Callback(hObject, eventdata, handles)
% hObject    handle to filterButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.str = get(handles.filterButton, 'String');

if strcmp(get(handles.filterButton, 'String'), 'Start Filter')
    set(handles.filterButton, 'String', 'Stop Filter');
elseif strcmp(get(handles.filterButton, 'String'), 'Stop Filter');
    set(handles.filterButton, 'String', 'Start Filter');
end
guidata(hObject, handles);


% --- Executes on button press in histButton.
function histButton_Callback(hObject, eventdata, handles)
% hObject    handle to histButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.str = get(handles.histButton, 'String');

if strcmp(get(handles.histButton, 'String'), 'Start Histogram')
    set(handles.histButton, 'String', 'Stop Histogram');
elseif strcmp(get(handles.histButton, 'String'), 'Stop Histogram');
    set(handles.histButton, 'String', 'Start Histogram');
end
guidata(hObject, handles);


% --- Executes on button press in velocityButton.
function velocityButton_Callback(hObject, eventdata, handles)
% hObject    handle to velocityButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.str = get(handles.histButton, 'String');

if strcmp(get(handles.velocityButton, 'String'), 'Start Velocity')
    set(handles.velocityButton, 'String', 'Stop Velocity');
elseif strcmp(get(handles.velocityButton, 'String'), 'Stop Velocity');
    set(handles.velocityButton, 'String', 'Start Velocity');
end
guidata(hObject, handles);

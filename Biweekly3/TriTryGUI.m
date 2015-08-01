function varargout = TriTryGUI(varargin)
% TRITRYGUI MATLAB code for TriTryGUI.fig
%      TRITRYGUI, by itself, creates a new TRITRYGUI or raises the existing
%      singleton*.
%
%      H = TRITRYGUI returns the handle to a new TRITRYGUI or the handle to
%      the existing singleton*.
%
%      TRITRYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRITRYGUI.M with the given input arguments.
%
%      TRITRYGUI('Property','Value',...) creates a new TRITRYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TriTryGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TriTryGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TriTryGUI

% Last Modified by GUIDE v2.5 31-Jul-2015 23:22:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TriTryGUI_OpeningFcn, ...
    'gui_OutputFcn',  @TriTryGUI_OutputFcn, ...
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

% --- Executes just before TriTryGUI is made visible.
function TriTryGUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TriTryGUI (see VARARGIN)

% Choose default command line output for TriTryGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TriTryGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = TriTryGUI_OutputFcn(hObject, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Start.
function Start_Callback(hObject, ~, handles)
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
set(handles.AllowFiltering, 'Enable', 'on')
%set(handles.serialStartTextBox, 'String', 'Done!');
guidata(hObject, handles);


% --- Executes on button press in Plot.
function Plot_Callback(hObject, ~, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot
set(handles.AllowFiltering, 'Enable', 'off')

set(hObject,'String','Stop Plotting');
handles.str = get(hObject, 'String');
cla

buffer=200; %Set buffer length
mag_raw=zeros(1,buffer); % Magnitude raw data

index=1:buffer; % Index for plotting
P1=plot(index,mag_raw); % Initialize plots
hold on
legend('Raw Data')

while get(hObject, 'Value') ==  1
    
    if get(hObject, 'Value') == 0
        break
    end
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo) ; % Read data from accelerometer
    mag_raw_new=sqrt(gx^2+gy^2+gz^2); % Calculate raw magnitude
    mag_raw=[mag_raw(2:end) mag_raw_new]; % Shift raw data vector and add new data point for rolling plots
    set(P1,'ydata',mag_raw); % Update plots
    axis([0 buffer 0 2.5]); % Set axis limits
    drawnow % Update the plots
    
end
set(hObject,'String','Start Plotting')
set(handles.AllowFiltering, 'Enable', 'on')




% --- Executes on button press in SMA.
function SMA_Callback(hObject, ~, handles)
% hObject    handle to SMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject,'String','Stop SMA');
handles.str = get(hObject, 'String');
cla

if get(hObject, 'Value') ==  1
    set(handles.editable1, 'Enable', 'off')
    %     set(handles.Thresh, 'Enable', 'off')
    set(handles.RunAlphaGo, 'Enable', 'off')
    set(handles.Plot, 'Enable', 'off')
    set(handles.AllowFiltering, 'Enable', 'off')
    set(handles.Start, 'Enable', 'off')
    
else
    set(handles.editable1, 'Enable', 'on')
    %     set(handles.Thresh, 'Enable', 'on')
    set(handles.RunAlphaGo, 'Enable', 'on')
    set(handles.Plot, 'Enable', 'on')
    set(handles.AllowFiltering, 'Enable', 'on')
    set(handles.Start, 'Enable', 'on')
end

buffer=200; %Set buffer length
mag_raw=zeros(1,buffer); % Magnitude raw data
mag_filt=zeros(1,buffer); % Magnitude filtered data
index=1:buffer; % Index for plotting
taps=str2double(get(handles.editable2)); % Window size for SMA


P1=plot(index,mag_raw); % Initialize plots
hold on
P2=plot(index,mag_filt,'r','Linewidth',2);
legend('Raw Data','Filtered Data')
threshold=1.5; % Set threshold
x = plot([0, buffer],[threshold, threshold],'g','Linewidth',3); % Plot threshold line

count=0; % Variable to count threshold crossings
global Thresh
while get(hObject, 'Value') ==  1

    get(handles.Thresh, 'Value')
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo) ; % Read data from accelerometer
    mag_raw_new=sqrt(gx^2+gy^2+gz^2); % Calculate raw magnitude
    mag_raw=[mag_raw(2:end) mag_raw_new]; % Shift raw data vector and add new data point for rolling plots
    
    mag_filt_new=mean(mag_raw(end-taps+1:end)); % Calculate average of last tap number of points for SMA
    mag_filt=[mag_filt(2:end) mag_filt_new]; % Shift filtered vector over and add new filtered data point
    
    set(P1,'ydata',mag_raw); % Update plots
    set(P2,'ydata',mag_filt);
    axis([0 buffer 0 2.5]); % Set axis limits
    if Thresh == 1
        x = plot([0, buffer],[threshold, threshold],'g','Linewidth',3); % Plot threshold line
        x
        if mag_filt_new>threshold && mag_filt(end-1)<threshold % If current point is above threshold, and last point was below threshold
            count=count+1; % Add to count
        end
    else
        delete(x)
    end
    title(['Threshold Crossings = ' num2str(count)]) % Title displays threshold counts
    drawnow % Update the plots
    
end
set(hObject,'String','Start SMA')

% --- Executes on button press in Exit.
function Exit_Callback(hObject, ~, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial
close all

% --- Executes on button press in Thresh.
function Thresh_Callback(hObject, ~, handles)
% hObject    handle to Thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Thresh
global Thresh
Thresh = get(hObject,'Value');

function editable1_Callback(hObject, ~, handles)
% hObject    handle to editable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editable1 as text
%        str2double(get(hObject,'String')) returns contents of editable1 as a double


% --- Executes during object creation, after setting all properties.
function editable1_CreateFcn(hObject, ~, handles)
% hObject    handle to editable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject, 'String', .5)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in RunAlphaGo.
function RunAlphaGo_Callback(hObject, ~, handles)
% hObject    handle to RunAlphaGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
ALPHA= str2double(get(handles.editable1));

if get(hObject, 'Value') ==  1
    set(handles.editable1, 'Enable', 'off')
    set(handles.SMA, 'Enable', 'off')
    set(handles.Plot, 'Enable', 'off')
    set(handles.AllowFiltering, 'Enable', 'off')
    set(handles.Start, 'Enable', 'off')
    
    
else
    set(handles.editable1, 'Enable', 'on')
    set(handles.SMA, 'Enable', 'on')
    set(handles.Plot, 'Enable', 'on')
    set(handles.AllowFiltering, 'Enable', 'on')
    set(handles.Start, 'Enable', 'on')
    
end

tval=2;
while tval > 1  % make sure there is an angle inside parameters
    if ALPHA > 1
        set(handles.Alpha1,'String','Alpha is too small. Enter a larger value.');
        guidata(hObject, handles);% Update handles variables
        break
        
    elseif ALPHA < 0
        set(handles.Alpha1,'String','Alpha is too small. Enter a larger value.');
        guidata(hObject, handles);% Update handles variables
        break
        
    else
        tval=0; % If input is inside parameters, this lets program continue to next step
    end
end
buffer =str2double(get(handles.editable3));
index = 1:buffer;
s=zeros(buffer,1);
sfilt=zeros(buffer,1);

AlphaStyleRaw=plot(index, s, 'b');
hold on
AlphaStyleFilt=plot(index, sfilt, 'm', 'LineWidth', 2);

axis([0 200 0 2.5]); % Defines axes
axes(handles.axes1)
xlabel('Rolling Time')
ylabel('Magnitude')
count = 0;
global Thresh 
x = plot([0, buffer],[threshold, threshold],'g','Linewidth',3); % Plot threshold line

while get(hObject, 'value') == 1
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo); %get data from accel
    xRead=sqrt(gx^2+gy^2+gz^2); % Calculate raw magnitude of raw data
    s=[s(2:end); xRead]; % raw data into set
    
    % FILTERED AREA 51
    sfilt_new=(1-ALPHA)*(sfilt(end))+(ALPHA*xRead); % calculating filtered value
    sfilt=[sfilt(2:end); sfilt_new]; % entering filtered data into
    
    if Thresh == 1
        x
        if sfilt_new>threshold && sfilt(end-1)<threshold % If current point is above threshold, and last point was below threshold
            count=count+1; % Add to count
        end
    else
        delete(x)
    end
    title(['Threshold Crossings = ' num2str(count)]) % Title displays threshold counts
    
    set(AlphaStyleRaw,'ydata',s); % plotting raw dataset
    set(AlphaStyleFilt,'ydata',sfilt);% plotting filtered dataset
    drawnow
end

guidata(hObject, handles);% Update handles variables


% --- Executes on button press in AllowFiltering.
function AllowFiltering_Callback(hObject, ~, handles)
% hObject    handle to AllowFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AllowFiltering
set(hObject,'String','Do not use filtering');
handles.str = get(hObject, 'String');

if get(hObject, 'Value') ==  1
    set(handles.editable1, 'Enable', 'on')
    set(handles.RunAlphaGo, 'Enable', 'on')
    set(handles.Thresh, 'Enable', 'on')
    set(handles.SMA, 'Enable', 'on')
else
    set(handles.editable1, 'Enable', 'off')
    set(handles.RunAlphaGo, 'Enable', 'off')
    set(handles.Thresh, 'Enable', 'off')
    set(handles.SMA, 'Enable', 'off')
end
guidata(hObject, handles);



function editable2_Callback(hObject, eventdata, handles)
% hObject    handle to editable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editable2 as text
%        str2double(get(hObject,'String')) returns contents of editable2 as a double


% --- Executes during object creation, after setting all properties.
function editable2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject, 'String', 5)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editable3_Callback(hObject, eventdata, handles)
% hObject    handle to editable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editable3 as text
%        str2double(get(hObject,'String')) returns contents of editable3 as a double


% --- Executes during object creation, after setting all properties.
function editable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject, 'String', 1)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

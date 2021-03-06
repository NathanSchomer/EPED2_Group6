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

% global accelerometer calCo comPort
% comPort = '/dev/tty.usbmodem1411';
% [accelerometer.s, ~] = setupSerial(comPort);
% calCo = calibrate(accelerometer.s);

axes(handles.videoFeed)
title('Video Feed')

axes(handles.cameraVisual)
title('Camera Visualization')

axes(handles.testAxes)
title('Rolling Data')

guidata(hObject, handles); % Updates handles structure

% --- Outputs from this function are returned to the command line.
function varargout = Section75Group10App_OutputFcn(~,~,handles)
varargout{1} = handles.output;

% --- Executes on button press in start.
function start_Callback(hObject,~,handles) %#ok<*DEFNU> % For some reason gets rid of that error

global accelerometer calCo

handles.mag_raw = zeros(1, 200);
yfilter = zeros(200, 1);
xfilter = zeros(200, 1);
handles.gx_vector = zeros(1, 200); % Buffer spacing
handles.gy_vector = zeros(1, 200); % Buffer spacing
handles.alphaValue = .1; % Alpha Value for filtering

% Initialize threshold values
thresh1 = 1.0;
thresh2 = 1.5;
thresh3 = -1.0;
thresh4 = -1.5;

% Initialize threshold counts to zero
% Even numbers are positive threshold counts, odd numbers are negative
[xcount1, xcount2, xcount3, xcount4, ycount1, ycount2, ycount3, ycount4] = deal(0);

% axes(handles.testAxes)
% axis([0 200 -3 3])
% hold on

% Set up plots
y_filtered = plot(yfilter, 'g', 'Linewidth', 2); % Plot for x and y filtered values
x_filtered = plot(xfilter, 'r', 'Linewidth', 2);

% Plot thresholds (visual representation, of no actual importance to data)
% plot([0, 200], [thresh1, thresh1], 'k', 'Linewidth', 1); % Plot first positive threshold line
% plot([0, 200], [thresh2, thresh2], 'k', 'Linewidth', 1); % Plot second positive threshold line
% plot([0, 200], [thresh3, thresh3], 'k', 'Linewidth', 1); % Plot first negative threshold line
% plot([0, 200], [thresh4, thresh4], 'k', 'Linewidth', 1); % Plot second negative threshold line

axes(handles.videoFeed)
cam = webcam;
img = snapshot(cam);
handles.screenshot = imshow(img);
%setup control arduino and servos
a = arduino('/dev/cu.usbserial-A8004ITT', 'uno', 'Libraries', 'Servo');
tiltServo = servo(a, 'D10');
panServo  = servo(a,  'D9');

% Write initial servo positions
writePosition(tiltServo, 0.44) % Keep between .22 and .65
writePosition(panServo, 0.51) % Keep between .3 and .75

if strcmp(get(handles.start,'String'),'Start') % If the start button is clicked
    set(handles.start,'String','Stop'); % Change string to 'Stop'
    while strcmp(get(handles.start,'String'),'Stop')
        
        get(handles.resetButton, 'Value')
        get(handles.freezeButton, 'Value')
        
        handles.screenshot = imshow(img);
        
        % Reset the platform position to the original value
        while handles.resetButton == 1
            writePosition(tiltServo, 0.44)
            writePosition(panServo, 0.51)
        end
        
        % Freeze the platform 
        while get(handles.freezeButton, 'Value') == 1
            writePosition(tiltServo, tiltServo)
            writePosition(panServo, panServo)
        end
        
        % Read Accelerometer
        [handles.gx, handles.gy, handles.gz]=readAcc(accelerometer, calCo) ; % Read data from accelerometer
        handles.gx_vector = [handles.gx_vector(2:end) handles.gx]; % Update X for rolling plot
        handles.gy_vector = [handles.gy_vector(2:end) handles.gy]; % Update Y for rolling plot
        
        % Alpha filtering of the X and Y data
        new_yfilter = (1 - handles.alphaValue) * yfilter(end) + handles.alphaValue * handles.gy_vector(end);
        yfilter = [yfilter(2:end); new_yfilter];
        
        new_xfilter = (1 - handles.alphaValue) * xfilter(end) + handles.alphaValue * handles.gx_vector(end);
        xfilter = [xfilter(2:end); new_xfilter];
        
        %Update plots
        set(x_filtered, 'ydata', xfilter)
        set(y_filtered, 'ydata', yfilter)
        
        if(new_xfilter >= 0 && new_xfilter <= 1)
            writePosition(panServo, new_xfilter)
        end
        
        if(new_yfilter >= 0 && new_yfilter <= 1)
            writePosition(tiltServo, new_yfilter)
        end
        
        % Analyze filtered data to utilize thresholds
        if new_xfilter > thresh1 && xfilter(end-1) < thresh1
            xcount1 = xcount1 + 1;
        end
        if new_xfilter > thresh2 && xfilter(end-1) < thresh2
            xcount2 = xcount2 + 1;
        end
        if new_xfilter < thresh3 && xfilter(end-1) > thresh3
            xcount3 = xcount3 + 1;
        end
        if new_xfilter < thresh4 && xfilter(end-1) > thresh4
            xcount4 = xcount4 + 1;
        end
        if new_yfilter > thresh1 && yfilter(end-1) < thresh1
            ycount1 = ycount1 + 1;
        end
        if new_yfilter > thresh2 && yfilter(end-1) < thresh2
            ycount2 = ycount2 + 1;
        end
        if new_yfilter < thresh3 && yfilter(end-1) > thresh3
            ycount3 = ycount3 + 1;
        end
        if new_yfilter < thresh4 && yfilter(end-1) > thresh4
            ycount4 = ycount4 + 1;
        end
        
        % Set title to display amount of times thresholds have been crossed
        % For Nate: "xt1" = Number of times the x value crosses the
        % first positive threshold
        title(['xt1: ' num2str(xcount1) ' ', 'xt2: ' num2str(xcount2) ' ', 'xt3: ' num2str(xcount3) ' ',...
            'xt4: ' num2str(xcount4) ' ', 'yt1: ' num2str(ycount1) ' ', 'yt2: ' num2str(ycount2) ' ',...
            'yt3: ' num2str(ycount3) ' ', 'yt4: ' num2str(ycount4) ' '])
        
        drawnow % Go ahead and draw that plot
    end
    
elseif strcmp(get(handles.start, 'String'), 'Stop') % If the string changes
    set(handles.start, 'String', 'Start'); % Set the value to start and clear the axis
    cla
    
end
guidata(hObject, handles)

% Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(~,~,~)
closeSerial

% --- Executes on button press in instruct.
function instruct_Callback(hObject,~, handles) %#ok<*DEFNU>
% hObject    handle to instruct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.instruct=hObject;

handles.dialog1=msgbox('These are instructions on how to operate the camera assembly');
uiwait(handles.dialog1)

handles.dialog2=msgbox('When you have read through the directions on each page, you can click OK to proceed.');
uiwait(handles.dialog2)

handles.dialog3=msgbox('Hold the accelerometer flat along the x-y plane such that the z-axis faces upward','Positioning');
uiwait(handles.dialog3)
% can add in some threshold here to ensure accelerometer is level?
% [handles.gx, handles.gy, handles.gz]=readAcc(accelerometer, calCo);
% handles.result=(handles.gx^2+handles.gy^2+handles.gz^2);
% while handles.result<1
%    uiwait(handles.dialog2)
% end

handles.dialog4=msgbox('To control the rotation of the servo, tilt the accelerometer about the x-axis.');
uiwait(handles.dialog4)

handles.dialog5=msgbox('Note, servo rotation will be controlled only by input and not locked in place.');
uiwait(handles.dialog5)


handles.dialogF=msgbox('Now you know how to operate the camera module.');
uiwait(handles.dialogF)

% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, ~, handles)
handles.resetButton = get(hObject, 'Value');

% --- Executes on button press in freezeButton.
function freezeButton_Callback(hObject, ~, handles)
handles.freezeButton = get(hObject, 'Value');
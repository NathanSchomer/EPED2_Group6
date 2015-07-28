%% EPED 2 GUI Archive
clear
close all
clc
%% Calibrate Function 

% --- Executes on button press in Calibrate.
% function Calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to Calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~exist('handles.calCo', 'var'))
    handles.calCo = calibrate(handles.accelerometer.s);
end
% set(handles.calibrateTextBox, 'String', 'Done!');
% Update handles structure
guidata(hObject, handles);

%% Draw Circle (slightly malfunctioning)

% --- Executes on button press in Plot_Circle.
% function Plot_Circle_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

circle_vector = (0:360);
x = cosd(circle_vector);
y = sind(circle_vector);
tic;
circle = fill(x, y, [0 0 1]);

while strcmp(handles.str, 'Start')
    axes(handles.axes2)
    axis([-1.5 1.5 -1.5 1.5])
    [gx, gy, gz]=readAcc(handles.accelerometer,handles.calCo);
    rotate(circle,[gx, gy], 'origin')
end

%% Push Button Test Example (From Week 4 Lecture)
% --- Executes on button press in pushbutton6.
% function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.str = get(handles.pushbutton6, 'String');

if strcmp(handles.str, 'Start')
    set(handles.pushbutton6, 'String', 'Stop')
    guidata(hObject, handles);
else
    set(handles.pushbutton6, 'String', 'Start')
    guidata(hObject, handles);
end

%% Draws 3D axes
% --- Executes on button press in Plot.
% function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject,'String','Stop');
handles.str = get(hObject, 'String');

while get(hObject, 'Value') ==  1
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



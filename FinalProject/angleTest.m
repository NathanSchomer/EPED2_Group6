    % while the toggle is on Stop Scan, the loop will run
    while get(radar,'String','Stop Scan')
        
	    clear(scan) % clear previous fill from screen
        
	[gx,gy,gz]=readAcc(handles.accelerometer,handles.calCo); % read accel
        result = sqrt((gx.^2)+(gy.^2)+(gz.^2)); % calculate resultant
        
	angle = arctan(result); % calculate angle (pitch)
	angle2 = arccos(angle);
        
	rotRAD = rot2_2(angle)*Radarcoord; % calculate new coord based on rotation
        set(radar,'xdata',rotRAD(1,:)) % define new radar(x)
        set(radar,'ydata',rotRAD(2,:)) % define new radar(y)
        drawnow %fill new coordinates
        pause(0.05)
        
        [gx,gy,gz]=readAcc(handles.accelerometer,handles.calCo); % read accel
        newloc=locator*trans(gx,gy);
    end

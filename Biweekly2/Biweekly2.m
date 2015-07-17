clear
close all
clc

%setup serial communication
comPort='COM6'; 
[accelerometer.s,flag]=setupSerial(comPort);

%calibrate accel
calCo = calibrate(accelerometer.s);
 
tic;
 
 
%%1A
%first plot in window
subplot(2, 1, 1)

%run for 10 seconds
while toc < 10
    cla		%clear axes
    [x_curr, y_curr, z_curr]=readAcc(accelerometer,calCo)	%get data from accel

    %plot x, y and z as individual compoenents
    line([0 x_curr],[0 0],[0 0],'Linewidth',2, 'color', 'b')
    line([0 0],[0 y_curr],[0 0],'Linewidth',2, 'color', 'r')
    line([0 0],[0 0],[0 z_curr],'Linewidth',2, 'color', 'g')

    %plot the resultant vector of x, y and z
    line([0 x_curr], [0 y_curr], [0 z_curr], 'Linewidth', 4, 'color', 'k');

    %plot settings and labels
    axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
    drawnow;
    grid on
    title('3D Representation')
    xlabel('x')
    ylabel('y')
    zlabel('z')
end

%%1B
tic = 0;	%set timer back to zero

%variable to store data from accel
Gx=rand(1,50);
Gy=rand(1,50);
Gz=rand(1,50);
Rezult=rand(1,50);

%second plot in window
subplot(2, 1, 2)

%run for 40 seconds
while toc < 40
    cla		%clear axes
    [gx, gy, gz]=readAcc(accelerometer,calCo)
   
    %calculate resultant 
    result=sqrt((gx^2)+(gy^2)+(gz^2));
    Gx=[Gx(2:end) gx];
    Gy=[Gy(2:end) gy];
    Gz=[Gz(2:end) gz];
    Rezult=[Rezult(2:end) result];
    
    %Plot data
    plot(Gx,'b')
    hold on
    plot(Gy,'r')
    plot(Gz,'g')
    plot(Rezult,'k')
    drawnow

    %Plot settings, labels and legend
    axis([0 50 -1.5 1.5])
    title('Rolling Plot')
    xlabel('time')
    ylabel('value')
    legend('x value','y value','z value','resultant value','location','best')
    grid on

end

%close the port
closeSerial

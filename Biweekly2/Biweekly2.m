%%Part 1
clear
close all
clc
%%Part 1
 %setup serial communication
 comPort='COM6'; 
 % chandler /dev/tty.usbmodem1421
 % bobby COM6
 [accelerometer.s,flag]=setupSerial(comPort);
 
 %calibrate accel
 calCo = calibrate(accelerometer.s);
 
 tic;
 
 
%%1A 
subplot(2, 1, 1)
while toc < 10
    cla
    [x_curr, y_curr, z_curr]=readAcc(accelerometer,calCo)

    line([0 x_curr],[0 0],[0 0],'Linewidth',2, 'color', 'b')
    line([0 0],[0 y_curr],[0 0],'Linewidth',2, 'color', 'r')
    line([0 0],[0 0],[0 z_curr],'Linewidth',2, 'color', 'g')
    line([0 x_curr], [0 y_curr], [0 z_curr], 'Linewidth', 4, 'color', 'k');

    axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
    drawnow;
    grid on
    title('3D Representation')
    xlabel('x')
    ylabel('y')
    zlabel('z')
end

%%1B
tic = 0;
Gx=rand(1,50);
Gy=rand(1,50);
Gz=rand(1,50);
Rezult=rand(1,50);


subplot(2, 1, 2)
while toc < 40
    cla
    [gx, gy, gz]=readAcc(accelerometer,calCo)
    result=sqrt((gx^2)+(gy^2)+(gz^2));
    Gx=[Gx(2:end) gx];
    Gy=[Gy(2:end) gy];
    Gz=[Gz(2:end) gz];
    Rezult=[Rezult(2:end) result];
    plot(Gx,'b')
    hold on
    plot(Gy,'r')
    plot(Gz,'g')
    plot(Rezult,'k')
    drawnow
    axis([0 50 -1.5 1.5])
    title('Rolling Plot')
    xlabel('time')
    ylabel('value')
    legend('x value','y value','z value','resultant value','location','best')
    grid on

end


% %% 
% for n=1:100
%     [gx, gy, gz]=readAcc(accelerometer,calCo)
%     cla %Slow way of replotting
%     line([gx 0 0],[0 0 0],[0 0 0],'Linewidth',2)
%     line([0 0 0],[0 gy 0],[0 0 0],'Linewidth',2)
%     line([0 0 0],[0 0 0],[0 0 gz],'Linewidth',2)
%     axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
%     %plot3(x,y,z)
%     drawnow;
% end
%  
%  while toc < 10 
%      [x, y, z]=readAcc(accelerometer,calCo);
%     % fprintf('%d, %d, %d\n', x, y, x)
%      cla
%      %line([x y z],[0 0 0], 'Linewidth', 2)
%      
%      %line([0 x],[0 0], 'Linewidth', 2)
%      line([x 0 0],[0 0 0], 'Linewidth', 2)
%      line([0 y 0],[0 0 0], 'Linewidth', 2)
%      line([0 0 z],[0 0 0], 'Linewidth', 2)
%      
%      
%      
%      axis([-1.5 1.5 -1.5 1.5]);
%      %closeplot3(x,y,z)
%  end
 
 
 %close serial port
 closeSerial
 
 
 
 %b. Plot data on rolling plot
 %c. circular cursor. y-axis: up and down, x-axis: left and right
 %d. stop sampling accel data (& close serial port)
 
 

%%Part 1
clear
close all
clc
%%Part 1
 %setup serial communication
 comPort='/dev/tty.usbmodem1421'; 
 [accelerometer.s,flag]=setupSerial(comPort);
 
 %calibrate accel
 calCo = calibrate(accelerometer.s);
 
 tic;
 
 
%%1A 
x_tot = 0;
y_tot = 0;
z_tot = 0;

subplot(2, 1, 1)
while toc < 2
    [x_curr, y_curr, z_curr]=readAcc(accelerometer,calCo)
    x_tot = x_tot + x_curr;
    y_tot = y_tot + y_curr;
    z_tot = z_tot + z_curr;
end

line([0 x_tot],[0 0],[0 0],'Linewidth',2, 'color', 'b')
line([0 0],[0 y_tot],[0 0],'Linewidth',2, 'color', 'r')
line([0 0],[0 0],[0 z_tot],'Linewidth',2, 'color', 'g')
line([0 x_tot], [0 y_tot], [0 z_tot], 'Linewidth', 4, 'color', 'k');


axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
drawnow;

%%1B
tic = 0;

subplot(2, 1, 2)
while toc < 100
    [gx, gy, gz]=readAcc(accelerometer,calCo)
    cla %Slow way of replotting
    line([0 gx],[0 0],[0 0],'Linewidth',2, 'color', 'b')
    line([0 0],[0 gy],[0 0],'Linewidth',2, 'color', 'g')
    line([0 0],[0 0],[0 gz],'Linewidth',2, 'color', 'r')
    line([0 gx], [0 gy], [0 gz], 'Linewidth', 4, 'color', 'k');
    axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    drawnow;
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
 
 

function [x] = launchMotion(startAng,initVel)
% Define ball
angball=0:359;
xball=cosd(angball);
yball=sind(angball);
% Initial conditions
t=0;
y=2;

% Movement of ball
while y>0
y=(initVel*(sind(startAng))*t)-((.5*9.81)*(t^2))+2; % position equations
x=(initVel*cosd(startAng))*t;
xMovBall=x+xball; % position change for ball
yMovBall=y+yball;
fill(xMovBall,yMovBall,'g'); % defines ball in motion
grid on
axis([-1 100 -1 100])
title('Projectile Motion')
xlabel('Distance(m)')
ylabel('Height(m)')
pause(.00001) %allows visual of motion
t=t+.01;
end
end


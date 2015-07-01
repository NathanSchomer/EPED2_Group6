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
y=(initVel*(sind(startAng))*t)-((.5*9.81)*(t^2))+2;
x=(initVel*cosd(startAng))*t;
xMovBall=x+xball;
yMovBall=y+yball;
fill(xMovBall,yMovBall,'g');
axis([-1 100 -1 100])
xlabel('Distance')
ylabel('Height')
pause(.00001)
t=t+.01;
end
end


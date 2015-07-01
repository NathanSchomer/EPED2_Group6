%% 5a

% define start angle
launchAng=input('enter launch angle between 0 and 90 degrees:\n');
t=2;
while t > 1
if launchAng > 90
    launchAng = input('Please choose a lower number:\n');
elseif launchAng < 0 
    launchAng = input('Please choose a higher number:\n');
else
    t=0;
end
end

% define start velocity
launchVel=input('enter launch speed between 0 and 20 m/s:\n');
w=2;
while w > 1
if launchAng > 90
    launchAng = input('Please choose a lower number:\n');
elseif launchAng < 0 
    launchAng = input('Please choose a higher number:\n');
else
    w=0;
end
end
% launch ball
xHit=launchMotion(launchAng,launchVel);



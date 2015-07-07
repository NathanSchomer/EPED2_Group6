%% Question 5a

% define start angle
launchAng=input('enter launch angle between 0 and 90 degrees:\n');
t=2;
while t > 1  % make sure there is an angle inside parameters
if launchAng > 90
    launchAng = input('Please choose a lower number:\n');  % asks again if prior input was too large
elseif launchAng < 0 
    launchAng = input('Please choose a higher number:\n');  % asks again if prior input was too small
else
    t=0; % if input is inside parameters, this lets program continue to next input step
end
end

% define start velocity
launchVel=input('enter launch speed between 0 and 20 m/s:\n');
w=2;
while w > 1   % make sure there is a velocity inside parameters
if launchVel > 20
    launchVel = input('Please choose a lower number:\n'); % asks again if prior input was too large
elseif launchVel < 0 
    launchVel = input('Please choose a higher number:\n'); % asks again if prior input was too small
else
    w=0;  % if input is inside parameters, this lets program continue to launch function
end
end
% launch ball
xHit=launchMotion(launchAng,launchVel);
fprintf('The ball traveled %.2f meters.',xHit) % displays distance traveled 
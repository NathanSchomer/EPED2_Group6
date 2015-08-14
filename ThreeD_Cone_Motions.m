
% Define shape: cone
[xcyl,ycyl,zcyl]=cylinder([0 1],20);
zcyl=(zcyl*3);
Conic=surface(xcyl,ycyl,zcyl,'facecolor','g');

% define axes and 3D space
axis([-15 15 -15 15 -5 30]);
view(3)
grid on
drawnow

Cc=hgtransform('Parent',gca); % Make transform object
set(Conic,'Parent',Cc); % Make cone a transform object


% First motion is translation
title('X-Translate')
for t=1:10
    Xmov=makehgtform('translate', [t 0 0]);
    set(Cc,'Matrix',Xmov); % Translate in x direction
    pause(.2)
end

title('Y-Translate')
for t=1:10
    Ymov=makehgtform('translate', [0 t 0]);
    set(Cc,'Matrix',Ymov); % Translate in y direction
    pause(.2)
end

title('Z-Translate')
for t=1:10
    Zmov=makehgtform('translate', [0 0 t]);
    set(Cc,'Matrix',Zmov); % Translate in z direction
    pause(.2)
end

title('Rotate about X axis')
pause(1) % pause for switching motion to rotating

for t=1:25
    Xrot=makehgtform('xrotate',1.25*t);
    set(Cc,'Matrix',Xrot);% Rotates cone about x axis
    pause(.1)
end

title('Rotate about Y axis')
pause(1)
for t=1:25
    Yrot=makehgtform('yrotate',1.25*t);
    set(Cc,'Matrix',Yrot);% Rotates cone about y axis
    pause(.1)
end

title('Rotate about Z axis')
pause(1)
for t=1:25
    Zrot=makehgtform('zrotate',3*t);
    set(Cc,'Matrix',Zrot);% Rotates cone about z axis
    pause(.2)
end

title('Scale for elongation')
pause(1) % pause for switching motion to scaling

for t=1:10
    growlong=makehgtform('scale',[1 1 t]);
    set(Cc,'Matrix',growlong);% elongates cone
    pause(.2)
end

title('Scale for scale for dilation')
for t=1:10
    growopening=makehgtform('scale',[t t 1]);
    set(Cc,'Matrix',growopening);% widens opening of cone
    pause(.2)
end
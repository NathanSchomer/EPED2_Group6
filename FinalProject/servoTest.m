clear
a = arduino('/dev/cu.usbserial-A8004ITT', 'uno', 'Libraries', 'Servo');
%a = arduino();
s = servo(a, 'D10') %pivot between 0 and 1
s2 = servo(a, 'D9') %pivot between 0 and 0.46

while(1)
    writePosition(s,0)
    writePosition(s2,0)
    for angle = 0:0.05:1
        writePosition(s,angle)
        writePosition(s2,angle)
	pause(1)
    end
    for angle = 1:0.05:0
        writePosition(s,angle)
        writePosition(s2,angle)
	pause(1)
    end
end

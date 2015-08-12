clear
a = arduino('/dev/cu.usbserial-A8004ITT', 'uno', 'Libraries', 'Servo');
%a = arduino();
s = servo(a, 'D10')

while(1)
    fprintf('test')
    writePosition(s,0)
    for angle = 0:0.2:1
        writePosition(s,angle)
        pause(1)
    end
    for angle = 1:0.2:0
        writePosition(s,angle)
        pause(1)
    end
end
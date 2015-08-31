SEC75_GROUP10_README.TXT

ENGR 202 - SECTION 075
GROUP 10
BENSON-REID, CHANDLER
BRANDIMARTE, CHRISTOPHER
HERMANN ROBERT

>>>> INSTRUCTIONS FOR USE OF GIMBAL CONTROL

>> It is advised that you use this file while running the application the first time. A good approach, for 
novice users to a 
  webcam UI control system, would be to leave this txt file open while you run the application. Users 
with previous experience 
  using an accelerometer-Arduino pair should rely purely on the in-built instructions UI included with the 
application package.

>> SUPPORT NEEDED

>> >> The basis of this application is to allow control of the included servo gimbal via the input from the 
accelerometer. To 
  run this software, ensure that the application package includes the following physical items...
	>> 2x Arduino developer boards with female USB port
	>> 1x Accelerometer with male USB cable
	>> MAC computer with installed drivers for external webcam access via MATLAB
	>> Servo gimbal assembly with SONY ( C ) PS EYE 0048 Camera
>> >> Once you have these items, ensure the software package includes the following files when 
installed to your computer's 
MATLAB directory...
	>> calibrate.m
	>> setupSerial.m
	>> readAcc.m
	>> closeSerial.m
	>> Section75Group10App.m
	>> Section75Group10App.fig

>> SETUP AND CONTROL

>> >> After opening the file Section75Group10App.m in MATLAB, you will see a pop-up window. This 
window will display the view from the webcam and a plot of the data input (acceleration) given from the 
accelerometer. At the left is a UI-based instructions manual that allows the user step-based tutorial in 
using the accelerometer to control the gimbal assembly. The pitch is easy to control, and is direct from 
the pitch with respect to the x-y plane. Rotation requires the use of roll about the longitudinal axis of 
the accelerometer. Although it would seem more logical to directly take roll from the acceleromter, the 
rear wire prohibits the user from full freedom of rotation. This required the use of the roll about the 
accelerometer's latteral axis to control rotation about the the z-axis of the gimbal.

>> TIPS FOR USE

	>> When running the application, know that it is important that none of the wires tangle or become 
	strained to the point of breakage, as this will negatively affect the equipment.

	>> Do not leave the application without ensuring the serial port, identified as USB Modem 1421 on 
	the MAC, is closed. This can be done via a supplementary function such as scanComPorts.m.

	>> When closing the application, ensure that the system is not continuing to intake data from the
	accelerometer by checking the MATLAB command window.

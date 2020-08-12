# control_system
# This is task assigned by E_yantra IIT bombey in round 2
1) In this task we have implemented the frequency filters through coding in
Octave. here “sensor_data.csv” contains readings from sensor module named GY-87 which is a
9-DOF motion sensor. These readings are obtained from 12 registers. These readings are taken at an interval of 10 milliseconds. These readings help us find out the tilt of the body on which the sensor is mounted.
Readings of registers from Sr. No. 1 to 6 in the Table 1 are from the
Accelerometer present in the sensor module. Similarly, readings of registers from Sr. No. 7 to 12 in the Table 1 are from the Gyroscope. Accelerometer and Gyroscope in
the GY-87 sensor module gives us readings for all three axes (X, Y and Z). 
Using these data we have computed Pitch and Roll by implementing the concept of Complementary Filter on the values filtered by lowpassfilter & highpassfilter.
theory https://drive.google.com/file/d/12AXD9h-kqCc8qqgwxgwGHYE5vnm_XG6p/view?usp=sharing
https://github.com/amritanjali123/control_system/blob/master/S-2.m
first cl]oli\umn contans pitch second roll.
2) In this task, we have implemented Pole Placement Controller and the LQR
controller on different types of physical systems. we have find out the
equations of motion for each of the physical systems.
theory:
https://github.com/amritanjali123/control_system/blob/master/1_Mathematical_Modelling_of_System.pdf
simple Pendulum:
https://github.com/amritanjali123/control_system/blob/master/Simple_Pendulum.m
spring mass system:
https://github.com/amritanjali123/control_system/blob/master/Mass_Spring_System.m
Cart_Pendulum: 
https://github.com/amritanjali123/control_system/blob/master/Cart_Pendulum.m
simple pully:
https://github.com/amritanjali123/control_system/blob/master/Simple_Pulley.m
complex pully:
https://github.com/amritanjali123/control_system/blob/master/Complex_Pulley.m

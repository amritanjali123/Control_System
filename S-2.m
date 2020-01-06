                       #######################
####### PLEASE CLEAR THEWORKSPACE BEFORE RUNNING THE CODE ############
                       #######################
1;
global A = csvread('csv_matter.csv');  #do not change this line
################################################
#######Declare your global variables here#######
################################################
global lyx=0;
global lyy=0;
global lyz=0;
global hyx=0;
global hyy=0;
global hyz=0;
global gx_in=0;
global gy_in=0;
global gz_in=0;
global p=0;
global r=0;


function read_accel(axl,axh,ayl,ayh,azl,azh)  
  axl=dec2bin(axl, 8);
  axh=dec2bin(axh, 8);
  ayl=dec2bin(ayl, 8);
  ayh=dec2bin(ayh, 8);
  azl=dec2bin(azl, 8);
  azh=dec2bin(azh, 8);
 
  ax=[axh,axl];
  ay=[ayh,ayl];
  az=[azh,azl];
 
  ax=bin2dec(ax);
  ay=bin2dec(ay);
  az=bin2dec(az);
 
  if(ax>32767)
   ax=(ax-65536);
  endif
  if(ay>32767)
   ay=(ay-65536);
  endif
  if(az>32767)
   az=(az-65536);
  endif
  #scaling +-2
  ax=ax/16384;
  ay=ay/16384;
  az=az/16384;
  f_cut=5;
  lowpassfilter(ax,ay,az,f_cut);
 
  #################################################
  ####### Write a code here to combine the ########
  #### HIGH and LOW values from ACCELEROMETER #####
  #################################################


  ####################################################
  # Call function lowpassfilter(ax,ay,az,f_cut) here #
  ####################################################

endfunction

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  gxl=dec2bin(gxl, 8);
  gxh=dec2bin(gxh, 8);
  gyl=dec2bin(gyl, 8);
  gyh=dec2bin(gyh, 8);
  gzl=dec2bin(gzl, 8);
  gzh=dec2bin(gzh, 8);
 
  gx=[gxh,gxl];
  gy=[gyh,gyl];
  gz=[gzh,gzl];
 
  gx=bin2dec(gx);
  gy=bin2dec(gy);
  gz=bin2dec(gz);
  f_cut=5;
  if(gx>32767)
   gx=(gx-65536);
  endif
  if(gy>32767)
   gy=(gy-65536);
  endif
  if(gz>32767)
   gz=(gz-65536);
  endif
  #scaling +-250
  gx=gx/131;
  gy=gy/131;
  gz=gz/131;
  
  highpassfilter(gx,gy,gz,f_cut);
 
 
  #################################################
  ####### Write a code here to combine the ########
  ###### HIGH and LOW values from GYROSCOPE #######
  #################################################


  #####################################################
  # Call function highpassfilter(ax,ay,az,f_cut) here #
  #####################################################;

endfunction



function lowpassfilter(ax,ay,az,f_cut)
  dT = 0.01;  #time in seconds
  Tau=1/(2*pi*f_cut) ;
  alpha = Tau/(Tau+dT);                #do not change this line
  #disp(alpha);
  ################################################
  ##############Write your code here##############
  ################################################
  global lyx;
  global lyy;
  global lyz;
  global gx;
  global gy;
  global gz;
  global acc;
  global gyro;
  global lyx_in;
  global lyy_in;
  global lyz_in;
  lyx = (1-alpha)*ax + alpha*lyx;
  lyy = (1-alpha)*ay + alpha*lyy;
  lyz = (1-alpha)*az + alpha*lyz;

endfunction



function highpassfilter(gx,gy,gz,f_cut)
  dT = 0.01;  #time in seconds
  Tau=1/(2*pi*f_cut) ;
  alpha = Tau/(Tau+dT);                #do not change this line
  ################################################
  ##############Write your code here##############
  ################################################
  global hyx;
  global hyy;
  global hyz;
  global gx_in;
  global gy_in;
  global gz_in;
 
  hyx=((1-alpha)*(hyx))+((1-alpha)*(gx-gx_in));
  hyy=((1-alpha)*(hyy))+((1-alpha)*(gy-gy_in));
  hyz=((1-alpha)*(hyz))+((1-alpha)*(gz-gz_in));
  gx_in=gx;
  gy_in=gy;
  gz_in=gz;

 
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)
  global p;

 
  ##############################################
  ####### Write a code here to calculate  ######
  ####### PITCH using complementry filter ######
  ##############################################
  
  p=((1-0.03)*(p+(gx*0.01))+(0.03)*(atan2(ay,abs(az)))*180/pi);
 
  
endfunction

function comp_filter_roll(ax,ay,az,gx,gy,gz)
  global r;
  global lyx_in;
  global lyy_in;
  global lyz_in;
  global hyx_in;
  global hyy_in;
  global r_m;
  
  ##############################################
  ####### Write a code here to calculate #######
  ####### ROLL using complementry filter #######
  ##############################################
 
  r=(((1-0.03)*(r+(gy*0.01)))+(0.03)*(atan2(ax,abs(az)))*180/pi);

endfunction

function execute_code
  A = csvread('csv_matter.csv');
  X = csvread('csv_output.csv');
  global lyx;
  global lyy;
  global lyz;
  global hyx;
  global hyy;
  global hyz;
  global alpha;
  global p;
  global r;
  
  for n = 1:rows(A)               #do not change this line
    read_accel(A(n,2),A(n,1),A(n,4),A(n,3),A(n,6),A(n,5));
    read_gyro(A(n,8),A(n,7),A(n,10),A(n,9),A(n,12),A(n,11));
    
    ###############################################
    ####### Write a code here to calculate  #######
    ####### PITCH using complementry filter #######
    ###############################################

    comp_filter_pitch(lyx,lyy,lyz,hyx,hyy,hyz);
    comp_filter_roll(lyx,lyy,lyz,hyx,hyy,hyz);
    B(n,1)=p;
   
    B(n,2)=r;
  endfor
  csvwrite('output_data.csv',B);        #do not change this line
endfunction


execute_code                           #do not change this line
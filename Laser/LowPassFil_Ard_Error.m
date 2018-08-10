%Lowpass filter for 2nd derivative of PD signal & 1st der of error signal
%stuart smyth 
%27 Jul 18



%Data is imported from saved .mat file
%%
%clear all
%clc
%load('Captured6.mat');

%%
t = time;
y = data;
figure()
subplot(3,1,1),plot(time,data)
%data is still quite noisey so using the built in MATLAB function 'smooth'
%with 'lowess'( Local regression using weighted linear least squares and a
%1st degree polynomial model).

yy = sgolayfilt(data,2,51);
% use the 'gradient' function to calculate the 1st derivative of y
% then the 2nd derivative of y
subplot(3,1,2),plot(time,yy)
%%
% use the 'gradient' function to calculate the 1st derivative of y
% then the 2nd derivative of y
gradY = gradient(yy);     %1st derivative of y
grad2Y = gradient(gradY); %2nd derivative of y


% design a digital filter object, set as lowpass FIR type, also set
% passband Frequency and stopband Frequency and stopband Attenuation rate

LowFilt = designfilt('lowpassfir', 'PassbandFrequency',700,...
    'StopbandFrequency', 1200, 'PassbandRipple', 0.1, 'StopbandAttenuation',...
   120, 'SampleRate', 70000);

% Apply this filter to the data 

Y = filter(LowFilt,gradY); %2nd derivative of y with filter


%need to filp data in x-axis
Yflip = Y.*-1;


%using the 'findpeaks' function to identify maxima in the signal for
%interest in plots. Also give the extact values in terms of t and y of the
%transistions which could be usefull for controlling laser at later stage.

[ypks,ytim] = findpeaks(Y,t,'MinPeakProminence',2);


%Plot of filtered signals versus time with peaks marked


subplot(3,1,3),plot(t,Y,ytim,ypks,'o m')


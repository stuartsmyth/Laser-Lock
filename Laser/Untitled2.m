%Lowpass filter for 2nd derivative of PD signal & 1st der of error signal
%stuart smyth 
%20 jun 18

% Takes the 2nd derivative of the PD signal and 1st derivatve of error
% and applies a lowpass filter to reduce the noise. Checks this by
% performing a FFT and then save the gradients and relative spacings of the
% Rb85 and Rb87 transition peaks for comparasion.

%Data is imported from saved .mat file then converted to an array from a
%table.

load ('ErrorTestFiles.mat');
test = table2array(errors2);

%takes array "errors#" and splits up the data into time variable "t"
% voltage of PZT, variable "y" and error signal voltage, variable g.

tfull = test(:,1);
yfull = test(:,2);
t = tfull(1:20:end,:);  % reduces array to 6250 samples
y = yfull(1:20:end,:);  % reduces array to 6250 samples

%data is still quite noisey so using the built in MATLAB function 'smooth'
%with 'lowess'( Local regression using weighted linear least squares and a
%1st degree polynomial model).

yy = smooth(y,'lowess'); 

% use the 'gradient' function to calculate the 1st derivative of y and g
% then the 2nd derivative of y

gradY = gradient(yy);     %1st derivative of y
grad2Y = gradient(gradY); %2nd derivative of y
% design a digital filter object, set as lowpass FIR type, also set
% passband Frequency and stopband Frequency and stopband Attenuation rate

LowFilt = designfilt('lowpassfir', 'PassbandFrequency',1500,...
    'StopbandFrequency', 2500, 'PassbandRipple', 0.5, 'StopbandAttenuation',...
   100, 'SampleRate', 62500);

% Apply these filters to the data 



%need to filp data in x-axis
Yflip = Y.*-1;


%using the 'findpeaks' function to identify maxima in the signal for
%interest in plots. Also give the extact values in terms of t and y of the
%transistions which could be usefull for controlling laser at later stage.

[ypks,ytim] = findpeaks(Yflip,t,'MinPeakProminence',0.000085);

%Plot of filtered signals versus time with peaks marked

figure(1)
plot(t,Yflip,ytim,ypks,'o m')

% difference between peaks
times = etim + 0.05;
c87 = (times(3) - times(2)) / (times(4) - times(3))
c85 = (times(7) - times(6)) / (times(8) - times(7))




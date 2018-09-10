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
test = table2array(T0004ALL);

%takes array "errors#" and splits up the data into time variable "t"
% voltage of PZT, variable "y" and error signal voltage, variable g.

tfull = test(:,1);
yfull = test(:,2);
gfull = test(:,4);
t = tfull(1:20:end,:);  % reduces array to 6250 samples
y = yfull(1:20:end,:);  % reduces array to 6250 samples
g = gfull(1:20:end,:);  % reduces array to 6250 samples

%data is still quite noisey so using the built in MATLAB function 'smooth'
yy = smooth(y,'lowess');
gg = sgolayfilt(g,2,51);
%with 'lowess'( Local regression using weighted linear least squares and a
%1st degree polynomial model).


% use the 'gradient' function to calculate the 1st derivative of y and g
% then the 2nd derivative of y

gradY = gradient(yy);     %1st derivative of y
grad2Y = gradient(gradY); %2nd derivative of y

gradErrors = gradient(gg); %1st derivative of g

% design a digital filter object, set as lowpass FIR type, also set
% passband Frequency and stopband Frequency and stopband Attenuation rate

LowFilt = designfilt('lowpassfir', 'PassbandFrequency',600,...
    'StopbandFrequency', 1500, 'PassbandRipple', 0.5, 'StopbandAttenuation',...
   100, 'SampleRate', 62500);

% Apply these filters to the data 

Y = filter(LowFilt,grad2Y); %2nd derivative of y with filter
G = filter(LowFilt,gradErrors); %1st derivative of g with filter

%need to filp data in x-axis
Yflip = Y.*-1;


%using the 'findpeaks' function to identify maxima in the signal for
%interest in plots. Also give the extact values in terms of t and y of the
%transistions which could be usefull for controlling laser at later stage.

[ypks,ytim] = findpeaks(Yflip,t,'MinPeakProminence',0.0001);
[epks,etim] = findpeaks(G,t,'MinPeakProminence',0.006);

%Plot of filtered signals versus time with peaks marked
figure()
subplot(2,1,1),plot(t,y)
subplot(2,1,2),plot(t,g)

figure()
subplot(2,1,1),plot(t,yy)
subplot(2,1,2),plot(t,gg)

figure()
subplot(3,1,1),plot(t,yy)
subplot(3,1,2),plot(t,gradY)
subplot(3,1,3),plot(t,Yflip,ytim,ypks,'o m')


% difference between peaks
%times = etim + 0.05;
%j =1;
%c85 = (times(j+1) - times(j)) / (times(j+2) - times(j+1))
%c85skip = (times(j+1) - times(j)) / (times(j+3) - times(j+1))
%initVal:endVal � Increment the index variable from initVal to endVal 
%by 1, and repeat execution of statements until index is greater than endVal.
%for j = 1:7
%c87 = (times(j+1) - times(j)) / (times(j+2) - times(j+1))
%end;


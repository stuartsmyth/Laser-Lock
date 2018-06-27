% Rb87 high level Transition Dectection using error signal
% stuart smyth
% 18 jun 18

% Version of code that takes spectroscipty data from csv file and uses cross
% correlation to find the pzt volatges that correspond to the peaks of 
% Rb85 high level transitions

%Data is imported as a CSV file, currently has extra info like model num of
%scope and such so using uiimport to confirm that only revelant colums have
%been selected. Also data is in table format so use 'table2array' to
%convert and transform into and array called "test".

load ('ErrorTestFiles.mat');
test = table2array(errors2);

% takes array "test" and splits up the data into x-axis(time) variable "t"
% and y-axis(voltage of PZT) variable "y".Need to decide what the max num
% of points that these arays should have as very large arrays produce to
% much noise and also impact exicution time.

tfull = test(:,1);
yfull = test(:,2);
gfull = test(:,4);
t = tfull(1:20:end,:);  % reduces array to 6250 samples
y = yfull(1:20:end,:);  % reduces array to 6250 samples
g = gfull(1:20:end,:);  % reduces array to 6250 samples

%data is still quite noisey so using the built in MATLAB function 'smooth'
%with 'lowess'( Local regression using weighted linear least squares and a
%1st degree polynomial model).

yy = smooth(y,'lowess');

% use the 'gradient' function to calculate the 1st derivative of y then
% smooth this data again.

dy = gradient(yy);
dydt = smooth(dy,'lowess');

%Applies a moving average filter on the error signal data to reduce noise

windowSize = 8; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
G = filter(b,a,g);
gg = smooth(G,'lowess');

%import the library of referance signal fragments we want to search for,
%both regular and gradient versions

load ('Rb87Frag.mat');
load ('Rb87GradFrag.mat');
load ('Rb87ErFrag.mat');

%Using the method of cross correlation to search the input signal for the
%fragments outputs the correlation coefficent "C" and the lag between these
%correlations "lag".

[C87,lag87] = xcorr(yy,frag);
[C87g,lag87g] = xcorr(dydt,frag3);
[C87e,lag87e] = xcorr(gg,fragE87);
[C87eg,lag87eg] = xcorr(dydt,fragE87);
%using the 'findpeaks' function to identify maxima in the signal for
%interest in plots. Also give the extact values in terms of t and y of the
%transistions which could be usefull for controlling laser at later stage.

[ypks,ytim] = findpeaks(C87,lag87,'MinPeakDistance',1,...
    'MinPeakProminence',0.015);
[dypks,dytim] = findpeaks(C87g,lag87g,'MinPeakDistance',20,...
    'MinPeakProminence',0.002);
[epks,etim] = findpeaks(C87e,lag87e,'MinPeakDistance',1,...
    'MinPeakProminence',0.015);

%Plot of original signal and dydt of signal versus time, underneath each is
%the plot of the cross corelation coefficeint vs lag in samples. When there
%is a peak in this plot then that sample number(index of the time "t" array)
%corresponds to the time  that the match is greatest so from this can get
%the coresponding PZT voltage.

figure(1)
subplot(3,1,1),plot(t,yy)
title('Input signal')
xlabel('time(s)')
ylabel('y')
subplot(3,1,2),plot(t,dydt)
title('1st div of input signal')
xlabel('time(s)')
ylabel('dy/dt')
subplot(3,1,3),plot(t,gg)
title('error signal')
xlabel('time(s)')
ylabel('y')

%plot of the cross correlation coefficient vs lag for PD signal against PD
%ref fragment, 1st derivative of PD signal against PD 1st div ref fragment,
%1st derivative of PD signal against error signal ref fragment and error
%signal vs error signal ref fragment.

figure(2)
subplot(4,1,1),plot(lag87,C87,ytim,ypks,'o m')
title('Rb87 Transition detection')
xlabel('Lag (samples)')
ylabel('C87')
xlim( [0 6250])
subplot(4,1,2),plot(lag87g,C87g,dytim,dypks,'o m')
title('C85g vs lag')
xlabel('Lag (samples)')
ylabel('C87 Grad')
xlim( [0 6250])
subplot(4,1,3),plot(lag87eg,C87eg)
title('C85e vs lag')
xlabel('Lag (samples)')
ylabel('C87 ErrorGrad')
xlim( [0 6250])
subplot(4,1,4),plot(lag87e,C87e,etim,epks,'o m')
title('C85eg vs lag')
xlabel('Lag (samples)')
ylabel('C87 Error')
xlim( [0 6250])


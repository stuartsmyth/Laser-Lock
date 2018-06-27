% Rb85 high level Transition Dectection using error signal
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
test = table2array(errors1);

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

load ('Rb85Frag.mat');
load ('Rb85GradFrag.mat');
load ('Rb85ErFrag.mat');

%Using the method of cross correlation to search the input signal for the
%fragments outputs the correlation coefficent "C" and the lag between these
%correlations "lag".

[C85,lag85] = xcorr(yy,frag2);
[C85g,lag85g] = xcorr(dydt,frag4);
[C85eg,lag85eg] = xcorr(dydt,fragE85);
[C85e,lag85e] = xcorr(gg,fragE85);

%using the 'findpeaks' function to identify maxima in the signal for
%interest in plots. Also give the extact values in terms of t and y of the
%transistions which could be usefull for controlling laser at later stage.

[ypks,ytim] = findpeaks(C85,lag85,'MinPeakDistance',1,...
    'MinPeakProminence',0.015);
[dypks,dytim] = findpeaks(C85g,lag85g,'MinPeakDistance',20,...
    'MinPeakProminence',0.002);
[epks,etim] = findpeaks(C85e,lag85e,'MinPeakDistance',1,...
    'MinPeakProminence',0.015);

%pionts

p = [-0.0326560 -0.0289280 -0.0229280000000000 0.01720 0.0183680 0.0205760];
pcorrect = p - 1.8433e-3;
x = [0 0 0 0 0 0];

%Plot of original signal and dydt of signal versus time, underneath each is
%the plot of the cross corelation coefficeint vs lag in samples. When there
%is a peak in this plot then that sample number(index of the time "t" array)
%corresponds to the time  that the match is greatest so from this can get
%the coresponding PZT voltage.

figure(1)
subplot(3,1,1),plot(t,yy,p,x,'o m',pcorrect,x,'x c')
title('Input signal')
xlabel('time(s)')
ylabel('y')
subplot(3,1,2),plot(t,g,p,x,'o m')
title('1st div of input signal')
xlabel('time(s)')
ylabel('dy/dt')
subplot(3,1,3),plot(t,gg,p,x,'o m')
title('error signal')
xlabel('time(s)')
ylabel('y')

%plot of the cross correlation coefficient vs lag for PD signal against PD
%ref fragment, 1st derivative of PD signal against PD 1st div ref fragment,
%1st derivative of PD signal against error signal ref fragment and error
%signal vs error signal ref fragment.

figure(2)
subplot(4,1,1),plot(lag85,C85,ytim,ypks,'o m')
title('C85 vs lag')
xlabel('Lag (samples)')
ylabel('C85')
xlim( [0 6250])
subplot(4,1,2),plot(lag85g,C85g,dytim,dypks,'o m')
title('C85g vs lag')
xlabel('Lag (samples)')
ylabel('C85 Grad')
xlim( [0 6250])
subplot(4,1,3),plot(lag85eg,C85eg)
title('C85eg vs lag')
xlabel('Lag (samples)')
ylabel('C85 ErGrad')
xlim( [0 6250])
subplot(4,1,4),plot(lag85e,C85e,etim,epks,'o m')
title('C85e vs lag')
xlabel('Lag (samples)')
ylabel('C85 Error')
xlim( [0 6250])
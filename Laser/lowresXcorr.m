% Offset finder
% Stuart Smyth
% created 8 Jun 18
% program using xcorr to find lagg between known fragment and and place of
% best fit inside test signal

% convert from a table to an array 
test15 = table2array(test5);
test16 = table2array(test6);
test17 = table2array(test7);

% extract and define time (t) and y-axis (y) from imported file
% also reduces number of points by sampling 1 in 20 to help with noise 
t5 = test15(:,1);
y5 = test15(:,2);
t6 = test16(:,1);
y6 = test16(:,2);
t7 = test17(:,1);
y7 = test17(:,2);

% smooth data to reduce noise
yy5 = smooth(y5,'lowess');
yy6 = smooth(y6,'lowess');
yy7 = smooth(y7,'lowess');

% 1st derivative of y wrt time 
Ft1 = gradient(yy5);
Ft2 = gradient(yy6);
Ft3 = gradient(yy7);
% use findpeaks to give location of maxima
% MinPeakDistance elimiates points that are closer than given time.
% MinPeakProminence eliminates points that are less importantm, small
% closer together, finds the interesting points in the data
[pks5,tim5,width5,prom5]=findpeaks(yy5,t5,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.05);
[pks6,tim6,width6,prom6]=findpeaks(yy6,t6,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.05);
[pks7,tim7,width7,prom7]=findpeaks(yy7,t7,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.05);
%create the fragment that we want to find 
% set start and end times
% snip is new array of x axis values between time a and time b
% frag is new array of y axis values that match x values in snip 



% find the cross-correlation of test signals and fragment
[C5,lag5] = xcorr(yy5,frag2);
[C6,lag6] = xcorr(yy6,frag2);
[C7,lag7] = xcorr(yy7,frag2);

[gC5,glag5] = xcorr(Ft1,frag4);
[gC6,glag6] = xcorr(Ft2,frag4);
[gC7,glag7] = xcorr(Ft3,frag4);
%Plot of y vs time with peaks identified
figure(1)
subplot(3,1,1), plot(t5,yy5,tim5,pks5,'o m')
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot (3,1,2), plot(lag5,C5)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 2499]);
subplot (3,1,3), plot(glag5,gC5)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 2499]);



figure(2)
subplot(2,1,1), plot(t6,yy6,tim6,pks6,'o m')
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot (2,1,2), plot(lag6,C6)
hold on 
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 2499]);

figure(3)
subplot(2,1,1), plot(t7,yy7,tim7,pks7,'o m')
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot (2,1,2), plot(lag7,C7)
hold on 
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 2499]);
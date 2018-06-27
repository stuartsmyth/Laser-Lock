% Offset finder
% Stuart Smyth
% created 8 Jun 18
% program using xcorr to find lagg between known fragment and and place of
% best fit inside test signal

% convert from a table to an array 
test11 = table2array(test1);
test12 = table2array(test2);
test13 = table2array(test3);
test14 = table2array(test4);

% extract and define time (t) and y-axis (y) from imported file
% also reduces number of points by sampling 1 in 20 to help with noise 
tfull1 = test11(:,1);
yfull1 = test11(:,2);
t1 = tfull1(1:20:end,:);
y1 = yfull1(1:20:end,:);
tfull2 = test12(:,1);
yfull2 = test12(:,2);
t2 = tfull2(1:20:end,:);
y2 = yfull2(1:20:end,:);
tfull3 = test13(:,1);
yfull3 = test13(:,2);
t3 = tfull3(1:20:end,:);
y3 = yfull3(1:20:end,:);
tfull4 = test14(:,1);
yfull4 = test14(:,2);
t4 = tfull4(1:20:end,:);
y4 = yfull4(1:20:end,:);

% smooth data to reduce noise
yy1 = smooth(y1,'lowess');
yy2 = smooth(y2,'lowess');
yy3 = smooth(y3,'lowess');
yy4 = smooth(y4,'lowess');

% use findpeaks to give location of maxima
% MinPeakDistance elimiates points that are closer than given time.
% MinPeakProminence eliminates points that are less importantm, small
% closer together, finds the interesting points in the data
[pks1,tim1,width1,prom1]=findpeaks(yy1,t1,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.015);
[pks2,tim2,width2,prom2]=findpeaks(yy2,t2,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.015);
[pks3,tim3,width3,prom3]=findpeaks(yy3,t3,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.015);
[pks4,tim4,width4,prom4]=findpeaks(yy4,t4,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.015);

%create the fragment that we want to find 
% set start and end times
% snip is new array of x axis values between time a and time b
% frag is new array of y axis values that match x values in snip 
timeA = -0.042;
timeB = -0.037;
snip =  t1(1815:1953,:);
frag =  yy1(1815:1953,:);

timeC = -0.0820;
timeD = -0.0755;
snip2 = t2(562:766,:);
frag2 = yy2(562:766,:);

% find the cross-correlation of test signals and fragment
[C1,lag1] = xcorr(yy1,frag);
[C2,lag2] = xcorr(yy2,frag);
[C3,lag3] = xcorr(yy3,frag);
[C4,lag4] = xcorr(yy4,frag);

[C5,lag5] = xcorr(yy1,frag2);
[C6,lag6] = xcorr(yy2,frag2);
[C7,lag7] = xcorr(yy3,frag2);
[C8,lag8] = xcorr(yy4,frag2);
%Plot of y vs time with peaks identified
figure(1)
subplot(4,1,1), plot(t1,y1,tim1,pks1,'o m')
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot(4,1,2), plot(t2,y2,tim2,pks2,'o m')
xlabel('time')
ylabel('y')
subplot(4,1,3), plot(t3,y3,tim3,pks3,'o m')
xlabel('time')
ylabel('y')
subplot(4,1,4), plot(t4,y4,tim4,pks4,'o m')


%plot of Corr vs lag for the fragment in the test signals
figure(2)
subplot(4,1,1);
plot (lag1,C1)
hold on 
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
hold off
subplot(4,1,2);
plot (lag2,C2)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,3);
plot (lag3,C3)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,4);
plot (lag4,C4)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])

%plot of Corr vs lag for the 2nd fragment in the test signals
figure(3)
subplot(4,1,1);
plot (lag5,C5)
hold on 
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
hold off
subplot(4,1,2);
plot (lag6,C6)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,3);
plot (lag7,C7)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,4);
plot (lag8,C8)
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
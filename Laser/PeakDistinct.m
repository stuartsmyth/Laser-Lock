%Peak distictiveness
%stuart smyth
%14 jun 18

% convert from a table to an array 
test11 = table2array(test1);
test12 = table2array(test7);
test13 = table2array(test3);
test14 = table2array(test4);

% extract and define time (t) and y-axis (y) from imported file
% also reduces number of points by sampling 1 in 20 to help with noise 
tfull1 = test11(:,1);
yfull1 = test11(:,2);
t1 = tfull1(1:20:end,:);
y1 = yfull1(1:20:end,:);
t2 = test12(:,1);
y2 = test12(:,2);
%t2 = tfull2(1:20:end,:);
%y2 = yfull2(1:20:end,:);
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

% 1st derivative of y wrt time 
Ft1 = gradient(yy1);
Fts1 = smooth(Ft1,'lowess');
Ft2 = gradient(yy2);
Fts2 = smooth(Ft2,'lowess');
Ft3 = gradient(yy3);
Fts3 = smooth(Ft3,'lowess');
Ft4 = gradient(yy4);
Fts4 = smooth(Ft4,'lowess');

% 2nd derivative of y wrt time 

fft1 = gradient(Fts1);
ffts1 = smooth(fft1,'lowess');
fft2 = gradient(Fts2);
ffts2 = smooth(fft2,'lowess');
fft3 = gradient(Fts3);
ffts3 = smooth(fft3,'lowess');
fft4 = gradient(Fts4);
ffts4 = smooth(fft4,'lowess');

% use findpeaks to give location of maxima
% MinPeakDistance elimiates points that are closer than given time.
% MinPeakProminence eliminates points that are less importantm, small
% closer together, finds the interesting points in the data
[pks1,tim1]=findpeaks(ffts1,t1,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.005);
[pks2,tim2]=findpeaks(ffts2,t2,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.005);
[pks3,tim3]=findpeaks(ffts3,t3,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.005);
[pks4,tim4]=findpeaks(ffts4,t4,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.005);
%Plot of y vs time with peaks identified
figure(1)
subplot(4,1,1), plot(t1,y1)
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot(4,1,2), plot(t2,y2)
xlabel('time')
ylabel('y')
subplot(4,1,3), plot(t3,y3)
xlabel('time')
ylabel('y')
subplot(4,1,4), plot(t4,y4)

%plot of dy/dt vs time
figure(2)
subplot(4,1,1), plot(t1,Ft1)
title('1st derivative');
xlabel('time')
ylabel('dy/dt')
subplot(4,1,2), plot(t2,Ft2)
title('1st derivative');
xlabel('time')
ylabel('dy/dt')
subplot(4,1,3), plot(t3,Ft3)
title('1st derivative');
xlabel('time')
ylabel('dy/dt')
subplot(4,1,4), plot(t4,Ft4)
title('1st derivative');
xlabel('time')
ylabel('dy/dt')

%plot of d^2y/dt^2 vs time
figure(3)
subplot(4,1,1), plot(t1,ffts1,tim1,pks1,'o m')
title('2nd derivative');
xlabel('time')
ylabel('d^2y/dt^2')
subplot(4,1,2), plot(t2,ffts2,tim2,pks2,'o m')
title('2nd derivative');
xlabel('time')
ylabel('d^2y/dt^2')
subplot(4,1,3), plot(t3,ffts3,tim3,pks3,'o m')
title('2nd derivative');
xlabel('time')
ylabel('d^2y/dt^2')
subplot(4,1,4), plot(t4,ffts4,tim4,pks4,'o m')
title('2nd derivative');
xlabel('time')
ylabel('d^2y/dt^2')



% Specta Ana multi
% Stuart Smyth
% created 7 Jun 18


% convert from a table to an array 
test11 = table2array(test1);
test12 = table2array(test2);
test13 = table2array(test3);
test14 = table2array(test4);

% extract and define time (t) and y-axis (y) from imported file
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
[pks1,tim1]=findpeaks(yy1,t1,'MinPeakDistance',0.001,'MinPeakProminence',0.015);
[pks2,tim2]=findpeaks(yy2,t2,'MinPeakDistance',0.001,'MinPeakProminence',0.015);
[pks3,tim3]=findpeaks(yy3,t3,'MinPeakDistance',0.001,'MinPeakProminence',0.015);
[pks4,tim4]=findpeaks(yy4,t4,'MinPeakDistance',0.001,'MinPeakProminence',0.015);


% plot of y vs time
figure(2)
subplot(4,1,1), plot(t1,yy1,tim1,pks1,'o m')
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot(4,1,2), plot(t2,yy2,tim2,pks2,'o m')
xlabel('time')
ylabel('y')
subplot(4,1,3), plot(t3,yy3,tim3,pks3,'o m')
xlabel('time')
ylabel('y')
subplot(4,1,4), plot(t4,yy4,tim4,pks4,'o m')

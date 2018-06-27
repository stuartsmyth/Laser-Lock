% FindSignal test of methods to see what gives best results
% stuart smyth
% 11 Jun 18

% convert from a table to an array 
test = table2array(test1);
test22 = table2array(test2);
% extract and define time (t) and y-axis (y) from imported file
tfull = test(:,1);
yfull = test(:,2);
t = tfull(1:20:end,:);
y = yfull(1:20:end,:);

tfull2 = test22(:,1);
yfull2 = test22(:,2);
t2 = tfull2(1:20:end,:);
y2 = yfull2(1:20:end,:);

% smooth data to reduce noise
yy = smooth(y,'lowess');
yy2 = smooth(y2,'lowess');

%create the snippet that we want to find 
% set start and end times
% snip is new array of x axis values between time a and time b
% frag is new array of y axis values that match x values in snip 
timeA = -0.042;
timeB = -0.037;
snip =  t(1800:1970,:);
frag =  yy(1800:1970,:);

% use findsignal to identify best match for fragment 
figure(1)
%Find the segment of the data that has the smallest 
%Euclidean distance to the signal.
findsignal(yy2,frag)

figure(2)
%Find the segment that is closest to the signal in the sense of having the
%smallest absolute distance.
findsignal(yy2,frag,'Metric','absolute')
title('Absolute')
xlabel('samples')
ylabel('y')
figure(3)
findsignal(yy2,frag,'Metric','euclidean')
title('Euclidean')
xlabel('samples')
ylabel('y')
figure(4)
findsignal(yy2,frag,'Metric','squared')
title('Squared')
xlabel('samples')
ylabel('y')

figure(5)
%Let the x-axes stretch if the stretching results in a smaller
%distance between the closest data segment and the signal.
findsignal(yy2,frag,'Metric','absolute','TimeAlignment','fixed')
title('Fixed')
xlabel('samples')
ylabel('y')
figure(6)
findsignal(yy2,frag,'Metric','absolute','TimeAlignment','dtw')
title('DTW')
xlabel('samples')
ylabel('y')
figure(7)
findsignal(yy2,frag,'Metric','absolute','TimeAlignment','edr',...
    'EDRTolerance',0.04)
title('EDR')
xlabel('samples')
ylabel('y')


figure(8)
%Let the x-axes stretch if the stretching results in a smaller
%distance between the closest data segment and the signal.
findsignal(yy2,frag,'Metric','absolute','TimeAlignment','edr',...
   'EDRTolerance',0.05, 'Normalization','center','Annotate','all')
title('Fixed with Normal')
xlabel('samples')
ylabel('y')
figure(9)
findsignal(yy2,frag,'Metric','absolute','TimeAlignment','edr',...
    'EDRTolerance',0.05, 'Normalization','zscore','Annotate','all')
title('DTW with Normal')
xlabel('samples')
ylabel('y')
figure(10)
findsignal(yy2,frag,'Metric','absolute','TimeAlignment','edr',...
    'EDRTolerance',0.05,'Normalization','power','Annotate','all')
title('EDR with normal')
xlabel('samples')
ylabel('y')


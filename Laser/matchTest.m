% Match test
% Stuart Smyth
% created 8 Jun 18

% convert from a table to an array 
test = table2array(test1);
% extract and define time (t) and y-axis (y) from imported file
tfull = test(:,1);
yfull = test(:,2);
t = tfull(1:20:end,:);
y = yfull(1:20:end,:);
% smooth data to reduce noise
yy = smooth(y,'lowess');

% limits of y axis 
m = min(yy);
M = max(yy);

%create the snippet that we want to find 
% set start and end times
% snip is new array of x axis values between time a and time b
% frag is new array of y axis values that match x values in snip 
timeA = -0.042;
timeB = -0.037;
snip =  t(1815:1953,:);
Frag =  yy(1815:1953,:);

% find the cross-correlation of full signal and fragment
[xCorr,lags] = xcorr(yy,Frag);
% replot and overlay fragment
[~,I] = max(abs(xCorr));
maxt = lags(I);
Trial = NaN(size(yy));
Trial(maxt+1:maxt+length(Frag)) = Frag;

% plot of y vs time
figure(1)
subplot(4,1,1),plot(t,yy,[timeA timeB;timeA timeB],[m m;M M],'r--');
title('Pzt vs time');
xlabel('time');
ylabel('y');
axis tight;
subplot(4,1,2),plot(snip,Frag)
xlabel('Time')
ylabel('y')
title('Fragment')
subplot(4,1,3),plot(lags,xCorr)
grid
xlabel('Lag')
ylabel('Clean')
axis tight
subplot(4,1,4),plot(t,yy,t,Trial)
xlabel('Time')
ylabel('y')
axis tight

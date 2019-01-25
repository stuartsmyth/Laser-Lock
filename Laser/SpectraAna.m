% Specta Ana
% Stuart Smyth
% Created 4 Jun 18


%convert from a table to an array 
test = table2array(test1);

% extract and define time (t) and y-axis (y) from imported file
tfull = test(:,1);
yfull = test(:,2);
t = tfull(1:20:end,:);
y = yfull(1:20:end,:);

% smooth data to reduce noise
yy = smooth(y,'lowess');

% 1st derivative of y wrt time 
Ft = gradient(yy);
Fts = smooth(Ft,'lowess');



%Applies a moving average filter on the error signal data to reduce noise

windowSize = 12; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
G = filter(b,a,Fts);

% use findpeaks to give location of maxima
% MinPeakDistance elimiates points that are closer than given time.
% MinPeakProminence eliminates points that are less importantm, small
% closer together, finds the interesting points in the data
[pks,tim]=findpeaks(yy,t,'MinPeakDistance',0.001,'MinPeakProminence',0.015);


% plot of y, dy/dt vs time
figure(1)
%subplot(2,1,1); 
plot(t,yy,tim,pks,'o m')
title('Pzt vs time');
xlabel('time')
ylabel('y')
%axis([ -0.044 -0.036 -0.2 0.3]);
%subplot(2,1,2), plot (t,G);
%title('1st derivative');
%xlabel('time')
%ylabel('dy/dt')
%axis([ -0.044 -0.036 -0.015 0.01]);



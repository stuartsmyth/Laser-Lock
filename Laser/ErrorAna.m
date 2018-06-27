% error ana
% Stuart Smyth
% Created 18 Jun 18


%convert from a table to an array 
test = table2array(errors2);

tfull = test(:,1);
gfull = test(:,4);
t = tfull(1:20:end,:);
g = gfull(1:20:end,:);

windowSize = 8; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
G = filter(b,a,g);
gg = smooth(G,'lowess');

snipE87 = t(821:1604,:);
fragE87 = gg(821:1604,:);

snipE85 = t(3956:4317,:);
fragE85 = gg(3956:4317,:);

%use findpeaks to give location of maxima
% MinPeakDistance elimiates points that are closer than given time.
% MinPeakProminence eliminates points that are less importantm, small
% closer together, finds the interesting points in the data
[pks,tim]=findpeaks(G,t,'MinPeakDistance',0.001,...
    'MinPeakProminence',0.015);

figure(1)
plot(snipE87,fragE87,snipE85,fragE85)
title('error vs time');
xlabel('time')
ylabel('y')
%xlim([-0.05 0])
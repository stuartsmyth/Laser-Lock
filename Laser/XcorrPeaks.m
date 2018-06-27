%lagg peaks
%stuart smyth
%12 jun 18

% use findpeaks to give location of maxima
% MinPeakDistance elimiates points that are closer than given time.
% MinPeakProminence eliminates points that are less importantm, small
% closer together, finds the interesting points in the data
[pks1,tim1]=findpeaks(C1,lag1,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks2,tim2]=findpeaks(C2,lag2,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks3,tim3]=findpeaks(C3,lag3,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks4,tim4]=findpeaks(C4,lag4,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks5,tim5]=findpeaks(C5,lag5,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks6,tim6]=findpeaks(C6,lag6,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks7,tim7]=findpeaks(C7,lag7,'MinPeakDistance',0.001,'MinPeakProminence',0.5);
[pks8,tim8]=findpeaks(C8,lag8,'MinPeakDistance',0.001,'MinPeakProminence',0.5);

%plot of Corr vs lag for the fragment in the test signals
figure(1)
subplot(4,1,1);
plot (lag1,C1,tim1,pks1,'o m')
hold on 
title('Smooth Peak');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
hold off
subplot(4,1,2);
plot (lag2,C2,tim2,pks2,'o m')
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,3);
plot (lag3,C3,tim3,pks3,'o m')
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,4);
plot (lag4,C4,tim4,pks4,'o m')
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])

figure(2)
subplot(4,1,1);
plot (lag5,C5,tim5,pks5,'o m')
hold on 
title('Sharp Peak');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
hold off
subplot(4,1,2);
plot (lag6,C6,tim6,pks6,'o m')
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,3);
plot (lag7,C7,tim7,pks7,'o m')
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
subplot(4,1,4);
plot (lag8,C8,tim8,pks8,'o m')
title('Corr vs lag');
xlabel('lag')
ylabel('C')
xlim( [0 6250])
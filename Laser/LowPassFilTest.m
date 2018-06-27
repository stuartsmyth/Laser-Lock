%Lowpass filter testing
%stuart smyth 
%19 jun 18

%Data is imported as a matalb file. Also data is in table format so use
%'table2array' to convert and transform into and array called "test".

load ('ErrorTestFiles.mat');
test = table2array(errors2);

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

yy = smooth(y,'lowess');
gradY = gradient(yy);
gradYs = smooth(gradY,'lowess');
grad2Y = gradient(gradYs);
grad2Ys = smooth(grad2Y,'lowess');

gradErrors = gradient(g);
%do some filtering

LowFilt = designfilt('lowpassfir', 'PassbandFrequency',1500,...
    'StopbandFrequency', 2500, 'PassbandRipple', 0.5, 'StopbandAttenuation',...
   100, 'SampleRate', 62500);
GGG = filter(LowFilt,gradErrors);

%Use filter in the form dataOut = filter(d,dataIn) to filter a signal with
%a digitalFilter, d. The input can be a double- or single-precision vector
%It can also be a matrix with as many columns as there are input channels.
figure(1)
subplot(2,1,1),plot(t,gradErrors);
subplot(2,1,2),plot(t,GGG);





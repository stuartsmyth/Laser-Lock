%findsignal example
%stuart smyth
%11 jun 18

% you have a sinewave:
%data = sin(2*pi*(0:100)/16);
%location of the signal:
%signal = cos(2*pi*(0:10)/16);
%By default findsignal always returns the closest match of the signal
%To return multiple matches, 
%you can specify a bound on the maximum sum squared difference.
%findsignal returns matches in sorted order of closeness
%findsignal(data,signal,'MaxDistance',1e-14)
%[iStart, iStop, distance] = findsignal(data,signal,'MaxDistance',1e-14);
%fprintf('iStart iStop  total squared distance\n')
%fprintf('%4i %5i     %.7g\n',[iStart; iStop; distance])

fs = 1e3;
t = 0:1/fs:0.5;
data = gauspuls(t,5,0.5);
ts = 0:1/fs:0.15;
signal = cos(2*pi*10*ts);
dt = data;
dt(t>0.1&t<0.11) = 2.1;
dt(t>0.11&t<0.12) = -2.1;

figure(1)
findsignal(dt,signal,'TimeAlignment','edr','EDRTolerance',3, ...
    'Normalization','zscore','NormalizationLength',21, ...
    'Metric','absolute','Annotate','all')
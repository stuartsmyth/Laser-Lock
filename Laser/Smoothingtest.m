% data smoothing test
% Stuart Smyth
% Last Mod 5 Jun 18

%collection of smoothing methods plotted for comparision.

%Moving average (default). A lowpass filter with filter coefficients equal
%to the reciprocal of the span.
y1 = smooth(y,'moving'); 	

%Moving average (default). A lowpass filter with filter coefficients equal
%to the reciprocal of the span.
y2 =   smooth(y,'lowess');

%Local regression using weighted linear least squares and a 2nd degree
%polynomial model
y3 =  smooth(y,'rlowess');

% comparassion plot 
plot (t,y,'b',t,y1,'r',t,y2,'g',t,y3,'m');
hold on

axis([ -0.05 -0.03 -0.3 0.3]);
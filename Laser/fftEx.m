t = 0:1/50:10-1/50;                     
x = sin(2*pi*15*t) + sin(2*pi*20*t);
figure(1)
plot(t,x)
y = fft(x);         
m = abs(y);                               
p = angle(y);
f = (0:length(y)-1)*50/length(y);
figure(2)
subplot(2,1,1)
plot(f,m)
title('Magnitude')

subplot(2,1,2)
plot(f,rad2deg(p))
title('Phase')
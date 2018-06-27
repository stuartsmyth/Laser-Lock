% FFT test


test = table2array(errors2);
tfull = test(:,1);
yfull = test(:,2);
gfull = test(:,4);
t = tfull(1:20:end,:);
y = yfull(1:20:end,:);
g = gfull(1:20:end,:);



% much filtering 
yy = smooth(y,'lowess');
gradY = gradient(yy);
gradYs = smooth(gradY,'lowess');
grad2Y = gradient(gradYs);
grad2YsU = smooth(grad2Y,'lowess');

windowSize = 20; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
G = filter(b,a,g);
gg = smooth(G,'lowess');
gradErrors = gradient(gg);

gradYs = filter(b,a,gradY);
grad2Y = gradient(gradYs);
grad2Ys = smooth(grad2Y,'lowess');
GG = filter(b,a,grad2Ys);



% ffts based on oppo code
N = length(GG);% number of points of grad2Y
T = 0.1;% define time interval
f = fft(GG);
m = abs(f);
m2 = m(1:N/2).^2;
freq = (0:N/2-1)/T;

fg = fft(gradErrors);
mg = abs(fg);
mg2 = mg(1:N/2).^2;




%plots of d^2y/dt^2
figure(1)
subplot(2,1,1),plot(t,GG)
title('d^2y/dt^2 of orig signal')
xlabel('time')
subplot(2,1,2),plot(t,gradErrors)
title('dy/dt of error signal')
xlabel('time')
figure(2)
plot(freq,m2/max(m2)),
title('FFT of d^2y/dt^2 of orig signal')
xlabel('Hertz')
figure(3)
plot(freq,mg2/max(mg2)),
title('FFT of dy/dt of error signal')
xlabel('Hertz')



test = table2array(errors2);
tfull = test(:,1);
yfull = test(:,2);
gfull = test(:,4);
t = tfull(1:20:end,:);
y = yfull(1:20:end,:);
g = gfull(1:20:end,:);

yy = smooth(y,'lowess');
gradY = gradient(yy);
gradYs = smooth(gradY,'lowess');

gradError = gradient(g);
gradErrors = smooth(gradError,'lowess');

grad2Y = gradient(gradYs);
grad2Ys = smooth(grad2Y,'lowess');
dy  = diff(y);
d2y = diff(y,2);
ed2y = diff(g);

figure(1)
subplot(4,1,1), plot(t,yy)
title('Pzt vs time');
xlabel('time')
ylabel('y')
subplot(4,1,2), plot (t,gradYs);
title('grad');
xlabel('time')
ylabel('dy/dt')
subplot(4,1,3), plot (t(1:length(dy),:),dy);
title('diff');
xlabel('time')
ylabel('dy/dt')
subplot(4,1,4), plot (t,g);
title('error');
xlabel('time')
ylabel('dydt')

figure(2)
subplot(4,1,1),plot (t,grad2Y)
title('grad');
xlabel('time')
ylabel('d^2y/dt^2')
subplot(4,1,2),plot (t(1:length(d2y),:),d2y)
title('diff');
xlabel('time')
ylabel('d^2y/dt^2')
subplot(4,1,3),plot (t,gradErrors)
title('grad of error');
xlabel('time')
ylabel('d^2y/dt^2')
subplot(4,1,4),plot (t(1:length(ed2y),:),ed2y)
title('diff of error');
xlabel('time')
ylabel('d^2y/dt^2')
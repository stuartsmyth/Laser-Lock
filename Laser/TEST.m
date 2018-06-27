fs = 1e3;
t = 0:1/fs:1;

x = [1 2]*sin(2*pi*[50 250]'.*t) + randn(size(t))/10;
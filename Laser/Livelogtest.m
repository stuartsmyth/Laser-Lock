%%Connect to Arduino
% use arduino cmd to connect to device

a = arduino;

%% Take single reading

v = readVoltage(a,'A0');

%% Record for ten seconds

ii = 0;
v = zeros(1e4,1);
t = zeros(1e4,1);
tic
while toc < 10
    ii = ii + 1;
    % read voltage value
    v(ii) = readVoltage(a,'A0');
    % get time since starting
    t(ii) = toc;
end

%creates data vectors with zeros removed

v = v(1:ii);
t = t(1:ii);

%plot voltage verus time
figure 
plot(t,v)
xlabel('time')
ylabel('voltage')
title('Volatge vs time')
set(gca,'xlim',[t(1) t(ii)])

%% Compute acquisition rate

timeBetweenData = diff(t);
AvgtimeBetweenData = mean(timeBetweenData)
DataRateHz = 1/AvgtimeBetweenData

%% Displaying Live data

figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [0 4];

stop = 0;
startTime = datetime('now');
while stop < 2000
    %read volatge value
    v = readVoltage(a,'A0');
    %get current time 
    t = datetime('now') - startTime;
    %add points to animation
    addpoints(h,datenum(t),v)
    %update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    %check stop condistion
    %stop = readDigitalPin(a,'D12');
    stop = stop+1;
end

%% Plot recorded data

[timelog,voltlog]  = getpoints(h);
timesecs = (timelog- timelog(1))*24*3600;
figure
plot(timesecs,voltlog)
xlabel('time')
ylabel('volts')

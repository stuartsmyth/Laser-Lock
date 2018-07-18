% Serial Data Logger
% stuart smyth
% 18 jun 18
% **CLOSE PLOT TO END SESSION
%% clear any remaining variables
clear
clc
%% set up workspace for program
%User Defined Properties 
serialPort = 'Com3';            % define COM port #
plotTitle = 'Serial Data Log';  % plot title
xLabel = 'Elapsed Time (s)';    % x-axis label
yLabel = 'Data';                % y-axis label
plotGrid = 'on';                % 'off' to turn off grid
min = 1000;                     % set y-min
max = 3000;                      % set y-max
scrollWidth = 10;               % display period in plot, plot entire data log if <= 0
delay = .000015;                % make sure sample faster than resolution
 
%Define Function Variables
time = 0;
data = 0;
count = 0;
%% set up plot window
%Set up Plot
plotGraph = plot(time,data,'-mo',...
                'LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',2);
             
title(plotTitle,'FontSize',25);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
axis([0 10 min max]);
grid(plotGrid);
%% open serial port and set parameters
%Open Serial COM Port
s = serial(serialPort)
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'BaudRate',115200);
set(s,'Parity','none');
disp('Close Plot to End Session');
fopen(s);
%% run loop while plot window is open
tic

while ishandle(plotGraph) %Loop when Plot is Active
     
    dat = fscanf(s,'%f'); %Read Data from Serial as Float
  
    if(~isempty(dat) && isfloat(dat)) %Make sure Data Type is Correct        
        count = count + 1;    
        time(count) = toc;    %Extract Elapsed Time
        data(count) = dat(1); %Extract 1st Data Element         
         
        %Set Axis according to Scroll Width
        if(scrollWidth > 0)
        set(plotGraph,'XData',time(time > time(count)-scrollWidth),'YData',data(time > time(count)-scrollWidth));
        axis([time(count)-scrollWidth time(count) min max]);
        else
        set(plotGraph,'XData',time,'YData',data);
        axis([0 time(count) min max]);
        end
         
        %Allow MATLAB to Update Plot
        pause(delay);
    end
end
%% when plot window is closed
%Close Serial COM Port and Delete useless Variables
fclose(s);
clear count dat delay max min plotGraph plotGrid plotTitle s ...
        scrollWidth serialPort xLabel yLabel;
 
 
disp('Session Terminated...');
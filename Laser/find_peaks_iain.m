function [ ypks, ytim, epks, etim ] = find_peaks_iain( t, y, g) %#codegen

% Stumbled accross this filter. Never used it before. Works well for blocks
% of data, but I have no idea how much maths is going on behind it!
Y = sgolayfilt(y,2,51);
G = sgolayfilt(g,2,101);

% I'm just ditching the end as it gets corrupt by the filtering process
Y=Y(1:end-200);
G=G(1:end-200);
t=t(1:end-200);

[ypks,ytim] = findpeaks(Y,t,'MinPeakProminence',0.01);
[epks,etim] = findpeaks(G,t,'MinPeakProminence',0.019);

end


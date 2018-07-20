load ('ErrorTestFiles.mat');
test = table2array(errors2);
%%
tfull = test(:,1);
yfull = test(:,2);
gfull = test(:,4);
t = tfull(1:20:end,:);  % reduces array to 6250 samples
y = yfull(1:20:end,:);  % reduces array to 6250 samples
g = gfull(1:20:end,:);  % reduces array to 6250 samples

[ ypks, ytim, epks, etim] = find_peaks_iain(t,y,g);
%%
f1 = figure(1);
a1 = axes;
hold off;
plot(t,y);
ylim1 = a1.YLim;
hold on;
for n=1:length(ypks)
    plot([ytim(n) ytim(n)],ylim1, 'r');
end
%% plot(ytim, ypks, 'o');

f2 = figure(2);
a2 = axes;
hold off;
plot(t,g);
ylim2 = a2.YLim;
hold on;
for n=1:length(ypks)
    plot([etim(n) etim(n)],ylim2, 'r');
end
%% plot(etim, epks, 'o');
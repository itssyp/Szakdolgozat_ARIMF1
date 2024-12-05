file = load('W3_g1.txt');
time_moments = file(:, [1,3,5]);
disp(time_moments);

pr_lower_lim = prctile(time_moments(:,3), 10);
pr_upper_lim = prctile(time_moments(:,3), 90);

indx = (time_moments(:,3) >= pr_lower_lim & time_moments(:,3) <= pr_upper_lim & ...
    time_moments(:,2) >= 0.05 & time_moments(:,2) <= 0.15);


filt_time_moments = time_moments(indx, :);


edges = 0:10:480;
counts = histcounts(filt_time_moments(:,1), edges);
%disp(counts);

counts_mean = counts/10;

figure
bar(counts_mean);
%xticks(0:10:480)
xticklabels({'0','50','100','150','200','250','300','350','400','450'})
xlabel('idő(s)');
ylabel('átlagos SWR frekvencia (Hz)');
xline(12, '-r');
xline(36, '-r');
ylim([0, 2]);
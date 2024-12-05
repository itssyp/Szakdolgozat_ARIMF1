loaded_file = load('KA1_g1_15.txt');
loaded_file2 = load('KA2_g0_0.txt');
loaded_file3 = load('KB1_g0_8.txt');
data = loaded_file(:, [1,3,5]);
data2 = loaded_file2(:, [1,3,5]);
data3 = loaded_file3(:, [1,3,5]);

%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim = prctile(data(:,3), 10);
pr_upper_lim = prctile(data(:,3), 90);

indx = (data(:,3) >= pr_lower_lim & data(:,3) <= pr_upper_lim & ...
    data(:,2) >= 0.05 & data(:,2) <= 0.15);

filtered_data = data(indx, :);


%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim2 = prctile(data2(:,3), 10);
pr_upper_lim2 = prctile(data2(:,3), 90);

indx2 = (data2(:,3) >= pr_lower_lim2 & data2(:,3) <= pr_upper_lim2 & ...
    data2(:,2) >= 0.05 & data2(:,2) <= 0.15);

filtered_data2 = data2(indx2, :);


%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim3 = prctile(data3(:,3), 10);
pr_upper_lim3 = prctile(data3(:,3), 90);

indx3 = (data3(:,3) >= pr_lower_lim3 & data3(:,3) <= pr_upper_lim3 & ...
    data3(:,2) >= 0.05 & data3(:,2) <= 0.15);

filtered_data3 = data3(indx3, :);


%DURATION ADATOK SZORTIROZASA BL, ON, OFF FAZISBA
BL_dur = [];
ON_dur = [];
OFF_dur = [];
for i=1:length(filtered_data(:,1))
    if 0 < filtered_data(i,1) && filtered_data(i,1) < 120
        BL_dur(length(BL_dur) + 1) = filtered_data(i,2);
    elseif 120 < filtered_data(i,1) && filtered_data(i,1) < 360           
        ON_dur(length(ON_dur) + 1) = filtered_data(i,2);
    else
        OFF_dur(length(OFF_dur) + 1) = filtered_data(i,2);
    end
end


%DURATION ADATOK SZORTIROZASA BL, ON, OFF FAZISBA
BL_dur2 = [];
ON_dur2 = [];
OFF_dur2 = [];
for i=1:length(filtered_data2(:,1))
    if 0 < filtered_data2(i,1) && filtered_data2(i,1) < 120
        BL_dur2(length(BL_dur2) + 1) = filtered_data2(i,2);
    elseif 120 < filtered_data2(i,1) && filtered_data2(i,1) < 360           
        ON_dur2(length(ON_dur2) + 1) = filtered_data2(i,2);
    else
        OFF_dur2(length(OFF_dur2) + 1) = filtered_data2(i,2);
    end
end

%DURATION ADATOK SZORTIROZASA BL, ON, OFF FAZISBA
BL_dur3 = [];
ON_dur3 = [];
OFF_dur3 = [];
for i=1:length(filtered_data3(:,1))
    if 0 < filtered_data3(i,1) && filtered_data3(i,1) < 120
        BL_dur3(length(BL_dur3) + 1) = filtered_data3(i,2);
    elseif 120 < filtered_data3(i,1) && filtered_data3(i,1) < 360           
        ON_dur3(length(ON_dur3) + 1) = filtered_data3(i,2);
    else
        OFF_dur3(length(OFF_dur3) + 1) = filtered_data3(i,2);
    end
end


%ATLAG MEGHATAROZASA
BL_dur_mean = mean(BL_dur);
ON_dur_mean = mean(ON_dur);
OFF_dur_mean = mean(OFF_dur);

%ATLAG MEGHATAROZASA
BL_dur_mean2 = mean(BL_dur2);
ON_dur_mean2 = mean(ON_dur2);
OFF_dur_mean2 = mean(OFF_dur2);

%ATLAG MEGHATAROZASA
BL_dur_mean3 = mean(BL_dur3);
ON_dur_mean3 = mean(ON_dur3);
OFF_dur_mean3 = mean(OFF_dur3);

data_vector = [BL_dur_mean BL_dur_mean2 BL_dur_mean3 ON_dur_mean ON_dur_mean2 ON_dur_mean3 OFF_dur_mean OFF_dur_mean2 OFF_dur_mean3]
grp = {'bl', 'bl', 'bl', 'on', 'on' , 'on' , 'off' , 'off' , 'off' }

[p, tbl, stats] = kruskalwallis(data_vector, grp, 'off');

disp(p)
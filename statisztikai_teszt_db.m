loaded_file = load('W1_g1_8.txt');
loaded_file2 = load('W2_g0_0.txt');
loaded_file3 = load('W3_g0_6.txt');
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


%BASELINE, ON, OFF FAZISBA VALO SZORTIROZAS
BL = 0;
ON = 0;
OFF = 0;
for i=1:length(filtered_data(:,1))
    if 0 < filtered_data(i,1) && filtered_data(i,1) < 120
        BL = BL + 1;
    elseif 120 < filtered_data(i,1) && filtered_data(i,1) < 360           
        ON = ON + 1;
    else
        OFF = OFF + 1;
    end
end

%BASELINE, ON, OFF FAZISBA VALO SZORTIROZAS
BL2 = 0;
ON2 = 0;
OFF2 = 0;
for i=1:length(filtered_data2(:,1))
    if 0 < filtered_data2(i,1) && filtered_data2(i,1) < 120
        BL2 = BL2 + 1;
    elseif 120 < filtered_data2(i,1) && filtered_data2(i,1) < 360           
        ON2 = ON2 + 1;
    else
        OFF2 = OFF2 + 1;
    end
end

%BASELINE, ON, OFF FAZISBA VALO SZORTIROZAS
BL3 = 0;
ON3 = 0;
OFF3 = 0;
for i=1:length(filtered_data3(:,1))
    if 0 < filtered_data3(i,1) && filtered_data3(i,1) < 120
        BL3 = BL3 + 1;
    elseif 120 < filtered_data3(i,1) && filtered_data3(i,1) < 360           
        ON3 = ON3 + 1;
    else
        OFF3 = OFF3 + 1;
    end
end

data_vector = [BL BL2 BL3 ON ON2 ON3 OFF OFF2 OFF3]
grp = {'bl', 'bl', 'bl', 'on', 'on' , 'on' , 'off' , 'off' , 'off' }

[p, tbl, stats] = kruskalwallis(data_vector, grp, 'off');

disp(p)

%comparisons = multcompare(stats, 'CType', 'bonferroni');
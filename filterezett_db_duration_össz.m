data = load('W1_g1.txt');
data2 = load('W2_g0.txt');
data3 = load('W3_g0.txt');
start_dur_medz = data(:, [1,3,5]);
start_dur_medz2 = data2(:, [1,3,5]);
start_dur_medz3 = data3(:, [1,3,5]);



%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim = prctile(start_dur_medz(:,3), 10);
pr_upper_lim = prctile(start_dur_medz(:,3), 90);

indx = (start_dur_medz(:,3) >= pr_lower_lim & start_dur_medz(:,3) <= pr_upper_lim & ...
    start_dur_medz(:,2) >= 0.05 & start_dur_medz(:,2) <= 0.15);


filtered_data = start_dur_medz(indx, :);

%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim2 = prctile(start_dur_medz2(:,3), 10);
pr_upper_lim2 = prctile(start_dur_medz2(:,3), 90);

indx2 = (start_dur_medz2(:,3) >= pr_lower_lim2 & start_dur_medz2(:,3) <= pr_upper_lim2 & ...
    start_dur_medz2(:,2) >= 0.05 & start_dur_medz2(:,2) <= 0.15);


filtered_data2 = start_dur_medz2(indx2, :);

%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim3 = prctile(start_dur_medz3(:,3), 10);
pr_upper_lim3 = prctile(start_dur_medz3(:,3), 90);

indx3 = (start_dur_medz3(:,3) >= pr_lower_lim3 & start_dur_medz3(:,3) <= pr_upper_lim3 & ...
    start_dur_medz3(:,2) >= 0.05 & start_dur_medz3(:,2) <= 0.15);


filtered_data3 = start_dur_medz3(indx3, :);


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


BL_ossz = BL+BL2+BL3
ON_ossz = ON+ON2+ON3
OFF_ossz = OFF+OFF2+OFF3

Z = [BL_ossz/3,ON_ossz/3,OFF_ossz/3]

BL_ossz_v = [BL BL2 BL3]
ON_ossz_v = [ON ON2 ON3]
OFF_ossz_v = [OFF OFF2 OFF3]


BL_ossz_std_dev = std(BL_ossz_v);
ON_ossz_std_dev = std(ON_ossz_v);
OFF_ossz_std_dev = std(OFF_ossz_v);

X = [BL_ossz_std_dev ON_ossz_std_dev OFF_ossz_std_dev];
disp(X);

%DBSZAM ABRAZOLAS
figure
bar(Z)
hold on;
errorbar(1,Z(1,1),BL_ossz_std_dev , 'k', 'LineStyle', 'none'); 
errorbar(2,Z(1,2),ON_ossz_std_dev , 'k', 'LineStyle', 'none');
errorbar(3,Z(1,3),OFF_ossz_std_dev , 'k', 'LineStyle', 'none');
xticklabels({'BL','ON','OFF'})
for i = 1:length(Z)
    text(i, Z(i), num2str(Z(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
total = BL_ossz/3+ON_ossz/3+OFF_ossz/3;
text(0, 160, ['Total: ', num2str(total)], 'FontWeight', 'bold')
ylim([0, 180]);
title('SWR-ek átlagos száma időpillanatokban és szórás') 
ylabel('SWR-ek átlagos száma [db]')

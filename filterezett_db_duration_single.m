data = load('W3_g1_7.txt');
start_dur_medz = data(:, [1,3,5])
%disp(start_dur_medz);

%FILTEREZES PERCENTILIS ÉS DURATION ALAPJAN 
pr_lower_lim = prctile(start_dur_medz(:,3), 10);
pr_upper_lim = prctile(start_dur_medz(:,3), 90);

indx = (start_dur_medz(:,3) >= pr_lower_lim & start_dur_medz(:,3) <= pr_upper_lim & ...
    start_dur_medz(:,2) >= 0.05 & start_dur_medz(:,2) <= 0.15);


filtered_data = start_dur_medz(indx, :);
%disp(filtered_data);

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

Z = [BL,ON,OFF]

%DBSZAM ABRAZOLAS
figure
bar(Z)
xticklabels({'BL','ON','OFF'})
for i = 1:length(Z)
    text(i, Z(i), num2str(Z(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
total = length(filtered_data(:,1));
text(0, 160, ['Total: ', num2str(total)], 'FontWeight', 'bold')
ylim([0, 180]);
title('SWR-ek szortírozása időpillanatok alapján')
ylabel('SWR-ek száma [db]')

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

%ATLAG ES SZORAS MEGHATAROZASA
BL_dur_mean = mean(BL_dur);
ON_dur_mean = mean(ON_dur);
OFF_dur_mean = mean(OFF_dur);

BL_dur_std_dev = std(BL_dur);
ON_dur_std_dev = std(ON_dur);
OFF_dur_std_dev = std(OFF_dur);

Z_2 = [BL_dur_mean,ON_dur_mean,OFF_dur_mean];

figure
bar(Z_2)
hold on;
errorbar(1,Z_2(1,1),BL_dur_std_dev , 'k', 'LineStyle', 'none'); 
errorbar(2,Z_2(1,2),ON_dur_std_dev , 'k', 'LineStyle', 'none');
errorbar(3,Z_2(1,3),OFF_dur_std_dev , 'k', 'LineStyle', 'none');
xticklabels({'BL','ON','OFF'})
for i = 1:length(Z_2)
    text(i, Z_2(i), num2str(Z_2(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

title('SWR-ek adott fázisokban mért átlagos időtartamának hossza, szórása')
ylabel('SWR-ek átlagos időtartama [s]')
ylim([0, 0.15]);

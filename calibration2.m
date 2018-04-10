% Plot out to visulize whether the guessed "mu" is good enough
% Mengtang Li
% 2018 Mar 8

clear;

% 4 sets of data were collected.
angle = load('C:\Users\lim14\Documents\MATLAB\Project_504\Bending_Actuator\calibration\data_angle9.mat');
pressure = load('C:\Users\lim14\Documents\MATLAB\Project_504\Bending_Actuator\calibration\data_pressure9.mat');

figure(2);
hold on; grid minor; grid on;
yyaxis left;
plot(angle.data.Time, angle.data.Data, 'b', 'linewidth', 2);
ylabel('angle, deg');
yyaxis right;
plot(pressure.data.Time, pressure.data.Data, 'r', 'linewidth', 2);
ylabel('pressure, bar');
xlabel('time, sec');
hold off;

figure(3);
hold on; grid minor; grid on;
plot(angle.data.Time, angle.data.Data, 'b', 'linewidth', 2);
angle_est_up = 3.6776*(pressure.data.Data).^2+44.611*(pressure.data.Data)+39.746;
plot(pressure.data.Time, angle_est_up, 'r', 'linewidth', 2);
% angle_est_down = 5.852*(pressure.data.Data).^2+40.238*(pressure.data.Data)+47.834;
% plot(pressure.data.Time, angle_est_down, 'm', 'linewidth', 2);
legend('accelerometer', 'pressure estimated');
% legend('accelerometer', 'pressure estimated (up)', 'pressure estimated (down)');
xlabel('time, sec');
hold off;
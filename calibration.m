% Plot out to visulize whether the guessed "mu" is good enough
% Mengtang Li
% 2018 Mar 8

clear;

% 4 sets of data were collected.
angle = load('C:\Users\lim14\Documents\MATLAB\Project_504\Bending_Actuator\calibration\data_angle6.mat');
pressure = load('C:\Users\lim14\Documents\MATLAB\Project_504\Bending_Actuator\calibration\data_pressure6.mat');

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
angle_est = 8.1471*(pressure.data.Data).^2+53.647*(pressure.data.Data)+1.8297;
plot(pressure.data.Time, angle_est, 'r', 'linewidth', 2);
legend('accelerometer', 'pressure estimated');
xlabel('time, sec');
hold off;
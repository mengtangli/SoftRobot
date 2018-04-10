% Vary mu and calibrate the robot.
% Mengtang Li
% 2018 Mar 6

clear;

a = 8e-3; % [m]
b = 2e-3; % [m]
t = 2e-3; % [m]
L = 160e-3; % [m]
mu1 = 0.314e6; % [Pa] probably has to be changed
mu2 = 0.720e6; % [Pa]
n = 201;
Angle_record = zeros(1,n);
Pin1_record = zeros(1,n);
Pin2_record = zeros(1,n);
M_theta1_record = zeros(1,n);
M_theta2_record = zeros(1,n);

for i = 0:1:(n-1)
    
    theta = i*pi/180;
    theta_new = theta-40*pi/180;
    Angle_record(i+1) = i;
    % original mu
    fun_beta1 = @(beta) mu1*L*beta*(a+t).*((beta*theta_new+L)/L-L^3./(beta*theta_new+L).^3);
    int11 = integral(fun_beta1, 0, b);
    
    fun_phitao1 = @(phi,tao) mu1*((a+tao).^2.*sin(phi)+b*(a+tao)).*...
        ((L+b*theta_new+sin(phi).*(a+tao)*theta_new)/L-L^3./(L+b*theta_new+sin(phi).*(a+tao)*theta_new).^3);
    int12 = integral2(fun_phitao1, 0, pi/2, 0, t);
    
    M_theta1 = 2*(int11+int12);
    M_theta1_record(i+1) = M_theta1;
    Pin1 = 6*M_theta1/(4*a^3+3*pi*a^2*b);
    Pin1_record(i+1) = Pin1;
    
    % original new mu
    fun_beta2 = @(beta) mu2*L*beta*(a+t).*((beta*theta_new+L)/L-L^3./(beta*theta_new+L).^3);
    int21 = integral(fun_beta2, 0, b);
    
    fun_phitao2 = @(phi,tao) mu2*((a+tao).^2.*sin(phi)+b*(a+tao)).*...
        ((L+b*theta_new+sin(phi).*(a+tao)*theta_new)/L-L^3./(L+b*theta_new+sin(phi).*(a+tao)*theta_new).^3);
    int22 = integral2(fun_phitao2, 0, pi/2, 0, t);
    
    M_theta2 = 2*(int21+int22);
    M_theta2_record(i+1) = M_theta2;
    Pin2 = 6*M_theta2/(4*a^3+3*pi*a^2*b);
    Pin2_record(i+1) = Pin2;
    
end

figure(1);
plot(Pin1_record*1e-5, Angle_record, 'b', 'LineWidth', 2);
hold on; grid minor; grid on;
plot(Pin2_record*1e-5, Angle_record, 'r', 'LineWidth', 2);
legend('orignial mu', 'new mu');
xlabel('Pressure/Bar');
ylabel('Angle/deg');

% points_x = [1.331 1.388 2.011 1.235 2.654];
% points_y = [89.96 99.98 147.7 104.5 159.7];
% points_x = [1.954 1.992 2.269 1.241];
% points_y = [141 144.3 166.8 105.8];
% points_x = [1.75 2.134 2.183 2.365 2.23 1.937 1.734 1.309];
% points_y = [117.3 149.7 156.1 172.5 172.5 154.7 140.5 112.2];
% points_x = [0.0033    1.2223    2.1096    2.2198    2.4440    2.4656    2.2464 1.9937    1.7709    1.5667    1.4176    1.2947    1.2203    1.1576 1.1466    0.8995    0.6741    0.5064    0.3749    0.2716    0.2002 0.1408    0.0979    0.0747    0.0547    0.0312    0.0259    0.0162 0.0172    0.0126];
% points_y = [47.8913   92.8702  147.2510  163.5431  178.3377  175.0709  174.3579 159.5703  144.6355  131.8837  121.6594  113.8461  108.0676  104.4089 102.9223   92.0710   77.7852   68.8689   61.6655   57.8581   55.4084  53.6315   52.6316   51.3316   51.2317   50.8626   50.4344   50.1342 49.6053   49.9684];

angle = load('C:\Users\lim14\Documents\MATLAB\Project_504\Bending_Actuator\calibration\data_angle9.mat');
pressure = load('C:\Users\lim14\Documents\MATLAB\Project_504\Bending_Actuator\calibration\data_pressure9.mat');
points_x = zeros(1,30);
points_y = zeros(1,30);
for i = 1:30
    points_x(i) = pressure.data.Data(i*500);
    points_y(i) = angle.data.Data(i*500);
end
plot(points_x(1,1:11), points_y(1,1:11), 'k+', 'linewidth', 2);
plot(points_x(1,11:end), points_y(1,11:end), 'ko', 'linewidth', 2);

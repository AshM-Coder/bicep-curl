% Dynamic biomechanical simulation and animation of a bicep curl
%
% Extends the static analysis into a dynamic system: a muscle-driven
% forearm undergoing simple harmonic motion under a carried load.
% Simulates and animates the joint kinematics (theta, omega, alpha),
% the required muscle force, and the resulting reaction forces over time.
%
% Inputs (entered by the user at runtime):
%   theta_o   - range-of-motion angle [deg], constrained to 0-60
%   reps/min  - repetition rate [min^-1]
%   m_weight  - mass of the carried weight [kg]
%
% Output: a synchronised animation showing the arm motion alongside
%         time-series plots of theta, R_par, R_prep, and F_muscle
%
clear
close all
clc
% Code up fixed parameters.
m_arm= 3; %[kg]
g=9.81; %[ms^-2]
a= 0.075; %[m]
b= 0.42; %[m]
mu_u=0.15; %[m]
mu_d=0.03; %[m]
t=linspace(0,30,100); %[s]
% Asks for user inputs.
thetao=input('Please input a value for the angle characteristic range of motion between 0 and 60 inclusive [deg]:\n');
if thetao<=60 && thetao>=0
    theta_o=(thetao/180)*pi; %[rad]
else 
    thetao=input('Please input a value for the angle characteristic range of motion between 0 and 60 inclusive [deg]:\n');
    theta_o=(thetao/180)*pi; %[rad]
end
reps_per_min=input('Please input a value for the number of reps per minute [min^-1]:\n');
m_weight=input('Please input a value for the mass of the carried weight [kg]:\n');
%
%Calculations
W_arm=m_arm*g; %[N]
W_weight=m_weight*g; %[N]
I_o= 0.03525 + 0.1804*m_weight; %Moment of inertia
r_com=(0.225 + 0.42*m_weight)/(3+m_weight); %location of centre of mass of system
%
f=reps_per_min/60; %[s^-1]frequency of motion
p= 2*pi*f; %[s^-1]angular frequency of motion
theta=theta_o.*cos(p.*t); %[rad]
omega= -theta_o.*p.*sin(p.*t); %[rad/s]
alpha= -theta_o.*p.*p.*cos(p.*t); %[rad/s^2]
% to be substituted
subst_1= sqrt((mu_u^2) + (mu_d^2) - (2.*mu_u.*mu_d.*sin(theta))); 
subst_2= (I_o.*alpha)+ ((a*m_arm + b*m_weight).*g.*cos(theta)); 
subst_3=(mu_d - (mu_u.*sin(theta))); 
subst_4= (m_arm+m_weight) .* ((g.*sin(theta)) - ((omega.^2).*r_com));
subst_5= (m_arm+m_weight) .* ((g.*cos(theta)) + (alpha.*r_com));
%
F_muscle= (subst_1.*subst_2)./(mu_u*mu_d.*cos(theta));
R_par= F_muscle.*(subst_3./subst_1) + subst_4;
R_prep= subst_5 - (F_muscle.*((mu_u.*cos(theta))./subst_1));
%
figure(1)
%
subplot(4,2,[1 3 5 7])
hold on
L=b; %[m] length of rod
tip_x=L.*cos(theta); % x-coordinates of rod tip
tip_y=L.*sin(theta); % y-coordinates of rod tip
rod=animatedline('Color','#7E2F8E','LineWidth',10);
xlabel('x [m]')
ylabel('y [m]')
axis equal 
axis([0,0.5,-0.5,0.5])
title('Bicep Curl animation')
ball=animatedline('MarkerFaceColor','#77AC30','Marker','o','MarkerSize',27);
bicep_x= mu_d.*cos(theta);
bicep_y= mu_d.*sin(theta);
bicep=animatedline('Color','r','LineWidth',4);
%
subplot(4,2,2)
hold on
theta_deg= theta.*(180/pi);
plot_1=animatedline('Color','b');
xlabel('t[s]')
ylabel('theta[deg]')
title('Graph of theta[deg] vs. t[s]')
xlim([0 30])
ylim([-60 60])

%
subplot(4,2,4)
hold on
plot_2= animatedline('Color','r');
xlabel('t[s]')
ylabel('R_par[N]')
title('Graph of R_par[N] vs. t[s]')
xlim([0 30])

%
subplot(4,2,6)
hold on
plot_3= animatedline('Color','g');
xlabel('t[s]')
ylabel('R_prep[N]')
title('Graph of R_prep[N] vs. t[s]')
xlim([0 30])

%
subplot(4,2,8)
hold on
plot_4= animatedline('Color','y');
xlabel('t[s]')
ylabel('F_muscle[N]')
title('Graph of F_muscle[N] vs. t[s]')
xlim([0 30])

%
for i=1:length(t)
    clearpoints(rod) 
    addpoints(rod,[0,tip_x(i)],[0,tip_y(i)])
    clearpoints(ball)
    addpoints(ball,tip_x(i),tip_y(i))
    clearpoints(bicep)
    addpoints(bicep,[0,bicep_x(i)],[mu_u,bicep_y(i)])
    addpoints(plot_1,t(i),theta_deg(i))
    addpoints(plot_2,t(i),R_par(i))
    addpoints(plot_3,t(i),R_prep(i))
    addpoints(plot_4,t(i),F_muscle(i))
    drawnow
    pause(0.07) 
end

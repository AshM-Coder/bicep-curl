% Static reaction force and moment analysis for a bicep curl
%
% Models the arm as a static system (weight of the forearm plus a
% carried load) and computes the reaction forces and bending moment at
% the elbow joint as a function of arm angle, theta.
%
% Inputs: theta [deg], entered by the user at runtime
% Outputs: reaction force parallel to the arm, reaction force
%          perpendicular to the arm, and the bending moment at the
%          joint (printed to the command window)
%
clear
close all
clc
%
% Code up fixed parameters.
m_arm= 3; %[kg]
m_weight= 15; %[kg]
g=9.81; %[ms^-2]
a= 0.075; %[m]
b= 0.42; %[m]
%Calculations
W_arm=m_arm*g; %[N]
W_weight=m_weight*g; %[N]
%
% Asks for user inputs.
theta=input('Please input a value for theta [deg]:\n');
%
R_x= W_arm*sind(theta) + W_weight*sind(theta); %[N], parallel reaction force
R_y= W_arm*cosd(theta) + W_weight*cosd(theta); %[N], perpendicular reaction force
M_o= (W_arm*a + W_weight*b)*cosd(theta); %[Nm]
%
result='The %s is %.2f[N].\n'; % sentence to be displayed
results='The %s is %.2f[Nm].\n';
%
% Reports the three forces.
fprintf(result,'reaction force at Point O parallel to the arm segment',R_x)
fprintf(result,'reaction force at Point O perpendicular to the arm segment',R_y)
fprintf(results,'Moment at O',M_o)




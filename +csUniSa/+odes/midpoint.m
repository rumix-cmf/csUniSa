function [t, y] = midpoint( odefun, tspan, y0, h, y1 )
%MIDPOINT Solve ODEs using the midpoint method.
% This MATLAB function, where tspan = [t0 tf], integrates the system of
% differential equations y'=f(t,y) from t0 to tf with initial conditions
% y0.This is a second order, two step, explcit method.
%
% Syntax
%   [t,y] = MIDPOINT( odefun, tspan, y0, h, y1 )
%
% Inputs
%   odefun - Functions to solve
%     function handle
%   tspan - Interval of integration
%     vector
%   y0 - Initial values
%     column vector
%   h - Step size
%     positive value
%   y1 - Starting values
%     column vector
%
% Output Arguments
%   t - Evaluation points
%     column vector
%   y - Solutions
%     array


% Generate time vector
t = (tspan(1):h:tspan(2))';

% Initialise solution vector
n = length( t );
y = zeros( n, length( y0 ) );
y(1,:) = y0';
y(2,:) = y1';

% Main loop
for i = 1:n-2
  y(i+2,:) = y(i,:) + 2*h*odefun( t(i+1), y(i+1,:)' )';
end
end
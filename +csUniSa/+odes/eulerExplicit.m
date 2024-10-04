function [t, y] = eulerExplicit( odefun, tspan, y0, h )
%EULEREXPLICIT Solve ODEs using Euler's method (explicit)
% This MATLAB function, where tspan = [t0 tf], integrates the system of
% differential equations y'=f(t,y) from t0 to tf with initial conditions
% y0.
%
% Syntax
%   [t,y] = EULEREXPLICIT( odefun, tspan, y0, h )
%
% Inputs
%   odefun - Functions to solve
%     function handle
%   tspan - Interval of integration
%     vector
%   y0 - Initial conditions
%     column vector
%   h - Step size
%     positive value
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
y = zeros( n, length(y0) );
y(1,:) = y0(:)';

% Main loop
for i = 1:n-1
  y(i+1,:) = y(i,:) + h * odefun( t(i), y(i,:)' )';
end
end
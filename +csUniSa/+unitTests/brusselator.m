function odefun = brusselator( A, B )
%BRUSSELATOR Brusselator ivp handle.
% Depends on two parameters A and B.
%
% Syntax
%   odefun = brusselator( A, B )

odefun = str2func( sprintf( '@(t,y) [%d + y(1)^2*y(2) - (%d+1)*y(1); %d*y(1) - y(1)^2*y(2)];', A, B, B ) );
end


%% Inizializzazione del problema

ivp = csUniSa.unitTests.ivp( [], [0 20], [1.5 3]', 'brusselator', [1 3] );
sol = [0.4986370713, 4.596780349]';
h = [0.1 0.05 0.025 0.0125 0.00625 0.003125];
tab = zeros( length( h ), 3 );
cd = zeros( length( h ), 1);
pest = cd;
tab(:,1) = h;

% Metodo 1
% csUniSa.odes.eulerExplicit

% Metodo 2
function [t, y] = metodo2( odefun, tspan, ivs, h, a )

    % Generate time vector
    t = (tspan(1):h:tspan(2))';
    
    % Initialise solution vector
    n       = length( t );
    y       = zeros( n, length( ivs(:,1) ) );
    y(1,:)  = ivs(:,1)';
    y(2,:)  = ivs(:,2)';
    
    % Main loop
    for i = 1:n-2
        y(i+2,:) = ...
            (1+a) * y(i+1,:) ...
            - a *   y(i,:) ...
            + h/2 * ((3-a)*odefun( t(i+1), y(i+1,:)' )'...
                     -(1+a)*odefun( t(i), y(i,:)' )');
    end
end

% Metodo 3
function [t, y] = metodo3( odefun, tspan, ivs, h )

    % Generate time vector
    t = (tspan(1):h:tspan(2))';
    
    % Initialise solution vector
    n       = length( t );
    y       = zeros( n, length( ivs(:,1) ) );
    y(1,:)  = ivs(:,1)';
    y(2,:)  = ivs(:,2)';
    
    % Main loop
    for i = 1:n-2
        y(i+2,:) = ...
            y(i+1,:) ...
            + h/3 * (3*odefun( t(i+1), y(i+1,:)' )' ...
                     - 2*odefun(t(i), y(i,:)' )');
    end
end

%% Metodo 1
for i = 1:length( h )
    [t y] = ivp.solve( 'eulerE', h(i) );
    cd(i) = -log10( norm( y(end,:)'-sol ) );
end

for i = 2:length( h )
  pest(i) = (cd(i)-cd(i-1)) / log10(2);
  tab(i, 2) = cd(i);
  tab(i, 3) = pest(i);
end

tab(1, 2) = cd(1);
tab(1, 3) = NaN;
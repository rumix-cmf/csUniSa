%% Problema. Soluzione esatta. Metodi

% Problema
odefun  = @(t,y) 4*t*sqrt(y);
tspan   = [0 1];
y0      = 1;

% Soluzione esatta
sol = @(t) (1+t.^2).^2;

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

%% Metodo 1. Tabella e grafico

% Inizializza tabelle
solutionTab         = zeros( 11, 5 );
solutionTab(:,1)    = (0:0.1:1)';
errorTab            = zeros( 11, 4);
errorTab(:,1)       = (0:0.1:1)';

% Inizializza grafici
figure( 1 )
fplot( sol, [0 1], 'k' )
hold on
figure( 2 )
hold on

% Soluzioni con passi diversi
h = [0.1 0.05 0.025];
for i = 1:length(h)

    % Calcola soluzioni ed errori, aggiorna grafici
    [t, y] = csUniSa.odes.eulerExplicit( odefun, tspan, y0, h(i) );
    exactValues = sol( t );
    err = abs( y - exactValues );
    figure( 1 )
    plot( t, y, '*' )
    figure( 2 )
    plot( t, err, '-*' )

    % Aggiorna tabelle
    for j = 1:11
        solutionTab(j,2) = exactValues((2^(i-1))*(j-1) +1);
        solutionTab(j,i+2) = y((2^(i-1))*(j-1) +1);
        errorTab(j,i+1) = err((2^(i-1))*(j-1) +1);
    end
end
figure( 1 )
legend( 'sol', 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 1' )
hold off
figure( 2 )
legend( 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 1 - Errore' )
hold off

%% Metodo 2, a=0. Tabella e grafico

% Inizializza tabelle
solutionTab         = zeros( 11, 5 );
solutionTab(:,1)    = (0:0.1:1)';
errorTab            = zeros( 11, 4);
errorTab(:,1)       = (0:0.1:1)';

% Inizializza grafici
figure( 1 )
fplot( sol, [0 1], 'k' );
hold on
figure( 2 )
hold on

% Soluzioni con passi diversi
h = [0.1 0.05 0.025];
for i = 1:length(h)

    % Calcola soluzioni ed errori, aggiorna grafici
    ivs = [y0 sol(h(i))];
    [t, y] = metodo2( odefun, tspan, ivs, h(i), 0 );
    exactValues = sol( t );
    err = abs( y - exactValues );
    figure( 1 )
    plot( t, y, '*' );
    figure( 2 )
    plot( t, err, '-*' );

    % Aggiorna tabelle
    for j = 1:11
        solutionTab(j,2) = exactValues((2^(i-1))*(j-1) +1);
        solutionTab(j,i+2) = y((2^(i-1))*(j-1) +1);
        errorTab(j,i+1) = err((2^(i-1))*(j-1) +1);
    end
end
figure( 1 )
legend( 'sol', 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 2, a=0' )
hold off
figure( 2 )
legend( 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 2, a=0 - Errore' )
hold off

%% Metodo 2, a=-5. Tabella e grafico

% Inizializza tabelle
solutionTab         = zeros( 11, 5 );
solutionTab(:,1)    = (0:0.1:1)';
errorTab            = zeros( 11, 4);
errorTab(:,1)       = (0:0.1:1)';

% Inizializza grafici
figure( 1 )
fplot( sol, [0 1], 'k' );
hold on
figure( 2 )
hold on

% Soluzioni con passi diversi
h = [0.1 0.05 0.025];
for i = 1:length(h)

    % Calcola soluzioni ed errori, aggiorna grafici
    ivs = [y0 sol(h(i))];
    [t, y] = metodo2( odefun, tspan, ivs, h(i), -5 );
    exactValues = sol( t );
    err = abs( y - exactValues );
    figure( 1 )
    plot( t, y, '*' );
    figure( 2 )
    plot( t, err, '-*' );

    % Aggiorna tabelle
    for j = 1:11
        solutionTab(j,2) = exactValues((2^(i-1))*(j-1) +1);
        solutionTab(j,i+2) = y((2^(i-1))*(j-1) +1);
        errorTab(j,i+1) = err((2^(i-1))*(j-1) +1);
    end
end
figure( 1 )
legend( 'sol', 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 2, a=-5' )
hold off
figure( 2 )
legend( 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 2, a=-5 - Errore' )
hold off

%% Metodo 3. Tabella e grafico

% Inizializza tabelle
solutionTab         = zeros( 11, 5 );
solutionTab(:,1)    = (0:0.1:1)';
errorTab            = zeros( 11, 4);
errorTab(:,1)       = (0:0.1:1)';

% Inizializza grafici
figure( 1 )
fplot( sol, [0 1], 'k' );
hold on
figure( 2 )
hold on

% Soluzioni con passi diversi
h = [0.1 0.05 0.025];
for i = 1:length(h)

    % Calcola soluzioni ed errori, aggiorna grafici
    ivs = [y0 sol(h(i))];
    [t, y] = metodo3( odefun, tspan, ivs, h(i) );
    exactValues = sol( t );
    err = abs( y - exactValues );
    figure( 1 )
    plot( t, y, '*' );
    figure( 2 )
    plot( t, err, '-*' );

    % Aggiorna tabelle
    for j = 1:11
        solutionTab(j,2) = exactValues((2^(i-1))*(j-1) +1);
        solutionTab(j,i+2) = y((2^(i-1))*(j-1) +1);
        errorTab(j,i+1) = err((2^(i-1))*(j-1) +1);
    end
end
figure( 1 )
legend( 'sol', 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 3' )
hold off
figure( 2 )
legend( 'h 0.1', 'h 0.05', 'h 0.025', 'Location', 'best' )
title( 'Metodo 3 - Errore' )
hold off
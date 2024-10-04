classdef ivp
  %IVP This class represents any initial value problem.

  properties
    odefun
    tspan
    y0
    sol
  end

  methods
    function obj = ivp( problem, odefun, tspan, y0, varargin )
      %IVP Contruct an instance of this class.
      % Can also reference any implemented problem, as long as any
      % required parameter is also passed. In particular, you can get a
      % default instance of a problem by passing just the name.
      %
      % Syntax
      %   obj = ivp( [], odefun, tspan, y0 )
      %   obj = ivp( problem )
      %   obj = ivp( problem, [], tspan, y0, varargin )
      %
      % Input Arguments
      %   problem - name of an implemented problem, see examples
      %     string
      %   odefun - Functions to solve
      %     function handle
      %   tspan - Interval of integration
      %     vector
      %   y0 - Initial value
      %     column vector
      %   varargin - Required parameters for the chosen method
      %
      % Examples
      %   
      %   obj = ivp( 'brusselator', [], tspan, y0, A, B )
      %   obj = ivp( 'brusselator' )

      if nargin == 1 % default instance of implemented problem
        switch problem
          case 'brusselator'
            obj.tspan = [0 20];
            obj.y0 = [1.5 3]';
            obj.odefun = csUniSa.unitTests.brusselator( 1, 3 );
        end
      else % generic instance of implemented ivp
        obj.tspan = tspan;
        obj.y0 = y0;
        switch problem
          case 'brusselator'
            A = varargin{1};
            B = varargin{2};
            obj.odefun = csUniSa.unitTests.brusselator( A, B );
  
          otherwise % generic ivp
            obj.odefun = odefun;
        end
      end
    end

    function [t, y] = solve( obj, command, varargin )
      %SOLVE Solve the problem using any suitable command.
      %
      % Syntax
      %   obj.solve( command, varargin )
      %
      %   Default command is ode23. Required parameters of custom methods
      %   must be provided.
      %
      % Examples
      %   obj.solve
      %   obj.solve( ode45 )
      %   obj.solve( euler, h )
      %   obj.solve( midpoint, h, start)

      if nargin == 1
        command = 'ode23';
      end

      % Commands with no special parameters besides timespan and initial
      % values, e.g. ode45
      if nargin <= 2
        commandStr = sprintf( '[t y] = %s( obj.odefun, obj.tspan, obj.y0 );', command );
      end

      % Custom methods in this library
      switch command
        case 'euler'
          h = varargin{1};
          commandStr = '[t y] = csUniSa.odes.euler( obj.odefun, obj.tspan, obj.y0, h );';
          command = sprintf( 'Euler, h=%0.6f', h );

        case 'midpoint'
          h = varargin{1};
          y1 = varargin{2};
          commandStr = '[t y] = csUnisa.odes.midpoint( obj.odefun, obj.tspan, obj,y0, h, y1 );';
          command = sprintf( 'Midpoint, h=%0.6f', h);
      end

      eval( commandStr );
      plot( t, y )
      title( command )
    end
  end
end
classdef ivp
  %IVP This class represents any initial value problem.

  properties
    odefun
    tspan
    y0
    sol
  end

  methods
    function obj = ivp( odefun, tspan, y0, problem, parameters )
      %IVP Contruct an instance of this class.
      % Can also reference any implemented problem, as long as any
      % required parameter is also passed.
      %
      % Syntax
      %   obj = ivp( tspan, y0, odefun )
      %   obj = ivp( tspan, y0, problem, parameters )
      %
      % Input Arguments
      %   odefun - Functions to solve
      %     function handle
      %   tspan - Interval of integration
      %     vector
      %   y0 - Initial value
      %     column vector
      %   problem - name of an implemented problem, see examples
      %     string
      %   parameters - Required parameters for the chosen method, bundled
      %   in a vector
      %
      % Examples
      %   
      %   obj = ivp ( tspan, y0, 'brusselator', [A B] )

      obj.tspan = tspan;
      obj.y0 = y0;

      if nargin == 4
        obj.odefun = odefun;
      end

      switch problem
        case 'brusselator'
          % Parameters: A, B
          A = parameters(1);
          B = parameters(2);
          obj.odefun = csUniSa.unitTests.brusselator( A, B );

        otherwise
          error("There is no such problem")
      end
    end

    function [t, y] = solve( obj, command, parameters )
      %SOLVE Solve the problem using any suitable command.
      %
      % Syntax
      %   obj.solve( command, parameters )
      %
      %   Default command is ode23. Required parameters of custom methods
      %   must be provided.
      %
      %   Examples
      %     obj.solve( eulerE, h )
      %
      %   Inputs
      %     parameters - Required parameters for the chosen method, bundled
      %     in a vector

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
        case 'eulerE'
          h = parameters(1);
          commandStr = '[t y] = csUniSa.odes.eulerExplicit( obj.odefun, obj.tspan, obj.y0, h );';
          command = sprintf( 'Euler (explicit), h=%0.6f', h );
      end

      eval( commandStr );
      plot( t, y )
      title( command )
    end
  end
end
%{
    Authors: 
        Anton Kostyuchenko

    Notes:
        syms x; % w/ respect to what to differentiate
        f = @(x)x^2;
        f = sym(f); % convert to normal function?
        df = diff(f) % differentiate
        % convert to normal function ??
%}

%{
    Class to contain different methods
    for finding roots of functions
%}
classdef RootFinder
    
    properties
        value_tolerance
        error_tolerance
        max_iterations
        
        ReturnReasons = struct(... % enumerator~ish
            'MAX_ITERATIONS_EXCEEDED', 1, ...
            'ERROR_TOLERANCE_SATISFIED', 2, ...
            'VALUE_TOLERANCE_SATISFIED', 3, ...
            'ERROR', 4 ...
        ); 
    end % properties
    
    methods
        
        % Constructor
        function obj = RootFinder(varargin)
            %fprintf('val: %d\n', varargin);
            
            p = inputParser;
            
            addOptional(p,'value_tolerance', 10^(-16), @isnumeric);
            addOptional(p,'error_tolerance', 10^(-16), @isnumeric);
            addOptional(p,'max_iterations', 100, @isnumeric);

        end % Constructor
        

        
        %{
        Input: 
            f - function
            a - start point
            b - end point
        Output: r (root)

        Notes:
            format long 
            to get more decimal places
        %} 
        function r = bisection(obj, f, a, b)
            fprintf('function: %s, startingpoint: %d, ending point: %d\n', func2str(f), a, b);
            
            counter = 0;
    
            f_a = f(a);
            f_b = f(b);

%             c = (a + b)/2;
% 
%             max_error = c - a;
% 
%             f_c = f(c);

            while (counter < obj.max_iterations) && (abs(f_c) > obj.value_tolerance) && (max_error > obj.error_tolerance)
                
                c = (a + b) / 2;
                f_c = f(c);
                max_error = c - a;

                if (f_a * f_c) < 0
                    b = c;
                    f_b = f_c;
                else
                    a = c;
                    f_a = f_c;
                end

                counter = counter + 1;
            end

            fprintf('steps performed: %3d', counter)
            r = c;
        end % bisection
        
        function r = newtons(obj, f, x_0)
            fprintf('function: %s, starting point: %d\n', func2str(f), x_0);
                % Constants:
            value_tolerance = 10^(-16);
            max_iterations = 100;
            % End constants

            c = df(x0)\ f(x0) ; 

            x = x0 - c;

            counter = 0;

            while (counter <= max_iterations) && (abs(c) > error_tolerance)
                c = df(x) \ f(x0) ; % backwards division thing does correct division for matrixes

                x = x - c;

                counter = counter + 1;
            end

            r = x;
            fprintf('steps: %3d', counter);

            if(counter >= max_iterations - 1)
                fprintf('maximum iteration exceeded.\n')
            end
        end % newtons
                
        % Helper Methods TODO: Move into Utility class or smth like that?
        
        function r = terminate_check(obj, iteration_count, value, error)
            r = (iteration_count >= obj.max_iterations - 1) && ... % assumes that counter started at 0
                    (abs(value) <= obj.value_tolerance) && ...
                    (abs(error) <= obj.error_tolerance)
        end
        
        % END Helper Methods
    
    end % methods
end % RootFinder
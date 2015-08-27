%{
    Input: 
        f - function
        df - derivative of f
        x0 - starting x
        error_tolerance - acceptable error value
    Output:
        root (if fortunate)

    Note:
        read Thm 3.5 (under certain conditions converges quadratically)

        note newton's method to solve system of 3 equations
%}

function r = newton(f, df, x0, error_tolerance)
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
end
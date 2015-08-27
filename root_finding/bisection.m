%{
    Input: f, a, b
    Output: r (root)

    Notes:
        format long 
        to get more decimal places
%}
function r = bisection(f, a, b, error_tolerance)
    %{
        when to stop loop?
        f(c) close to 0 OR
        maximum num of iterations OR
        (maximum) error small enough (|x_k - r|, different from first possible
        condition)
    %}
    % Constants:
    max_iterations = 100;
    value_tolerance = 10^(-16);
    %error_tolerance = 10^(-3);
    % End constants
    
    counter = 0;
    
    f_a = f(a);
    f_b = f(b);

    c = (a + b)/2;

    max_error = c - a;

    f_c = f(c);
    
    while (counter < max_iterations) && (abs(f_c) > value_tolerance) && (max_error > error_tolerance)
   
        
        if (f_a * f_c) < 0
            b = c;
            f_b = f_c;
        else
            a = c;
            f_a = f_c;
        end
        
        c = (a + b) / 2;
        f_c = f(c);
        max_error = c - a;

        
        counter = counter + 1;
    end
    
    fprintf('steps performed: %3d', counter)
    r = c;

    
    
function I = set_constant_current_sequence(time_length, I_val)

if nargin < 2
    I_val = 100;
end

I = zeros(1, time_length);
I(3001:time_length-3000) = I_val;


function I = set_constant_current_sequence(time_length, I_val)

if nargin < 2
    I_val = 90;
end

I = zeros(1, time_length);
I(:) = I_val;

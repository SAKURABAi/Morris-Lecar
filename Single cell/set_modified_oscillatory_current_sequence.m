function I = set_modified_oscillatory_current_sequence(time_length, step, tau_up, tau_down, section_time, I_max)

if nargin == 5
    I_max = 100;
end
I = zeros(1, time_length);
section_length = section_time / step;
down_length = floor(section_length * tau_down / (tau_down + tau_up));
up_length = ceil(section_length * tau_up / (tau_down + tau_up));
I_up = zeros(1, up_length);
I_down = zeros(1, down_length);
I_down(1) = I_max; I_up(1) = I_max;
for i = 1:down_length-1
    I_down(i + 1) = I_down(i) - (I_down(i)/tau_down) * step;
end
for i = 1:up_length-1
    I_up(i + 1) = I_up(i) - (I_up(i)/tau_up) * step;
end
for i = 1:int64(time_length/section_length)
    I((i-1)*section_length + 1:(i-1)*section_length + up_length) = fliplr(I_up);
    I((i-1)*section_length + up_length + 1:i*section_length) = I_down;
end
I(time_length) = I(time_length-1);
I = Normalize(I, 50, 100);
end

function A = Normalize(data, lower_bound, upper_bound)
A = (data - min(data)) ./ (max(data) - min(data)) .* (upper_bound - lower_bound) + lower_bound;
end

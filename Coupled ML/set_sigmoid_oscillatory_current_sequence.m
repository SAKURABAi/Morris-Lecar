function I = set_sigmoid_oscillatory_current_sequence(time_length, step, ratio_up, ratio_down, section_time)

I_max_up   = 150; I_min_up   = 0;
I_max_down = 150; I_min_down = 0;

I = zeros(1, time_length);
section_length = section_time / step;
down_length = floor(section_length * ratio_down / (ratio_down + ratio_up));
up_length = ceil(section_length * ratio_up / (ratio_down + ratio_up));
I_up = generate_sigmoid(up_length, 10, 'up');
I_down = generate_sigmoid(down_length, 10, 'down');

I_up = Normalize(I_up, I_min_up, I_max_up);
I_down = Normalize(I_down, I_min_down, I_max_down);
% I_down(:) = I_max_down;
for i = 1:int64(time_length/section_length)
    I((i-1)*section_length + 1:(i-1)*section_length + up_length) = I_up;
    I((i-1)*section_length + up_length + 1:i*section_length) = I_down;
end
I(time_length) = I(time_length-1);
end

function sigmoid = generate_sigmoid(section_length, boundary, type)
sigmoid = linspace(-boundary, boundary, section_length);
if strcmp(type, 'up') == 1
    sigmoid = 1 ./ (1 + exp(-sigmoid));
elseif strcmp(type, 'down') == 1
    sigmoid = 1 ./ (1 + exp(sigmoid));
else 
    disp('error');
    exit;
end
end

function A = Normalize(data, lower_bound, upper_bound)
A = (data - min(data)) ./ (max(data) - min(data)) .* (upper_bound - lower_bound) + lower_bound;
end



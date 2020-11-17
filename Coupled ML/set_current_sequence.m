function I = set_current_sequence(time_length, section_time, I_max)

% I_max   = 124;
I_min = 0;

I = zeros(1, time_length);
% section_length = section_time / step;
% down_length = floor(section_length * tau_down / (tau_down + tau_up));
% up_length = ceil(section_length * tau_up / (tau_down + tau_up));
% I_up = zeros(1, up_length);
% I_down = zeros(1, down_length);
% I_up(:) = I_max;
% I_down(:) = I_min;
% for i = 1:int64(time_length/section_length)
%     I((i-1)*section_length + 1:(i-1)*section_length + up_length) = fliplr(I_up);
%     I((i-1)*section_length + up_length + 1:i*section_length) = I_down;
% end
% I(time_length) = I(time_length-1);
% 
% I(3000:8500) = I_max;
% I(12000:18200) = I_max;
% I(22000:28200) = I_max;
I(:) = I_max;
% I(32000:38200) = I_max;

end


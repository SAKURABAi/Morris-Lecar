function [y, v_nullcline, w_nullcline] = Runge_Kutta_and_nullcline(y0, step, t_span, params, I)
% ¿ª·¢ÖÐ
y = zeros(length(y0), length(t_span));
v_nullcline = zeros(1, length(t_span));
w_nullcline = zeros(1, length(t_span));
y(:,1) = y0;
for i = 1:length(t_span) - 1
    k1 = Morris_Lecar(t_span(i), y(:,i), I(i), step, params);
    k2 = Morris_Lecar(t_span(i) + step/2, y(:, i) + step/2 * k1, I(i), step, params);
    k3 = Morris_Lecar(t_span(i) + step/2, y(:, i) + step/2 * k2, I(i), step, params);
    k4 = Morris_Lecar(t_span(i) + step, y(:, i) + step * k3, I(i), step, params);
    y(:, i + 1) = y(:, i) + (step/6) * (k1 + 2*k2 + 2*k3 + k4);
    [v_nullcline(i), w_nullcline] = MLnullcline(v_span, I, params);
end


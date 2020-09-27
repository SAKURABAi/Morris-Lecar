function w = w_inf(V, params)
% winf for Morris Lecar Model
% params: [v_3, v_4]
v_3 = params(1);
v_4 = params(2);
w = 0.5 * (1 + tanh((V - v_3)/v_4));
end


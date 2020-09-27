function tau = tau_w(V, params)
% lambda for Morris Lecar Model
% params: [v_3, v_4]
v_3 = params(1);
v_4 = params(2);
tau = 1 / (cosh((V-v_3)/(2*v_4)));
end

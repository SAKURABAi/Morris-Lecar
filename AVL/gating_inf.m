function m = gating_inf(V, params)
v_1 = params(1);
v_2 = params(2);
m = 0.5 * (1 + tanh((V - v_1)/v_2));
end


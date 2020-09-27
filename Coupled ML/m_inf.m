function m = m_inf(V, params)
% minf for Morris Lecar Model
% params: [v_1, v_2]
v_1 = params(1);
v_2 = params(2);
m = 0.5 * (1 + tanh((V - v_1)/v_2));
end


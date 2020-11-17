function dy = Morris_Lecar(t, y, I, step, params)
% differential equations for Morris Lecar model
% params: [C, I, g_Ca, g_K, g_L, v_Ca, v_K, v_L, phi, v_1, v_2, v_3, v_4, t_start, t_end]

C     = params.C;
g_Ca  = params.g_Ca;
g_K   = params.g_K;
g_L   = params.g_L;
v_Ca  = params.v_Ca;
v_K   = params.v_K;
v_L   = params.v_L;
phi   = params.phi;
v_1   = params.v_1;
v_2   = params.v_2;
v_3   = params.v_3;
v_4   = params.v_4;

V = y(1);
w = y(2);

%{
tau_w = 1 / (cosh((V-v_3)/(2*v_4)));
w_inf = 0.5 * (1 + tanh((V - v_3)/v_4));
m_inf = 0.5 * (1 + tanh((V - v_1)/v_2));
%}

% dvdt = (I(int64(t/step+1)) - g_Ca*m_inf(V, [v_1, v_2])*(V-v_Ca) - g_K*(w)*(V-v_K) - g_L*(V-v_L)) / C;
dvdt = (90 - g_Ca*m_inf(V, [v_1, v_2])*(V-v_Ca)) / C;
dwdt = phi * (w_inf(V, [v_3, v_4])-w) / tau_w(V, [v_3, v_4]);
dy = [dvdt; dwdt];
function [v_nullcline, w_nullcline] = MLnullcline(v_span, I, params)
% calculate nullcline of Morris Lecar model

% params: [C, g_Ca, g_K, g_L, v_Ca, v_K, v_L, phi, v_1, v_2, v_3, v_4]
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

v_nullcline = zeros(1, length(v_span));
w_nullcline = zeros(1, length(v_span));
for i = 1:length(v_span)
    v = v_span(i);
    v_nullcline(i) = (max(I) - g_Ca*m_inf(v, [v_1, v_2])*(v-v_Ca) - g_L*(v-v_L)) / (g_K*(v-v_K));
    w_nullcline(i) = w_inf(v, [v_3, v_4]);
end

    
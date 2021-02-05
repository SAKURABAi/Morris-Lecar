function dy = Morris_Lecar_with_slow_channel(t, y, I, step, params)
% differential equations for Morris Lecar model
 
C     = params.C;
g_Ca  = params.g_Ca;
g_K   = params.g_K;
g_L   = params.g_L;
v_Ca  = params.v_Ca;
v_K   = params.v_K;
v_L   = params.v_L;
% K-channel
phi_w   = params.phi_w;
v_1   = params.v_1;
v_2   = params.v_2;
v_3   = params.v_3;
v_4   = params.v_4;
% K-channel 2
g_Ks   = params.g_Ks;
v_Ks   = params.v_K;
phi_k = params.phi_k;
v_5      = params.v_5;
v_6      = params.v_6;
% Slow Ca-channel
g_Cas   = params.g_Cas;
v_Cas   = params.v_Ca;
phi_n = params.phi_n;
phi_h = params.phi_h;
v_7      = params.v_7;
v_8      = params.v_8;
v_9      = params.v_9;
v_10     = params.v_10;

V = y(1);
w = y(2);
k = y(3);
n = y(4);
h = y(5);

dvdt = (I(int64(t/step+1))...
        - g_Ca * gating_inf(V, [v_1, v_2]) * (V-v_Ca)...
        - g_K * w * (V-v_K)...
        - g_Ks * k * (V-v_Ks)...
        - g_Cas * n^2 * h * (V-v_Cas)...
        - g_L * (V-v_L)...
       ) / C;
% K channel
dwdt = phi_w * (gating_inf(V, [v_3, v_4])-w) / tau(V, [v_3, v_4]);
% Ks channel
dkdt = phi_k * (gating_inf(V, [v_5, v_6])-k) / tau(V, [v_5, v_6]);
% Cas channel
dndt = phi_n * (gating_inf(V, [v_7, v_8])-n) / tau(V, [v_7, v_8]);
dhdt = phi_h * (gating_inf(V, [v_9, v_10])-h) / tau(V, [v_9, v_10]);

dy = [dvdt; dwdt; dkdt; dndt; dhdt];
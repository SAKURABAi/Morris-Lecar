function dy = Morris_Lecar_with_slow_channel(t, y, params)
% differential equations for Morris Lecar model
% params: [C, g_Ca, g_K, g_L, v_Ca, v_K, v_L, phi, v_1, v_2, v_3, v_4, g_gap]

cell_num = length(y)/ 5; 
C     = params.C;
g_Ca  = params.g_Ca;
g_K   = params.g_K;
g_L   = params.g_L;
g_gap = params.g_gap;
v_Ca  = params.v_Ca;
v_K   = params.v_K;
v_L   = params.v_L;
% K-channel
phi_w   = params.phi_w;
v_1   = params.v_1;
v_2   = params.v_2;
v_3   = params.v_3;
v_4   = params.v_4;
% SHK-1 channel (Liu et al.)
g_shk   = params.g_shk;
v_shk   = params.v_shk;
phi_k = params.phi_k;
v_5      = params.v_5;
v_6      = params.v_6;
% CCA-1 channel(T-type Ca2+ channel)
g_cca   = params.g_cca;
v_cca   = params.v_cca;
phi_m = params.phi_m;
phi_h = params.phi_h;
v_7      = params.v_7;
v_8      = params.v_8;
v_9      = params.v_9;
v_10     = params.v_10;

G_gap = set_gap_junction(cell_num, g_gap);

V = y(1:cell_num);
w = y(cell_num+1:cell_num*2);
k = y(cell_num*2+1:cell_num*3);
m = y(cell_num*3+1:cell_num*4);
h = y(cell_num*4+1:cell_num*5);


dvdt = zeros(cell_num, 1);
dwdt = zeros(cell_num, 1);
dkdt = zeros(cell_num, 1);
dmdt = zeros(cell_num, 1);
dhdt = zeros(cell_num, 1);

for i = 1:cell_num
    gap_junction = 0;
    for j = 1:cell_num
        gap_junction = gap_junction + G_gap(i, j) * (V(i) - V(j));
    end
    
    dvdt(i) = (- g_Ca*gating_inf(V(i), [v_1, v_2])*(V(i)-v_Ca) - g_K*w(i)*(V(i)-v_K) - g_L*(V(i)-v_L) - g_shk*k(i)*(V(i)-v_shk) - g_cca*m(i)^2*h(i)*(V(i)-v_cca) - gap_junction) / C;
    % K channel
    dwdt(i) = phi_w * (gating_inf(V(i), [v_3, v_4])-w(i)) / tau(V(i), [v_3, v_4]);
    % SHK-1 K channel
    dkdt(i) = phi_k * (gating_inf(V(i), [v_5, v_6])-k(i)) / tau(V(i), [v_5, v_6]);
    % CCA-1 Ca channel
    dmdt(i) = phi_m * (gating_inf(V(i), [v_7, v_8])-m(i)) / tau(V(i), [v_7, v_8]);
    dhdt(i) = phi_h * (gating_inf(V(i), [v_9, v_10])-h(i)) / tau(V(i), [v_9, v_10]);
end
dy = [dvdt; dwdt; dkdt; dmdt; dhdt];
function dy = Morris_Lecar_with_slow_channel(t, y, params)
% differential equations for Morris Lecar model
% params: [C, g_Ca, g_K, g_L, v_Ca, v_K, v_L, phi, v_1, v_2, v_3, v_4, g_gap]

cell_num = length(y)/ 11; 
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
% SLowly activating K+ channel
g_Ks   = params.g_Ks;
v_Ks   = params.v_Ks;
phi_k = params.phi_k;
v_5      = params.v_5;
v_6      = params.v_6;
% Slowly inactivating T-type Ca2+ channel
g_Cas   = params.g_Cas;
v_Cas   = params.v_Cas;
phi_n = params.phi_n;
phi_h = params.phi_h;
v_7      = params.v_7;
v_8      = params.v_8;
v_9      = params.v_9;
v_10     = params.v_10;
% Slowly inactivating T-type Ca2+ channel seq1
g_Cas1   = params.g_Cas1;
v_Cas1   = params.v_Cas1;
phi_n1 = params.phi_n1;
phi_h1 = params.phi_h1;
v_11      = params.v_11;
v_12      = params.v_12;
v_13      = params.v_13;
v_14     = params.v_14;
% Slowly inactivating T-type Ca2+ channel seq2
g_Cas2   = params.g_Cas2;
v_Cas2   = params.v_Cas2;
phi_n2 = params.phi_n2;
phi_h2 = params.phi_h2;
v_15      = params.v_15;
v_16      = params.v_16;
v_17      = params.v_17;
v_18     = params.v_18;
% Slowly inactivating T-type Ca2+ channel seq3
g_Cas3   = params.g_Cas3;
v_Cas3   = params.v_Cas3;
phi_n3 = params.phi_n3;
phi_h3 = params.phi_h3;
v_19      = params.v_19;
v_20      = params.v_20;
v_21      = params.v_21;
v_22     = params.v_22;

G_gap = set_gap_junction(cell_num, g_gap);

V = y(1:cell_num);
w = y(cell_num+1:cell_num*2);
k = y(cell_num*2+1:cell_num*3);
n = y(cell_num*3+1:cell_num*4);
h = y(cell_num*4+1:cell_num*5);
n1 = y(cell_num*5+1:cell_num*6);
h1 = y(cell_num*6+1:cell_num*7);
n2 = y(cell_num*7+1:cell_num*8);
h2 = y(cell_num*8+1:cell_num*9);
n3 = y(cell_num*9+1:cell_num*10);
h3 = y(cell_num*10+1:cell_num*11);

dvdt = zeros(cell_num, 1);
dwdt = zeros(cell_num, 1);
dkdt = zeros(cell_num, 1);
dndt = zeros(cell_num, 1);
dhdt = zeros(cell_num, 1);
dn1dt = zeros(cell_num, 1);
dh1dt = zeros(cell_num, 1);
dn2dt = zeros(cell_num, 1);
dh2dt = zeros(cell_num, 1);
dn3dt = zeros(cell_num, 1);
dh3dt = zeros(cell_num, 1);

for i = 1:cell_num
    gap_junction = 0;
    for j = 1:cell_num
        gap_junction = gap_junction + G_gap(i, j) * (V(i) - V(j));
    end
    
    dvdt(i) = (- g_Ca*gating_inf(V(i), [v_1, v_2])*(V(i)-v_Ca) - g_K*w(i)*(V(i)-v_K) - g_L*(V(i)-v_L)...
               - g_Ks*k(i)*(V(i)-v_Ks)...
               - g_Cas*n(i)^2*h(i)*(V(i)-v_Cas)...
               - g_Cas1*n1(i)^2*h1(i)*(V(i)-v_Cas1)...
               - g_Cas2*n2(i)^2*h2(i)*(V(i)-v_Cas2)...
               - g_Cas3*n3(i)^2*h3(i)*(V(i)-v_Cas3)...
               - gap_junction) / C;
    % K channel
    dwdt(i) = phi_w * (gating_inf(V(i), [v_3, v_4])-w(i)) / tau(V(i), [v_3, v_4]);
    % Ks channel
    dkdt(i) = phi_k * (gating_inf(V(i), [v_5, v_6])-k(i)) / tau(V(i), [v_5, v_6]);
    % Cas channel
    dndt(i) = phi_n * (gating_inf(V(i), [v_7, v_8])-n(i)) / tau(V(i), [v_7, v_8]);
    dhdt(i) = phi_h * (gating_inf(V(i), [v_9, v_10])-h(i)) / tau(V(i), [v_9, v_10]);
    % Cas channel seq1
    dn1dt(i) = phi_n1 * (gating_inf(V(i), [v_11, v_12])-n1(i)) / tau(V(i), [v_11, v_12]);
    dh1dt(i) = phi_h1 * (gating_inf(V(i), [v_13, v_14])-h1(i)) / tau(V(i), [v_13, v_14]);
    % Cas channel seq2
    dn2dt(i) = phi_n2 * (gating_inf(V(i), [v_15, v_16])-n2(i)) / tau(V(i), [v_15, v_16]);
    dh2dt(i) = phi_h2 * (gating_inf(V(i), [v_17, v_18])-h2(i)) / tau(V(i), [v_17, v_18]);
    % Cas channel seq3
    dn3dt(i) = phi_n3 * (gating_inf(V(i), [v_19, v_20])-n3(i)) / tau(V(i), [v_19, v_20]);
    dh3dt(i) = phi_h3 * (gating_inf(V(i), [v_21, v_22])-h3(i)) / tau(V(i), [v_21, v_22]);
end
dy = [dvdt; dwdt; dkdt; dndt; dhdt; dn1dt; dh1dt; dn2dt; dh2dt; dn3dt; dh3dt];
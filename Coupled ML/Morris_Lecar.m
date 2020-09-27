function dy = Morris_Lecar(t, y, I, step, params)
% differential equations for Morris Lecar model
% params: [C, g_Ca, g_K, g_L, v_Ca, v_K, v_L, phi, v_1, v_2, v_3, v_4, g_gap]
cell_num = length(y) / 2; 
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
g_gap = params.g_gap;

G_gap = set_gap_junction(cell_num, g_gap);

V = y(1:cell_num);
w = y(cell_num+1:cell_num*2);

dvdt = zeros(cell_num, 1);
dwdt = zeros(cell_num, 1);
for i = 1:cell_num
    gap_junction = 0;
    for j = 1:cell_num
        gap_junction = gap_junction + G_gap(i, j) * (V(i) - V(j));
    end 
    if i == 1
        dvdt(i) = (I(int64(t/step+1)) - g_Ca*m_inf(V(i), [v_1, v_2])*(V(i)-v_Ca) - g_K*w(i)*(V(i)-v_K) - g_L*(V(i)-v_L) - gap_junction) / C;
    else
        dvdt(i) = (- g_Ca*m_inf(V(i), [v_1, v_2])*(V(i)-v_Ca) - g_K*w(i)*(V(i)-v_K) - g_L*(V(i)-v_L) - gap_junction) / C;
    end
%     dvdt(i) = (I(int64(t/step+1)) - g_Ca*m_inf(V(i), [v_1, v_2])*(V(i)-v_Ca) - g_K*w(i)*(V(i)-v_K) - g_L*(V(i)-v_L) - gap_junction) / C;
    dwdt(i) = phi * (w_inf(V(i), [v_3, v_4])-w(i)) / tau_w(V(i), [v_3, v_4]);
end
dy = [dvdt; dwdt];
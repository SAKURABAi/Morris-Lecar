function G_gap = set_gap_junction(cell_num, g_gap)
% 假定相邻细胞间均存在gap junction
G_gap = zeros(cell_num);
index = [0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
         1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
         0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
         1 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
         1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
         0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
         0 0 0 0 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
         0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 1 0 0 1 1 0 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 1 0 0 1 1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 1 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 0;
         0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 1;
         0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
         0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0];
if cell_num == 20
    G_gap(index > 0) = g_gap;
else
    G_gap(:) = g_gap;
end
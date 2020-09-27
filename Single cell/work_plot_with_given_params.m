% Plot_Morris_Lecar_with_given_params({'g_{Ca}', 'v_{Ca}', 'g_{K}', 'v_3', 'v_4'}, {6, 2, 5, 15, 30})
% for I = 6.7:0.01:6.9
%     Plot_Morris_Lecar_with_given_params({'C', 'phi', 'g_{Ca}', 'v_{L}', 'I','v_3', 'v_4'}, {3, 0.2, I, -80, 60, 5, 30}, [-10,0])
% end

% modify current
for I = 6.7
    Plot_Morris_Lecar_with_given_params({'C', 'phi', 'g_{Ca}', 'v_{L}','v_3', 'v_4'}, {3, 0.2, 6.7, -80, 5, 30}, [-10,0])
end

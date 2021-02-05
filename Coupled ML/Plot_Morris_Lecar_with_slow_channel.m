function Plot_Morris_Lecar_with_slow_channel(time)

% original parameters
params = struct('C', 2.5, 'g_Ca', 6.2, 'g_K', 7.3, 'g_L', 1.3, 'g_gap', 5,...
                'v_Ca', 69, 'v_K', -50, 'v_L', -34, 'phi_w', 0.3,...
                'v_1', -2, 'v_2', 14, 'v_3', 5, 'v_4', 40,...
                'g_Ks', 2.5, 'v_Ks', -50, 'phi_k', 0.050, 'v_5', 5, 'v_6', 20,...
                'v_Cas', 69, 'phi_n', 0.5, 'v_7', -50, 'v_8' , 10,...
                'g_Cas', 0.2, 'phi_h', 0.002, 'v_9', -25, 'v_10', -20,...
                'v_Cas1', 69, 'phi_n1', 0.5, 'v_11', -50, 'v_12' , 10,...
                'g_Cas1', 0.2, 'phi_h1', 0.002, 'v_13', -20, 'v_14', -20,...
                'v_Cas2', 69, 'phi_n2', 0.5, 'v_15', -50, 'v_16' , 10,...
                'g_Cas2', 0.1, 'phi_h2', 0.002, 'v_17', -10, 'v_18', -20,...
                'v_Cas3', 69, 'phi_n3', 0.5, 'v_19', -50, 'v_20' , 10,...
                'g_Cas3', 0.1, 'phi_h3', 0.002, 'v_21', -5, 'v_22', -20);
step = 0.01;
t_span = 0:step:time;
cell_num = 6;

initPos = [-15,-16,-12,-10,-35,-45,...
           0.1,0.1,0.1,0.1,0.1,0.1,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2,...
           0.2,0.2,0.2,0.2,0.2,0.2];

% make folder
now = nowtime();
Folder = ['image\slow_channel\cell_num_' num2str(cell_num) '\' now '\'];
if ~exist(Folder, 'dir')
    mkdir(Folder);
end

tic;
% apply current
[t, track] = ode45(@Morris_Lecar_with_slow_channel, t_span, initPos, [], params);
g = figure(cell_num+1);
set(g,'visible','off', 'position',[0,0,1080,540])
for i = 1:cell_num
    if i >= 10
        cell_idx = num2str(i);
    else 
        cell_idx = ['0' num2str(i)];
    end
    disp(['Processing: cell ' cell_idx]);
    h = figure(i); 
    set(h,'visible','off', 'position',[0,0,1080,540]);
%   plot V over t
    plot(t/1000, track(:, i), 'k', 'LineWidth', 2); 
    axis([0, time/1000, -50, 40]);
    xlabel('$t\ (\mathrm{s})$','Interpreter','LaTex', 'Fontsize', 14);
    ylabel('$V\ (\mathrm{mV})$','Interpreter','LaTex', 'Fontsize', 14);

    title(['Cell ' cell_idx], 'Fontsize', 14);
    set(gca,'XAxisLocation','origin','ticklabelinterpreter','latex','tickdir','out')
    
    figure(cell_num+1);hold on;
    plot(t/1000, track(:, i), 'LineWidth', 2); 
    hold off;

    print(h, [Folder 'Cell_' cell_idx '.jpg'], '-djpeg', '-r300');
    close(h);
end
figure(cell_num+1);
xlabel('$t\ (\mathrm{s})$','Interpreter','LaTex', 'Fontsize', 14);
ylabel('$V\ (\mathrm{mV})$','Interpreter','LaTex', 'Fontsize', 14);
axis([0, time/1000, -50, 40]);
set(gca,'ticklabelinterpreter','latex','tickdir','out')
legend({'$\mathrm{cell}\ 1$', '$\mathrm{cell}\ 2$', '$\mathrm{cell}\ 3$', '$\mathrm{cell}\ 4$', '$\mathrm{cell}\ 5$', '$\mathrm{cell}\ 6$'}, 'interpreter', 'LaTex');
print(g, [Folder 'total.jpg'], '-djpeg', '-r600');

close(g);
timespend = toc;
disp(['Total time cost: ' num2str(timespend) ' s']);

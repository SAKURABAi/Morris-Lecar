function Plot_Morris_Lecar_with_slow_channel(time)

% original parameters
params = struct('C', 2.5, 'g_Ca', 6.2, 'g_K', 7.3, 'g_L', 1.3, 'g_gap', 5,...
                'v_Ca', 69, 'v_K', -52, 'v_L', -34, 'phi_w', 0.3,...
                'v_1', -2, 'v_2', 14, 'v_3', 5, 'v_4', 40,...
                'g_shk', 3.5, 'v_shk', -50, 'phi_k', 0.010, 'v_5', 5, 'v_6', 20,...
                'v_cca', 69, 'phi_m', 0.5, 'v_7', -50, 'v_8' , 10,...
                'g_cca', 1.2, 'phi_h', 0.002, 'v_9', -20, 'v_10', -20);
step = 0.01;
t_span = 0:step:time;
cell_num = 6;

initPos = [-15,-16,-12,-10,-35,-45,...
           0.1,0.1,0.1,0.1,0.1,0.1,...
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
clf(g);
set(g,'visible','off', 'position',[0,0,1080,540])
for i = 1:cell_num
    if i >= 10
        cell_idx = num2str(i);
    else 
        cell_idx = ['0' num2str(i)];
    end
    disp(['Processing: cell ' cell_idx]);
    h = figure(i); 
    clf(h);
    set(h,'visible','off', 'position',[0,0,1080,540]);
%   plot V over t
    plot(t, track(:, i), 'k', 'LineWidth', 2); 
    axis([0, time, -65, 65]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itV', 'Fontsize', 14);
    title(['Cell ' cell_idx], 'Fontsize', 14);

    figure(cell_num+1);hold on;
    plot(t, track(:, i), 'LineWidth', 1.3); 
    hold off;

    print(h, [Folder 'Cell_' cell_idx '.jpg'], '-djpeg', '-r300');
    close(h);
end
figure(cell_num+1);
xlabel('\itt', 'Fontsize', 14);
ylabel('\itV', 'Fontsize', 14);
axis([0, time, -65, 65]);
legend({'cell 1', 'cell 2', 'cell 3', 'cell 4', 'cell 5', 'cell 6'});
print(g, [Folder 'total.jpg'], '-djpeg', '-r300');
close(g);
timespend = toc;
disp(['Total time cost: ' num2str(timespend) ' s']);

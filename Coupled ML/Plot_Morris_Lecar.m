function Plot_Morris_Lecar(tau_up, tau_down, time)

% original parameters
params = struct('C', 3, 'g_Ca', 6.7, 'g_K', 8, 'g_L', 2, 'g_gap', 0.0,...
                'v_Ca', 120, 'v_K', -84, 'v_L', -80, 'phi', 0.2,...
                'v_1', -1.2, 'v_2', 18, 'v_3', 5, 'v_4', 30);
step = 0.01;
t_span = 0:step:time;
cell_num = 20;

initPos = [-11 0.01;
           -10.9 0.01;
           -10.8 0.01;
           -10.7 0.01;
           -10.6 0.01;
           -10.5 0.01;
           -10.4 0.01;
           -10.3 0.01;
           -10.2 0.01;
           -10.1 0.01;
           -10.0 0.01;
           -9.9 0.01;
           -9.8 0.01;
           -9.7 0.01;
           -9.6 0.01;
           -9.5 0.01;
           -9.4 0.01;
           -9.3 0.01;
           -9.2 0.01;
           -9.1 0.01];

Folder = 'image\';
if ~exist(Folder, 'dir')
    mkdir(Folder);
end

tic;
for i = 1:cell_num
    if i >= 10
        cell_idx = num2str(i);
    else 
        cell_idx = ['0' num2str(i)];
    end
    disp(['Processing: cell ' cell_idx]);
    
    % apply current
    I = set_modified_oscillatory_current_sequence(length(t_span), step, tau_up, tau_down, 500);

    [t, track] = ode45(@Morris_Lecar, t_span, initPos, [], I, step, params);

    h = figure(i); 
    set(h,'visible','off', 'position',[0,0,1080,1080]);
    
    subplot(211);
    % plot V over t
    plot(t, track(:, i), 'k', 'LineWidth', 2); 
    axis([0, time, -100, 100]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itV', 'Fontsize', 14);
    title(['Cell ' cell_idx], 'Fontsize', 14);

    subplot(212);
    plot(t, I, 'k', 'LineWidth', 2); 
    axis([0, time, -10, 200]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itI_{stim}', 'Fontsize', 14);
    
    print(h, [Folder 'Cell_' cell_idx '.jpg'], '-djpeg', '-r300');
    close(h);
end
time = toc;
disp(['Total time cost: ' num2str(time) ' s']);

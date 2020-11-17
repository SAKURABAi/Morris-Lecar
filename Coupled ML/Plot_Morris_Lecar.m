function Plot_Morris_Lecar(tau_up, tau_down, time)

% original parameters
params = struct('C', 2.5, 'g_Ca', 7.2, 'g_K', 8, 'g_L', 1.9, 'g_gap', 2,...
                'v_Ca', 130, 'v_K', -90, 'v_L', -70, 'phi', 0.2,...
                'v_1', -1.2, 'v_2', 18, 'v_3', 5, 'v_4', 30);
step = 0.01;
t_span = 0:step:time;
cell_num = 6;
section_time = 100;

% initPos = [-55 0.01;
%            -54.5 0.01;
%            -54 0.01;
%            -53.5 0.01;
%            -53 0.01;
%            -52.5 0.01;
%            -52 0.01;
%            -51 0.01;
%            -50.5 0.01;
%            -50 0.01;
%            -50.5 0.01;
%            -51 0.01;
%            -51.5 0.01;
%            -52 0.01;
%            -52.5 0.01;
%            -53 0.01;
%            -54 0.01;
%            -54.5 0.01;
%            -55 0.01;
%            -55.5 0.01];
% initPos = [10, 0.01;
%             -10.5, 0.02;
%             -11, 0.03;
%             -11.5, 0.04;
%             -12, 0.05;
%             -12.5, 0.06];
initPos = [-15, 0.01;
    -56, 0.31;
    -50, 0.11;
    -50, 0.11;
    -55, 0.11;
    -50, 0.11];
% initPos = [-15, 0.01;
%     50, 0.31;
%     50, 0.11;];
% make folder
now = nowtime();
Folder = ['image\cell_num_' num2str(cell_num) '\' now '\'];
if ~exist(Folder, 'dir')
    mkdir(Folder);
end

tic;
% apply current
I = set_sigmoid_oscillatory_current_sequence(length(t_span), step, tau_up, tau_down, section_time);
[t, track] = ode45(@Morris_Lecar, t_span, initPos, [], I, step, params);
for i = 1:cell_num
    if i >= 10
        cell_idx = num2str(i);
    else 
        cell_idx = ['0' num2str(i)];
    end
    disp(['Processing: cell ' cell_idx]);
    h = figure(i); 
    set(h,'visible','off', 'position',[0,0,1080,1080]);
    
    subplot(211);
    % plot V over t
    plot(t, track(:, i), 'k', 'LineWidth', 2); 
    axis([0, time, -90, 90]);
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

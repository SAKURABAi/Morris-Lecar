function Plot_Morris_Lecar_with_given_g_gap(tau_up, tau_down, time, g_gap_span)

% original parameters
params = struct('C', 2.5, 'g_Ca', 7.2, 'g_K', 8, 'g_L', 1.9, 'g_gap', 2,...
                'v_Ca', 128, 'v_K', -90, 'v_L', -70, 'phi', 0.2,...
                'v_1', -1.2, 'v_2', 18, 'v_3', 5, 'v_4', 30);
step = 0.01;
t_span = 0:step:time;
cell_num = 6;
section_time = 100;

% initPos = [-15 0.01;
%            -14.5 0.01;
%            -14 0.01;
%            -13.5 0.01;
%            -13 0.01;
%            -12.5 0.01;
%            -12 0.01;
%            -11 0.01;
%            -10.5 0.01;
%            -10 0.01;
%            -10.5 0.01;
%            -11 0.01;
%            -11.5 0.01;
%            -12 0.01;
%            -12.5 0.01;
%            -13 0.01;
%            -14 0.01;
%            -14.5 0.01;
%            -15 0.01;
%            -15.5 0.01];
initPos = [-15, 0.01;
    -56, 0.31;
    -50, 0.11;
    -50, 0.11;
    -55, 0.11;
    -50, 0.11];
% initPos = [-25, 0.05;
%     -21, 0.21;
%     -40, 0.11;];

% I = set_sigmoid_oscillatory_current_sequence(length(t_span), step, tau_up, tau_down, section_time);
I = set_current_sequence(length(t_span), step, tau_up, tau_down, section_time);
% make folder
now = nowtime();
Folder = ['image\cell_num_' num2str(cell_num) '\' now '\'];
if ~exist(Folder, 'dir')
    mkdir(Folder);
end

tic;
g = figure(cell_num+1);
set(g,'visible','off', 'position',[0,0,1080,1080])
for idx = 1:length(g_gap_span)
    disp(['Processing: g_gap = ' num2str(g_gap_span(idx))]);
    
    params.g_gap = g_gap_span(idx);
    subFolder = [Folder 'g_gap_' num2str(g_gap_span(idx)) '\'];
    if ~exist(subFolder, 'dir')
        mkdir(subFolder);
    end

    [t, track] = ode45(@Morris_Lecar, t_span, initPos, [], I, step, params);
    for i = 1:cell_num
        if i >= 10
            cell_idx = num2str(i);
        else 
            cell_idx = ['0' num2str(i)];
        end
        
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
        figure(cell_num+1);subplot(211);hold on;
        plot(t, track(:, i), 'LineWidth', 1.3); 
        hold off;

        print(h, [subFolder 'Cell_' cell_idx '.jpg'], '-djpeg', '-r300');
        close(h);
    end
    figure(cell_num+1);
    subplot(211);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itV', 'Fontsize', 14);
    legend({'cell 1', 'cell 2', 'cell 3', 'cell 4', 'cell 5', 'cell 6'});
    subplot(212);
    plot(t, I, 'k', 'LineWidth', 2); 
    axis([0, time, -10, 200]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itI_{stim}', 'Fontsize', 14);
    print(g, [subFolder 'total.jpg'], '-djpeg', '-r300');
end
time = toc;
disp(['Total time cost: ' num2str(time) ' s']);

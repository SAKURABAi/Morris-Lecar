function Plot_Morris_Lecar(param_name, param_span)

% params: [C, g_Ca(g_fast), g_K(g_slow), g_L, v_Ca(v_fast), v_K(v_slow), v_L, phi, v_1, v_2, v_3, v_4]
% params = [20, 4.4, 8, 2, 120, -84, -60, .04, -1.2, 18, 2, 30]; % Hopf
% params = [20, 4, 8, 2, 120, -84, -60, .067, -1.2, 18, 12, 17.4]; % SNLC
% params = [20, 4.4, 8, 2, 120, -84, -60, .04, -1.2, 18, 2, 30]; % Homoclinic

% original parameters
params = struct('C', 3, 'g_Ca', 6.7, 'g_K', 8, 'g_L', 2,...
                'v_Ca', 120, 'v_K', -84, 'v_L', -80, 'phi', 0.2,...
                'v_1', -1.2, 'v_2', 18, 'v_3', 5, 'v_4', 30);
step = 0.01;
t_span = 0:step:500;
initPos1 = [-10,0.01];
freq = 6;

Folder = ['image\', param_name '\'];
if ~exist(Folder, 'dir')
    mkdir(Folder);
end

tic;
for i = 1:length(param_span)
    disp(['Processing: ' param_name ' = ' num2str(param_span(i))]);
    
    param_name_strip = strrep(param_name, '{', ''); 
    param_name_strip = strrep(param_name_strip, '}', ''); 
    if isfield(params, param_name_strip)
        params = setfield(params, param_name_strip, param_span(i));
    end
    
    % apply current
    if strcmp(param_name, 'I')
        I = set_constant_current_sequence(length(t_span), param_span(i));
    else 
        I = set_constant_current_sequence(length(t_span));
    end
    
    % calculate nullcline
    v_span = [-100:.1:90];
    [v_nullcline, w_nullcline] = MLnullcline(v_span, I, params);
    [t, track1] = ode45(@Morris_Lecar, t_span, initPos1, [], I, step, params);

    h = figure(i); 
    set(h,'visible','off', 'position',[0,0,1920,1080]);
    
    subplot(2, 2, [1, 3]);
    hold on;
    % phase plot
    plot(track1(:, 1), track1(:, 2), 'k', 'LineWidth', 2);
    v_ncl = plot(v_span, v_nullcline, 'b--', 'LineWidth', 1);
    w_ncl = plot(v_span, w_nullcline, 'r--', 'LineWidth', 1);
    legend([v_ncl, w_ncl], 'V - nullcline', 'w - nullcline');
    axis([-80, 80, -0.05, 1]);
    xlabel('\itV', 'Fontsize', 14);
    ylabel('\itw', 'Fontsize', 14);
    title([param_name ' = ' num2str(param_span(i))]);
    hold off;

    subplot(222);
    % plot V over t
    plot(t, track1(:, 1), 'k', 'LineWidth', 2); 
    axis([0, 500, -100, 100]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itV', 'Fontsize', 14);
    
    subplot(224);
    plot(t, I, 'k', 'LineWidth', 2); 
    % axis([0, 500, -10, 150]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itI_{stim}', 'Fontsize', 14);
    
    print(h, [Folder param_name '_' num2str(param_span(i)) '.jpg'], '-djpeg', '-r300');
    close(h);
end
MakeVideo(param_span, freq, param_name);
time = toc;
disp(['Total time cost: ' num2str(time) ' s']);

function Plot_Morris_Lecar_with_given_tau(tau_span, decay_time, initPos1)

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
freq = 6;

Folder = ['image\tau\decay_' num2str(decay_time) '\'];
if ~exist(Folder, 'dir')
    mkdir(Folder);
end

if nargin == 1
    initPos1 = [0, 0.01];
end

tic;
for i = 1:length(tau_span)
    disp(['Processing: tau = ' num2str(tau_span(i))]);
    
    % apply current
    I = set_modified_current_sequence(length(t_span), step, tau_span(i), decay_time);

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
    axis([-100, 80, -0.05, 1]);
    xlabel('\itV', 'Fontsize', 14);
    ylabel('\itw', 'Fontsize', 14);
    hold off;

    subplot(222);
    % plot V over t
    hold on
    plot(t, track1(:, 1), 'k', 'LineWidth', 2); 
    axis([0, 500, -100, 80]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itV', 'Fontsize', 14);

    subplot(224);
    plot(t, I, 'k', 'LineWidth', 2); 
    axis([0, 500, -10, 150]);
    xlabel('\itt', 'Fontsize', 14);
    ylabel('\itI_{stim}', 'Fontsize', 14);
    title(['tau = ' num2str(tau_span(i))], 'Fontsize', 12);
    
    print(h, [Folder 'tau_' num2str(tau_span(i)) '.jpg'], '-djpeg', '-r300');
    close(h);
end
MakeDecayCurrentVideo(tau_span, decay_time, freq)
time = toc;
disp(['Total time cost: ' num2str(time) ' s']);
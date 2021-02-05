function Plot_Morris_Lecar(time, param_name, param_span)

% % original parameters
% params = struct('C', 10, 'g_Ca', 1.7, 'g_K', 4, 'g_L', 0.5,...
%                 'v_Ca', 120, 'v_K', -84, 'v_L', -65, 'phi_w', 0.01,...
%                 'v_1', 10, 'v_2', 7, 'v_3', 10, 'v_4', 35,...
%                 'g_Ks', 3, 'phi_k', 0.02, 'v_5', 1, 'v_6', 20,...
%                 'g_Cas', 2.1, 'phi_n', 0.1, 'v_7', -22, 'v_8' , 5,...
%                 'phi_h', 0.1, 'v_9', 20, 'v_10', 20);
            
params = struct('C', 7, 'g_Ca', 1.8, 'g_K', 6, 'g_L', 0.35,...
                'v_Ca', 120, 'v_K', -84, 'v_L', -65, 'phi_w', 0.01,...
                'v_1', 10, 'v_2', 9, 'v_3', 15, 'v_4', 30,...
                'g_Ks', 5, 'phi_k', 0.02, 'v_5', 3, 'v_6', 20,...
                'g_Cas', 2.4, 'phi_n', 0.13, 'v_7', -30, 'v_8' , 5,...
                'phi_h', 0.1, 'v_9', 20, 'v_10', 20);
step = 0.01;
freq = 12;
t_span = 0:step:time;
initPos1 = [-50, 0.3,0.3,0.3,0.3];

param_name_strip = strrep(param_name, '{', ''); 
param_name_strip = strrep(param_name_strip, '}', ''); 
Folder = ['image\', param_name_strip '\'];
if ~exist(Folder, 'dir')
    mkdir(Folder);
end
param_name_latex = ParamNameToLaTex(param_name);

tic;
for i = 1:length(param_span)
    disp(['Processing: ' param_name_strip ' = ' num2str(param_span(i))]);
    
    if isfield(params, param_name_strip)
        params = setfield(params, param_name_strip, param_span(i));
    end
    
    % apply current
    if strcmp(param_name, 'I')
        I = set_constant_current_sequence(length(t_span), param_span(i));
    else 
        I = set_constant_current_sequence(length(t_span));
    end
    [t, track] = ode45(@Morris_Lecar_with_slow_channel, t_span, initPos1, [], I, step, params);

    h = figure(i); 
    set(h,'visible','off', 'position',[0,0,720,720]);
    
    subplot(211);
    % plot V over t
    plot(t, track(:, 1), 'k', 'LineWidth', 2); 
    axis([0, 500, -100, 100]);
    xlabel('$t$', 'Fontsize', 14, 'Interpreter', 'LaTex');
    ylabel('$V$', 'Fontsize', 14, 'Interpreter', 'LaTex');
    title(['$' param_name_latex '=' num2str(param_span(i)) '$'], 'FontSize',14, 'Interpreter', 'LaTex');
    
    subplot(212);
    plot(t, I, 'k', 'LineWidth', 2); 
    axis([0, 500, -10, 120]);
    xlabel('$t$', 'Fontsize', 14, 'Interpreter', 'LaTex');
    ylabel('$I$', 'Fontsize', 14, 'Interpreter', 'LaTex');
    
    print(h, [Folder param_name_strip '_' num2str(param_span(i)) '.jpg'], '-djpeg', '-r300');
    close(h);
end
MakeVideo(param_span, freq, param_name_strip);
time = toc;
disp(['Total time cost: ' num2str(time) ' s']);

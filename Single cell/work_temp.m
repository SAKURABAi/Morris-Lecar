clear;clc;
% original parameters
params = struct('C', 3, 'g_Ca', 6.7, 'g_K', 8, 'g_L', 2,...
                'v_Ca', 120, 'v_K', -84, 'v_L', -80, 'phi', 0.2,...
                'v_1', -1.2, 'v_2', 18, 'v_3', 5, 'v_4', 30);
time = 1500;
step = 0.01;

t_span = 0:step:time;
freq = 6;
tau = 200;
decay = 150;
initPos1 = [0, 0.01];
I_max = 90;

% apply current
% I = set_modified_current_sequence(length(t_span), step, tau, time, I_span(i));
I = zeros(1, length(t_span));
npoints = decay / step; % Discretize time into 1000 intervals
I_decay = zeros(1, npoints); % initializes N_nuclei, a vector of dimension npoints X 1,to being all zeros
I_decay(1) = I_max; % the initial condition, first entry in the vector N_nuclei is N_nuclei_initial
for i = 1:npoints-1 % loop over the timesteps and calculate the numerical solution
    I_decay(i + 1) = I_decay(i) - (I_decay(i)/tau) * step;
end
I_ramp = linspace(0, 50, 35000);
for i = 0:int64(time/500)-1
    I(50000*i+35001:50000*i+npoints+35000) = I_decay;
    I(50000*i+1:50000*i+35000) = I_ramp;
end
% calculate nullcline
v_span = [-100:.1:90];
[v_nullcline, w_nullcline] = MLnullcline(v_span, I, params);

[t, track1] = ode45(@Morris_Lecar, t_span, initPos1, [], I, step, params);

h = figure(); 
set(h, 'position',[0,0,1920,1080]);

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
axis([0, t_span(length(t_span)), -100, 80]);
xlabel('\itt', 'Fontsize', 14);
ylabel('\itV', 'Fontsize', 14);

subplot(224);
plot(t, I, 'k', 'LineWidth', 2); 
axis([0, t_span(length(t_span)), -10, 165]);
xlabel('\itt', 'Fontsize', 14);
ylabel('\itI_{stim}', 'Fontsize', 14);
    
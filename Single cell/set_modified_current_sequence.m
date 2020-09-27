function I = set_modified_current_sequence(time_length, step, tau, decay, I_max)

if nargin == 4
    I_max = 100;
end
I = zeros(1, time_length);
npoints = decay / step; % Discretize time into 1000 intervals
I_decay = zeros(1, npoints); % initializes N_nuclei, a vector of dimension npoints X 1,to being all zeros
I_decay(1) = I_max; % the initial condition, first entry in the vector N_nuclei is N_nuclei_initial
for i = 1:npoints-1 % loop over the timesteps and calculate the numerical solution
    I_decay(i + 1) = I_decay(i) - (I_decay(i)/tau) * step;
end
I(1:npoints) = I_decay;



clear; clc;
param_name = 'phi_{w}';
param_span = 0.01:0.01:0.5;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'phi_{n}';
param_span = 0.01:0.01:0.5;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'phi_{k}';
param_span = 0.01:0.01:0.5;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'phi_{h}';
param_span = 0.01:0.01:0.5;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'g_{Ca}';
param_span = 1:0.1:8;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'g_{Cas}';
param_span = 1:0.1:8;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{1}';
param_span = -40:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{2}';
param_span = 1:.5:50;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{L}';
param_span = -90:0.5:-30;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{K}';
param_span = -120:0.5:-40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'g_{K}';
param_span = 1:0.1:10;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'g_{Ks}';
param_span = 1:0.1:6;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'C';
param_span = 1:.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{Ca}';
param_span = 40:150;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'g_{L}';
param_span = 0.02:0.02:5;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{3}';
param_span = -40:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{4}';
param_span = 5:0.5:50;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{5}';
param_span = -40:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{6}';
param_span = 3:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{9}';
param_span = -40:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{10}';
param_span = -40:0.5:-4;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{7}';
param_span = -40:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

clear; clc;
param_name = 'v_{8}';
param_span = 5:0.5:40;
Plot_Morris_Lecar(500, param_name, param_span);

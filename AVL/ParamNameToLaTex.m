function param_name_latex = ParamNameToLaTex(param_name)
prefix_loc = find(param_name == '_');
if isempty(prefix_loc)
    param_name_latex = param_name;
elseif param_name(prefix_loc+2) >= '1' && param_name(prefix_loc+2) <= '9'
    param_name_latex = param_name;
elseif strcmp(param_name(1:3), 'phi')
    param_name_latex = ['\' param_name(1:prefix_loc) param_name(prefix_loc+1:end)];
else 
    param_name_latex = [param_name(1:prefix_loc) '\mathrm' param_name(prefix_loc+1:end)];
end
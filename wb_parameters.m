function wb_cfg = wb_parameters(test_wb_command)

if nargin==0; test_wb_command=0;end

wb_cfg.pathToWB     = 'D:\Programs\neuro\workbench\bin_windows64';
wb_cfg.wb_command   = fullfile(wb_cfg.pathToWB, 'wb_command.exe');

if test_wb_command
    system(wb_cfg.wb_command);
end
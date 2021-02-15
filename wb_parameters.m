function wb_cfg = wb_parameters(test_wb_command)

if nargin==0; test_wb_command=0;end

% this works only on my Desktop and Mac for now

if IsWin
    wb_cfg.pathToWB     = 'D:\Programs\neuro\workbench\bin_windows64';
    wb_cfg.wb_command   = fullfile(wb_cfg.pathToWB, 'wb_command.exe');
else
    wb_cfg.pathToWB     = '/Applications/workbench/bin_macosx64';
    wb_cfg.wb_command   = fullfile(wb_cfg.pathToWB, 'wb_command');
end


if test_wb_command
    system(wb_cfg.wb_command);
end
function wb_cfg = wb_parameters(pathToWB, test_wb_command)
% function wb_cfg = wb_parameters(pathToWB, test_wb_command)

global global_wb_dir

if nargin==0 || nargin>0&&isempty(pathToWB)
    if ~isempty(global_wb_dir)
        pathToWB = global_wb_dir;
        assert(isfolder(pathToWB), 'the path provided in global_wb_dir to workbench connectome does not exist!!');
    elseif isfolder('/imaging/local/software/workbench/v1.5.0/bin/')
        % I'm in CBU
        pathToWB = '/imaging/local/software/workbench/v1.5.0/bin/';
    elseif isfolder('D:\Programs\neuro\workbench\workbench_150\bin_windows64')
        % I'm in local Windows desktop
        pathToWB = 'D:\Programs\neuro\workbench\workbench_150\bin_windows64';
    else
        error('path to workbench connectome does not exist!!');
    end
    
else
    assert(isfolder(pathToWB), 'the provided path to workbench connectome does not exist!!');
end


if isunix
    wb_command = 'wb_command';
else
    wb_command = 'wb_command.exe';
end


if nargin<2
    test_wb_command=0;
end

% this works only on my Desktop and Mac for now

wb_cfg.pathToWB     = pathToWB;
wb_cfg.wb_command   = fullfile(wb_cfg.pathToWB, wb_command);

% try
%     if IsWin
%         wb_cfg.pathToWB     = 'D:\Programs\neuro\workbench\workbench_150\bin_windows64';
%         wb_cfg.wb_command   = fullfile(wb_cfg.pathToWB, 'wb_command.exe');
%     else
%         wb_cfg.pathToWB     = '/Applications/workbench/bin_macosx64';
%         wb_cfg.wb_command   = fullfile(wb_cfg.pathToWB, 'wb_command');
%     end
% catch
%     % Assuming I am on the CBU cluster
%     wb_cfg.pathToWB         = '/imaging/local/software/workbench/v1.5.0/bin/';
%     wb_cfg.wb_command       = fullfile(wb_cfg.pathToWB, 'wb_command');
%
%     if test_wb_command
%         system(wb_cfg.wb_command);
%     end
%
% end


if test_wb_command
    system(wb_cfg.wb_command);
end
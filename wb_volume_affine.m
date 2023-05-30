function [status,cmdout] = wb_volume_affine(volume_in, volume_space, method, volume_out)
% function [status,cmdout] = wb_volume_affine(volume_in, volume_space, method, volume_out)

wb_par=wb_parameters;
wb_command=wb_par.wb_command;

wb_cmd=[wb_command ' -volume-resample ' volume_in ' ' volume_space ' ' method ' ' volume_out];

[status,cmdout] = system(wb_cmd);
if status ~= 0
    display(cmdout)
else
    fprintf('file succesfully resampled from %s to %s\n', volume_in, volume_out);
end
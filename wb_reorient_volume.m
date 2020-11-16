function [status,cmdout] = wb_reorient_volume(wb_cfg, volume_in, orient_string, volume_out)
% function [status,cmdout] = wb_reorient_volume(wb_cfg, volume_in, orient_string, volume_out)
% CHANGE VOXEL ORDER OF A VOLUME FILE
%    wb_command -volume-reorient
%       <volume> - the volume to reorient
%       <orient-string> - the desired orientation
%       <volume-out> - out - the reoriented volume
% 
%       Changes the voxel order and the header spacing/origin information such
%       that the value of any spatial point is unchanged.  Orientation strings
%       look like 'LPI', which means first index is left to right, second is
%       posterior to anterior, and third is inferior to superior.  The valid
%       characters are:
% 
%       L      left to right
%       R      right to left
%       P      posterior to anterior
%       A      anterior to posterior
%       I      inferior to superior
%       S      superior to inferior

if nargin==0
    [wb_cfg, volume_in, orient_string, volume_out] = wb_reorient_volume_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -volume-reorient');

wb_cmd = [wb_function ' ' '"' volume_in '"' ' ' '"' orient_string '"' ' ' '"' volume_out '"'];

[status,cmdout] = system(wb_cmd);
if status
    fprintf('Something wrong\n')
    display(cmdout);
else
    fprintf('Orientation changed to %s\n', orient_string)
end

function [wb_cfg, volume_in, orient_string, volume_out] = wb_reorient_volume_test

wb_cfg          = wb_parameters;
volume_in       = 'D:\Projects\RESPACT\data\fsaverage\mri\T1.nii';
orient_string   = 'LAS';%'LIA';
volume_out      = strrep(volume_in, '.nii', strcat('_', orient_string, '.nii'));
function [status,cmdout] = wb_cifti_convert_nii(wb_cfg, fname_in, conversion_type, fname_out)
% function [status,cmdout] = wb_cifti_convert_nii(wb_cfg, fname_in, conversion_type, fname_out)
%   wb_command -cifti-convert
% 
%       [-to-gifti-ext] - convert to GIFTI external binary
%          <cifti-in> - the input cifti file
%          <gifti-out> - output - the output gifti file
% 
%       [-from-gifti-ext] - convert a GIFTI made with this command back into a
%          CIFTI
%          <gifti-in> - the input gifti file
%          <cifti-out> - output - the output cifti file
% 
%          [-reset-timepoints] - reset the mapping along rows to timepoints,
%             taking length from the gifti file
%             <timestep> - the desired time between frames
%             <timestart> - the desired time offset of the initial frame
% 
%             [-unit] - use a unit other than time
%                <unit> - unit identifier (default SECOND)
% 
%          [-reset-scalars] - reset mapping along rows to scalars, taking length
%             from the gifti file
% 
%          [-replace-binary] - replace data with a binary file
%             <binary-in> - the binary file that contains replacement data
% 
%             [-flip-endian] - byteswap the binary file
% 
%             [-transpose] - transpose the binary file
% 
%       [-to-nifti] - convert to NIFTI1
%          <cifti-in> - the input cifti file
%          <nifti-out> - output - the output nifti file
% 
%       [-from-nifti] - convert a NIFTI (1 or 2) file made with this command back
%          into CIFTI
%          <nifti-in> - the input nifti file
%          <cifti-template> - a cifti file with the dimension(s) and mapping(s)
%             that should be used
%          <cifti-out> - output - the output cifti file
% 
%          [-reset-timepoints] - reset the mapping along rows to timepoints,
%             taking length from the nifti file
%             <timestep> - the desired time between frames
%             <timestart> - the desired time offset of the initial frame
% 
%             [-unit] - use a unit other than time
%                <unit> - unit identifier (default SECOND)
% 
%          [-reset-scalars] - reset mapping along rows to scalars, taking length
%             from the nifti file
% 
%       [-to-text] - convert to a plain text file
%          <cifti-in> - the input cifti file
%          <text-out> - output - the output text file
% 
%          [-col-delim] - choose string to put between elements in a row
%             <delim-string> - the string to use (default is a tab character)
% 
%       [-from-text] - convert from plain text to cifti
%          <text-in> - the input text file
%          <cifti-template> - a cifti file with the dimension(s) and mapping(s)
%             that should be used
%          <cifti-out> - output - the output cifti file
% 
%          [-col-delim] - specify string that is between elements in a row
%             <delim-string> - the string to use (default is any whitespace)
% 
%          [-reset-timepoints] - reset the mapping along rows to timepoints,
%             taking length from the text file
%             <timestep> - the desired time between frames
%             <timestart> - the desired time offset of the initial frame
% 
%             [-unit] - use a unit other than time
%                <unit> - unit identifier (default SECOND)
% 
%          [-reset-scalars] - reset mapping along rows to scalars, taking length
%             from the text file
% 
%       This command is used to convert a full CIFTI matrix to/from formats that
%       can be used by programs that don't understand CIFTI.  You must specify
%       exactly one of -to-gifti-ext, -from-gifti-ext, -to-nifti, -from-nifti,
%       -to-text, or -from-text.
% 
%       If you want to write an existing CIFTI file with a different CIFTI
%       version, see -file-convert, and its -cifti-version-convert option.
% 
%       If you want part of the CIFTI file as a metric, label, or volume file,
%       see -cifti-separate.  If you want to create a CIFTI file from metric
%       and/or volume files, see the -cifti-create-* commands.
% 
%       If you want to import a matrix that is restricted to an ROI, first create
%       a template CIFTI file matching that ROI using a -cifti-create-* command.
%       After importing to CIFTI, you can then expand the file into a standard
%       brainordinates space with -cifti-create-dense-from-template.  If you want
%       to export only part of a CIFTI file, first create an roi-restricted CIFTI
%       file with -cifti-restrict-dense-mapping.
% 
%       The -transpose option to -from-gifti-ext is needed if the replacement
%       binary file is in column-major order.
% 
%       The -unit options accept these values:
% 
%       SECOND
%       HERTZ
%       METER
%       RADIAN

if nargin==0
    [wb_cfg, fname] = wb_file_info_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -cifti-convert');

wb_cmd = [wb_function ' ' conversion_type ' ' '"' fname_in '"' ' ' '"' fname_out '"'];

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
%     fprintf('Information about the surface %s\n', fname)
else
    display(cmdout);
end

function [wb_cfg, fname] = wb_file_info_test

wb_cfg      = wb_parameters;
% anat
% surf_file   = 'C:\Users\UCJT035\neuro Programs\workbench\data\Glasser_et_al_2016_HCP_MMP1.0_RVVG\HCP_PhaseTwo\Q1-Q6_RelatedParcellation210\MNINonLinear\fsaverage_LR32k\Q1-Q6_RelatedParcellation210.L.pial_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii';
% func
fname   = 'D:\Projects\RESPACT\analysis\results\univariate\group\ttest\onesampleT\smth8\catch_vs_images_FDR_mask.nii.R.func.gii';
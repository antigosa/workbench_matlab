function [status,cmdout] = wb_volume_palette(wb_cfg, nii_file, scale_mode, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo)
% function [status,cmdout] = wb_volume_palette(wb_cfg, gii_file, scale_mode, paletteName, minMaxVal, thresholdInfo)
% SET THE PALETTE OF A VOLUME FILE
%    wb_command -volume-palette
%       <volume> - the volume file to modify
%       <mode> - the mapping mode
% 
%       [-subvolume] - select a single subvolume
%          <subvolume> - the subvolume number or name
% 
%       [-pos-percent] - percentage min/max for positive data coloring
%          <pos-min-%> - the percentile for the least positive data
%          <pos-max-%> - the percentile for the most positive data
% 
%       [-neg-percent] - percentage min/max for negative data coloring
%          <neg-min-%> - the percentile for the least negative data
%          <neg-max-%> - the percentile for the most negative data
% 
%       [-pos-user] - user min/max values for positive data coloring
%          <pos-min-user> - the value for the least positive data
%          <pos-max-user> - the value for the most positive data
% 
%       [-neg-user] - user min/max values for negative data coloring
%          <neg-min-user> - the value for the least negative data
%          <neg-max-user> - the value for the most negative data
% 
%       [-interpolate] - interpolate colors
%          <interpolate> - boolean, whether to interpolate
% 
%       [-disp-pos] - display positive data
%          <display> - boolean, whether to display
% 
%       [-disp-neg] - display positive data
%          <display> - boolean, whether to display
% 
%       [-disp-zero] - display data closer to zero than the min cutoff
%          <display> - boolean, whether to display
% 
%       [-palette-name] - set the palette used
%          <name> - the name of the palette
% 
%       [-thresholding] - set the thresholding
%          <type> - thresholding setting
%          <test> - show values inside or outside thresholds
%          <min> - lower threshold
%          <max> - upper threshold
% 
%       The original volume file is overwritten with the modified version.  By
%       default, all columns of the volume file are adjusted to the new settings,
%       use the -subvolume option to change only one subvolume.  Mapping settings
%       not specified in options will be taken from the first subvolume.  The
%       <mode> argument must be one of the following:
% 
%       MODE_AUTO_SCALE
%       MODE_AUTO_SCALE_ABSOLUTE_PERCENTAGE
%       MODE_AUTO_SCALE_PERCENTAGE
%       MODE_USER_SCALE
% 
%       The <name> argument to -palette-name must be one of the following:
% 
%       PSYCH
%       PSYCH-NO-NONE
%       ROY-BIG
%       ROY-BIG-BL
%       Orange-Yellow
%       Gray_Interp_Positive
%       Gray_Interp
%       clear_brain
%       videen_style
%       fidl
%       raich4_clrmid
%       raich6_clrmid
%       HSB8_clrmid
%       RBGYR20
%       RBGYR20P
%       POS_NEG
%       red-yellow
%       blue-lightblue
%       FSL
%       power_surf
%       fsl_red
%       fsl_green
%       fsl_blue
%       fsl_yellow
%       JET256
% 
%       The <type> argument to -thresholding must be one of the following:
% 
%       THRESHOLD_TYPE_OFF
%       THRESHOLD_TYPE_NORMAL
% 
%       The <test> argument to -thresholding must be one of the following:
% 
%       THRESHOLD_TEST_SHOW_OUTSIDE
%       THRESHOLD_TEST_SHOW_INSIDE

if nargin==0
    [wb_cfg, nii_file, scale_mode, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo] = wb_metric_palette_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -volume-palette');

wb_cmd = [wb_function ' ' '"' nii_file '"' ' ' '"' scale_mode '"' ' ' '"-palette-name"' ' "' paletteName '" ' ...
    '"-neg-user"' ' ' num2str(neg_minMaxVal(1)) ' ' num2str(neg_minMaxVal(2)) ' ' '"-pos-user"' ' ' num2str(pos_minMaxVal(1)) ' ' num2str(pos_minMaxVal(2))  ' ', ...
    '"-thresholding"' ' "' thresholdInfo{1} '" ',  ' "' thresholdInfo{2} '" ',  ' ' num2str(thresholdInfo{3}) ' ',  ' ' num2str(thresholdInfo{4}) ' ',...    
    ];

[status,cmdout] = system(wb_cmd);

function [wb_cfg, nii_file, scale_mode, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo] = wb_metric_palette_test

wb_cfg          = wb_parameters;
nii_file        = './test/onesampleT_Tstat_masked_with_Zstat_MAXSUM_p001_body_detail_model.nii';
scale_mode      = 'MODE_USER_SCALE';
paletteName     = 'FSL';
neg_minMaxVal   = [0 -5];
pos_minMaxVal   = [0 5];
thresholdInfo   = {'THRESHOLD_TYPE_NORMAL', 'THRESHOLD_TEST_SHOW_INSIDE', 3, 5};
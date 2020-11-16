function [status,cmdout] = wb_cifti_palette(wb_cfg, cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts)
% function [status,cmdout] = wb_cifti_palette(wb_cfg, cifti_in, scale_mode, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts)
% SET THE PALETTE OF A CIFTI FILE
%    wb_command -cifti-palette
%       <cifti-in> - the cifti input
%       <mode> - the mapping mode
%       <cifti-out> - output - the output cifti file
% 
%       [-column] - select a single column for scalar maps
%          <column> - the column number or name
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
%       NOTE: The output file must be a different file than the input file.
% 
%       For scalar maps, by default the palette is changed for every map, specify
%       -column to change only one map.  Palette settings not specified will be
%       taken from the first column for scalar maps, and from the existing file
%       palette for other mapping types.  The <mode> argument must be one of the
%       following:
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
    [wb_cfg, cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts] = wb_cifti_palette_test;
end

if nargin==6
    thresholdInfo       = [];
    opts.disp_pos       = 'true';
    opts.disp_neg       = 'true';
end

if nargin==7
    opts.disp_pos       = 'true';
    opts.disp_neg       = 'true';
end


switch scale_mode
    
    case 'MODE_USER_SCALE'
        pos_str = '-pos-user';
        neg_str = '-neg-user';
        
    case 'MODE_AUTO_SCALE_ABSOLUTE_PERCENTAGE'        
        pos_str = '-pos-percent';
        neg_str = '-neg-percent';
        
    case 'MODE_AUTO_SCALE_PERCENTAGE'
        pos_str = '-pos-percent';
        neg_str = '-neg-percent';
        
    case 'MODE_AUTO_SCALE'
    
end

if isnumeric(col)
    col = num2str(col);
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -cifti-palette');

wb_cmd = [wb_function ' ' '"' cifti_in '"' ' ' '"' scale_mode '"' ' ' '"' cifti_out '" ' '"-column"' ' "' col '" ' '"-palette-name"' ' "' paletteName '" ' ...
    neg_str ' ' num2str(neg_minMaxVal(1)) ' ' num2str(neg_minMaxVal(2)) ' ' pos_str ' ' num2str(pos_minMaxVal(1)) ' ' num2str(pos_minMaxVal(2)) ' ' ...
    '"-disp-pos"' ' ' opts.disp_pos ' ', '"-disp-neg"' ' '  opts.disp_neg ' ' ...
    ];

if ~isempty(thresholdInfo)
    wb_cmd = [wb_cmd ' ', ...
        '"-thresholding"' ' "' thresholdInfo{1} '" ',  ' "' thresholdInfo{2} '" ',  ' ' num2str(thresholdInfo{3}) ' ',  ' ' num2str(thresholdInfo{4}) ' '
        ];
end

[status,cmdout] = system(wb_cmd);
if isempty(cmdout)
    fprintf('palette changed for file %s\n', cifti_in)
else
    display(cmdout);
end

function [wb_cfg, cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts] = wb_cifti_palette_test

wb_cfg              = wb_parameters;
cifti_in            = './pRF.Multivariate.Exp3.Dorsum.dscalar.nii';
cifti_out           = './tmp.dscalar.nii';
scale_mode          = 'MODE_USER_SCALE';
col                 = 1;
paletteName         = 'ROY-BIG-BL';
neg_minMaxVal       = [0 -5];
pos_minMaxVal       = [0 0.35];
thresholdInfo       = {'THRESHOLD_TYPE_NORMAL', 'THRESHOLD_TEST_SHOW_INSIDE', 0, 1};
opts.disp_pos       = 0;
opts.disp_neg       = 1;
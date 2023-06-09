function [status,cmdout] = wb_cifti_palette(cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts)
% function [status,cmdout] = wb_cifti_palette(cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts)


if nargin==0
    [cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts] = wb_cifti_palette_test;
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

% =========================================================================
% Options
% =========================================================================
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

if isnumeric(opts.disp_pos)
    switch opts.disp_pos
        case 0
            opts.disp_pos = 'false';
        case 1
            opts.disp_pos = 'true';
    end
end

if isnumeric(opts.disp_neg)
    switch opts.disp_neg
        case 0
            opts.disp_neg = 'false';
        case 1
            opts.disp_neg = 'true';
    end
end


% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -cifti-palette ' cifti_in ' ' scale_mode ' ' cifti_out ' -column ' col ' -palette-name ' paletteName ' ' ...
    neg_str ' ' num2str(neg_minMaxVal(1)) ' ' num2str(neg_minMaxVal(2)) ' ' pos_str ' ' num2str(pos_minMaxVal(1)) ' ' num2str(pos_minMaxVal(2)) ' ', ...
    ' -disp-pos ' opts.disp_pos ' -disp-neg ' opts.disp_neg];


if ~isempty(thresholdInfo)
    wb_cmd = [wb_cmd ' ', ...
        ' -thresholding ' thresholdInfo{1} ' ' thresholdInfo{2} ' ' num2str(thresholdInfo{3}) ' ' num2str(thresholdInfo{4})];
end

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('palette changed for file %s\n', cifti_in)
else
    display(cmdout);
end

function [cifti_in, scale_mode, cifti_out, col, paletteName, neg_minMaxVal, pos_minMaxVal, thresholdInfo, opts] = wb_cifti_palette_test

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
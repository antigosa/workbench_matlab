function [status,cmdout] = wb_metric_label_import(wb_cfg, metric_in, label_list_txt, label_gii_output)
% function [status,cmdout] = wb_metric_label_import(wb_cfg, metric_in, label_list_txt, label_gii_output)
% 
% e.g. -metric-label-import 

% MPORT A GIFTI LABEL FILE FROM A METRIC FILE
%    wb_command -metric-label-import
%       <input> - the input metric file
%       <label-list-file> - text file containing the values and names for labels
%       <output> - output - the output gifti label file
% 
%       [-discard-others] - set any values not mentioned in the label list to the
%          ??? label
% 
%       [-unlabeled-value] - set the value that will be interpreted as unlabeled
%          <value> - the numeric value for unlabeled (default 0)
% 
%       [-column] - select a single column to import
%          <column> - the column number or name
% 
%       [-drop-unused-labels] - remove any unused label values from the label
%          table
% 
%       Creates a new gifti label file from a metric file with label-like values.
%       You may specify the empty string ('' will work on linux/mac) for
%       <label-list-file>, which will be treated as if it is an empty file.  The
%       label list file must have lines of the following format:
% 
%       <labelname>
%       <value> <red> <green> <blue> <alpha>
% 
%       Do not specify the "unlabeled" key in the file, it is assumed that 0
%       means not labeled unless -unlabeled-value is specified.  Label names must
%       be on a separate line, but may contain spaces or other unusual characters
%       (but not newline).  Whitespace is trimmed from both ends of the label
%       name, but is kept if it is in the middle of a label.  The values of red,
%       green, blue and alpha must be integers from 0 to 255, and will specify
%       the color the label is drawn as (alpha of 255 means opaque, which is
%       probably what you want).  By default, it will set new label names with
%       names of LABEL_# for any values encountered that are not mentioned in the
%       list file, specify -discard-others to instead set these voxels to the
%       "unlabeled" key.




if nargin==0
    [wb_cfg, metric_in, label_list_txt, label_gii_output] = wb_metric_label_import_test;
end


% =========================================================================
% wb_command
% =========================================================================
wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-label-import');


% =========================================================================
% command string
% =========================================================================
wb_cmd = [wb_function ' ' '"' metric_in '"' ' ' '"' label_list_txt '"' ' ' '"' label_gii_output '"'];


% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-metric-label-import completed\n');
else
    display(cmdout);
end

function [wb_cfg, metric_in, label_list_txt, label_gii_output] = wb_metric_label_import_test

cd('D:\Projects\2018\pRF_hands\Experiment\Exp1_estimating_hand_pRFs\bash_script\roi_HCPMMP1_subjectSpace\S101\label');
wb_cfg              = wb_parameters;
metric_in           = 'lh.S102_HCPMMP1.annot.shape.gii';
label_list_txt      = 'lh.labels_info.txt';
label_gii_output    = 'lh.S102_HCPMMP1.annot.label.gii';

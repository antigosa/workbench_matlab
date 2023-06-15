function [status,cmdout] = wb_file_info(fname, s)
% function [status,cmdout] = wb_file_info(fname, s)
%    wb_command -file-information
%       <data-file> - data file
%
%       [-no-map-info] - do not show map information for files that support maps
%
%       [-only-step-interval] - suppress normal output, print the interval
%          between maps
%
%       [-only-number-of-maps] - suppress normal output, print the number of maps
%
%       [-only-map-names] - suppress normal output, print the names of all maps
%
%       [-only-metadata] - suppress normal output, print file metadata
%
%          [-key] - only print the metadata for one key, with no formatting
%             <key> - the metadata key
%
%       List information about the content of a data file.  Only one -only option
%       may be specified.  The information listed when no -only option is present
%       is dependent upon the type of data file.

if nargin<2;s=[];end

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

% =========================================================================
% command string
% =========================================================================
wb_cmd=[wb_command ' -file-information ' fname];

if ~isempty(s); wb_cmd=[wb_cmd ' ' s]; end

% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('-surface-closest-vertex executed correclty\n')
else
    display(cmdout);
end
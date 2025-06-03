function [status,cmdout] = wb_volume_find_clusters(volume_in, thrsh_val, min_val, volume_out)
% FILTER CLUSTERS BY VOLUME
%    wb_command -volume-find-clusters
%       <volume-in> - the input volume
%       <value-threshold> - threshold for data values
%       <minimum-volume> - threshold for cluster volume, in mm^3
%       <volume-out> - output - the output volume
% 
%       [-less-than] - find values less than <value-threshold>, rather than
%          greater
% 
%       [-roi] - select a region of interest
%          <roi-volume> - the roi, as a volume file
% 
%       [-subvolume] - select a single subvolume
%          <subvol> - the subvolume number or name
% 
%       [-size-ratio] - ignore clusters smaller than a given fraction of the
%          largest cluster in map
%          <ratio> - fraction of the largest cluster's volume
% 
%       [-distance] - ignore clusters further than a given distance from the
%          largest cluster
%          <distance> - how far from the largest cluster a cluster can be, edge
%             to edge, in mm
% 
%       [-start] - start labeling clusters from a value other than 1
%          <startval> - the value to give the first cluster found
% 
%       Outputs a volume with nonzero integers for all voxels within a large
%       enough cluster, and zeros elsewhere.  The integers denote cluster
%       membership (by default, first cluster found will use value 1, second
%       cluster 2, etc).  Cluster values are not reused across frames of the
%       output, but instead keep counting up.  By default, values greater than
%       <value-threshold> are considered to be in a cluster, use -less-than to
%       test for values less than the threshold.  To apply this as a mask to the
%       data, or to do more complicated thresholding, see -volume-math.

% =========================================================================
% wb_command
% =========================================================================
wb_par=wb_parameters;
wb_command=wb_par.wb_command;

if isnumeric(thrsh_val); thrsh_val=num2str(thrsh_val);end
if isnumeric(min_val); min_val=num2str(min_val);end

% =========================================================================
% command string
% =========================================================================
wb_cmd=['"' wb_command '" -volume-find-clusters "' volume_in '" '  thrsh_val ' ' min_val ' "' volume_out '"'];


% =========================================================================
% execute program
% =========================================================================
[status,cmdout] = system(wb_cmd);

% =========================================================================
% check output
% =========================================================================
if isempty(cmdout)
    fprintf('clusters saved in %s\n', volume_out)
else
    display(cmdout);
end
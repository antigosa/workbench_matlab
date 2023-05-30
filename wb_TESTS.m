addpath(genpath('D:\Programs\toolbox\raffa_functions\fmri_utils'))
addpath(genpath('D:\Programs\toolbox\gifti'))
addpath(genpath('D:\Programs\toolbox\workbench_matlab\'))
[gii_surf, glasser_fn] = fmri_glasser_files;

%% wb_surface_geodesic_distance
surface         = glasser_fn.lh.pial_fname;
vertex          = 7929;
opt.limit       = 35;
metric_out      = sprintf('lh.circularROI%d.func.gii', opt.limit);
[status,cmdout] = wb_surface_geodesic_distance(surface, vertex, metric_out, opt);

gii_ROI         = gifti(metric_out);
gii_ROI.cdata(5151+1)

%% wb_surface_closest_vertex
fprintf(fopen('list_file_coord.txt', 'w'), '51 -17 55\n43 -14 23');
surface             = glasser_fn.rh.midthick_fname;
coord_list_file     = 'list_file_coord.txt';
vertex_list_out     = 'list_out_vertex.txt';
wb_surface_closest_vertex(surface, coord_list_file, vertex_list_out);
fclose all;

fprintf(fopen('list_file_coord.txt', 'w'), '-42.5358 -27.0488 60.8598\n');
surface             = glasser_fn.lh.inflated_fname;
coord_list_file     = 'list_file_coord.txt';
vertex_list_out     = 'list_out_vertex.txt';
wb_surface_closest_vertex(surface, coord_list_file, vertex_list_out);
fileread(vertex_list_out)
fclose all;


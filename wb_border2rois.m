function wb_border2rois(surf_file, border_in, metric_out)
% THIS WORKS FOR ONE ROI PER FILE, FOR NOW

wb_par=wb_parameters;
wb_command=wb_par.wb_command;

system([wb_command ' -border-to-rois ' surf_file ' ' border_in ' ' metric_out]);
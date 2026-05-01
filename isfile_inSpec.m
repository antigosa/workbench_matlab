function [file_exist, out] = isfile_inSpec(spec_file, fname)
spec_struct = read_spec_file(spec_file);

file_exists = zeros(length(spec_struct), 1);
f_dir1      = cell(length(spec_struct), 1);
for i = 1:length(spec_struct)
    [f_dir1{i}, f_name1, f_ext1] = fileparts (spec_struct{i}.Path);
    [f_dir2, f_name2, f_ext2] = fileparts (fname);
    
    file_exists(i) = strcmp(strcat(f_name1, f_ext1), strcat(f_name2, f_ext2));    
end

file_exist = any(file_exists==1);

out.file_exist      = file_exists;
out.dirs_inSpec     = f_dir1;
out.dir_fname       = f_dir2;
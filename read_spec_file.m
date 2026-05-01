function data_files = read_spec_file(xml_filename)

% Parse the XML file into a DOM node object
xDoc = xmlread(xml_filename);

% Get a list of all <DataFile> nodes
data_file_nodes = xDoc.getElementsByTagName('DataFile');

% Initialize a cell array to store the data
num_files = data_file_nodes.getLength;
data_files = cell(1, num_files);

% Loop through each DataFile node
for i = 0:num_files-1
    node = data_file_nodes.item(i);
    
    % Read the attributes of the DataFile node
    file_info.Structure = char(node.getAttribute('Structure'));
    file_info.DataFileType = char(node.getAttribute('DataFileType'));
    file_info.Selected = char(node.getAttribute('Selected'));
    
    % Read the text content (the file path) inside the node
    file_info.Path = char(node.getFirstChild.getNodeValue);
    
    % Trim leading/trailing whitespace
    file_info.Path = strtrim(file_info.Path);
    
    % Store the struct
    data_files{i+1} = file_info;
end


% Example Usage:
% file_path = 'my_caret_spec.xml';
% result_struct = parse_caret_spec(file_path);
%
% % Now you can access the content:
% disp(result_struct{1}.Path);
% disp(result_struct{2}.DataFileType);

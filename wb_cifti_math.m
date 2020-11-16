function [status,cmdout] = wb_cifti_math(wb_cfg, expr, v, cifti_fname_out)
% NOT READY

%% EVALUATE EXPRESSION ON CIFTI FILES
%    wb_command -cifti-math
%       <expression> - the expression to evaluate, in quotes
%       <cifti-out> - output - the output cifti file
% 
%       [-fixnan] - replace NaN results with a value
%          <replace> - value to replace NaN with
% 
%       [-override-mapping-check] - don't check the mappings for compatibility,
%          only check length
% 
%       [-var] - repeatable - a cifti file to use as a variable
%          <name> - the name of the variable, as used in the expression
%          <cifti> - the cifti file to use as this variable
% 
%          [-select] - repeatable - select a single index from a dimension
%             <dim> - the dimension to select from (1-based)
%             <index> - the index to use (1-based)
% 
%             [-repeat] - repeat the selected values for each index of output in
%                this dimension
% 
%       This command evaluates <expression> at each matrix element independently.
%       There must be at least one -var option (to get the output layout from),
%       even if the <name> specified in it isn't used in <expression>.
% 
%       To select a single column from a 2D file (most cifti files are 2D), use
%       -select 1 <index>, where <index> is 1-based.  To select a single row from
%       a 2D file, use -select 2 <index>.  Where -select is not used, the cifti
%       files must have compatible mappings (e.g., brain models and parcels
%       mappings must match exactly except for parcel names).  Use
%       -override-mapping-check to skip this checking.
% 
%       Filenames are not valid in <expression>, use a variable name and a -var
%       option with matching <name> to specify an input file.  The format of
%       <expression> is as follows:
% 
%       Expressions consist of constants, variables, operators, parentheses, and
%       functions, in infix notation, such as 'exp(-x + 3) * scale'.  Variables
%       are strings of any length, using the characters a-z, A-Z, 0-9, and _, but
%       may not take the name of a named constant.  Currently, there is only one
%       named constant, PI.  The operators are +, -, *, /, ^, >, <, >=, <=, ==,
%       !=, !, &&, ||.  These behave as in C, except that ^ is exponentiation,
%       i.e. pow(x, y), and takes higher precedence than other binary operators
%       (also, '-3^-4^-5' means '-(3^(-(4^-5)))').  The <=, >=, ==, and !=
%       operators are given a small amount of wiggle room, equal to one millionth
%       of the smaller of the absolute values of the values being compared.
% 
%       Comparison and logical operators return 0 or 1, you can do masking with
%       expressions like 'x * (mask > 0)'.  For all logical operators, an input
%       is considered true iff it is greater than 0.  The expression '0 < x < 5'
%       is not syntactically wrong, but it will NOT do what is desired, because
%       it is evaluated left to right, i.e. '((0 < x) < 5)', which will always
%       return 1, as both possible results of a comparison are less than 5.  A
%       warning is generated if an expression of this type is detected.  Use
%       something like 'x > 0 && x < 5' to get the desired behavior.
% 
%       Whitespace between elements is ignored, ' sin ( 2 * x ) ' is equivalent
%       to 'sin(2*x)', but 's in(2*x)' is an error.  Implied multiplication is
%       not allowed, the expression '2x' will be parsed as a variable.
%       Parentheses are (), do not use [] or {}.  Functions require parentheses,
%       the expression 'sin x' is an error.
% 
%       The following functions are supported:
% 
%          sin: 1 argument, the sine of the argument (units are radians)
%          cos: 1 argument, the cosine of the argument (units are radians)
%          tan: 1 argument, the tangent of the argument (units are radians)
%          asin: 1 argument, the inverse of sine of the argument, in radians
%          acos: 1 argument, the inverse of cosine of the argument, in radians
%          atan: 1 argument, the inverse of tangent of the argument, in radians
%          atan2: 2 arguments, atan2(y, x) returns the inverse of tangent of
%       (y/x), in radians, determining quadrant by the sign of both arguments
%          sinh: 1 argument, the hyperbolic sine of the argument
%          cosh: 1 argument, the hyperbolic cosine of the argument
%          tanh: 1 argument, the hyperboloc tangent of the argument
%          asinh: 1 argument, the inverse hyperbolic sine of the argument
%          acosh: 1 argument, the inverse hyperbolic cosine of the argument
%          atanh: 1 argument, the inverse hyperboloc tangent of the argument
%          ln: 1 argument, the natural logarithm of the argument
%          exp: 1 argument, the constant e raised to the power of the argument
%          log: 1 argument, the base 10 logarithm of the argument
%          sqrt: 1 argument, the square root of the argument
%          abs: 1 argument, the absolute value of the argument
%          floor: 1 argument, the largest integer not greater than the argument
%          round: 1 argument, the nearest integer, with ties rounded away from
%       zero
%          ceil: 1 argument, the smallest integer not less than the argument
%          min: 2 arguments, min(x, y) returns y if (x > y), x otherwise
%          max: 2 arguments, max(x, y) returns y if (x < y), x otherwise
%          mod: 2 arguments, mod(x, y) = x - y * floor(x / y), or 0 if y == 0
%          clamp: 3 arguments, clamp(x, low, high) = min(max(x, low), high)


if nargin==0
    [wb_cfg, expr, v, cifti_fname_out] = wb_metric_math_test;
end

wb_function = strcat('"', wb_cfg.wb_command, '"', ' -metric-math');

nvariables = length(v);
variables = '';
for i = 1:nvariables    
    variables = [variables, ' ', sprintf('-var %s "%s"', v(i).name, v(i).metric)]; %#ok<AGROW>
end

wb_cmd = [wb_function ' ' '"' expr '"' ' ' '' variables '' ' ' '"' cifti_fname_out '"'];

[status,cmdout] = system(wb_cmd);
if status==0
    fprintf('expression %s applied correclty\n', expr)
else
    display(cmdout);
end

function [wb_cfg, expr, v, cifti_fname_out] = wb_metric_math_test
cd('D:\Projects\2018\pRF_hands\Experiment\Exp3_localise_fingers\results\S102\func\glm_PalmSeparatedPredictors_smth3_hpf128')
wb_cfg              = wb_parameters;
cifti_fname_out    = './SPM.PalmSeparatedPredictors.smth3.hpf128.masked.dscalar.nii';

expr                = 'abs(m)>=1.65';
v(1).name           = 'm';
v(1).metric         = './test/images_vs_rest_Zstat_MAXSUM_p001.nii.L.func.gii';
% var(2).name    = 'y';
% var(2).metric  = 'images_vs_rest_Zstat_MAXSUM_p001.nii';

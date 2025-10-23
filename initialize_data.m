% initialize_data.m
%
% This script runs ONCE to create the initial database files.
% It converts the original hard-coded matrices into persistent
% .mat files containing readable 'tables'.

clear; clc;
fprintf('Initializing database in ''data/'' directory...\n');

% --- Create data directory ---
if ~exist('data', 'dir')
    mkdir('data');
end

% --- Employee Data ---
employees_mat = [401101 1001; 401102 1002];
employees_table = array2table(employees_mat, ...
    'VariableNames', {'Username', 'Password'});
save('data/employees.mat', 'employees_table');

% --- Teacher Data ---
teachers_mat = [401201 2001; 401202 2002; 401203 2003];
teachers_table = array2table(teachers_mat, ...
    'VariableNames', {'Username', 'Password'});
save('data/teachers.mat', 'teachers_table');

% --- Course Data ---
% We separate course info from student grades.
% The 'assess' logic will be done dynamically.
course_names = ["Algo"; "NumAnalysis"; "MathDB"; "MathSW"; "OS"];
credits = [3; 3; 3; 3; 4];
courses_table = table(course_names, credits, ...
    'VariableNames', {'Name', 'Credits'});
save('data/courses.mat', 'courses_table');

% --- Student Data ---
% Original matrix with grades
students_mat = [401301 3001 -1 -1 15 -1 -1;
    401302 3002 -1 -1 13.25 -1 -1;
    401303 3003 -1 -1 19 -1 -1;
    401304 3004 -1 -1 20 -1 -1;
    401307 3007 -1 -1 16 -1 -1;
    401308 3008 -1 -1 18 -1 -1;
    401305 3005 -1 -1 18.75 -1 -1;
    401306 3006 -1 -1 15 -1 -1;
    401309 3009 -1 -1 17.5 -1 -1;
    401310 3010 -1 -1 20 -1 -1;
    401311 3011 -1 -1 20 -1 -1;
    401312 3012 -1 -1 11.5 -1 -1;
    401313 3013 -1 -1 17 -1 -1;
    401314 3014 -1 -1 10 -1 -1;
    401315 3015 -1 -1 20 -1 -1;
    401316 3016 -1 -1 8.5 -1 -1;
    401317 3017 -1 -1 19.75 -1 -1;
    401318 3018 -1 -1 9.25 -1 -1;
    401319 3019 -1 -1 10.25 -1 -1;
    401320 3020 -1 -1 12.75 -1 -1];

% Convert to a table for readable, named columns
students_table = array2table(students_mat, 'VariableNames', ...
    {'Username', 'Password', 'Algo', 'NumAnalysis', 'MathDB', 'MathSW', 'OS'});
save('data/students.mat', 'students_table');

fprintf('Database initialized successfully.\n');

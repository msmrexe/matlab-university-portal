% +golestan/DataService.m
classdef DataService
    % Handles loading from and saving to .mat data files.
    
    properties
        DataPath
        EmployeesFile
        TeachersFile
        StudentsFile
        CoursesFile
    end
    
    methods
        function obj = DataService(path)
            % Constructor: Sets up the file paths
            obj.DataPath = path;
            obj.EmployeesFile = fullfile(path, 'employees.mat');
            obj.TeachersFile = fullfile(path, 'teachers.mat');
            obj.StudentsFile = fullfile(path, 'students.mat');
            obj.CoursesFile = fullfile(path, 'courses.mat');
        end
        
        function [emp, tch, stu, crs] = loadAllData(obj)
            % Loads all tables from .mat files
            if ~exist(obj.DataPath, 'dir')
                error(['Data directory not found: %s\n' ...
                    'Please run initialize_data.m first.'], obj.DataPath);
            end
            emp = load(obj.EmployeesFile).employees_table;
            tch = load(obj.TeachersFile).teachers_table;
            stu = load(obj.StudentsFile).students_table;
            crs = load(obj.CoursesFile).courses_table;
        end
        
        function saveStudents(obj, students_table)
            % Saves only the students table (most common change)
            save(obj.StudentsFile, 'students_table');
        end
        
        function saveCourses(obj, courses_table)
            % Saves only the courses table
            save(obj.CoursesFile, 'courses_table');
        end
    end
end

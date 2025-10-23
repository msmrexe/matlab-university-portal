% +golestan/utils.m
classdef utils
    % Static class for utility functions (assess, gpacalc).
    
    methods (Static)
        function [min_g, max_g, avg_g] = assess(students_table, course_name)
            % Calculates min, max, and avg for a course
            
            % Get all grades for the course by its name
            grades = students_table.(course_name);
            
            % Filter for only valid (non-pending) grades
            valid_grades = grades(grades >= 0);
            
            if isempty(valid_grades)
                min_g = NaN;
                max_g = NaN;
                avg_g = NaN;
            else
                % Use fast, built-in vectorized functions
                min_g = min(valid_grades);
                max_g = max(valid_grades);
                avg_g = mean(valid_grades);
            end
        end
        
        function gpa = gpacalc(student_row, courses_table)
            % Calculates GPA for a single student (passed as a table row)
            
            points = 0;
            credits = 0;
            
            for i = 1:height(courses_table)
                course_name = courses_table.Name(i);
                grade = student_row.(course_name);
                
                if grade >= 0
                    credit_val = courses_table.Credits(i);
                    points = points + (grade * credit_val);
                    credits = credits + credit_val;
                end
            end
            gpa = points / credits; % Will be NaN if credits = 0
        end
    end
end

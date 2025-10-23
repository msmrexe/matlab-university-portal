% +golestan/TeacherPortal.m
function [students_out] = run(students_in, courses)
    % Runs the main loop for the Teacher Portal.
    % Returns the modified students table.
    
    students_out = students_in; % Work on a copy
    fprintf("Welcome, Teacher!\n");
    
    course_names = students_out.Properties.VariableNames(3:end);

    while true
        fprintf("\n--- Teacher Menu ---\n");
        fprintf("0) Exit Portal and Save Changes\n");
        for i = 1:length(course_names)
            fprintf("%d) Manage Course: %s\n", i, course_names{i});
        end
        
        num = input("Enter option number: ");
        
        if num == 0
            fprintf("Exiting and saving changes...\n\n");
            break;
        elseif num >= 1 && num <= length(course_names)
            course_name = course_names{num};
            
            % --- View/Edit Grades ---
            [min_g, max_g, avg_g] = golestan.utils.assess(students_out, course_name);
            
            if isnan(avg_g)
                fprintf("Grades have not yet been entered for %s.\n", course_name);
                empty = true;
            else
                fprintf("\n--- Current Grades for %s ---\n", course_name);
                % Display current grades
                for i = 1:height(students_out)
                    fprintf("Student %d: %f\n", students_out.Username(i), students_out.(course_name)(i));
                end
                fprintf("--------------------\n");
                fprintf("Min: %f\nMax: %f\nAverage: %f\n", min_g, max_g, avg_g);
                empty = false;
            end
            
            action = input("Would you like to enter/edit grades for this course? (y/n): ", "s");
            if action == "y"
                fprintf("\n--- Grade Entry ---\n");
                for i = 1:height(students_out)
                    prompt = sprintf("Enter grade for Student %d (current: %f): ", ...
                        students_out.Username(i), students_out.(course_name)(i));
                    new_grade = input(prompt);
                    students_out.(course_name)(i) = new_grade;
                end
                fprintf("Grades saved temporarily! Returning to menu...\n\n");
            else
                fprintf("Alright! Returning to menu...\n\n");
            end
        else
            fprintf("Invalid option. Please try again.\n");
        end
    end
end

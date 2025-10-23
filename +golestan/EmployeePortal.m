% +golestan/EmployeePortal.m
function [courses_out] = run(courses_in)
    % Runs the main loop for the Employee Portal.
    % Returns the modified courses table.
    
    courses_out = courses_in; % Work on a copy
    fprintf("Welcome, Employee!\n");

    while true
        fprintf("\n--- Employee Menu ---\n");
        fprintf("0) Exit Portal and Save Changes\n");
        fprintf("1) View/Edit Course Credits\n");
        
        num = input("Enter option number: ");
        
        if num == 0
            fprintf("Exiting and saving changes...\n\n");
            break;
        elseif num == 1
            % --- View/Edit Credits ---
            fprintf("\n--- Current Courses ---\n");
            disp(courses_out); % 'disp' prints a nice table
            
            course_num = input("Enter course row number to edit: ");
            
            if course_num >= 1 && course_num <= height(courses_out)
                current_cred = courses_out.Credits(course_num);
                course_name = courses_out.Name(course_num);
                fprintf("Current credits for %s: %d\n", course_name, current_cred);
                
                new_cred = input("Enter new credit value: ");
                courses_out.Credits(course_num) = new_cred;
                fprintf("Credits for %s updated temporarily.\n\n", course_name);
            else
                fprintf("Invalid row number.\n\n");
            end
        else
            fprintf("Invalid option. Please try again.\n");
        end
    end
end

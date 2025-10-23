% +golestan/StudentPortal.m
function run(students, courses, student_row_index)
    % Runs the main loop for the Student Portal.
    
    my_data = students(student_row_index, :);
    fprintf("Welcome, Student %d!\n", my_data.Username);

    while true
        fprintf("\n--- Student Menu ---\n");
        fprintf("0) Exit Portal\n");
        % Dynamically list courses
        for i = 1:height(courses)
            fprintf("%d) Course Details: %s\n", i, courses.Name(i));
        end
        fprintf("6) Report Card\n");
        
        num = input("Enter option number: ");
        
        if num == 0
            fprintf("Exiting student portal...\n\n");
            break;
        elseif num == 6
            % --- Report Card ---
            fprintf("\n--- Your Report Card ---\n");
            for i = 1:height(courses)
                course_name = courses.Name(i);
                grade = my_data.(course_name);
                if grade >= 0
                    fprintf("%s: %f\n", course_name, grade);
                end
            end
            gpa = golestan.utils.gpacalc(my_data, courses);
            if ~isnan(gpa)
                fprintf("--------------------\n");
                fprintf("Your GPA: %f\n", gpa);
            else
                fprintf("No courses have grades yet.\n");
            end
            fprintf("Returning to menu...\n\n");
            
        elseif num >= 1 && num <= height(courses)
            % --- Course Details ---
            course_name = courses.Name(num);
            grade = my_data.(course_name);
            
            if grade >= 0
                fprintf("\nYour grade for %s: %f\n", course_name, grade);
                [min_g, max_g, avg_g] = golestan.utils.assess(students, course_name);
                action = input("Would you like to view class statistics? (y/n): ", "s");
                if action == "y"
                    fprintf("\n--- Class Statistics ---\n");
                    fprintf("Min: %f\nMax: %f\nAverage: %f\n", min_g, max_g, avg_g);
                end
                fprintf("Returning to menu...\n\n");
            else
                fprintf("\nGrades for %s have not yet been entered.\n\n", course_name);
            end
        else
            fprintf("Invalid option. Please try again.\n");
        end
    end
end

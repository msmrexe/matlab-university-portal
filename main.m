% main.m
% Main entry point for the Mini-Golestan application.
% Handles user login, calls the correct portal,
% and saves data on logout.

clear; clc;
addpath(genpath(pwd)); % Add all subfolders (like +golestan) to path

% --- Create a DataService object ---
% This object will handle all our loading and saving.
try
    ds = golestan.DataService('data');
catch ME
    disp(ME.message);
    return; % Stop if data isn't initialized
end

fprintf("Welcome to Mini Golestan!\n");

% --- Main Login Loop ---
while true
    % Load fresh data at the start of each login cycle
    [employees, teachers, students, courses] = ds.loadAllData();
    
    fprintf("\n--- Main Menu ---\n");
    fprintf("Which type of user are you?\n");
    fprintf("  e) Employee\n");
    fprintf("  t) Teacher\n");
    fprintf("  s) Student\n");
    fprintf("  x) Exit Program\n");
    type = input("Enter your choice: ", "s");

    if type == "x"
        fprintf("Thank you for using Mini Golestan. Goodbye!\n");
        break;
    elseif ~ismember(type, ["e", "t", "s"])
        fprintf("Invalid choice. Please try again.\n");
        continue;
    end

    % --- Authentication ---
    username = input("Enter your username: ");
    password = input("Enter your password: ");

    status = false;
    user_id = 0;
    
    try
        if type == "e"
            [status, ~] = golestan.AuthService.login(username, password, employees);
        elseif type == "t"
            [status, ~] = golestan.AuthService.login(username, password, teachers);
        elseif type == "s"
            [status, user_id] = golestan.AuthService.login(username, password, students);
        end
    catch ME
        fprintf("Login error: %s\n", ME.message);
        continue;
    end
    
    % --- Portal Logic ---
    if status
        fprintf("Login successful!\n");
        if type == "e"
            % Employee portal runs and returns modified courses
            modified_courses = golestan.EmployeePortal.run(courses);
            ds.saveCourses(modified_courses); % Save changes
            
        elseif type == "t"
            % Teacher portal runs and returns modified students
            modified_students = golestan.TeacherPortal.run(students, courses);
            ds.saveStudents(modified_students); % Save changes
            
        elseif type == "s"
            % Student portal runs, but does not save anything
            golestan.StudentPortal.run(students, courses, user_id);
        end
        fprintf("Logged out. Returning to Main Menu...\n");
        
    else
        fprintf("Login failed. Wrong username or password.\n");
    end
end

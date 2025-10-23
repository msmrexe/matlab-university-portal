% +golestan/AuthService.m
classdef AuthService
    % Provides a static method for user authentication.
    
    methods (Static)
        function [status, row_index] = login(username, password, user_table)
            % Efficiently finds a user in a table
            % This is a fast, vectorized lookup.
            
            row_index = find(user_table.Username == username & ...
                             user_table.Password == password);
            
            if isempty(row_index)
                status = false;
                row_index = 0; % Return a scalar
            else
                status = true;
                row_index = row_index(1); % Ensure scalar
            end
        end
    end
end

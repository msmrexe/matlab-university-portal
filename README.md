# MATLAB University Portal (Mini-Golestan)

This project is a modular university registration system ("Mini-Golestan") written in MATLAB. It was refactored from a single-script project to demonstrate professional MATLAB development practices, including packages, classes, file-based data persistence, and vectorized operations.

The system supports three user roles:
* **Students:** Can view their grades, see class statistics (min/max/avg), and check their GPA.
* **Teachers:** Can view class rosters and enter/edit grades for their courses.
* **Employees:** Can view and edit course information, such as credit hours.

## Features

* **Persistent Data:** All data (users, grades, courses) is stored in `.mat` files, so changes are saved between sessions.
* **Modular Package:** All application logic is encapsulated in a `+golestan` MATLAB package, separating it from the main script.
* **Clean Data Structures:** Uses MATLAB `tables` instead of raw matrices. This allows for readable, named-column access (e.g., `students.MathDB`) instead of "magic numbers" (`students(:, 3)`).
* **Separation of Concerns:**
    * `DataService.m` handles all file loading/saving.
    * `AuthService.m` handles user login.
    * `utils.m` provides static helper functions (GPA, grade assessment).
    * `StudentPortal.m`, `TeacherPortal.m`, and `EmployeePortal.m` contain their own UI loops.
* **Efficient Code:** Uses fast, vectorized table lookups instead of `for`-loop user searches.

## Project Structure

```
matlab-university-portal/ 
├── .gitignore 
├── LICENSE 
├── README.md                      # This documentation 
├── initialize_data.m              # --- RUN THIS FIRST --- 
├── main.m                         # The main runnable script (CLI) 
└── +golestan/                     # The MATLAB package folder 
    ├── AuthService.m              # Static class for login 
    ├── DataService.m              # Class for loading/saving .mat files 
    ├── EmployeePortal.m           # Function for the employee UI 
    ├── StudentPortal.m            # Function for the student UI 
    ├── TeacherPortal.m            # Function for the teacher UI 
    └── utils.m                    # Static class for gpacalc, assess
```

## How to Run

1.  **Open MATLAB.**
2.  **Add to Path:** Make sure the project's root folder is on the MATLAB path.
    ```matlab
    >> addpath(genpath(pwd));
    ```
3.  **Initialize the Database (Run Once):**
    Run the initialization script from the MATLAB command window. This will create the `data/` directory.
    ```matlab
    >> initialize_data
    Initializing database in 'data/' directory...
    Database initialized successfully.
    ```
4.  **Run the Main Program:**
    Now you can run the main application.
    ```matlab
    >> main
    Welcome to Mini Golestan!

    --- Main Menu ---
    Which type of user are you?
      e) Employee
      t) Teacher
      s) Student
      x) Exit Program
    Enter your choice:
    ```

---

## Author

Feel free to connect or reach out if you have any questions!

* **Maryam Rezaee**
* **GitHub:** [@msmrexe](https://github.com/msmrexe)
* **Email:** [ms.maryamrezaee@gmail.com](mailto:ms.maryamrezaee@gmail.com)

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for full details.

# Team Children of Jupyter Final Project
Group 1 Final Project: Data Analytics Boot Camp

## Selected Topic and Rationale
We will be using machine learning to create a model that predicts which passengers survived the Titanic shipwreck. Our team selected this topic because we wanted to obtain a deeper understanding of the tragedy and how different passenger attributes impacted their odds of survival.
## Data Source
Our resources will come from the dataset contained in the ["stablelearner" r-package](https://search.r-project.org/CRAN/refmans/DALEX/html/titanic.html#:~:text=According%20to%20the%20website%201317,for%20a%20few%20regular%20passengers.) and stored as [CSV files](Resources/titanic.csv).

## Technologies Used
The project is broken into component pieces below. 

* <strong>Machine Learning</strong>: We used a [decision tree model](Notebooks/Titanic-decision-tree.ipynb) 
* <strong>Database Storage</strong>: We used a local instance of pgAdmin (PostgresSQL) to store [a backup file](Resources/titanic_project_db_backup.sql) of the database that project members can download and restore on their local machines. Users are encouraged to use the [create_database](Notebooks/create_database.ipynb) script in Jupyter Notebook to this end (see steps below) 
* <strong>Statistical Analyses</strong>: RStudio
* <strong>Interactive Dashboard</strong>: Tableau 
* <strong>Website</strong>: Flask with API routes that render across Python, HTML and JavaScript (see usage details below)
* <strong>Presentation</strong>: PowerPoint; Google Slides

## Questions We Hope to Answer
We will run statistical analysis to see how different groups faired based on factors such as age, gender, socio-economic status, etc. We are hoping to add a section of our dashboard that allows users to input their own information and generate their probability of survival.

## Communication Protocols
We plan to work asynchronously and use class times to go over what each member is working on, including walkthroughs of how tasks were completed. We will be communicating through slack and using Saturday morning sessions to troubleshoot on an as-needed basis.

## Importing titanic.csv into PgAdmin
* Create a database named ```titanic_project``` and ensure it is selected with an active connection. 
* Add a ```config.py``` file to your Notebooks folder in the group repo. (The file is otherwise hidden in .gitignore.) It should read:
    ```
    db_password = '[insert your password here]'
    ```
* Open a command line terminal in this same Notebooks folder and run ```jupyter notebook```
* Open the ```create_database.ipynb``` file and execute the four cells 
* Refresh your database. You should see a new table ```passenger_registry```
    * To confirm the data imported properly, run the following query: 
        ```
        select * from passenger_registry where country='United States';
        ```
        You should see 264 records returned. 

## Flask: Running the application locally
* Ensure that your development environment is active with
    ```
    conda activate [development-environment-name]
    ```
* If you haven't already, install Flask with the following command
    ```
    pip install flask
    ```
* Navigate to the /webapp folder of the repo. Run the following command:
    ```
    flask run
    ```

    or

    ```
    python app.py
    ```

    The app should open on a localhost (likely http://127.0.0.1:5000/). Copy this address into your browser and enjoy!
* When you finish using the app, you can run ```Ctrl + C``` in the terminal to end the local connection. 
    
<!-- * Navigate to the 'children-of-jupyter' repo
* Right-click and open 'Git Bash here'
* Run this command in the terminal:
    ```
    python app.py
    ```
* You should see a message that the Flask application is running on localhost
* Enter the address (usually http://127.0.0.1:5000/) in  your browser to view the application -->
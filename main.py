import subprocess as sp
import pymysql
import pymysql.cursors

# --- Globals ---
CLEAR_FLAG = True

# --- Utils ---
def clear_screen():
    if CLEAR_FLAG:
        return sp.call('clear', shell=True)
    else:
        return -1

def print_menu():
    print('Select operation: ')
    print('1 - Search alumni')
    print('2 - Add new job to the market')
    print('3 - Find projects by field')
    print('4 - Check eligibility')
    print('5 - Find Job!!')
    print('0 - Logout')

def handle_exception(e, desc=''):
    print(f'Exception: {desc}\n> {e}\n')


# --- Functional Requirements ---
# fn_    functions handle input
# query_ functions handle the query 

def fn_search_alumni(cursor):
    '''
    Search for all alumni of a particular educational institute
    '''

    educational_institute = input('\tEnter name of the institute > ')
    query_search_alumni(cursor, educational_institute)


def query_search_alumni(cursor, educational_institute):
    '''
    select p.Person_Id as 'Person ID', p.Name as 'Name', q.Description 'Description', q.CGPA as 'CGPA', q.Qualifications as Degree 
    from Person p, Educational_Qualifications q, Educational_Institutes e
    where q.Person_Id = p.Person_Id and q.Educational_Institute_Id = e.Educational_Institute_Id
          and e.Name = <educational_institute>;
    '''

    try:
        query  = f"select p.Person_Id as 'Person ID', p.Name as 'Name', q.Description as 'Description', q.CGPA as 'CGPA', q.Qualifications as 'Degree' "
        query += f"from Person p, Educational_Qualifications q, Educational_Institutes e "
        query += f"where q.Person_Id = p.Person_Id and q.Educational_Institute_Id = e.Educational_Institute_Id "
        query += f"and e.Name = '{educational_institute}';"

        print(f"Query Executed:\n{query}\n")

        cursor.execute(query)
        results = cursor.fetchall()
        print(f'Result: {type(results)}\n', results)
    except Exception as e:
        handle_exception(e, 'query_search_alumni')


def fn_add_job(cursor):
    '''
    Add a new job to the market
    '''

    job_id          = int(input('\tEnter Job ID > '))
    job_description = input('\tEnter Job Description > ')
    institute_id    = int(input('\tEnter Institute ID > ')) # Institute ID of the institute offering the job
    salary          = int(input('\tEnter Salary > '))
    start_date      = input('\tEnter Start Date (YYYY-MM-DD) > ')
    end_date        = input('\tEnter End Date (YYYY-MM-DD) > ')
    type_           = input("\tEnter Job Type (('Software Developer', 'Project Manager', 'Researcher')) > ")
    duration_worked = int(input('\tEnter Duration Worked > '))

    row = {
        'job_id': job_id,
        'job_description': job_description,
        'institute_id': institute_id,
        'salary': salary,
        'start_date': start_date,
        'end_date': end_date,
        'type_': type_,
        'duration_worked': duration_worked
    }

    query_add_job(cursor, row)


def query_add_job(cursor, row):
    '''
    insert into Jobs(Job_Id, Job_Description, Institute_Id, Salary, 
                     Start_Date, End_Date, Type, Duration_Worked)
    values(...);

    '''
    try:

        query  = f"insert into Jobs(Job_Id, Job_Description, Institute_Id, Salary, Start_Date, End_Date, Type, Duration_Worked) "
        query += f"values({row['job_id']}, '{row['job_description']}', {row['institute_id']}, {row['salary']}, "
        query += f"'{row['start_date']}', '{row['end_date']}', '{row['type_']}', {row['duration_worked']});"

        print(f"Query Executed:\n{query}\n")

        cursor.execute(query)
        print("Job added to the job market successfully")
    except Exception as e:
        handle_exception(e, 'query_add_job')


def fn_projects_by_field(cursor):
    '''
    List the projects worked on by anyone in a particular field
    '''

    field  = input('\tEnter field > ')
    query_projects_by_field(cursor, field)
    

def query_projects_by_field(cursor, field):
    '''

    select pr.Project_Id as 'Project ID', pr.Type 'Type', pr.Description as 'Description', 
           i.Name as 'Affiliated Institute', p.Name as 'Name'
    from Associated_With a, Person p, Institutes i, Project pr, Fields f
    where a.Person_Id = p.Person_Id and a.Institute_Id = i.Institute_Id and a.Project_Id = pr.Project_Id
          and pr.Field_Id = f.Field_Id
          and f.Field = <field>;
    
    '''

    try:
        query  = f"select pr.Project_Id as 'Project ID', pr.Type_ 'Type', pr.Description as 'Description', i.Name as 'Affiliated Institute', p.Name as 'Name' "
        query += f"from Associated_With as a join Person as p on p.Person_Id = a.Person_Id join Institutes as i on a.Institute_Id = i.Institute_Id join Project as pr on a.Project_Id = pr.Project_Id "
        query += f"join Project_Field as pf on pf.Project_Id = a.Project_Id join Fields as f on pf.Field_Id = f.Field_Id and f.Field_ = '{field}';"
    
        print(f"Query Executed:\n{query}\n")

        cursor.execute(query)
        results = cursor.fetchall()
        print(f'Result: {type(results)}\n', results)
    except Exception as e:
        handle_exception(e, 'query_projects_by_field')


def fn_check_eligibility(cursor):
    '''
    Given a specific person and job, return whether or not the person is eligible for it
    '''

    person_id = input('\tEnter Person ID > ')
    job_id    = input('\tEnter Job ID > ')
    result = query_check_eligibility(cursor, person_id, job_id)

    if result:
        print('\nYES. The person is eligible')
    else:
        print('\nNO. The person is not eligible')
   

def query_check_eligibility(cursor, person_id, job_id):
    '''
    How qualification works -
    It follows the Hierarchy (PhD > Masters > Bachelors)
    
    Query Logic -
    1. first find the total work experience (in years) of the person
    2. then find the cgpa and qualification
    3. Retrieve the minimum years of experience, minimum qualification and minimum cgpa from Work_Experience
    4. If the person's values are equal to or larger, return 'YES'. Else return 'NO'

    select sum(w.Number_of_Years) as 'Experience'
    from Work_Experience w, Person p, Jobs j
    where w.Person_Id = p.Person_Id and w.Job_Id = j.Job_Id
          and p.Person_Id = <person_id>;

    Assumption: The highest qualification of the person is maintained in Educational_Qualifications
    select q.cgpa, q.Qualifications
    from Educational_Qualifications q 
    where q.Person_Id = <person_id>;

    select m.Min_Years_of_Experience, m.Min_Qualification, m.CGPA
    from Minimum_Job_Requirements m
    where m.Job_Id = <job_id>;

    Now compare the two and return 'YES' or 'NO'
    '''

    try:
        query1  = f"select sum(w.Number_of_Years) as 'Experience' "
        query1 += f"from Work_Experience w, Person p, Jobs j "
        query1 += f"where w.Person_Id = p.Person_Id and w.Job_Id = j.Job_Id and p.Person_Id = {person_id};"

        cursor.execute(query1)
        results = cursor.fetchall()
        results = results[0]

        person_total_work_experience = results['Experience']

        query2  = f"select q.CGPA as 'CGPA', q.Qualifications as 'Degree' from Educational_Qualifications q "
        query2 += f"where q.Person_Id = {person_id};"

        cursor.execute(query2)
        results = cursor.fetchall()
        results = results[0]

        degree_ranks = {
            'Bachelors': 1,
            'Masters': 2,
            'PhD': 3
        }

        person_cgpa = results['CGPA']
        person_degree = degree_ranks[results['Degree']]

        query3  = f"select m.Min_Years_of_Experience as 'Min_Years_of_Experience', m.Min_Qualifications as 'Degree', m.min_CGPA as 'CGPA' "
        query3 += f"from Minimum_Job_Requirements m where m.Job_Id = {job_id};"

        cursor.execute(query3)
        results = cursor.fetchall()
        results = results[0]

        job_min_years_of_experience = results['Min_Years_of_Experience']
        job_min_degree = degree_ranks[results['Degree']]
        job_min_cgpa = results['CGPA']

        if person_cgpa < job_min_cgpa or person_degree < job_min_degree or person_total_work_experience < job_min_years_of_experience:
            return False
        else:
            return True

    except Exception as e:
        handle_exception(e, 'query_check_eligibility')

def fn_find_job(cursor):
    '''
    Given a person's ID, search for all jobs in the market that the person is qualified to do 
    '''

   

def query_find_job(cursor, row, person_id):
    '''
    This is the same as check_eligibility applied on all jobs

    Retrieve the Job_Id and Job_Description of all jobs and then run check_eligibility()
    select j.Job_Id, j.Job_Description
    from Jobs j;

    If check_eligibility returns 'YES', then print the job details
    select j.Job_Id, j.Job_Description, j.Institute_Id, j.Salary, j.Start_Date, j.End_Date, j.Type
    from Jobs j where j.Job_Id = <job_id>;
    '''

    None


def run_client(connection):
    with connection.cursor() as cursor:
        while True:
            clear_screen()
            print_menu()

            choice = int(input('Enter choice > '))

            if choice == 0:
                print('Logging off')
                break

            elif choice == 1:
                fn_search_alumni(cursor)
                connection.commit() # By executing this outside the fn_ function, we are maintaining atomicity
            
            elif choice == 2:
                fn_add_job(cursor)
                connection.commit()
            elif choice == 3:
                fn_projects_by_field(cursor)
                connection.commit()
            elif choice == 4:
                fn_check_eligibility(cursor)
                connection.commit()


            control = input("\nContinue? (yes/no) > ")
            
            while control != 'yes' and control != 'no':
                control = input("Continue? (yes/no) > ")

            if control == 'no':
                return 'exit'

connection = None

while True:
    clear_screen()
    print("--- Welcome to Only Jobs ---")

    username = input("Enter username > ")
    password = input("Enter password > ")

    try:
        connection = pymysql.connect(host='localhost',
            port=13306,
            user=username,
            password=password,
            db='jobs_db',
            cursorclass=pymysql.cursors.DictCursor)
    
        if connection.open:
            print('Connection established')
            ret = run_client(connection)
            if ret == 'exit':
                break

    except Exception as e:
        print(e)
        print('Connection Refused: either username or password is incorrect,')
        print('or the user doesn\'t have access to the database')
        tmp = input('Enter any key to continue')

print("\n--- Exiting Only-Jobs! ---\n")

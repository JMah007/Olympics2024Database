import mysql.connector

# Function to display menu
def display_menu():
    print("\nMenu\n")
    print("1. Find team in certain discipline and team start with specific letter")
    print("2. Add an athlete")
    print("3. Delete an athlete")
    print("4. Update athlete gender")
    print("5. Display a table")
    print("6. Modify coach")
    print("7. Exit")


# Function to find a team according to teamsa first letter of the name and their discipline
def find_team(cursor, conn):
    # Get discipline and letter 
    discipline_name = input("Enter the discipline name (e.g., Swimming): ")
    id_prefix = input("Enter the ID prefix for the team (e.g., T): ")

    # Query to find all the teams who compete in a specified discipline and ID start with a specified letter
    query = "SELECT * FROM Teams WHERE disciplineName = %s AND ID LIKE %s;"

    cursor.execute(query, (discipline_name, f"{id_prefix}%")) 
    results = cursor.fetchall()

    # Print the results
    print(f"\nResults for discipline '{discipline_name}' with ID prefix '{id_prefix}':")
    for row in results:
        print(row)


# Function to add a new athlete from table Athletes
def add_athlete(cursor, conn):
    # Get athletes info
    athlete_id = input("Enter the athlete's ID (7 characters): ")
    athlete_name = input("Enter the athlete's name: ")
    athlete_gender = input("Enter the athlete's gender as F or M: ")
    athlete_total_medals = input("Enter the athlete's total number of medals: ")
    athlete_country = input("Enter the athlete's country: ")

    # Insert statement and formating of data to insert
    insert_stmt = "INSERT INTO Athletes (ID, athleteName, gender, totalMedals, countryName) VALUES (%s, %s, %s, %s, %s)"
    data = (athlete_id, athlete_name, athlete_gender, athlete_total_medals, athlete_country)
    
    cursor.execute(insert_stmt, data)
    conn.commit()

    print(f"Athlete with ID {athlete_id} has been added.")


# Function to delete a medal from the Medals table
def delete_medal(cursor, conn):
    # Get medal athleteID
    athlete_id = input("Enter the athlete's ID (7 characters): ")

    # Delete statement
    delete_stmt = "DELETE FROM Medals WHERE athleteID = %s"
    
    cursor.execute(delete_stmt, (athlete_id,))
    conn.commit()

    print(f"Medal with ID {athlete_id} has been removed.")



# Function to update an athletes gender
def update_athlete_gender(cursor, conn):
    # Get athlete new gender and ID
    athlete_id = input("Enter the athlete's ID (7 characters): ")
    athlete_gender = input("Enter new gender as F or M: ")

    # Update statement and formating of data
    update_stmt = "UPDATE Athletes SET gender = %s WHERE ID = %s"
    data = (athlete_gender, athlete_id)

    cursor.execute(update_stmt, data)
    conn.commit()

    print(f"Athlete with ID {athlete_id} has been updated.")
    


# Function to display any table specified by the user
def disp_tables(cursor, conn):
    # List of valid table names
    valid_tables = ["Athletes", "Countries", "Medals", "Coach", "Teams", "Disciplines"]

    # Get table name from user
    table_name = input("Choose a table to display \n 1. Athletes\n 2. Countries \n 3. Medals \n 4. Coaches \n 5. Teams \n 6. Disciplines: ")

    # Validate the input
    while table_name not in valid_tables:
        print("Invalid input. Please choose a valid table name.")
        table_name = input("Choose a table to display \n 1. Athletes\n 2. Countries \n 3. Medals \n 4. Coach \n 5. Teams \n 6. Disciplines: ")

    query = f"SELECT * FROM {table_name}"  

    cursor.execute(query)
    results = cursor.fetchall()

    # Print the results
    print(f"\nResults for '{table_name}':")
    for row in results:
        print(row)


# Function to update coaches name and gender if applicable
def modify_coach(cursor, conn):
    # Get coach info from user
    coach_id = input("Enter the coach's ID (7 characters): ")
    new_coach_name = input("Enter the coach's new name: ")
    new_gender = input("Enter the new gender as F or M: ")

    # Call the stored procedure from mysql
    cursor.callproc('modifyCoach', (coach_id, new_coach_name, new_gender))
    
    conn.commit()
    
    print(f"Coach with ID {coach_id} has been updated.")
    


def main():
    # Get database credentials from user
    user = input("Enter your database username: ")
    password = input("Enter your database password: ")

    # Make a connection to the database
    conn = mysql.connector.connect(
        user=user,
        password=password,
        host='127.0.0.1',
        database='Olympics2024_20717432'
    )

    # Check if the connection was successful
    if conn.is_connected():
        print("Connection successful!")
    else:
        print("Connection failed.")
        return 

    # Create cursor
    cursor = conn.cursor()

    # Boolean flag to allow program to continuously run
    continueProgram = True

    print("\n\n--------------------------------------------------------------")
    print("\nOlympics 2024 Database\n")
    print("--------------------------------------------------------------\n")
    
    while continueProgram:
        display_menu()
        
        choice = input("Please select an option (1-6): ")  

        if choice == '1':
            print("You selected Option 1.")
            find_team(cursor, conn)  
        elif choice == '2':
            print("You selected Option 2.")
            add_athlete(cursor, conn)  
        elif choice == '3':
            print("You selected Option 3.")
            delete_medal(cursor, conn)  
        elif choice == '4':
            print("You selected Option 4.")
            update_athlete_gender(cursor, conn)  
        elif choice == '5':
            disp_tables(cursor, conn)  
        elif choice == '6':
            modify_coach(cursor, conn)  
        elif choice == '7':
            print("\nExiting the program. Goodbye!")
            continueProgram = False
        else:
            print("\nInvalid option, try again.")

    # Close the cursor and connection when done
    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()

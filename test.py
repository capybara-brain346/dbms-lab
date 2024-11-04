import mysql.connector


# Connect to MySQL
def connect_to_mysql():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="root123",  # replace with your MySQL password
            database="dbmslab",  # replace with your database name
        )
        if connection.is_connected():
            print("Connected to MySQL database")
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None


# Create employees table if it doesn't exist
def create_table(cursor):
    try:
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS employees (
            id INT PRIMARY KEY,
            name VARCHAR(255),
            department VARCHAR(255)
        )
        """)
        print("Table created or already exists.")
    except mysql.connector.Error as err:
        print(f"Error creating table: {err}")


# Add a new record to the employees table
def add_record(cursor, connection, emp_id, emp_name, emp_dept):
    try:
        query = "INSERT INTO employees (id, name, department) VALUES (%s, %s, %s)"
        values = (emp_id, emp_name, emp_dept)
        cursor.execute(query, values)
        connection.commit()
        print("Record added successfully!")
    except mysql.connector.Error as err:
        print(f"Error: {err}")


# Delete a record from the employees table
def delete_record(cursor, connection, employee_id):
    try:
        query = "DELETE FROM employees WHERE id = %s"
        cursor.execute(query, (employee_id,))
        connection.commit()
        print(f"Record with id {employee_id} deleted successfully!")
    except mysql.connector.Error as err:
        print(f"Error: {err}")


# Edit a record in the employees table
def edit_record(cursor, connection, employee_id, new_name):
    try:
        query = "UPDATE employees SET name = %s WHERE id = %s"
        cursor.execute(query, (new_name, employee_id))
        connection.commit()
        print(f"Record with id {employee_id} updated successfully!")
    except mysql.connector.Error as err:
        print(f"Error: {err}")


# Close the connection
def close_connection(connection):
    if connection.is_connected():
        connection.close()
        print("MySQL connection closed")


# Main function to demonstrate operations
if __name__ == "__main__":
    # Step 1: Connect to MySQL
    conn = connect_to_mysql()

    if conn:
        cursor = conn.cursor()

        # Step 2: Create employees table
        create_table(cursor)

        # Step 3: Add a record
        print("\nAdding a record:")
        add_record(cursor, conn, 1, "John Doe", "HR")

        # Step 4: Edit the record
        print("\nEditing the record:")
        edit_record(cursor, conn, 1, "Jane Doe")

        # Step 5: Delete the record
        print("\nDeleting the record:")
        delete_record(cursor, conn, 1)

        # Step 6: Close the connection
        close_connection(conn)

import psycopg2

def connect_to_db():
    try:

        connection = psycopg2.connect(
            dbname="task01",
            user="max",
            password="your_password",
            host="localhost",
            port="5432"
        )
        print("Connection successful")
        return connection
    except Exception as error:
        print(f"Error connecting to database: {error}")
        return None

from shapely.wkt import loads

def query_all_geometries(connection):
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT identifier, ST_AsText(geometry) FROM Objects;")
        rows = cursor.fetchall()
        for row in rows:
            print(f"ID: {row[0]}, Geometry (WKT): {row[1]}")
        cursor.close()
    except Exception as error:
        print(f"Error fetching geometries: {error}")

def query_geometries_within_distance(connection, x, y, distance):
    try:
        cursor = connection.cursor()
        query = """
            SELECT identifier, ST_AsText(geometry) FROM Objects
            WHERE ST_DWithin(geometry, ST_SetSRID(ST_MakePoint(%s, %s), 32637), %s);
        """
        cursor.execute(query, (x, y, distance))
        rows = cursor.fetchall()
        for row in rows:
            print(f"ID: {row[0]}, Geometry (WKT): {row[1]}")
        cursor.close()
    except Exception as error:
        print(f"Error fetching geometries: {error}")

def insert_new_geometry(connection, wkt_geometry):
    try:
        cursor = connection.cursor()
        query = """
            INSERT INTO Objects (geometry) 
            VALUES (ST_GeomFromText(%s, 32637));
        """
        cursor.execute(query, (wkt_geometry,))
        connection.commit()
        print("Geometry added successfully")
        cursor.close()
    except Exception as error:
        print(f"Error inserting geometry: {error}")

def calculate_length(connection):
    try:
        cursor = connection.cursor()
        query = """
            SELECT identifier, ST_Length(geometry) FROM Objects
            WHERE ST_GeometryType(geometry) = 'ST_LineString';
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        for row in rows:
            print(f"ID: {row[0]}, Length: {row[1]} meters")
        cursor.close()
    except Exception as error:
        print(f"Error calculating length: {error}")

def calculate_area(connection):
    try:
        cursor = connection.cursor()
        query = """
            SELECT identifier, ST_Area(geometry) FROM Objects
            WHERE ST_GeometryType(geometry) = 'ST_Polygon';
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        for row in rows:
            print(f"ID: {row[0]}, Area: {row[1]} square meters")
        cursor.close()
    except Exception as error:
        print(f"Error calculating area: {error}")


def main():
    connection = connect_to_db()
    if connection:
        while True:
            print("\nChoose an option:")
            print("1: Output all geometries in WKT")
            print("2: Output geometries within distance from a point")
            print("3: Insert new geometry")
            print("4: Calculate lengths of LineStrings")
            print("5: Calculate areas of Polygons")
            print("0: Exit")

            choice = input("Enter your choice: ")

            if choice == "1":
                query_all_geometries(connection)
            elif choice == "2":
                x = float(input("Enter X coordinate: "))
                y = float(input("Enter Y coordinate: "))
                distance = float(input("Enter distance (in meters): "))
                query_geometries_within_distance(connection, x, y, distance)
            elif choice == "3":
                wkt_geometry = input("Enter WKT geometry: ")
                insert_new_geometry(connection, wkt_geometry)
            elif choice == "4":
                calculate_length(connection)
            elif choice == "5":
                calculate_area(connection)
            elif choice == "0":
                break
            else:
                print("Invalid choice, please try again.")

        connection.close()

if __name__ == "__main__":
    main()

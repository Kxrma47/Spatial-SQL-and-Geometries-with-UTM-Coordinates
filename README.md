
# Spatial SQL and Geometries with UTM Coordinates

## Overview

This repository contains the solution for working with **spatial data** using **PostGIS** and the **Well-Known Text (WKT)** format. The project includes creating geometries in UTM coordinates, performing spatial queries, and inserting data into a **PostgreSQL** database with the **PostGIS** extension. The project is divided into three parts:

1. **Geometry Exercise**: Creating geometries in UTM 37N using WKT.
2. **Spatial SQL**: Setting up a database and managing geometries with PostGIS.
3. **Accessing PostGIS**: Using Python to interact with the PostGIS database, query geometries, and calculate spatial properties like lengths and areas.

---

## Table of Contents

- [Requirements](#requirements)
- [Project Structure](#project-structure)
- [Setting Up PostGIS Database](#setting-up-postgis-database)
- [Python Scripts](#python-scripts)
- [SQL Queries](#sql-queries)
- [Sample Outputs](#sample-outputs)
- [License](#license)

---

## Requirements

- **PostgreSQL** with **PostGIS extension** enabled.
- **Python 3.x** and the following Python libraries:
  - `psycopg2` (for connecting Python to PostgreSQL)
  - `shapely` (for handling geometries)

Install the necessary Python libraries using:

```bash
pip install psycopg2-binary shapely
```

---

## Project Structure

```text
.
├── README.md               # This readme file
├── task_01.sql             # SQL file for creating and inserting data into the PostGIS table
├── task_01.py              # Python script for accessing and querying PostGIS
└── geometries.png          # Image illustrating geometries and their WKT representations
```

### Files:

1. **`task_01.sql`**:
   - SQL file that creates a table in PostGIS and inserts geometries (points, multipoints, polygons, etc.) in UTM 37N.

2. **`task_01.py`**:
   - Python script to interact with the PostGIS database, query and insert geometries, and calculate spatial properties like lengths and areas.

3. **`geometries.png`**:
   - An illustration of the geometries used in this project, displayed with their UTM coordinates.

---

## Setting Up PostGIS Database

1. **Create Database and Enable PostGIS**:

   Open PostgreSQL and execute the following to create a database and enable the PostGIS extension:

   ```sql
   CREATE DATABASE task01;
   \c task01;  -- Connect to the task01 database
   CREATE EXTENSION postgis;
   ```

2. **Run the SQL Script**:

   Execute the provided SQL file `task_01.sql` to create the table and insert geometries:

   ```bash
   psql -d task01 -f task_01.sql
   ```

---

## Python Scripts

### Running the Python Script

1. **Connect to the Database**:
   
   The `task_01.py` script connects to the PostgreSQL database using **psycopg2** and allows you to query geometries, insert new data, and calculate spatial properties.

2. **Run the Script**:

   ```bash
   python3 task_01.py
   ```

3. **Functions in the Script**:

   - **`query_all_geometries()`**: Outputs all geometries in WKT format from the `Objects` table.
   - **`query_geometries_within_distance(x, y, distance)`**: Retrieves all geometries within a specified distance of a point (x, y).
   - **`insert_new_geometry(wkt_geometry)`**: Inserts a new geometry into the table.
   - **`calculate_length()`**: Calculates the lengths of all LineStrings in the table.
   - **`calculate_area()`**: Calculates the areas of all Polygons in the table.

4. **Sample Output**:

   ```
   Connection successful

   Choose an option:
   1: Output all geometries in WKT
   2: Output geometries within distance from a point
   3: Insert new geometry
   4: Calculate lengths of LineStrings
   5: Calculate areas of Polygons
   0: Exit
   ```

---

## SQL Queries

1. **Creating the PostGIS Table**:

   ```sql
   CREATE TABLE Objects (
       identifier SERIAL PRIMARY KEY,
       geometry GEOMETRY(Geometry, 32637),
       name VARCHAR(255)
   );
   ```

2. **Inserting Geometries**:

   Examples of inserting geometries in WKT format:

   ```sql
   INSERT INTO Objects (geometry, name)
   VALUES (ST_GeomFromText('POINT(100 200)', 32637), 'Statue');

   INSERT INTO Objects (geometry, name)
   VALUES (ST_GeomFromText('POLYGON((100 100, 200 100, 200 200, 100 200, 100 100))', 32637), 'Building');
   ```

3. **Spatial Queries**:

   Query all geometries within a specific distance from a point:

   ```sql
   SELECT identifier, ST_AsText(geometry)
   FROM Objects
   WHERE ST_DWithin(geometry, ST_SetSRID(ST_MakePoint(100, 200), 32637), 100);
   ```

4. **Calculate Length and Area**:

   - To calculate the length of all LineStrings:

     ```sql
     SELECT identifier, ST_Length(geometry)
     FROM Objects
     WHERE ST_GeometryType(geometry) = 'ST_LineString';
     ```

   - To calculate the area of all Polygons:

     ```sql
     SELECT identifier, ST_Area(geometry)
     FROM Objects
     WHERE ST_GeometryType(geometry) = 'ST_Polygon';
     ```

---

## Sample Outputs

### Example Geometry Table

| Identifier | Geometry (WKT)                                                   | Name                   |
|------------|-------------------------------------------------------------------|------------------------|
| 1          | POINT(100 200)                                                    | Statue                 |
| 2          | MULTIPOINT((500 600), (510 610), (520 620))                       | Group of Trees         |
| 3          | POLYGON((100 100, 200 100, 200 200, 100 200, 100 100))            | Building with Courtyard|

### Geometry Visualization

<img width="452" alt="image" src="https://github.com/user-attachments/assets/564604ec-3718-4f74-9036-4b6440f6bdbb">

<img width="452" alt="image" src="https://github.com/user-attachments/assets/67ac8741-338b-44a2-95e5-04dc625cd05e">

NOTE: This is a real life scenario

<img width="315" alt="image" src="https://github.com/user-attachments/assets/6f7715f6-7418-419d-8d7e-3c98ffefdf69">

<img width="452" alt="image" src="https://github.com/user-attachments/assets/6856f359-2ab9-41ca-bcae-a3f794b07389">

NOTE: More simple approach




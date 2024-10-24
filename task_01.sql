-- enable the PostGIS extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS postgis;

--  the table 'Objects' with UTM 37N geometries
CREATE TABLE Objects (
    identifier SERIAL PRIMARY KEY,
    geometry GEOMETRY(Geometry, 32637),  -- UTM 37N (EPSG:32637)
    name VARCHAR(255)
);

--  Points
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('POINT(100 200)', 32637), 'Statue');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('POINT(150 250)', 32637), 'Tree');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('POINT(300 400)', 32637), 'Bench');

--  Multipoints
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('MULTIPOINT((500 600), (510 610), (520 620))', 32637), 'Group of Trees');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('MULTIPOINT((200 100), (210 110), (220 120))', 32637), 'Statues');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('MULTIPOINT((400 200), (410 210), (420 220))', 32637), 'Benches');

--  Polygons with holes (buildings with courtyards)
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('POLYGON((100 100, 200 100, 200 200, 100 200, 100 100), (120 120, 180 120, 180 180, 120 180, 120 120))', 32637), 'Building with Courtyard 1');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('POLYGON((300 100, 400 100, 400 200, 300 200, 300 100), (320 120, 380 120, 380 180, 320 180, 320 120))', 32637), 'Building with Courtyard 2');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('POLYGON((500 100, 600 100, 600 200, 500 200, 500 100), (520 120, 580 120, 580 180, 520 180, 520 120))', 32637), 'Building with Courtyard 3');

--  Multipolygons (parks or fields)
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('MULTIPOLYGON(((700 700, 750 700, 750 750, 700 750, 700 700)), ((760 700, 800 700, 800 750, 760 750, 760 700)))', 32637), 'Park 1');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('MULTIPOLYGON(((200 300, 250 300, 250 350, 200 350, 200 300)), ((260 300, 300 300, 300 350, 260 350, 260 300)))', 32637), 'Park 2');

--  Linestrings (paths)
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('LINESTRING(0 0, 50 50, 100 0)', 32637), 'Path 1');

INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('LINESTRING(200 200, 250 250, 300 200)', 32637), 'Path 2');

--  Multilinestring (complex path)
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('MULTILINESTRING((400 400, 450 450), (500 500, 550 550), (600 600, 650 650))', 32637), 'Complex Walking Path');

--  Geometry Collection (containing multiple types)
INSERT INTO Objects (geometry, name)
VALUES (ST_GeomFromText('GEOMETRYCOLLECTION(POINT(100 200), POLYGON((100 100, 200 100, 200 200, 100 200, 100 100), (120 120, 180 120, 180 180, 120 180, 120 120)), LINESTRING(0 0, 50 50, 100 0))', 32637), 'Mixed Collection');

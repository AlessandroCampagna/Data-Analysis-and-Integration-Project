-- Create schema for the data warehouse

DROP DATABASE IF EXISTS EnergyDataWarehouse;

CREATE DATABASE  EnergyDataWarehouse;

USE EnergyDataWarehouse;

-- Dimension tables

CREATE TABLE dim_time (
    time_id INT PRIMARY KEY AUTO_INCREMENT,
    year INT NOT NULL,
    season ENUM('Spring', 'Summer', 'Autumn', 'Winter') NOT NULL,
    month INT NOT NULL,
    UNIQUE KEY (year, month)
);

CREATE TABLE dim_location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    district VARCHAR(255) NOT NULL,
    municipality VARCHAR(255) NOT NULL,
    parish VARCHAR(255),
    municipalityparishcode INT,
    UNIQUE KEY (district, municipality, parish, municipalityparishcode)
);

-- Fact tables

CREATE TABLE fact_energy_consumption (
    time_id INT ,
    location_id INT ,
    energy_consumption DECIMAL(15, 3) NOT NULL,
    count_smart INT NOT NULL,
    count_non_smart INT NOT NULL,
    FOREIGN KEY (time_id) REFERENCES dim_time(time_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
    PRIMARY KEY (time_id, location_id)
);


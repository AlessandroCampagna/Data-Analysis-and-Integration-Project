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
    region VARCHAR(255) NOT NULL,
    municipality VARCHAR(255) NOT NULL,
    parish VARCHAR(255),
    UNIQUE KEY (region, municipality, parish)
);

-- Fact tables

CREATE TABLE fact_energy_consumption (
    fact_id INT PRIMARY KEY AUTO_INCREMENT,
    time_id INT NOT NULL,
    location_id INT NOT NULL,
    energy_consumption DECIMAL(15, 2) NOT NULL,
    percentage_smart_meters DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (time_id) REFERENCES dim_time(time_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id)
);


Hotel Reservation System Project 

## Overview

This project involves the analysis of a hotel reservation system dataset using MySQL for data storage, Apache Spark for analytics, and Power BI for visualization. The dataset includes information about hotel bookings, customer details, and booking-related parameters.

## Project Structure

The project can be divided into the following sections:

### MySQL Database Creation and Data Loading

1. **Database Schema:**
    - `Hotel_Reservations`: Contains detailed information about hotel reservations.
    - `Customer_Details`: Stores customer-related details extracted from hotel reservations.
    - `Booking_Details`: Focuses on booking-specific details, excluding customer-specific                    			information.

2. **Data Loading:**
    - Data from the CSV file (`Hotel_Reservations.csv`) is loaded into the MySQL tables using `LOAD DATA INFILE` statements.

3. **Data Normalization:**
    - The dataset is normalized into two tables, `Customer_Details` and `Booking_Details`, to organize information efficiently.

### Apache Spark Integration

4. **Apache Spark Setup:**
    - Ensure Apache Spark is installed. If not, download and configure Spark.
    - Use Spark JDBC connectors to connect to MySQL.


// Spark Session setup
	val spark = SparkSession.builder().master("local[*]").appName("HotelReservationAnalysis").getOrCreate()

// Read data from MySQL tables
val customerDetailsDF = spark.read.format("jdbc")
  .option("url", "jdbc:mysql://localhost/your mysql database")
  .option("driver", "com.mysql.cj.jdbc.Driver")
  .option("dbtable", "Customer_Details")
  .option("user", "your mysql username")
  .option("password", "your mysql password")
  .load()

val bookingDetailsDF = spark.read.format("jdbc")
  .option("url", "jdbc:mysql://localhost/your mysql databse")
  .option("driver", "com.mysql.cj.jdbc.Driver")
  .option("dbtable", "Booking_Details")
  .option("user", "your mysql username")
  .option("password", "your mysql password")
  .load()
```

### Data Analysis in Apache Spark

5. **Data Analysis Code:**
    - Use Spark for data analysis. Here's an example:

```scala
// Spark data analysis example
val avgPricePerRoomType = bookingDetailsDF.groupBy("room_type_reserved").agg(avg("avg_price_per_room").as("avg_price"))
avgPricePerRoomType.show()
```

### Visualization in Power BI

6. **Power BI Integration:**
    - Connect Power BI to MySQL using MySQL Net Connector.

7. **Visual Analysis:**
    - Import data from MySQL tables into Power BI for creating interactive visualizations.

## Running the Project

To reproduce the analysis and visualizations, follow these steps:

1. Execute MySQL scripts to create tables and load data.
2. Set up Apache Spark and execute Spark scripts for data analysis.
3. Connect Power BI to MySQL using MySQL Net Connector.
4. Import data from MySQL tables into Power BI for visualization.

## Conclusion

The project provides a holistic approach to hotel reservation system analysis, combining the power of MySQL for data storage, Apache Spark for advanced analytics, and Power BI for intuitive visualizations. The insights obtained contribute to informed decision-making,enabling effective management of hotel operations and enhancing the overall guest experience.

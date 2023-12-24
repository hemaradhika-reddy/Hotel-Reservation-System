#### APACHE SPARK ANALYSIS ###

1) DAY OF THE WEEK WITH MOST BOOKINGS:

import org.apache.spark.sql.functions._
import java.sql.Timestamp
val bookingWithDayOfWeek = Booking_Details.withColumn("arrival_date_full", to_date(concat_ws("-", $"arrival_year", $"arrival_month", 	$"arrival_date"))).withColumn("arrival_day_of_week", date_format($"arrival_date_full", "EEEE"))
val mostBookingsDayOfWeek =   bookingWithDayOfWeek.groupBy("arrival_day_of_week").count().sort(desc("count")).limit(1)
mostBookingsDayOfWeek.show()

2) THE LENGTH OF STAY FOR EACH BOOKING:

import org.apache.spark.sql.functions.{datediff, to_date, expr, col}
val totalNights = col("no_of_weekend_nights") + col("no_of_week_nights")
val arrivalDate = to_date(expr("concat(arrival_year, '-', lpad(arrival_month, 2, '0'), '-', lpad(arrival_date, 2, '0'))"), "yyyy-MM-dd")
val departureDate = expr("date_add(arrivalDate, totalNights)")
	bookingDetails.withColumn("arrivalDate", arrivalDate).withColumn("totalNights", totalNights).withColumn("departureDate", departureDate).select($"Booking_ID", 	datediff($"departureDate", $"arrivalDate").as("length_of_stay")).show()

3) CANCELLATION ANALYSIS:

val totalBookings = Customer_Details.count()
val totalCancellations = Customer_Details.filter($"booking_status" === "Canceled\r").count()
val cancellationPercentage = (totalCancellations.toDouble / totalBookings.toDouble) * 100
val statusCountsDF = Customer_Details.groupBy("booking_status").agg(count("Booking_ID").alias("count"))
statusCountsDF.show()

4) AVG LEAD TIME FOR EACH MONTH TO MONTH

import org.apache.spark.sql.expressions.Window
val windowSpec = Window.partitionBy("arrival_month").orderBy("arrival_year")
val avgLeadTime = avg("lead_time").over(windowSpec)
val bookingsWithAvgLeadTime = Booking_Details.withColumn("avg_lead_time", avgLeadTime)
val result = bookingsWithAvgLeadTime.select("arrival_year", "arrival_month", "avg_lead_time").distinct()
result.show()

5) ROOM UTILIZATION 

val roomUtilizationRate = Booking_Details.groupBy("room_type_reserved").agg((count("Booking_ID") / countDistinct("arrival_date")).alias("utilization_rate"))
roomUtilizationRate.show()

6) DISTINCT MEAL PLANS

val distinctMealPlans = Booking_Details.select("type_of_meal_plan").distinct()
val bookingsCountByMealPlan = Booking_Details.groupBy("type_of_meal_plan").agg(count("Booking_ID").alias("total_bookings"))
bookingsCountByMealPlan.show()

7) HIGH VALUE CUSTOMERS

val highValueCustomers = Customer_Details.filter("no_of_previous_cancellations = 0“ AND repeated_guest = 1”)
val highValueBookings = highValueCustomers.join(Booking_Details, "Booking_ID")
val avgRoomPriceByType = highValueBookings.groupBy("room_type_reserved").agg(avg("avg_price_per_room").cast("double").alias("avg_price_per_room_type"))
avgRoomPriceByType.show()

8) PRICE CHANGE ANALYSIS

val joinedDF = Customer_Details.join(Booking_Details, "Booking_ID")
val windowSpec = Window.partitionBy("arrival_year", "arrival_month", "arrival_date").orderBy("arrival_date")
val priceChangeDF = joinedDF.withColumn("lag_price", lag("avg_price_per_room",1). over (windowSpec).withColumn("price_change", $"avg_price_per_room" - $"lag_price")
priceChangeDF.select("Booking_ID", "arrival_year", "arrival_month", "arrival_date", "avg_price_per_room", "price_change").show()

9) PERCENTAGE OF BOOKINGS WITH CAR PARKING SPACE BY MARKET SEGMENT

val parkingPercentageBySegment = 	Booking_Details.groupBy("market_segment_type").agg(sum(when($"required_car_parking_space" === 	1)).cast("double").alias("parking_count"),count("*").alias("total_bookings")).withColumn("parking_percenta	ge", ($"parking_count" / $"total_bookings") * 	100).select("market_segment_type", "parking_percentage")
parkingPercentageBySegment.show()

10) PERCENTAGE WITH SPECIAL REQUESTS

val specialRequestsPercentage = Booking_Details.withColumn("has_special_request", when(col("no_of_special_requests") > 0, 1).otherwise(0))
val percentageWithSpecialRequests = specialRequestsPercentage.agg((sum("has_special_request") / count("*") * 100).alias("percentage_with_special_requests"))
percentageWithSpecialRequests.show()

11) REPEATED GUESTS BY ROOM TYPE

val joined = Customer_Details.join(Booking_Details, "Booking_ID")
val totalRepeatedGuestsByRoomType = joined.filter($"repeated_guest" === 1).groupBy("room_type_reserved").agg(count("Booking_ID").alias("total_repeated_guests"))







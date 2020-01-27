from pyspark.sql import SparkSession
from pyspark.sql import functions as sf
from pyspark.sql.types import *

spark = SparkSession \
    .builder \
    .appName("Spark Individual SQL") \
    .getOrCreate()

# DataFrame creation from JSON file
df_purchases = spark.read.json("data/purchases.json")
df_stock = spark.read.csv("data/stock.csv", header=True,sep=",")

# Register each dataset as tables
df_purchases.createOrReplaceTempView("purchases")

df_stock.createOrReplaceTempView("stock")

# Qtn 1 - Top 10 most purchased products
Topten = spark.sql("SELECT product_id, COUNT(*) as Total FROM purchases "
                   "GROUP BY product_id ORDER BY Total DESC LIMIT 10")
Topten.show()

#Qtn 2 - Purchase percentage of each product type
Itempurchaseperc = spark.sql("SELECT item_type, ROUND(COUNT(*) * 100 / (select count(*) from purchases), 2) as Percentage "
                             "FROM purchases GROUP BY item_type")

Itempurchaseperc.show()

#Qtn 3 - Shop that has sold the most products
Topshop = spark.sql("SELECT shop_id, COUNT(*) as Total FROM purchases"
                    " GROUP BY shop_id ORDER BY Total DESC LIMIT 1")

#Topshop.show()

#Qtn 4 - Shop that has billed more money
Topbilling = spark.sql("SELECT shop_id, round(sum(price), 2) as Total_billed FROM purchases "
                       "GROUP BY shop_id ORDER BY Total_billed DESC LIMIT 1")

Topbilling.show()

# Qtn 5 - Divide world into 5 geographical areas based on longitude by adding a column
#Using udf functions to transfrom location into a string and extract it and place it into a new column

def loc(x):
    return x[1:-1]

loc_tran = sf.udf(loc, StringType())

df_purchases = df_purchases.withColumn("location", df_purchases.location.cast('string'))

df_purchases = df_purchases.withColumn("location", loc_tran(df_purchases["location"]))


def lat_ext(x):
    return x.split(",")[0]

def lon_ext(y):
    return y.split(",")[1]


lat_tran = sf.udf(lat_ext, StringType())

lon_ext = sf.udf(lon_ext, StringType())

df_purchases = df_purchases.withColumn("lat", lat_tran(df_purchases["location"]))

df_purchases = df_purchases.withColumn("lon", lon_ext(df_purchases["location"]))


# Transforming longitude into a float
df_purchases = df_purchases.withColumn("lon",df_purchases.lon.cast('float'))

# Dividing areas
df_purchases = df_purchases.withColumn("Area",sf.when((df_purchases.lon >= -180) & (df_purchases.lon < -108), 1)\
                           .when((df_purchases.lon > -108) & (df_purchases.lon < -36), 2)\
                           .when((df_purchases.lon > -36) & (df_purchases.lon < 36), 3)\
                           .when((df_purchases.lon > 36) & (df_purchases.lon < 108), 4).otherwise(5))

#Creating a new table
df_purchases.registerTempTable("area_table")


# Qtn 5A - In which area is Paypal used the most
Paypal_area = spark.sql("SELECT area,COUNT(*) AS Paypal_purchases FROM (SELECT * FROM area_table WHERE payment_type == 'paypal')"
                        "GROUP BY area, payment_type ORDER BY Paypal_purchases DESC LIMIT 1 ")
Paypal_area.show()

# Qtn 5B - Top 3 most purchased products in each area

# Area-wise grouping

area_purchases = spark.sql("SELECT area,product_id, COUNT(*) AS No_of_Purchases FROM area_table "
                           "GROUP BY area,product_id ORDER BY No_of_Purchases DESC")

# Creating a Area-wise table to query from
area_purchases.registerTempTable("area_purchase")


# Top 3 products sold in Area 1

Area_1 = spark.sql("SELECT area, product_id, No_of_Purchases FROM area_purchase WHERE area == 1 ORDER BY No_of_Purchases DESC LIMIT 3")
Area_1.show()

# Top 3 products sold in Area 2

Area_2 = spark.sql("SELECT area, product_id, No_of_Purchases FROM area_purchase WHERE area == 2 ORDER BY No_of_Purchases DESC LIMIT 3")
Area_2.show()

# Top 3 products sold in Area 3

Area_3 = spark.sql("SELECT area, product_id, No_of_Purchases FROM area_purchase WHERE area == 3 ORDER BY No_of_Purchases DESC LIMIT 3")
Area_3.show()

# Top 3 products sold in Area 4

Area_4 = spark.sql("SELECT area, product_id, No_of_Purchases FROM area_purchase WHERE area == 4 ORDER BY No_of_Purchases DESC LIMIT 3")
Area_4.show()

# Top 3 products sold in Area 5

Area_5 = spark.sql("SELECT area, product_id, No_of_Purchases FROM area_purchase WHERE area == 5 ORDER BY No_of_Purchases DESC LIMIT 3")
Area_5.show()

# Qtn 5C - Area that billed the least money

Area_least = spark.sql("SELECT area, SUM(price) AS Total_billed FROM area_purchase GROUP BY area ORDER BY Total_billed LIMIT 1")
Area_least.show()


# Qtn 6 - Products that do not have enough stock for purchases made
prodpurchases = spark.sql("SELECT product_id, COUNT(*) as total_pur FROM purchases "
                          "GROUP BY product_id")

prodpurchases.createOrReplaceTempView("total_prod_pur")

nostock = spark.sql("SELECT a.product_id, a.total_pur, b.quantity FROM total_prod_pur a "
                    "INNER JOIN stock b ON a.product_id = b.product_id "
                    "WHERE a.total_pur > b.quantity")

nostock.show()
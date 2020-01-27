from pyspark.sql import SparkSession
from pyspark.sql import functions as sf
from pyspark.sql.window import Window
from pyspark.sql.types import *


spark = SparkSession \
    .builder \
    .appName("Spark Individual Dataframe") \
    .getOrCreate()

# DataFrame creation from JSON file
df_purchases = spark.read.json("data/purchases.json")
df_stock = spark.read.csv("data/stock.csv", header=True,sep=",")


# Qtn 1 - Top 10 most purchased products
df_purchases.groupBy(df_purchases.product_id).count()\
             .sort('count', ascending = False)\
             .limit(10).show()

# Qtn 2 - Purchase percentage of each product type
df_purchases.groupBy(df_purchases.item_type).count()\
             .withColumn('percent', sf.col('count')/sf.sum('count')\
             .over(Window.partitionBy())).show()

# Qtn 3 - Shop that has sold the most products
df_purchases.groupBy(df_purchases.shop_id).count()\
             .sort('count', ascending=False)\
             .limit(1).show()

#Qtn 4 - Shop that has billed more money
df_purchases.groupBy(df_purchases.shop_id).agg(sf.round(sf.sum(df_purchases.price), 2)\
            .alias("Total_billed")).orderBy("Total_billed", ascending=False)\
            .limit(1).show()


# Qtn 5 - Split into 5 geographical areas

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

#df_purchases.show()

# Qtn 5A - In which area is Paypal used the most
df_purchases.where(df_purchases.payment_type=="paypal").groupBy(["Area","payment_type"])\
            .agg(sf.count(df_purchases.product_id).alias("Paypal payments"))\
            .orderBy("Paypal payments",ascending=False).limit(1).show()

# Qtn 5B - Top 3 most purchased products in each area

# Creating an grouping of each product per area
Area_df = df_purchases.groupBy(["Area","product_id"]).agg(sf.count(df_purchases.product_id).alias("No of Purchases"))

# Top 3 products sold in Area 1
Area_df.filter(Area_df["Area"]==1).orderBy("No of Purchases",ascending=False).limit(3).show()

# Top 3 products sold in Area 2
Area_df.filter(Area_df["Area"]==2).orderBy("No of Purchases",ascending=False).limit(3).show()

# Top 3 products sold in Area 2
Area_df.filter(Area_df["Area"]==3).orderBy("No of Purchases",ascending=False).limit(3).show()

# Top 3 products sold in Area 4
Area_df.filter(Area_df["Area"]==4).orderBy("No of Purchases",ascending=False).limit(3).show()

# Top 3 products sold in Area 5
Area_df.filter(Area_df["Area"]==5).orderBy("No of Purchases",ascending=False).limit(3).show()


# Qtn 5C - Area that billed the least money
df_purchases.groupBy(["Area"]).agg(sf.sum("price").alias("Billed Amount"))\
            .orderBy("Billed Amount",ascending=True).limit(1).show()


# Qtn 6 - Products that do not have enough stock for purchases made
df_prodpurchases = df_purchases.groupBy(df_purchases.product_id).count()\
                            .withColumnRenamed("count", "total_pur")

df_join = df_prodpurchases.join(df_stock, df_prodpurchases.product_id == df_stock.product_id)

df_join.where(df_join.total_pur > df_join.quantity).show()


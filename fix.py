df = df.withColumn('timestamp_nano', col('timestamp').cast(StringType()))\
    .drop(col('timestamp'))\
    .withColumn('timestamp_mili', col("timestamp_nano")[0:10])\
    .withColumn('timestamp_int', col("timestamp_mili").cast(IntegerType()))\
    .withColumn('timestamp_real', col("timestamp_int").cast(TimestampType()))\
  
    
df_final = df.select(col("timestamp_nano"), col("id"), col("side"), col("price"), col("amount"), col("timestamp_utc" ))

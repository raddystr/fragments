import time
import datetime
  
  
string = "20-01-2020"
string2 = "10-02-2020"
start_time = int(time.mktime(datetime.datetime.strptime(string,"%d-%m-%Y").timetuple()))
end_time = int(time.mktime(datetime.datetime.strptime(string2,"%d-%m-%Y").timetuple()))

if ((end_time - start_time)/3600)/24 > 29: # convert to days and check if the period is too long 
    print("The period between end and start time must be less than 30 days")
else:
    print("I will return a response")

def gas_stations(distance, tank_size, stations):
    stations_list = []
    current_distance = tank_size
    stations.append(distance)

    for i in range(len(stations)):
        if stations[i] > current_distance:
            stations_list.append(stations[i - 1])
            current_distance = tank_size + stations[i - 1]
    return stations_list


print(gas_stations(
320, 
90, [
50, 
80, 
140, 
180, 
220, 
290]))
            


   

   

   

   

def gas_stations(distance, tank_size, stations):
   
    stations_list = []
    full_tank = tank_size
    to_burgas = stations[1:]
    to_burgas.append(distance)

    for i in range(len(stations)):
        #if i == 0:
            if abs(full_tank - stations[i]) < to_burgas[i] - stations[i]:
                stations_list.append(stations[i])
                full_tank = tank_size   
            else:
                full_tank -= to_burgas[i] - stations[i]
        #else:
        #    if stations[i] - full_tank < to_burgas[i] - stations[i]:
        #        stations_list.append(stations[
        # i])
        #        full_tank = tank_size
        #    else:
        #        distance_liters = to_burgas[i] - stations[i]
        #        full_tank -= distance_liters
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




print(gas_stations(
390, 
80, [
70, 
90, 
140, 
210, 
240, 
280, 
350]))
            


   

   

   

   

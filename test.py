def max_elven_food_calculator(list_foods: str):def max_elven_food_calculator(list_foods: str):
    list_calories = list_foods.split("\n")
    sums_calories = []
    sumed = 0
    for sc in list_calories:
        if sc:
            sumed += int(sc)
        else:
            sums_calories.append(sumed)
            sumed = 0
            
    
    return(sums_calories)
 
    list_calories = list_foods.split("\n")
    sums_calories = []
    sumed = 0
    for sc in list_calories:
        if sc:
            sumed += int(sc)
        else:
            sums_calories.append(sumed)
            sumed = 0
            
    
    return(sums_calories)
 

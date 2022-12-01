#AoC day1
def max_elven_food_calculator(list_foods: str) -> int:
    list_calories_per_elf, sums_calories_per_elf, sum_per_elf = list_foods.split("\n"), [], 0
    
    for sc in list_calories_per_elf:
        if sc:
            sum_per_elf += int(sc)
            continue
        sums_calories_per_elf.append(sum_per_elf)
        sum_per_elf = 0
        
    return max(sums_calories_per_elf)
 

def max_elven_food_calculator(list_foods: str) -> tuple:
    list_calories_per_elf, sums_calories_per_elf, sum_per_elf = list_foods.split("\n"), [], 0
    for sc in list_calories_per_elf:
        if sc:
            sum_per_elf += int(sc)
            continue
        sums_calories_per_elf.append(sum_per_elf)
        sum_per_elf = 0
        sums_calories_per_elf.sort()
    return (sums_calories_per_elf[-1], sum(sums_calories_per_elf[-3:]))  

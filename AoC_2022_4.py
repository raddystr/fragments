def cleaning_optimization(cleaning_area: str, ver: int) -> int:
    cleaning_list = cleaning_area.split("\n")
    redundant = 0
    for area in cleaning_list:
        sub_area_1, sub_area_2 = area.split(',')[0].split('-'), area.split(',')[1].split('-')
        sub_area_1, sub_area_2 = tuple(map(int, sub_area_1)), tuple(map(int, sub_area_2))
        if ver == 1: 
            if (sub_area_1[0] <= sub_area_2[0] and sub_area_1[1] >= sub_area_2[1]) or\
            (sub_area_1[0] >= sub_area_2[0] and sub_area_1[1] <= sub_area_2[1]):    
                redundant += 1
        elif ver == 2:
            if sub_area_1[1] > sub_area_2[1] and sub_area_1[0] > sub_area_2[1]:
                    continue
            elif sub_area_1[1] < sub_area_2[1] and sub_area_1[1] < sub_area_2[0]:
                    continue
            redundant += 1 
    return redundant

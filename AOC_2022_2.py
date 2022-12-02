def strategies_counter(games_list,strategie, stategie_type) -> int:
    result = 0
    for game in games_list:
        result += strategie[game][stategie_type]
    return result


def main_results(games_palyed: str) -> tuple:
    games_list = games_palyed.strip().split("\n")
    rock, paper, scissors, = 1, 2, 3    
    win, draw, loss = 6, 3, 0

    strategie = {
        "A X": (rock + draw, scissors + loss),
        "A Y": (paper + win, rock + draw),
        "A Z": (scissors + loss, paper + win),
        "B X": (rock + loss, rock + loss),
        "B Y": (paper + draw, paper + draw),
        "B Z": (scissors + win, scissors + win),
        "C X": (rock + win, paper + loss), 
        "C Y": (paper + loss, scissors + draw),
        "C Z": (scissors + draw, rock + win)
    }

    # strategie type: 0 for condition 1; 1 for condition 2
    return (strategies_counter(games_list, strategie, 0), strategies_counter(games_list, strategie, 1))  

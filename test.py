def games_counter(games_palyed: str) -> int:
    games_list = games_palyed.split("\n")
    rock, scissors, paper = 1, 2, 3    
    win, draw, lose = 6, 3, 0
    player_1 = {"A": "rock",
                "B": "paper",
                "C": "scissors"}
    player_2 = {"X": "rock",
                "Y": "paper",
                "Z": "scissors"}
    result = 0
    for game in games_list:
      #  print(player_2[game[2]])
        if player_1[game[0]] == "rock" and player_2[game[2]] == "rock":
            result += (rock + draw)
            continue
        elif player_1[game[0]] == "rock" and player_2[game[2]] == "paper":
            result += (rock + lose)
            continue
        elif player_1[game[0]] == "rock" and player_2[game[2]] == "scissors":
            result += (rock + win)
            continue      
        elif player_1[game[0]] == "paper" and player_2[game[2]] == "rock":
            result += (paper + win)
            continue
        elif player_1[game[0]] == "paper" and player_2[game[2]] == "paper":
            result += (paper + draw)
            continue
        elif player_1[game[0]] == "paper" and player_2[game[2]] == "scissors":
            result += (paper + lose)
            continue
        elif player_1[game[0]] == "scissors" and player_2[game[2]] == "rock":
            result += (scissors + lose)
            continue
        elif player_1[game[0]] == "scissors" and player_2[game[2]] == "paper":
            result += (scissors + win)
            continue
        elif player_1[game[0]] == "scissors" and player_2[game[2]] == "scissors":
            result += (scissors + draw)
            continue
    print(result)

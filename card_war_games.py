from random import shuffle


SUITE = 'H D S C'.split()
RANKS = '2 3 4 5 6 7 8 9 10 J Q K A'.split()


class Deck():
    
    def __init__(self):
        self.all_cards = [(s,r) for s in SUITE for r in RANKS]
    
    def shuffle(self):
        shuffle(self.all_cards)

    def split_in_half(self):
        return(self.all_cards[:26], self.all_cards[26:])

    
class Hand:
    
    def __init__(self,cards):
        self.cards = cards;

    def __str__(self,cards):
        return("Contains {} cards".format(len(self.cards)))

    def add(self, added_cards):
        self.cards.extend(added_cards)
    
    def remove_card(self):
        return self.cards.pop()

    
class Player:
    
    def __init__(self, name, hand):
        self.name = name 
        self.hand = hand
    
    def play_card(self):
        drawn_card = self.hand.remove_card()
        print("{} has placed: {}".format(self.name, drawn_card))
        print("\n")
        return drawn_card
    
    def remove_war_cards(self):
        war_cards = []
        if len(self.hand.cards) < 3:
            return self.hand.cards
        else:
            for x in range(3):
                war_cards.append(self.hand.cards.pop())
            return war_cards
        
    def still_has_cards(self):
        return len(self.hand.cards) != 0


my_deck = Deck()
my_deck.shuffle()
half1, half2 = my_deck.split_in_half()

comp = Player("computer", Hand(half1))

name = input("What is your name?")

human = Player(name, Hand(half2))


total_rounds = 0
war_count = 0

while human.still_has_cards() and comp.still_has_cards():
    total_rounds +=1

    print(human.name + " hash the count " + str(len(human.hand.cards)))
    
    print(comp.name + " hash the count " + str(len(comp.hand.cards)))
    
    table_card = []

    c_card = comp.play_card()
    
    h_card = human.play_card()

    table_card.append(c_card)

    table_card.append(h_card)

    if c_card[1] == h_card[1]:
        war_count += 1
        print("WAR!!!")
        table_card.extend(human.remove_war_cards())
        table_card.extend(comp.remove_war_cards())
        
        if RANKS.index(c_card[1])<RANKS.index(h_card[1]):
            human.hand.add(table_card)
        else:
            comp.hand.add(table_card)

    else:
        if RANKS.index(c_card[1])<RANKS.index(h_card[1]):
            human.hand.add(table_card)
        else:
            comp.hand.add(table_card)

print("game over, number of rounds:" + str(total_rounds))

print("War happens" + str(war_count) + "times")

print("Computer card:", str(comp.still_has_cards()))

print("Human card:", str(human.still_has_cards()))

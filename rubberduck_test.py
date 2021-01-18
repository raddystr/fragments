def is_anagram(word1, word2):
    arr_w1 = []
    arr_w2 = []

# First let's check if the strings length is equal if it's not we don't need to proceed...
    if len(word1) != len(word1):
        return False

# Second, I think the easiest way is to turn strings to arrays then just lowercase(to avoid case differences) 
# and sort them
    for letter in range(len(word1)):
        arr_w1.append(word1[letter].lower())
        arr_w2.append(word2[letter].lower())

    arr_w1.sort()
    arr_w2.sort()
    
# Then just do the comparing 
    if arr_w1 == arr_w2:
        return(True)
    else:
        return(False)

print(is_anagram('hello', 'hlleo')) #True
print(is_anagram('test', 'tast')) # False
print(is_anagram('one from me', 'me from one')) #True

from hashlib import md5
from random import choice


chars = []

for char in range(ord('a'), ord('z')):
    chars.append(char)

def rand_choice():
    return chr(choice(chars))

hash = ""
mail = input("Enter your mail to generate name!")
while not hash.startswith("00"):
    name = ""
    for i in range(5):
        name += rand_choice()
    m = md5()
    m.update(name.encode("utf-8"))
    m.update(mail.encode("utf-8"))
    hash = m.hexdigest()
    if  hash.startswith("00"):
        print(f'Name: {name} | Mail: {mail}')

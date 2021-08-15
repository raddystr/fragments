from hashlib import md5
from random import choice


chars = []

for char in range(ord('a'), ord('z')):
    chars.append(char)

print(chars)
def rand_choice():
    return chr(choice(chars))

hash = "adasdasdasdad"

while not hash.startswith("00"):
    name = ""
    for i in range(5):
        name += rand_choice()
    mail = 'raddy.radev@abv.bg'
    print(name, mail)
    m = md5()
    m.update(name.encode("utf-8"))
    m.update(mail.encode("utf-8"))
    hash = m.hexdigest()
    print(hash)

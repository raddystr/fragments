import string

nums = [1, 2, 3, 4, 45, 5, 6, 67, 7, 78, 7, 13, 100, 50, 5, 12]

my_list = [n for n in nums if n%2 ==0]

print(my_list)

my_map = map(lambda n:n%2==0, nums)
my_filter = filter(lambda n:n%2==0, nums)

for x in my_map:
    print("This is map:", x)

for x in my_filter:
    print("This is filter:", x)

keyboard = list()

for x in range(2,10):
    print(x)
    for letter in string.ascii_lowercase[::2]:
        print(letter)
####TEESTSSS
        
        
        def add(x, y):
    return x + y


def substract(x, y):
    return x - y


def multiply(x, y):
    return x * y


def divide(x, y):
    if y == 0:
        raise ValueError('Can\'d devide by zero!!!')
    return x / y


   

   

   

   

#first class functions ---> treat functions like any other object

# closures allow to function to return a second function 
# which can use all variables as his own



def greeting(name):
    def greeting_type(grt):
        print(f"{grt}, {name}!")
    return greeting_type

first_greeting = greeting('Dragan4o')

first_greeting('Nazdrave')


second_greeting = greeting('Guten tag')

second_greeting("Gunter")


def decorator_func(arg_function):
    def wrapper_fucnction():
        return arg_function()
    return wrapper_fucnction

def text_log():
    print("Everythin works as expcted")


test_deco = decorator_func(text_log) 


test_deco()

            


   

   

   

   

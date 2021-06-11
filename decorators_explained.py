#Explanation: f2 take a function as arg. We decorate f0 and f1 with f2...

@f2
def f0(a=1, b=2):
    z = a + b
    return(z)

@f2 
def f1(name, age=34):
    return f"I'm {name}. My age is {age} y.o."

def f2(func):
    #We have to specified *args and **kwargs in case that we want the decorated function 
    #to take positional or keyword arguments
    def wrapper(*args, **kwargs):
        ret_val = func(*args, **kwargs)
        return ret_val
    return wrapper
        
f1('Petkan', age=12)

my_sum = f0(a=100,b=200)

pres = f1('Strahil', age=100)

print(pres)

print(f'This is the sum: {my_sum+100}')

#Some practical examples

import time 

def timer(func):
    def wrapper():
        before = time.time()
        func()
        print(f'Function took {time.time() - before} seconds to be executed')
    return wrapper

@timer
def run():
    time.sleep(10)
    

run()

import datetime

def log(func):
    def wrapper(*args, **kwargs):
        with open("log.txt", 'a') as f:
            f.write(f'Called function with {" ".join([str(arg) for arg in args])} at {str(datetime.datetime.now())}!\n')
        val = func(*args, **kwargs)
        return val
    return wrapper
@log
def log_test(a, b, c=9):
    print(a+b+c)
    
log_test(1,3,c=14)

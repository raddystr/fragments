PROJECT NAME: iriswall v.1

##############################################################################

PROJECT STRUCTURE:

##############################################################################

```
─ iriswall
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── __init__.cpython-310.pyc
│   │   ├── settings.cpython-310.pyc
│   │   ├── urls.cpython-310.pyc
│   │   └── wsgi.cpython-310.pyc
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── manage.py
├── requirements.txt
├── wall
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── __init__.cpython-310.pyc
│   │   ├── admin.cpython-310.pyc
│   │   ├── apps.cpython-310.pyc
│   │   ├── models.cpython-310.pyc
│   │   ├── tests.cpython-310.pyc
│   │   └── views.cpython-310.pyc
│   ├── admin.py
│   ├── apps.py
│   ├── migrations
│   │   ├── __init__.py
│   │   └── __pycache__
│   │       └── __init__.cpython-310.pyc
│   ├── models.py
│   ├── tests.py
│   └── views.py
└── workers.log

```
##############################################################################

QUICKSTART:

UNIX:

1. From root directory run `python3 manage.py runserver` optional you can use
<portnumber> for a specific port.

2. By default the api can be accessed on localhost:8000

3. You can run all test from ROOT directory of the project:
 `python3 manage.py test wall.tests.WallTests`

DOCKER:

1. You can also run the project with Docker `Dockerfile` is available in the 
root dir of the project

2. docker build -t <image_name> . now the project is available as a local img

3. docker run -it -p <img>:<host> <image_name> e.g. docker run -it -p 8000:8000 iriswall

4. Now the API is available on 0.0.0.0:8000

5. You can log on the container like docker exec -it <contaomner id> bash. And run 
the test `python3 /iriswall/mamange.py  test wall.tests.WallTests`

##############################################################################

OVERVIEW:

1. main implementation of the logis is /iriswall/wall/views.py

2. test - /iriswall/wall/tests.py

3. urls - /iriswall/wall/urls.py

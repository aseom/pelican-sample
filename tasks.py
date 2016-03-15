import os
import sys
import time
import threading
import webbrowser
from subprocess import Popen
from invoke import task, run

@task
def build():
    """Build for publish"""
    run('pelican -s publishconf.py -o output')

@task
def watch():
    """Auto regenerate site"""
    Popen('pelican -s pelicanconf.py -o output -r').wait()

@task
def serve():
    """Serve site at localhost:8000"""
    os.chdir('output')
    print("Starting server in new window...")
    if sys.platform == "win32":
        from subprocess import CREATE_NEW_CONSOLE
        Popen('python -m http.server 8000', creationflags=CREATE_NEW_CONSOLE)
    else:
        Popen('python -m http.server 8000', shell=True)

@task
def preview():
    """Run for local preview"""
    threading.Thread(target=watch).start()
    time.sleep(0.5)
    serve()
    
    time.sleep(1.0)
    webbrowser.open('http://localhost:8000/')

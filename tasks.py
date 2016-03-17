from invoke import task
from subprocess import check_call, Popen
import os

if os.environ.get('TRAVIS'):
    @task
    def travis():
        """Deploy via Travis CI
        Raise execption is nonzero exit
        """
        print("\n\033[33mStart publish...\033[0m")
        check_call('pelican -s publishconf.py -o output', shell=True)
        print('\n\033[33mStart deploy...\033[0m')
        check_call('chmod +x deploy.sh && ./deploy.sh', shell=True)

@task
def watch():
    """Auto regenerate site"""
    # Don't create '__pycache__'
    os.environ['PYTHONDONTWRITEBYTECODE'] = 'true'
    check_call('pelican -s pelicanconf.py -o output --autoreload', shell=True)

@task
def serve():
    """Serve site at localhost:8000"""
    os.chdir('output')
    print("Starting server in new window...")
    from subprocess import CREATE_NEW_CONSOLE # Windows only
    Popen('python -m http.server 8000',
          shell=True, creationflags=CREATE_NEW_CONSOLE)

@task
def preview():
    """Run for local preview"""
    import time
    import threading
    import webbrowser

    threading.Thread(target=watch).start()

    # Prevent 'output' dir not found
    while not os.path.exists('output'):
        time.sleep(0.1) 
    serve()

    time.sleep(1.0)
    webbrowser.open('http://localhost:8000/')

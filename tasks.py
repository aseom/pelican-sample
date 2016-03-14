import os
import time
import threading
import webbrowser
from subprocess import Popen, CREATE_NEW_CONSOLE
from invoke import task, run

@task
def build():
    """Build for publish"""
    run('pelican -s publishconf.py -o output')

@task
def travis():

    TARGET_REPO = 'aseom/pelican-test'
    TARGET_BRANCH = 'build-test'
    COMMIT_MSG = '(Test) Travis build #%s' % os.environ['TRAVIS_BUILD_NUMBER']

    if os.environ['TRAVIS_PULL_REQUEST'] == 'false':
        git_url = 'https://' + os.environ['GH_TOKEN'] + '@github.com/' + TARGET_REPO + '.git'
        run('git clone --branch={TARGET_BRANCH} {git_url} publish'.format(**locals()))

        os.chdir('publish')
        run('echo Test > dummyfile')

        run('git config user.name "aseom"')
        run('git config user.email "hm9599@gmail.com"')
        run('git add . && git commit -m "%s"' % COMMIT_MSG)
        run('git push origin %s' % TARGET_BRANCH)

        print("Publish completed.")

@task
def watch():
    """Auto regenerate site"""
    Popen('pelican -s pelicanconf.py -o output -r').wait()

@task
def serve():
    """Serve site at localhost:8000"""
    os.chdir('output')
    print("Starting server in new window...")
    Popen('python -m http.server 8000', creationflags=CREATE_NEW_CONSOLE)

@task
def preview():
    """Run for local preview"""
    threading.Thread(target=watch).start()
    time.sleep(0.5)
    serve()
    
    time.sleep(1.0)
    webbrowser.open('http://localhost:8000/')

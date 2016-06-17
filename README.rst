This is a special version of ``isbnlib`` that avoids side effects on Flask apps
caused by a call to ``socket.setdefaulttimeout`` in the 'normal' version (see issue #43).


You could test it on TravisCI using branch *TRAVIS_flask*. 


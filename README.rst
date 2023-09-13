Vim
===

Books
-----

The web has a load of good Vim tutorials, covering how to use Vim and
scripting tips.Here is a link to a very comprehensive online book:
http://learnvimscriptthehardway.stevelosh.com

WWW Vim Knowledge
-----------------

- `Vim wiki`_
- `Vim Galore`_
- `reedit`_

The History of hjkl
-------------------

Back in the days of 1976 there was this thing_.
Some things never change!

.. _Vim wiki : http://vim.wikia.com/wiki/Vim_Tips_Wiki
.. _Vim Galore : https://github.com/mhinz/vim-galore
.. _reedit : https://www.reddit.com/r/vim/
.. _thing : https://en.m.wikipedia.org/wiki/ADM-3A

Prepare your Computer
---------------------

Python3 Libs
''''''''''''

If Vim requires a Python 3 version that isn't installed on your computer, get
the Python 3 files (embedded release) and extract them. Add this lines in your
startup code to tell Vim where to find the missing files, here Python V3.11.

.. code-block::

    set pythonthreehome=%LOCALAPPDATA%\\Programs\\Python\\Python311emb
    set pythonthreedll=%LOCALAPPDATA%\\Programs\\Python\\Python311emb\\python311.dll





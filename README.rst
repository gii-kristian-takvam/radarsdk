.. = with overline, for title
   = for section
   - for sub-section
   + for sub-sub-section
   ^ for sub-sub-sub-section
   ` for sub-sub-sub-sub-section

======
README
======

A Ruby environment for working with the Radar SDK Wiki.

The wiki is powered by `Gollum <https://github.com/github/gollum#readme>`_.

Instructions
============

.. note::

    These intructions were written from deploying on Arch Linux.  They
    should work elsewhere (e.g. Ubuntu), although on Mac OS X, you can
    install rbenv using `Homebrew <http://mxcl.github.com/homebrew/>`_.
    
1.  Install `rbenv <https://github.com/sstephenson/rbenv/>`_
    and `ruby-build <https://github.com/sstephenson/ruby-build>`_.

    ::

        $ git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
        $ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

#.  Install the recommended version of Ruby for gollum (you can find this in
    .ruby-version).

    ::

        $ rbenv install 1.9.3-p392

#.  Install `Bundler <http://gembundler.com/>`_.

    ::

        $ gem install bundler

    .. note::

        If you already have Bundler installed, you may wish to updated it::
        
            $ gem update bundler

#. Create a Ruby virtual environment.

::

    # Create a parent directory for it if it doesn't already exist
    $ mkdir -p ~/workspace/rubyenv/
    
    # Clone the wiki repe
    $ cd ~/workspace/rubyenv/
    $ git clone https://github.com/cedexis/radarsdk.git radarsdk-wiki-dev
    
    # Change to the ruby-environment branch
    $ cd radarsdk-wiki-dev
    $ git checkout wiki-ruby-environment

#.  Run gollum, passing the root directory of the wiki project.

::

    # From anywhere
    $ run-gollum.sh ~/workspace/repos/cedexis/radarsdk.wiki

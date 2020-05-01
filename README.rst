=========
idl_emcee
=========
    
.. image:: https://travis-ci.org/mcfit/idl_emcee.svg?branch=master
    :target: https://travis-ci.org/mcfit/idl_emcee
    :alt: Build Status

.. image:: https://ci.appveyor.com/api/projects/status/52mh7p2qfa2qnu30?svg=true
    :target: https://ci.appveyor.com/project/danehkar/idl-emcee
    :alt: Build Status

.. image:: http://mybinder.org/badge.svg
    :target: http://mybinder.org/repo/mcfit/idl_emcee
    :alt: Binder

.. image:: https://img.shields.io/badge/license-MIT-blue.svg
    :target: https://github.com/mcfit/idl_emcee/blob/master/LICENSE
    :alt: GitHub license

**The IDL implementation of the affine-invariant MCMC Hammer**

Description
============

**idl_emcee** is an `Interactive Data Language <http://www.harrisgeospatial.com/ProductsandSolutions/GeospatialProducts/IDL.aspx>`_ (IDL)/`GNU Data Language <http://gnudatalanguage.sourceforge.net/>`_ (GDL) implementation of the *affine-invariant Markov chain Monte Carlo (MCMC) ensemble sampler*, based on `sl_emcee <https://github.com/mcfit/sl_emcee>`_ by `M. A. Nowak <http://space.mit.edu/home/mnowak/isis_vs_xspec/>`_, an S-Lang/`ISIS <http://space.mit.edu/cxc/isis/>`_ implementation of the MCMC Hammer proposed by `Goodman & Weare (2010) <http://dx.doi.org/10.2140/camcos.2010.5.65>`_, and then implemented in Python (`emcee <https://github.com/dfm/emcee>`_) by `Foreman-Mackey et al. (2013) <http://adsabs.harvard.edu/abs/2013PASP..125..306F>`_. 

Installation
============
 
* To get this package, you can simply use ``git`` command as follows::

        git clone --recursive https://github.com/mcfit/idl_emcee.git

* This package does not include any dependent packages in the current version.

Installation in IDL
-------------------

* To install the **idl_emcee** IDL library in the Interactive Data Language (IDL), you need to add the path of this package directory to your IDL path. For more information about the path management in IDL, read `the tips for customizing IDL program path <https://www.harrisgeospatial.com/Support/Self-Help-Tools/Help-Articles/Help-Articles-Detail/ArtMID/10220/ArticleID/16156/Quick-tips-for-customizing-your-IDL-program-search-path>`_ provided by Harris Geospatial Solutions or `the IDL library installation note <http://www.idlcoyote.com/code_tips/installcoyote.php>`_ by David Fanning in the Coyote IDL Library. 

* This package requires IDL version 7.1 or later. 


Installation in GDL
-------------------

*  You can install the GNU Data Language (GDL) if you do not have it on your machine:

    - Linux (Fedora)::

        sudo dnf install gdl
    
    - Linux (Ubuntu)::
    
        sudo apt-get install gnudatalanguage
    
    - OS X (`brew <https://brew.sh/>`_)::

        brew tap brewsci/science
        brew install gnudatalanguage

    - OS X (`macports <https://www.macports.org/>`_)::

        sudo port selfupdate
        sudo port upgrade libtool
        sudo port install gnudatalanguage
        
    - Windows: You can use the `GNU Data Language for Win32 <https://sourceforge.net/projects/gnudatalanguage-win32/>`_ (Unofficial Version) or you can compile the `GitHub source <https://github.com/gnudatalanguage/gdl>`_ using Visual Studio 2015 as shown in `appveyor.yml <https://github.com/gnudatalanguage/gdl/blob/master/appveyor.yml>`_.

* To install the **idl_emcee** library in GDL, you need to add the path of this package directory to your ``.gdl_startup`` file in your home directory::

    !PATH=!PATH + ':/home/idl_emcee/pro/'

  You may also need to set ``GDL_STARTUP`` if you have not done in ``.bashrc`` (bash)::

    export GDL_STARTUP=~/.gdl_startup

  or in ``.tcshrc`` (cshrc)::

    setenv GDL_STARTUP ~/.gdl_startup

* This package requires GDL version 0.9.8 or later.

Documentation
=============

For more information on how to use the API functions from the idl_emcee libray, please read the `API Documentation  <https://mcfit.github.io/idl_emcee/doc>`_ published on `mcfit.github.io/idl_emcee <https://mcfit.github.io/idl_emcee>`_.



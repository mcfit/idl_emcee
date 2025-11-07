=========
idl_emcee
=========
    
.. image:: https://app.travis-ci.com/mcfit/idl_emcee.svg?branch=master
    :target: https://app.travis-ci.com/github/mcfit/idl_emcee
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
    
.. image:: https://img.shields.io/badge/DOI-10.5281/zenodo.4495897-blue.svg
    :target: https://doi.org/10.5281/zenodo.4495897
    :alt: Zenodo

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/mcfit/idl_emcee/HEAD?labpath=Notebook.ipynb


**The IDL implementation of the affine-invariant MCMC Hammer**

Description
============

**idl_emcee** is an `Interactive Data Language <http://www.harrisgeospatial.com/ProductsandSolutions/GeospatialProducts/IDL.aspx>`_ (IDL)/`GNU Data Language <http://gnudatalanguage.sourceforge.net/>`_ (GDL) implementation of the *affine-invariant Markov chain Monte Carlo (MCMC) ensemble sampler*, based on `sl_emcee <https://github.com/mcfit/sl_emcee>`_ by `M. A. Nowak <http://space.mit.edu/home/mnowak/isis_vs_xspec/>`_, an S-Lang/`ISIS <http://space.mit.edu/cxc/isis/>`_ implementation of the MCMC Hammer proposed by `Goodman & Weare (2010) <http://dx.doi.org/10.2140/camcos.2010.5.65>`_, and then implemented in Python (`emcee <https://github.com/dfm/emcee>`_) by `Foreman-Mackey et al. (2013) <https://ui.adsabs.harvard.edu/abs/2013PASP..125..306F/abstract>`_. 

Installation
============
 
* To get this package, you can simply use ``git`` command as follows:

.. code-block::

        git clone --recursive https://github.com/mcfit/idl_emcee.git

* This package does not include any dependent packages in the current version.

Installation in IDL
-------------------

* To install the **idl_emcee** IDL library in the Interactive Data Language (IDL), you need to add the path of this package directory to your IDL path. For more information about the path management in IDL, read `the tips for customizing IDL program path <https://www.harrisgeospatial.com/Support/Self-Help-Tools/Help-Articles/Help-Articles-Detail/ArtMID/10220/ArticleID/16156/Quick-tips-for-customizing-your-IDL-program-search-path>`_ provided by Harris Geospatial Solutions or `the IDL library installation note <http://www.idlcoyote.com/code_tips/installcoyote.php>`_ by David Fanning in the Coyote IDL Library. 

* This package requires IDL version 7.1 or later. 


Installation in GDL
-------------------

*  You can install the GNU Data Language (GDL) if you do not have it on your machine:

    - Linux (Fedora):
    
    .. code-block::

        sudo dnf install gdl
    
    - Linux (Ubuntu):
    
    .. code-block::
    
        sudo apt-get install gnudatalanguage
    
    - OS X (`brew <https://brew.sh/>`_):
    
    .. code-block::

        brew tap brewsci/science
        brew install gnudatalanguage

    - OS X (`macports <https://www.macports.org/>`_):
    
    .. code-block::

        sudo port selfupdate
        sudo port upgrade libtool
        sudo port install gnudatalanguage
        
    - Windows: You can use the `GNU Data Language for Win32 <https://sourceforge.net/projects/gnudatalanguage-win32/>`_ (Unofficial Version) or you can compile the `GitHub source <https://github.com/gnudatalanguage/gdl>`_ using Visual Studio 2015 as shown in `appveyor.yml <https://github.com/gnudatalanguage/gdl/blob/master/appveyor.yml>`_.

* To install the **idl_emcee** library in GDL, you need to add the path of this package directory to your ``.gdl_startup`` file in your home directory:

  .. code-block::

    !PATH=!PATH + ':/home/idl_emcee/pro/'

  You may also need to set ``GDL_STARTUP`` if you have not done in ``.bashrc`` (bash):
  
  .. code-block::

    export GDL_STARTUP=~/.gdl_startup

  or in ``.tcshrc`` (cshrc):
  
  .. code-block::

    setenv GDL_STARTUP ~/.gdl_startup

* This package requires GDL version 0.9.9 or later.


How to Use
==========

The Documentation of the IDL functions provides in detail in the *API Documentation* (`mcfit.github.io/idl_emcee/doc <https://mcfit.github.io/idl_emcee/doc>`_). This IDL library creates the MCMC sampling  for given upper and lower uncertainties, and propagates uncertainties of parameters into the function.

See *Jupyter Notebook*: `Notebook.ipynb <https://github.com/mcfit/idl_emcee/blob/master/Notebook.ipynb>`_

Run *Jupyter Notebook* on `Binder <https://mybinder.org/v2/gh/mcfit/idl_emcee/HEAD?labpath=Notebook.ipynb>`_:

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/mcfit/idl_emcee/HEAD?labpath=Notebook.ipynb

You need to define your function. For example:

.. code-block:: idl
      
    function myfunc1, input
      result1 = total(input)
      result2 = input[1]^input[0]
      return, [result1, result2]
    end

and use the appropriate confidence level and uncertainty distribution. For example, for a 1.645-sigma standard deviation with a uniform distribution:

.. code-block:: idl

    clevel=.9; 1.645-sigma
    use_gaussian=0 ; uniform distribution from min value to max value

for a 1-sigma standard deviation with a Gaussian distribution:

.. code-block:: idl

    clevel=0.68268949 ; 1.0-sigma
    use_gaussian=1 ; gaussian distribution from min value to max value

and specify the number of walkers and the number of iterations:

.. code-block:: idl

    walk_num=30
    iteration_num=100

Now you provide the given upper and lower uncertainties of the input parameters:

.. code-block:: idl

    input=[1. , 2.]
    input_err=[0.2, 0.5]
    input_err_p=input_err
    input_err_m=-input_err
    output=myfunc1(input)
    temp=size(output,/DIMENSIONS)
    output_num=temp[0]

You can create the MCMC sample and propagate the uncertainties of the input parameters into your defined functions as follows:

.. code-block:: idl

    mcmc_sim=emcee_hammer('myfunc1', input, input_err_m, $
                          input_err_p, output, walk_num, $
                          iteration_num, use_gaussian)

To determine the upper and lower errors of the function outputs, you need to run:

.. code-block:: idl

    output_error=emcee_find_errors(output, mcmc_sim, clevel, do_plot=1)

Alternatively, you could load the **emcee** object class as follows:

.. code-block:: idl

    mc=obj_new('emcee')
    mcmc_sim=mc->hammer('myfunc1', input, input_err_m, $
                        input_err_p, output, walk_num=walk_num, $
                        iteration_num=iteration_num, $
                        use_gaussian=use_gaussian)
    output_error=mc->find_errors(output, mcmc_sim, clevel=clevel, do_plot=1)

which shows the following distribution histograms:

.. image:: https://raw.githubusercontent.com/mcfit/idl_emcee/master/examples/images/histogram0.jpg
    :width: 100

.. image:: https://raw.githubusercontent.com/mcfit/idl_emcee/master/examples/images/histogram1.jpg
    :width: 100

To print the results:

.. code-block:: idl

    for i=0, output_num-1 do begin
      print, output[i], transpose(output_error[i,*])
    endfor

which provide the upper and lower limits on each parameter:

.. code-block::

    3.00000     -0.35801017      0.35998471
    2.00000     -0.37573196      0.36297235

For other standard deviation, you should use different confidence levels:

.. code-block:: idl

    clevel=0.38292492 ; 0.5-sigma
    clevel=0.68268949 ; 1.0-sigma
    clevel=0.86638560 ; 1.5-sigma
    clevel=0.90       ; 1.645-sigma
    clevel=0.95       ; 1.960-sigma
    clevel=0.95449974 ; 2.0-sigma
    clevel=0.98758067 ; 2.5-sigma
    clevel=0.99       ; 2.575-sigma
    clevel=0.99730020 ; 3.0-sigma
    clevel=0.99953474 ; 3.5-sigma
    clevel=0.99993666 ; 4.0-sigma
    clevel=0.99999320 ; 4.5-sigma
    clevel=0.99999943 ; 5.0-sigma
    clevel=0.99999996 ; 5.5-sigma
    clevel=0.999999998; 6.0-sigma

Documentation
=============

For more information on how to use the API functions from the idl_emcee libray, please read the `API Documentation  <https://mcfit.github.io/idl_emcee/doc>`_ published on `mcfit.github.io/idl_emcee <https://mcfit.github.io/idl_emcee>`_.

Acknowledgement
===============

If you employ **idl_emcee** in your work, please acknowledge the usage by citing the following reference:
	
* Danehkar, A. (2025). idl_emcee: IDL Implementation of the MCMC Ensemble Sampler. *ASP Conf. Ser.*, **538**, 385. doi: `10.26624/BIVU8108 <https://doi.org/10.26624/BIVU8108>`_ ads: `2025ASPC..538..385D <https://ui.adsabs.harvard.edu/abs/2025ASPC..538..385D/abstract>`_.

.. code-block:: bibtex

   @article{Danehkar2025,
     author = {{Danehkar}, Ashkbiz,
     title = {idl\_emcee: IDL Implementation of the MCMC Ensemble Sampler},
     journal = {ASP Conf. Ser.},
     volume = {538},
     pages = {385},
     year = {2025},
     doi = {10.26624/BIVU8108}
   }

Learn More
==========

==================  =============================================
**Documentation**   https://mcfit.github.io/idl_emcee/doc/
**Repository**      https://github.com/mcfit/idl_emcee
**Issues & Ideas**  https://github.com/mcfit/idl_emcee/issues
**Archive**         `10.5281/zenodo.4495897 <https://doi.org/10.5281/zenodo.4495897>`_
==================  =============================================

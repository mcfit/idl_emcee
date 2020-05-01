## Test with mgunit

To test this package with [mgunit](https://github.com/mgalloy/mgunit), you need to install ``mgunit`` on your machine:

    git clone --recursive https://github.com/mgalloy/mgunit.git

To have all of them in ``externals`` directory of idl-emcee, you can download idl-emcee with all dependencies as follows 

    git clone --recursive https://github.com/mcfit/idl_emcee.git

To run the test, you need to run the following command:

    idl test_all.pro

This will produce two files: ``test-results.log`` and ``test-results.html``. All the functions should pass the test without any failure.




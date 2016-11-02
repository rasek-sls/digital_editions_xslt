# Digital Editions XSLT
XSLT style sheets for SLS digital editions

If you add this to your composer.json you can include these xslt transforations in your project.
~~~~
...
    "repositories": [
      {
        "type": "vcs",
        "url": "git@github.com:slsfi/digital_editions_xslt.git"
      }
    ],
    "require": {
        "slsfi/digital_editions_xslt": "dev-master"
    }
...
~~~~
Then you can get the newest update by issuing the command

~~~~
composer update

~~~~

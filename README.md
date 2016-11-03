# Digital Editions XSLT

XSLT style sheets for SLS digital editions

## Installation
This assumes that you are using composer in your project (and [composer available on your system as an executable](https://getcomposer.org/doc/00-intro.md)).

If you have not already created a composer.json file, you can create one with the command
```bash
composer init
```
To install this library, execure the following command:

```bash
composer config repositories.slsfi/digital-editions-xslt vcs git@github.com:slsfi/digital_editions_xslt.git
composer require slsfi/digital-editions-xslt:dev-master
```

Then in your project, if you autload from composer, for instance in your index.php
```php
require_once __DIR__.'/vendor/autoload.php';
```

You have access to the classes in this library like so:
```php
$xml2html = new \Slsfi\DigitalEditions\Xslt\ReadingTextXmlToHtml();
```

To fetch new updates from this library you can do that using
```bash
composer update
```

## User Manual
Here will come more info on how to use it later...
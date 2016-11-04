<?php
namespace Slsfi\DigitalEditions\Xslt;

class ManuscriptTransformer extends XmlToHtml {

    public function __construct($xmlFilePath) {
        parent::__construct(__DIR__ . "/../../../../xslt/ms_changes.xsl", $xmlFilePath);
    }

}


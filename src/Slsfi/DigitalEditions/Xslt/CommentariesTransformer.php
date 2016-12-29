<?php
namespace Slsfi\DigitalEditions\Xslt;

class CommentariesTransformer extends XmlToHtml {

    public function __construct($xmlFilePath) {
        parent::__construct(__DIR__ . "/../../../../xslt/est.xsl", $xmlFilePath);
    }

}


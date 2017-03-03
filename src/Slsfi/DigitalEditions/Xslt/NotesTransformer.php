<?php
namespace Slsfi\DigitalEditions\Xslt;

class NotesTransformer extends XmlToHtml {

    public function __construct($xmlFilePath) {
        parent::__construct(__DIR__ . "/../../../../xslt/notes.xsl", $xmlFilePath);
    }

}


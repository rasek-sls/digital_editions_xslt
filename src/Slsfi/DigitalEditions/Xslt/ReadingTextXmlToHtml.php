<?php
namespace Slsfi\DigitalEditions\Xslt;

class ReadingTextXmlToHtml extends XmlToHtml {
    protected function getValue() {
        return "ReadingTheXML";
    }

    public function prefixValue($prefix) {
        return "{$prefix}ReadingTheXML";
    }
}


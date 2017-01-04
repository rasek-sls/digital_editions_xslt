<?php
namespace Slsfi\DigitalEditions\Xslt;

abstract class XmlToHtml {

    // Force Extending class to define this method
    //abstract protected function getValue();
    //abstract protected function prefixValue($prefix);

    protected $xmlFilePath;
    protected $xslFilePath;
    

    public function __construct($xslFilePath, $xmlFilePath) {
        if (!file_exists($xslFilePath)) {
            throw new \Exception("XSL File not found");
        }
        $this->xslFilePath = $xslFilePath;

        if (!file_exists($xmlFilePath)) {
            throw new \Exception("XML File not found");
        }
        $this->xmlFilePath = $xmlFilePath;

    }

    // Common method
    public function getHTML($params = [], $replace_ns = true) {
        // Load the XML source
        $xml = new \DOMDocument;
        if ($replace_ns) {
            $xml->loadXML(
                str_replace('xmlns="http://www.sls.fi/tei"',
                            'xmlns="http://www.tei-c.org/ns/1.0"',
                            file_get_contents($this->xmlFilePath)
                )
            );
        } else {
            $xml->loadXML(file_get_contents($this->xmlFilePath));
        }

        $xsl = new \DOMDocument;
        $xsl->load($this->xslFilePath);

        // Configure the transformer
        $proc = new \XSLTProcessor;
        $proc->importStyleSheet($xsl); // attach the xsl rules

        foreach ($params as $name => $value) {
            $proc->setParameter('', $name, $value);
        }

        return $proc->transformToXML($xml);

    }
}

<?php
namespace Slsfi\Test\DigitalEditions\Xslt;

use Slsfi\DigitalEditions\Xslt\ManuscriptTransformer;

class ManuscriptTransformerTest extends \PHPUnit_Framework_TestCase
{
    public function testTrueIsTrue()
    {
        $foo = true;
        $this->assertTrue($foo);
    }

    public function testConstruction_validFilePath_shouldCreteObject() {
        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/ms/1_11_ms_1.xml";
        $object = new ManuscriptTransformer($xmlPath);

        $this->assertInstanceOf(ManuscriptTransformer::class, $object);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_inValidFilePath_shouldCreteObject() {
        $xmlPath = "";
        $object = new ManuscriptTransformer($xmlPath);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_nullFilePath_shouldCreteObject() {
        $object = new ManuscriptTransformer(null);
    }


    public function testGetHTML_validFilePath_shouldReturnHTML() {

        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/ms/1_11_ms_1.xml";
        $object = new ManuscriptTransformer($xmlPath);
        $html = $object->getHTML();

        $this->assertContains('<p class=', $html);

    }
}


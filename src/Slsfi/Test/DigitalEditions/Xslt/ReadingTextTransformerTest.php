<?php
namespace Slsfi\Test\DigitalEditions\Xslt;

use Slsfi\DigitalEditions\Xslt\ReadingTextTransformer;

class ReadingTextTransformerTest extends \PHPUnit_Framework_TestCase
{
    public function testTrueIsTrue()
    {
        $foo = true;
        $this->assertTrue($foo);
    }

    public function testConstruction_validFilePath_shouldCreteObject() {
        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/est/1_14_est.xml";
        $object = new ReadingTextTransformer($xmlPath);

        $this->assertInstanceOf(ReadingTextTransformer::class, $object);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_inValidFilePath_shouldCreteObject() {
        $xmlPath = "";
        $object = new ReadingTextTransformer($xmlPath);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_nullFilePath_shouldCreteObject() {
        $object = new ReadingTextTransformer(null);
    }


    public function testGetHTML_validFilePath_shouldReturnHTML() {

        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/est/1_14_est.xml";
        $object = new ReadingTextTransformer($xmlPath);
        $html = $object->getHTML();

        $this->assertContains('<p class=', $html);
    }

    public function testGetHTML_withOldNamespace_shouldUseNewNamespace() {
        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/est/10_1_est.xml";
        $object = new ReadingTextTransformer($xmlPath);
        $html = $object->getHTML();
        $this->assertContains('<p class=', $html);
    }

}


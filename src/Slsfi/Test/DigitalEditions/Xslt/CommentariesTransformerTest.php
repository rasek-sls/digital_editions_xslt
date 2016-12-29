<?php
namespace Slsfi\Test\DigitalEditions\Xslt;

use Slsfi\DigitalEditions\Xslt\CommentariesTransformer;

class CommentariesTransformerTest extends \PHPUnit_Framework_TestCase
{
    public function testTrueIsTrue()
    {
        $foo = true;
        $this->assertTrue($foo);
    }

    public function testConstruction_validFilePath_shouldCreteObject() {
        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/com/15_677_com.xml";
        $object = new CommentariesTransformer($xmlPath);

        $this->assertInstanceOf(CommentariesTransformer::class, $object);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_inValidFilePath_shouldCreteObject() {
        $xmlPath = "";
        $object = new CommentariesTransformer($xmlPath);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_nullFilePath_shouldCreteObject() {
        $object = new CommentariesTransformer(null);
    }


    public function testGetHTML_validFilePath_shouldReturnHTML() {

        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/com/15_677_com.xml";
        $object = new CommentariesTransformer($xmlPath);
        $html = $object->getHTML();

        $this->assertContains('<span class=', $html);
        $this->assertContains('naturliga ordningar', $html);
    }

    public function testGetHTML_withOldNamespace_shouldUseNewNamespace() {
        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/com/15_677_com.xml";
        $object = new CommentariesTransformer($xmlPath);
        $html = $object->getHTML();
        $this->assertContains('<span class=', $html);
    }

}


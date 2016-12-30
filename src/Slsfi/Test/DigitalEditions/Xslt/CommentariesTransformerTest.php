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

        $xmlPath = __DIR__ . "/xml-files/com/4_1_com.xml";
        $estPath = __DIR__ . "/xml-files/est/4_1_est.xml";
        $object = new CommentariesTransformer($xmlPath);

        echo $estPath;
        
        $params = [
                "sectionId" => "en5696",
                "bookId" => "4",
                "fileDiv" => "1",
                "commentTitle" => "FOO",
                "estDocument" => "file://" . $estPath];

        $html = $object->getHTML($params);

        $this->assertContains('<span class=', $html);
        $this->assertContains('Kommentar till FOO', $html);
    }

}


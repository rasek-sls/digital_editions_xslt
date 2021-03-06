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

        $xmlPath = __DIR__ . "/xml-files/com/1_1_com.xml";
        $estPath = __DIR__ . "/xml-files/est/1_1_est.xml";
        $object = new CommentariesTransformer($xmlPath);

        $generalCommentContent = 'Kommentar till FOO';
        $noteCommentContent = ' tröst ej nära?';


        $params = [
           //     "sectionId" => "en5696",
                "bookId" => "1",
                "fileDiv" => "0",
                "commentTitle" => "FOO",
                "estDocument" => "file://" . $estPath];
        
        $generalComment = $object->getHTML($params, true);


        $this->assertContains($generalCommentContent, $generalComment);
        $this->assertNotContains($noteCommentContent, $generalComment);
     


    }

}


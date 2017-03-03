<?php
namespace Slsfi\Test\DigitalEditions\Xslt;

use Slsfi\DigitalEditions\Xslt\NotesTransformer;

class NotesTransformerTest extends \PHPUnit_Framework_TestCase
{


    public function testConstruction_validFilePath_shouldCreteObject() {
        $xmlPath = __DIR__ . "/../../../Test/DigitalEditions/Xslt/xml-files/com/1_1_com.xml";
        $object = new NotesTransformer($xmlPath);

        $this->assertInstanceOf(NotesTransformer::class, $object);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_inValidFilePath_shouldCreteObject() {
        $xmlPath = "";
        $object = new NotesTransformer($xmlPath);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage XML File not found
     */
    public function testConstruction_nullFilePath_shouldCreteObject() {
        $object = new NotesTransformer(null);
    }


    public function testGetHTML_validFilePath_shouldReturnHTML() {

        $xmlPath = __DIR__ . "/xml-files/com/1_1_com.xml";
        $estPath = __DIR__ . "/xml-files/est/1_1_est.xml";
        $object = new NotesTransformer($xmlPath);

        $generalCommentContent = 'Kommentar till FOO';
        $noteCommentContent = ' tröst ej nära?';

        $params = [
                "noteId" => "en350",
                "bookId" => "1",
                "fileDiv" => "0",
                "commentTitle" => "FOO",
                "estDocument" => "file://" . $estPath];


        $noteComments = $object->getHTML($params, true);

        $this->assertContains($noteCommentContent, $noteComments);
        $this->assertNotContains($generalCommentContent, $noteComments);
  
    }

}


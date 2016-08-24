<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://swww.seesharp.fi )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

  <!-- OPENER CLOSER START -->

  <xsl:template match="tei:opener">
    <p class="noIndent teiOpener">
      <xsl:apply-templates/>
    </p>
    <!--<xsl:apply-templates/>-->
  </xsl:template>

  <xsl:template match="tei:closer">
    <p class="noIndent teiCloser">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:address">
    <xsl:choose>
      <xsl:when test="parent::tei:opener or parent::tei:closer">
        <xsl:if test="preceding-sibling::*">
          <br />
          <br />
        </xsl:if>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <p style="font-style: italic;">
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:salute">
    <xsl:choose>
      <xsl:when test="parent::tei:opener or parent::tei:closer">
        <xsl:if test="preceding-sibling::*">
          <br />
          <br />
        </xsl:if>
        <xsl:apply-templates/>
        <!--<p>
          &#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates/>
        </p>-->
      </xsl:when>
      <xsl:otherwise>
        <p class="noIndent">
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:signed">
    <xsl:choose>
      <xsl:when test="ancestor::tei:opener or ancestor::tei:closer">
        <xsl:if test="preceding-sibling::*">
          <br />
          <br />
        </xsl:if>
        <xsl:apply-templates/>
        <!--<p style="text-align: right;">
          <xsl:apply-templates/>
        </p>-->
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:dateline">
    <xsl:choose>
      <xsl:when test="ancestor::tei:opener or ancestor::tei:closer">
        <xsl:if test="preceding-sibling::*">
          <br />
          <br />
        </xsl:if>
        <span>
          <xsl:call-template name="attRend"/>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <p class="dateline noIndent">
          <span>
            <xsl:call-template name="attRend"/>
            <xsl:apply-templates/>
          </span>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- OPENER CLOSER END -->
  
  <!-- TABLES START -->

  <xsl:template match="tei:table">
    <table>
      <xsl:call-template name="attRend">
        <xsl:with-param name="defaultClasses">
          <xsl:if test="@xml:id">
            <xsl:value-of select="@xml:id"/>
          </xsl:if>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="tei:row">
    <tr>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="tei:cell">
    <td>
      <xsl:choose>
        <xsl:when test="@role='label'">
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">bold</xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="attRend"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <!--<xsl:template match="tei:table">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="tei:row">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="tei:cell">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>-->
  
  <!-- TABLES END-->

  <xsl:template match="tei:list">
    <xsl:apply-templates/>
    <!--<p class="noIndent">
      <xsl:apply-templates/>
    </p>-->
  </xsl:template>

  <xsl:template match="tei:item">
    <xsl:choose>
      <xsl:when test="ancestor::tei:switchPos">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="following-sibling::*">
        <p class="l">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p class="l">
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
    <!--<xsl:apply-templates/>
    <xsl:if test="following-sibling::*">
      <br/>
    </xsl:if>-->
  </xsl:template>

  <xsl:template match="tei:postscript">
    <xsl:apply-templates/>
    <p class="paragraphSpace"></p>
  </xsl:template>

  <xsl:template match="tei:xref">
    <a>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@type='introduction'">
            <xsl:text>xreference ref_introduction</xsl:text>
          </xsl:when>
          <xsl:when test="@type='readingtext'">
            <xsl:text>xreference ref_readingtext</xsl:text>
          </xsl:when>
          <xsl:when test="@type='comment'">
            <xsl:text>xreference ref_comment</xsl:text>
          </xsl:when>
          <xsl:when test="@type='ext'">
            <xsl:text>xreference ref_external</xsl:text>
          </xsl:when>
          <xsl:when test="@type='book'">
            <xsl:text>xreference ref_book</xsl:text>
          </xsl:when>
          <xsl:when test="@type='collection'">
            <xsl:text>xreference ref_collection</xsl:text>
          </xsl:when>
          <xsl:when test="@type='pdf'">
            <xsl:text>xreference ref_pdf</xsl:text>
          </xsl:when>
          <xsl:when test="@type='illustration'">
            <xsl:text>xreference ref_illustration</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:if test="@type='pdf'">
          <xsl:text>pdf_zts/</xsl:text>
        </xsl:if>
        <xsl:if test="@type='illustration'">
          <xsl:text>#</xsl:text>
        </xsl:if>
        <xsl:value-of select="@target"/>
        <!--<xsl:value-of select="substring(@target, 3)"/>-->
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="tei:xptr">
    <a>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@type='illustration'">
            <xsl:text>xreference ref_illustration</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <img src="images/image_symbol.gif"/>
    </a>
  </xsl:template>

  <xsl:template match="tei:anchor">
    <a>
      <xsl:attribute name="name">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:when test="@xml:id">
            <xsl:value-of select="@xml:id"/>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>anchor </xsl:text>
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:when test="@xml:id">
            <xsl:value-of select="@xml:id"/>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
    </a>
  </xsl:template>

  <xsl:template match="tei:stamp">
    <span class="stamp">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:print">
    <span class="print">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="tei:milestone">
    <xsl:choose>
      <xsl:when test="@type='bar'">
        <p class="center"><img src="images/bar.png"/></p>
      </xsl:when>
      <xsl:when test="@type='smallBar'">
        <p class="center">
          <img src="images/smallbar.png"/>
        </p>
      </xsl:when>
      <xsl:when test="@unit='part' and @when">
        <p class="milestoneWhen center">
          <xsl:text>Avsnittet ingår i HT </xsl:text>
          <xsl:choose>
            <xsl:when test="substring(@when,9,1)='0'">
              <xsl:value-of select="substring(@when,10,1)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring(@when,9,2)"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>/</xsl:text>
          <xsl:choose>
            <xsl:when test="substring(@when,6,1)='0'">
              <xsl:value-of select="substring(@when,7,1)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring(@when,6,2)"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text> </xsl:text>
          <xsl:value-of select="substring(@when,1,4)"/>
          <xsl:text>:</xsl:text>
        </p>
      </xsl:when>
      <xsl:when test="@unit='part'">
        <p class="milestonePart">
          <xsl:text>&#160;</xsl:text>
        </p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:date">
    <xsl:choose>
      <xsl:when test="@rend">
        <span>
          <xsl:call-template name="attRend"/>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:lb">
    <xsl:choose>
      <xsl:when test="ancestor::tei:p or ancestor::tei:l or ancestor::tei:head or ancestor::tei:note or ancestor::tei:opener or ancestor::tei:closer">
        <br />
      </xsl:when>
      <xsl:otherwise>
        <p>&#160;</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Ignore this element inside a tooltip -->
  <xsl:template match="tei:note" mode="tooltip"/>

  <xsl:template match="tei:hi" mode="tooltip">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:hi">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:emph" mode="tooltip">
    <xsl:choose>
      <xsl:when test="@rend">
        <span>
          <xsl:call-template name="attRend"/>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span class="italics">
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template> 
  <xsl:template match="tei:emph">
    <xsl:choose>
      <xsl:when test="@rend">
        <span>
          <xsl:call-template name="attRend"/>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span class="italics">
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="attRend">
    <xsl:param name="defaultClasses"/>
    <xsl:choose>
      <xsl:when test="@rend">
        <xsl:attribute name="class">
          <xsl:value-of select="$defaultClasses" />
          <xsl:if test="string-length(normalize-space($defaultClasses)) > 0">
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:value-of select="@rend" />
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="string-length(normalize-space($defaultClasses)) > 0">
          <xsl:attribute name="class">
            <xsl:value-of select="$defaultClasses" />
          </xsl:attribute>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:note">
    <xsl:variable name="handen" select="translate(@hand, '#', '')" />
    <xsl:if test="@type='editor'">
      <img src="images/asterix.png">
        <!--<xsl:attribute name="onmouseover">
          <xsl:text>Tip("</xsl:text>
            <xsl:value-of select="normalize-space(.)" />
          <xsl:text>", WIDTH, 300)</xsl:text>
        </xsl:attribute>-->
        <xsl:attribute name="class">
          <xsl:text>comment commentScrollTarget tooltiptrigger ttComment </xsl:text>
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:attribute name="id">
           <xsl:value-of select="@id" />
        </xsl:attribute>
      </img>
      <span class="tooltip">
        <span class="ttFixed">
          <xsl:apply-templates/>
        </span>
      </span>
    </xsl:if>
    <xsl:if test="contains(@place, 'foot') or contains(@place, 'end') or contains(@id, 'ftn')">
      <span class="footnoteindicator hand">
        <xsl:attribute name="class">
          <xsl:text>footnoteindicator tooltiptrigger ttFoot </xsl:text>
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <!--<xsl:attribute name="onmouseover">
          <xsl:text>Tip("</xsl:text>
          <xsl:apply-templates mode="tooltip"/><xsl:value-of select="normalize-space(.)" />
          <xsl:text>", WIDTH, 300)</xsl:text>
        </xsl:attribute>-->
        <xsl:value-of select="@n" />
      </span>
      <span class="tooltip ttFoot">
        <span class="ttFixed">
          <xsl:apply-templates/>
        </span>
      </span>
    </xsl:if>
    <xsl:if test="contains(@type, 'editorial')">
      <span>
        <xsl:attribute name="class">
          <xsl:text>tei_editorial tooltiptrigger ttMs</xsl:text>
        </xsl:attribute>
        <xsl:apply-templates />
      </span>
    </xsl:if>
    <xsl:call-template name="mediumTooltip">
      <xsl:with-param name="hand">
        <xsl:value-of select="$handen"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="listFootnotes">
    <xsl:param name="sectionToProcess" />
    <xsl:param name="noEmptyLines" />
    <xsl:if test="string-length($noEmptyLines)=0">
      <p>&#160;</p>
      <p>&#160;</p>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="string-length($sectionToProcess)&gt;0">
        <xsl:for-each select="//tei:div[@id=$sectionToProcess]//tei:note">
          <xsl:call-template name="printFootNote"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="//tei:note">
          <xsl:call-template name="printFootNote"/>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="printFootNote">
    <xsl:if test="contains(@place, 'foot') or contains(@place, 'end') or contains(@id, 'ftn')">
      <p>
        <xsl:attribute name="class">
          <xsl:text>footnote hand</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
          <!--<xsl:text>_text</xsl:text>-->
        </xsl:attribute>
        <xsl:value-of select="@n"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates />
      </p>
    </xsl:if>
  </xsl:template>

  <xsl:template name="placeIcon">
    <xsl:if test="starts-with(@rend, 'place_')">
      <img src="images/icon_link_variant.png">
        <xsl:attribute name="class">
          <xsl:text>tooltiptrigger ttExplanations</xsl:text>
          <!--<xsl:value-of select="@id" />-->
        </xsl:attribute>
        <!--<xsl:attribute name="id">
          <xsl:value-of select="@id" />
        </xsl:attribute>-->
      </img>
      <span class="tooltip">
        <xsl:text>Texten fortsätter</xsl:text>
        <xsl:choose>
          <xsl:when test="contains(@rend, 'previousPage')">
            <xsl:text> på föregående sida</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'nextPage')">
            <xsl:text> på nästa sida</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="contains(@rend, 'rightMargin')">
            <xsl:text> i högra marginalen</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'leftMargin')">
            <xsl:text> i vänstra marginalen</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'botMargin')">
            <xsl:text> i nedre marginalen</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'topMargin')">
            <xsl:text> i övre marginalen</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'other')">
            <xsl:text> på annat/avvikande ställe</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'ontopRotatedACW90')">
            <xsl:text>, pappret vänt moturs och ny text skriven ovanpå tidigare text</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@rend, 'ontopRotatedCW90')">
            <xsl:text>, pappret vänt medurs och ny text skriven ovanpå tidigare text</xsl:text>
          </xsl:when>
        </xsl:choose>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:figure">
    <img class="tei_bar">
      <xsl:attribute name="src">
        <xsl:text>images/figures/</xsl:text>
        <xsl:value-of select="@type"/>
        <xsl:text>.png</xsl:text>
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="variantMouseOver">
    <xsl:if test="@type">
      <span class="tooltip ttVariant">
        <xsl:choose>
          <xsl:when test="contains(@type,'sub') and contains(@type,'ort') and contains(@type,'int')">
            <xsl:text>substantiell skillnad och skillnad i ortografi/typografi samt i interpunktion</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@type,'sub') and contains(@type,'ort')">
            <xsl:text>substantiell och ortografisk/typografisk skillnad</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@type,'sub') and contains(@type,'int')">
            <xsl:text>substantiell skillnad och skillnad i interpunktion</xsl:text>
          </xsl:when>
          <xsl:when test="contains(@type,'ort') and contains(@type,'int')">
            <xsl:text>skillnad i ortografi/typografi och i interpunktion</xsl:text>
          </xsl:when>
          
          <xsl:when test="substring(@type,1,3)='sub'">
            <xsl:text>substantiell skillnad</xsl:text>
          </xsl:when>
          <xsl:when test="substring(@type,1,3)='ort'">
            <xsl:text>skillnad i ortografi/typografi</xsl:text>
          </xsl:when>
          <xsl:when test="substring(@type,1,3)='int'">
            <xsl:text>skillnad i interpunktion</xsl:text>
          </xsl:when>
          <xsl:when test="substring(@type,1,3)='ide'">
            <xsl:text>identiskt</xsl:text>
          </xsl:when>
        </xsl:choose>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:gap">
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@reason='overstrike' or @reason='erased'">
            <xsl:text>gap deletion tooltiptrigger ttMs</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>gap tooltiptrigger ttMs</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="mediumClass" />
      </xsl:attribute>
      <xsl:text>[oläsligt]</xsl:text>
    </span>
    <span class="tooltip">
      <xsl:text>Oläsligt</xsl:text>
      <xsl:choose>
        <xsl:when test="@extent and @unit">
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@extent"/>
          <xsl:choose>
            <xsl:when test="@extent='1'">
              <xsl:choose>
                <xsl:when test="@unit='letters'">
                  <xsl:text> bokstav</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='words'">
                  <xsl:text> ord</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='lines'">
                  <xsl:text> rad</xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="@unit='letters'">
                  <xsl:text> bokstäver</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='words'">
                  <xsl:text> ord</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='lines'">
                  <xsl:text> rader</xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>)</xsl:text>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
      <xsl:call-template name="attReason"/>
      <xsl:if test="@medium">
        <br/>
        <xsl:call-template name="inks">
          <xsl:with-param name="ink" select="@medium"/>
        </xsl:call-template>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template name="mediumClass">
    <xsl:if test="@medium">
      <xsl:text> medium tooltiptrigger ttMs</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="mediumTooltip">
    <xsl:param name="hand" />
    <xsl:if test="@medium">
      <span class="tooltip">
        <xsl:call-template name="inks">
          <xsl:with-param name="ink" select="@medium"/>
          <xsl:with-param name="attHand" select="$hand"/>
        </xsl:call-template>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attReason">
    <xsl:choose>
      <xsl:when test="@reason='faded'">
        <xsl:text>: svagt bläck</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='binding'">
        <xsl:text>: inbindning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='damage'">
        <xsl:text>: skador</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='endline'">
        <xsl:text>: slutet av raden</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='erased'">
        <xsl:text>: utsuddning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='glue'">
        <xsl:text>: överlimning eller tejp</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='inksmudge'">
        <xsl:text>: bläckplump eller motsvarande</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='overstrike'">
        <xsl:text>: strykning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='overwritten'">
        <xsl:text>: överskrivning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='seal'">
        <xsl:text>: sigill</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='smudge'">
        <xsl:text>: avsvärtning, utflutet bläck</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='stamp'">
        <xsl:text>: frimärke/poststämpel</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='writing'">
        <xsl:text>: handstil</xsl:text>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="attReasonUnclear">
    <xsl:choose>
      <xsl:when test="@reason='writing'">
        <xsl:text>svårtytt</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='endline'">
        <xsl:text>svårläst p.g.a. radslut</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='damage'">
        <xsl:text>svårläst p.g.a. skada</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='inksmudge'">
        <xsl:text>svårläst p.g.a. bläckplump eller motsvarande</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='binding'">
        <xsl:text>svårläst p.g.a. inbindning/konservering</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='overstrike'">
        <xsl:text>svårläst p.g.a. strykning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='overwritten'">
        <xsl:text>svårläst p.g.a. överskrivning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='glue'">
        <xsl:text>svårläst p.g.a. överlimning eller tejp</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='faded'">
        <xsl:text>svårläst p.g.a. att bläcket är svagt och avmattat, på väg att ta slut</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='erased'">
        <xsl:text>svårläst p.g.a. utsuddning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='stamp'">
        <xsl:text>svårläst p.g.a. frimärke</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='seal'">
        <xsl:text>svårläst p.g.a. sigill</xsl:text>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="attReasonSupplied">
    <xsl:choose>
      <xsl:when test="@reason='writing'">
        <xsl:text>oläslig handstil</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='endline'">
        <xsl:text>utanför pappret (radslut)</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='damage'">
        <xsl:text>oläsligt p.g.a. skada</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='inksmudge'">
        <xsl:text>oläsligt p.g.a. bläckplump eller motsvarande</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='bindning'">
        <xsl:text>oläsligt p.g.a. konservering/inbindning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='binding'">
        <xsl:text>oläsligt p.g.a. konservering/inbindning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='glue'">
        <xsl:text>oläsligt p.g.a. överlimning eller tejp</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='faded'">
        <xsl:text>oläsligt p.g.a. att bläcket är svagt och avmattat, på väg att ta slut</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='erased'">
        <xsl:text>oläsligt p.g.a. utsuddning</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='stamp'">
        <xsl:text>oläsligt p.g.a. frimärke/poststämpel</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='seal'">
        <xsl:text>oläsligt p.g.a. sigill</xsl:text>
      </xsl:when>
      <xsl:when test="@reason='overwritten'">
        <xsl:text>oläsligt p.g.a. överskrivning</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>tillagt av utgivaren</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="xmlLang">
    <span class="tooltip ttLang">
      <xsl:text>språk: </xsl:text>
      <xsl:choose>
        <xsl:when test="@xml:lang='cel'">
          <xsl:text>keltiska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='dan'">
          <xsl:text>danska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='eng'">
          <xsl:text>engelska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='ang'">
          <xsl:text>fornengelska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='est'">
          <xsl:text>estniska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='fin'">
          <xsl:text>finska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='fre'">
          <xsl:text>franska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='ger'">
          <xsl:text>tyska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='gre'">
          <xsl:text>grekiska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='ita'">
          <xsl:text>italienska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='lap'">
          <xsl:text>samiska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='lat'">
          <xsl:text>latin</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='nor'">
          <xsl:text>norska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='oic'">
          <xsl:text>fornisländska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='rus'">
          <xsl:text>ryska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='spa'">
          <xsl:text>spanska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='ara'">
          <xsl:text>arabiska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='heb'">
          <xsl:text>hebreiska</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:lang='tib'">
          <xsl:text>tibetanska</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>annat</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template name="spaceText">
    <xsl:text>[</xsl:text>
    <xsl:call-template name="repeatText">
      <xsl:with-param name="i" select="1"/>
      <xsl:with-param name="count" select="@extent"/>
      <xsl:with-param name="text">

        <xsl:choose>
          <xsl:when test="name() = 'space'">
            <xsl:choose>
              <xsl:when test="@unit='letters'">
                <xsl:text>&#160;</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='words'">
                <xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='lines'">
                <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@unit='letters'">
                <xsl:text>-</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='words'">
                <xsl:text>----</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='lines'">
                <xsl:text>---- ---- ---- ---- ----</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:with-param>
      <xsl:with-param name="spaces">
        <xsl:if test="@unit='words' or @unit='lines'">
          <xsl:value-of select="1"/>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text>]</xsl:text>
  </xsl:template>

  <xsl:template name="pb_text">
    <xsl:choose>
      <xsl:when test="contains(@type, 'unprinted')">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>]</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>|</xsl:text>
        <xsl:value-of select="@n"/>
        <xsl:text>|</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="att_pb_class">
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="contains(@type, 'ZTS')">
          <xsl:text>pb_zts</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>pb_orig</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="spaceTooltipText">
    <xsl:text>Tomrum</xsl:text>
    <!--<xsl:choose>
      <xsl:when test="@extent and @unit">
        <xsl:text> (</xsl:text>
        <xsl:value-of select="@extent"/>
        <xsl:choose>
          <xsl:when test="@extent='1'">
            <xsl:choose>
              <xsl:when test="@unit='letters'">
                <xsl:text> bokstav</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='words'">
                <xsl:text> ord</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='lines'">
                <xsl:text> rad</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@unit='letters'">
                <xsl:text> bokstäver</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='words'">
                <xsl:text> ord</xsl:text>
              </xsl:when>
              <xsl:when test="@unit='lines'">
                <xsl:text> rader</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>-->
  </xsl:template>

  <xsl:template name="inks">
    <xsl:param name="ink"/>
    <xsl:param name="attHand"/>
    <xsl:choose>
      <xsl:when test="string-length($attHand)&gt;0">
        <xsl:value-of select="//tei:handNote[@id=$attHand]"/>
        <xsl:text>: </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>med annan penna: </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$ink='black-ink'">
        <xsl:text>svart bläck</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='black-inkOther'">
        <xsl:text>annat svart bläck</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='blue-ink'">
        <xsl:text>blått bläck</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='blue-pencil'">
        <xsl:text>blå färgpenna</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='brown-ink'">
        <xsl:text>brunt bläck</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='brown-inkOther'">
        <xsl:text>annat brunt bläck</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='pencil'">
        <xsl:text>blyerts</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='red-ink'">
        <xsl:text>rött bläck</xsl:text>
      </xsl:when>
      <xsl:when test="$ink='violet-ink'">
        <xsl:text>violett bläck</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="endSpace">
    <p>&#160;</p>
    <p>&#160;</p>
    <p>&#160;</p>
  </xsl:template>

  <xsl:template name="repeatText">
    <xsl:param name="i" />
    <xsl:param name="count" />
    <xsl:param name="text" />
    <xsl:param name="spaces" select="0"/>
    <!-- 0 = no spaces, 1 = with spaces -->
    <xsl:param name="lineBreaks" select="0"/>
    <!-- 0 = no linebreaks, 1 = with linebreaks -->

    <xsl:if test="$i &lt;= $count">
      <xsl:value-of select="$text"/>
      <xsl:if test="$i &lt; $count and $spaces = 1">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:if test="$i &lt; $count and $lineBreaks = 1">
        <br/>
      </xsl:if>
    </xsl:if>

    <!--begin_: RepeatTheLoopUntilFinished-->
    <xsl:if test="$i &lt;= $count">
      <xsl:call-template name="repeatText">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1"/>
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count"/>
        </xsl:with-param>
        <xsl:with-param name="text">
          <xsl:value-of select="$text"/>
        </xsl:with-param>
        <xsl:with-param name="spaces">
          <xsl:value-of select="$spaces"/>
        </xsl:with-param>
        <xsl:with-param name="lineBreaks">
          <xsl:value-of select="$lineBreaks"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>

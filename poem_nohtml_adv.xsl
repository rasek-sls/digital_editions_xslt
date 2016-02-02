<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://seesharp.witchmastercreations.com )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei" xmlns:zte="http://www.topelius.fi">

  <xsl:include href="inc_common.xsl" />
  
  <xsl:param name="sectionId" />
  
  <xsl:template match="tei:teiHeader"/>
  
  <xsl:template match="tei:body">
    <xsl:choose>
      <xsl:when test="string-length($sectionId)&gt;0">
        <xsl:for-each select="//tei:div[@id=$sectionId]">
          <xsl:apply-templates/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="listFootnotes">
      <xsl:with-param name="sectionToProcess"><xsl:value-of select="$sectionId"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="endSpace"/>
  </xsl:template>

  <xsl:template match="tei:head">
    <h3>
      <xsl:choose>
        <xsl:when test="@rend='italics'">
          <i>
            <xsl:apply-templates/>
          </i>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </h3>
  </xsl:template>
  
   <xsl:template match="tei:div">
    <xsl:choose>
      <xsl:when test="@type='comment'"/>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:opener">
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:lg">
    <xsl:if test="not(ancestor::tei:note)">
      <xsl:apply-templates/>
      <xsl:if test="name(following-sibling::*[1]) = 'lg' or name(following-sibling::*[1]) = 'pb'">
        <p class="strofeSpacing" />
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:l">
    <p>
      <xsl:attribute name="class">
        <xsl:text>l</xsl:text>
        <xsl:if test="@rend='indent'">
          <xsl:text> lIndent</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <xsl:if test="(@n mod 5) = 0">
        <span class="lNumber">
          <xsl:value-of select="@n"/>
        </span>
      </xsl:if>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <!-- Changed strofe behaviour
  <xsl:template match="tei:lg">
    <xsl:if test="not(ancestor::tei:note)">
      <p class="strofe">
        <xsl:apply-templates/>
      </p>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:l">
    <xsl:if test="(@n mod 5) = 0">
      <span style="position:absolute;left:-15px;width:18px;color:#a9a49a;">
        <xsl:value-of select="@n"/>
      </span>
    </xsl:if>
    <xsl:if test="@rend='indent'">
      <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <br />
  </xsl:template>-->

  <xsl:template match="tei:address">
    <p style="font-style: italic;">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:salute">
    <xsl:choose>
      <xsl:when test="parent::tei:closer">
        <p>
          &#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:signed">
    <xsl:choose>
      <xsl:when test="parent::tei:closer">
        <p style="text-align: right;">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:title">
    <span class="title">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:orgName">
    <span class="orgName">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <span>
      <xsl:call-template name="attRend">
        <xsl:with-param name="defaultClasses">placeName tooltiptrigger ttPlace</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="@corresp">
        <xsl:attribute name="id">
          <xsl:value-of select="@corresp"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--<xsl:template match="tei:persName" mode="tooltip">
    <xsl:apply-templates/>
  </xsl:template>-->
  <xsl:template match="tei:persName">
    <span>
      <xsl:call-template name="attRend">
        <xsl:with-param name="defaultClasses">person tooltiptrigger ttPerson</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="@corresp">
        <xsl:attribute name="id">
          <xsl:value-of select="@corresp"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:p">
    <p>
      <xsl:choose>
        <xsl:when test="@rend">
          <xsl:call-template name="attRend"/> 
        </xsl:when>
        <xsl:when test="parent::tei:postscript or @n='1'">
          <xsl:attribute name="class">
            <xsl:text>noIndent</xsl:text>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <span class="paragraph_number">
        <xsl:number/>
      </span>
      <xsl:apply-templates/>
    </p>
    
    <!--<p>
      <xsl:if test="parent::tei:postscript or @rend='noIndent'">
        <xsl:attribute name="class">
          <xsl:text>noIndent</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@rend='italics'">
          <i>
            <xsl:apply-templates/>
          </i>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </p>-->
  </xsl:template>
  
  <xsl:template match="tei:anchor">
    <xsl:choose>
      <xsl:when test="contains(@id, 'lem')">
        <span class="anchor_lemma symbol_red">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:text>|</xsl:text>
        </span>
      </xsl:when>
      <xsl:when test="contains(@id, 'pos')">
        <a>
          <xsl:attribute name="name">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>anchor </xsl:text>
            <xsl:value-of select="@id"/>
          </xsl:attribute>
        </a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:choice">
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <!--<xsl:when test="child::tei:sic">
            <xsl:attribute name="class">
              <xsl:text>choice tooltiptrigger</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="onmouseover">
              <xsl:text>Tip("</xsl:text>
              <xsl:text>original: </xsl:text>
              <xsl:value-of select="tei:sic"/>
              <xsl:text>", WIDTH, 0)</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="zte:orig">
              <xsl:text>original: </xsl:text>
              <xsl:value-of select="tei:sic"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="child::tei:orig">
            <xsl:attribute name="class">
              <xsl:text>choice tooltiptrigger</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="onmouseover">
              <xsl:text>Tip("</xsl:text>
              <xsl:text>original: </xsl:text>
              <xsl:value-of select="tei:orig"/>
              <xsl:text>", WIDTH, 0)</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="zte:orig">
              <xsl:text>original: </xsl:text>
              <xsl:value-of select="tei:orig"/>
            </xsl:attribute>
          </xsl:when>-->
          <xsl:when test="child::tei:sic or child::tei:orig">
            <xsl:text>choice tooltiptrigger ttChanges</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>choice</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
    <xsl:choose>
      <xsl:when test="child::tei:sic">
        <span class="tooltip ttChanges">
          <xsl:text>original: </xsl:text>
          <xsl:value-of select="tei:sic"/>
        </span>
      </xsl:when>
      <xsl:when test="child::tei:orig">
        <span class="tooltip ttChanges">
          <xsl:text>original: </xsl:text>
          <xsl:value-of select="tei:orig"/>
        </span>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:sic">
    <!--<span style="background-color:#EF8066">
      <xsl:apply-templates/>
    </span>-->
  </xsl:template>

  <xsl:template match="tei:corr">
    <xsl:choose>
    <xsl:when test="@source='Rättelser'">
      <span class="corr_red tooltiptrigger ttChanges">
        <!--<xsl:attribute name="onmouseover">
          <xsl:text>Tip("Rättelse i originalet", WIDTH, 0)</xsl:text>
        </xsl:attribute>-->
        <xsl:apply-templates/>
      </span>
      <span class="tooltip ttChanges">
        <xsl:text>Rättelse i originalet</xsl:text>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="parent::tei:choice/tei:reg"/>
        <xsl:otherwise>
          <span class="corr">
            <xsl:apply-templates/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:orig">
    <!--<span style="background-color:#e76c4f">
      <xsl:apply-templates/>
    </span>-->
  </xsl:template>

  <xsl:template match="tei:reg">
    <xsl:choose>
      <xsl:when test="parent::tei:choice">
        <span class="corr">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span class="reg">
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:supplied">
    <span class="corr_red choice tooltiptrigger ttChanges">
      <xsl:apply-templates/>
    </span>
    <span class="tooltip ttChanges">
      <xsl:text>tillagt av utgivaren</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="tei:foreign">
    <span>
      <xsl:call-template name="attRend">
        <xsl:with-param name="defaultClasses">foreign tooltiptrigger ttLang</xsl:with-param>
      </xsl:call-template>
      <!--<xsl:attribute name="onmouseover">
        <xsl:text>Tip("</xsl:text>
        <xsl:text>språk: </xsl:text>
        <xsl:choose>
          <xsl:when test="@xml:lang='fin'">
            <xsl:text>finska</xsl:text>
          </xsl:when>
          <xsl:when test="@xml:lang='lat'">
            <xsl:text>latin</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>annat</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>", WIDTH, 0)</xsl:text>
      </xsl:attribute>-->
      <xsl:attribute name="lang">
        <xsl:value-of select="@xml:lang"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
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
        <xsl:otherwise>
          <xsl:text>annat</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="tei:hi">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
    <!--<xsl:choose>
      <xsl:when test="@rend='raised'">
        <span style="vertical-align: 20%;">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <i>
          <xsl:apply-templates/>
        </i>
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>

  <xsl:template match="tei:pb">
    <xsl:choose>
      <xsl:when test="parent::tei:body or parent::tei:div">
        <p class="noIndent">
          <xsl:call-template name="att_pb_class"/>
          <xsl:call-template name="pb_text"/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="att_pb_class"/>
          <xsl:call-template name="pb_text"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
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

  <xsl:template match="tei:table">
    <table style="border-collapse:collapse">
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="tei:row">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="tei:add">
    <span style="vertical-align: 30%;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:del">
    <span style="text-decoration: line-through;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:cell">
    <td style="border:1px solid gray">
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template match="tei:ref">
    <a class="textreference">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text><xsl:value-of select="@target"/>
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
        <xsl:text>#</xsl:text><xsl:value-of select="@target"/>
      </xsl:attribute>
      <img src="images/image_symbol.gif"/>
    </a>
  </xsl:template>
  
  <xsl:template match="tei:figure">
    <xsl:choose>
      <xsl:when test="@type='pictogram'">
        <img class="symbol" src="images/symbol_pictogram.gif"/>
      </xsl:when>
      <xsl:when test="@type='illustration'">
        <img class="symbol" src="images/symbol_illustration.gif"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
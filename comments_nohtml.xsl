<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://seesharp.witchmastercreations.com )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">
  
  <xsl:include href="inc_common.xsl" />
  
  <xsl:param name="sectionId" />
  
  <xsl:template match="tei:teiHeader"/>

  <xsl:template match="tei:body">
    <xsl:choose>
      <xsl:when test="//tei:div[@type='comment']">
        <div class="container cont_comment">
          <xsl:apply-templates/>
          <xsl:call-template name="listEditorNotes"/>
          <xsl:call-template name="endSpace"/>
        </div>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="listEditorNotes">
    <xsl:choose>
      <xsl:when test="string-length($sectionId)&gt;0">
        <xsl:call-template name="printEditorNoteHeader">
          <xsl:with-param name="noteCount" select="count(//tei:div[@id=$sectionId]//tei:note[contains(@type, 'editor')])"/>
        </xsl:call-template>
        <xsl:for-each select="//tei:div[@id=$sectionId]//tei:note[contains(@type, 'editor')]">
          <xsl:call-template name="printEditorNote"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="printEditorNoteHeader">
          <xsl:with-param name="noteCount" select="count(//tei:body//tei:note[contains(@type, 'editor')])"/>
        </xsl:call-template>
        <xsl:for-each select="//tei:note[contains(@type, 'editor')]">
          <xsl:call-template name="printEditorNote"/>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <!--<xsl:for-each select="//tei:note">
      <xsl:if test="contains(@type, 'editor')">
        
      </xsl:if>
    </xsl:for-each>-->
  </xsl:template>
  
  <xsl:template name="printEditorNoteHeader">
    <xsl:param name="noteCount"/>
    <xsl:choose>
      <xsl:when test="$noteCount=1">
        <h3>Punktkommentar</h3>
      </xsl:when>
      <xsl:when test="$noteCount>1">
        <h3>Punktkommentarer</h3>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="printEditorNote">
    <p style="cursor:pointer;">
      <xsl:attribute name="class">
        <xsl:text>paragraphSpace noIndent commentScrollTarget </xsl:text>
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute >
      <xsl:apply-templates />
    </p>
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

  <xsl:template match="tei:opener">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:div">
    <xsl:choose>
      <xsl:when test="@type='comment'">
        <h3>Kommentar</h3>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="@type='bibl'">
        <h3>Bibliografi</h3>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="@type='background'">
        <div class="comment_background">
        <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lg">
    <p class="strofe">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:l">
    <xsl:apply-templates/>
    <br />
  </xsl:template>

  <xsl:template match="tei:address">
    <p style="font-style: italic;">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:dateline">
    <p style="text-align: right;">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <span style="background-color:#F8E3BC">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:persName">
    <span style="background-color:#F8E3BC">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="tei:p">
    <p>
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
    </p>
  </xsl:template>

  <!--<xsl:template match="tei:p">
    <p style="margin:0px;padding:0px;">
      <xsl:choose>
        <xsl:when test="parent::tei:postscript"/>
        <xsl:when test="@rend='noIndent'"/>
        <xsl:otherwise>&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:otherwise>
      </xsl:choose>
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
    </p>
  </xsl:template>-->

  <xsl:template match="tei:emph">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <xsl:template match="tei:hi">
    <xsl:choose>
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
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:note"/>

  <xsl:template match="tei:pb">
    <xsl:choose>
      <xsl:when test="parent::tei:body">
        <p>
          <strong>//</strong>
        </p>
      </xsl:when>
      <xsl:otherwise>&#160;<strong>//</strong>
      </xsl:otherwise>
    </xsl:choose>
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
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:del" />

  <xsl:template match="tei:cell">
    <td style="border:1px solid gray">
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template match="tei:xref">
    <a>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@type='introduction'">
            <xsl:text>xreference ref_introduction</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:value-of select="substring(@target, 3)"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

</xsl:stylesheet>
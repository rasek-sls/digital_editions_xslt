<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">

  <xsl:template match="tei:teiHeader"/>
  
  <xsl:param name="personId" />
  <xsl:param name="placeId" />

  <xsl:template match="tei:document">
    <p style="font-weight:bold;margin-top:1em;">
      <a>
        <xsl:variable name="itemId" select="substring(./tei:name, 0, string-length(./tei:name)-7)"/>
        <xsl:attribute name="href">
          <xsl:text>?p=texts&amp;bookId=</xsl:text>
          <xsl:value-of select="substring-before($itemId, '_')"/>
          <xsl:text>#itemId=</xsl:text>
          <xsl:value-of select="$itemId"/>
        </xsl:attribute>
        <!--<xsl:value-of select="./tei:hits/tei:hit/tei:document-title"/>-->
        <xsl:text>{</xsl:text>
        <xsl:value-of select="$itemId"/>
        <xsl:text>}</xsl:text>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="$itemId"/>
        <xsl:text>)</xsl:text>
      </a>
    </p>
    <xsl:apply-templates select="tei:hits"/>
  </xsl:template>

  <xsl:template match="tei:hits">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:hit">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:document-name">
  </xsl:template>
  
  <xsl:template match="tei:document-title">
  </xsl:template>
  
  <xsl:template match="tei:unique-div">
    <xsl:if test="string-length(@id)&gt;0">
      <p class="parHalfIndent">
        <a>
          <xsl:variable name="itemId" select="substring(../../../tei:name, 0, string-length(../../../tei:name)-7)"/>
          <xsl:attribute name="href">
            <xsl:text>?p=texts&amp;bookId=</xsl:text>
            <xsl:value-of select="substring-before($itemId, '_')"/>
            <xsl:text>#itemId=</xsl:text>
            <xsl:value-of select="$itemId"/>
            <xsl:text>&amp;sectionId=</xsl:text>
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </a>
      </p>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:document-meta">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="tei:text">
    <p class="parIndent">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:name">
    <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match="tei:para">
      <xsl:apply-templates/>
  </xsl:template>  

  <xsl:template match="tei:head">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:lg">
    <xsl:choose>
      <xsl:when test="ancestor::tei:note">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <p class="parIndent">
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:l">
    <xsl:apply-templates/>
    <xsl:if test="name(following-sibling::*[1]) = 'l'">
      <xsl:text> / </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:p">
    <p>
      <xsl:attribute name="class">
        <xsl:text>parIndent</xsl:text>
        <xsl:if test="ancestor::tei:editor">
          <xsl:text> p_editor</xsl:text>
        </xsl:if>
      </xsl:attribute>
	    <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="tei:note">
    <xsl:choose>
      <xsl:when test="@type='editor'">
        <span class="note_editor">&#160;<xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise>
        <span class="note_foot">&#160;<xsl:apply-templates/></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:persName">
    <xsl:choose>
      <xsl:when test="$personId=@corresp">
        <span class="highlightPerson"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:placeName">
    <xsl:choose>
      <xsl:when test="$placeId=@corresp">
        <span class="highlightPerson"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:sic"/>
  <xsl:template match="tei:orig"/>
  
  <!--<xsl:template match="tei:note"/>-->
  <xsl:template match="tei:anchor"/>
    
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">

  <xsl:template match="tei:hit">
    <h3>
      <xsl:apply-templates select="tei:document-name"/>
    </h3>
    <p>
      <xsl:apply-templates select="tei:document-title"/>
    </p>
    <p>
      <xsl:text>Score: </xsl:text>
      <xsl:value-of select="@score"/>
    </p>
    <xsl:apply-templates select="tei:document-summary"/>
  </xsl:template>

  <xsl:template match="tei:document-name">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:document-title">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:document-summary">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="span">
    <xsl:choose>
      <xsl:when test="@class='hi'">
        <b><xsl:apply-templates/></b>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  
  <!-- Hide certain elements -->
  <xsl:template match="tei:sic"/>
  <xsl:template match="tei:orig"/>
  <xsl:template match="tei:note"/>
  <xsl:template match="tei:anchor"/>
  
</xsl:stylesheet>
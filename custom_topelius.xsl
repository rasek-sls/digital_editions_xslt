<?xml version="1.0" encoding="utf-8"?>
<!--
This is a topelius custom xsl file
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

<xsl:template match="tei:subst">
    <xsl:call-template name="sofortSymbol"/>
    <xsl:choose>
      <xsl:when test="not(descendant::tei:del)">
        <span class="symbol_red">|</span><span>
          <xsl:attribute name="class">
            <xsl:text>substitution</xsl:text>
            <xsl:call-template name="mediumClass"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span><span class="symbol_red">|</span>
        <xsl:call-template name="mediumTooltip"/>
      </xsl:when>
      <xsl:otherwise>
        <span class="symbol_red">|</span><span>
          <xsl:attribute name="class">
            <xsl:call-template name="mediumClass"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span><span class="symbol_red">|</span>
        <xsl:call-template name="mediumTooltip"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:add">
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::tei:subst">
            <xsl:text>add_subst</xsl:text>
          </xsl:when>
          <xsl:when test="@reason='choice'">
            <xsl:text>add_choice</xsl:text>
          </xsl:when>
          <xsl:when test="@place='leftMargin' or @place='rightMargin' or @place='topMargin' or @place='botMargin'">
            <xsl:text>add_margin</xsl:text>
          </xsl:when>
          <xsl:when test="@place='sublinear'">
            <xsl:text>add_sublinear</xsl:text>
          </xsl:when>
          <xsl:when test="@place='inline'">
            <xsl:text>add_inline</xsl:text>
          </xsl:when>
          <xsl:when test="parent::tei:add and parent::tei:add[@place!='inline']">
            <xsl:text>add_in_add</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>add_over</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="mediumClass" />
      </xsl:attribute>
      <xsl:call-template name="handSymbol"/>
      <xsl:call-template name="sofortSymbol"/>
      <!--<xsl:call-template name="marginAnchorSymbol"/>-->
      <xsl:call-template name="marginAddSymbol"/>
      <xsl:choose>
        <xsl:when test="parent::tei:add and not(@rend)">
          <span class="symbol_red">&#92;&#92;</span><xsl:apply-templates/><span class="symbol_red">/</span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="marginAddSymbol"/>
    </span>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>
  
  <xsl:template match="tei:del">
    <xsl:call-template name="sofortSymbol"/>
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::tei:subst">
            <xsl:text>deletion_subst</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>deletion</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="mediumClass" />
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="parent::tei:del">
          <span class="symbol_red">[</span><xsl:apply-templates/><span class="symbol_red">]</span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>
 
</xsl:stylesheet>

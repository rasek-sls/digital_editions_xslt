<?xml version="1.0" encoding="utf-8"?>
<!--
This is a parland custom xsl file
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

<xsl:template match="tei:subst">
    <xsl:call-template name="sofortSymbol"/>
        <span class="tei_substitution_hps">
            <xsl:apply-templates/>
        </span>
  </xsl:template>

  <xsl:template match="tei:add">
    <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::tei:subst">
            <xsl:choose>
              <xsl:when test="ancestor::tei:p[@rend='noIdent']">
                <xsl:text>tei_add_subst_noindent_hps</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>tei_add_subst_hps</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="@reason='choice'">
            <xsl:text>tei_add_choice</xsl:text>
          </xsl:when>
          <xsl:when test="@place='leftMargin' or @place='rightMargin' or @place='topMargin' or @place='botMargin'">
            <xsl:text>tei_add_margin</xsl:text>
          </xsl:when>
          <xsl:when test="@place='sublinear'">
            <xsl:text>tei_add_sublinear</xsl:text>
          </xsl:when>
          <xsl:when test="@place='inline'">
            <xsl:text>tei_add_inline</xsl:text>
          </xsl:when>
          <xsl:when test="parent::tei:add and parent::tei:add[@place!='inline']">
            <xsl:text>tei_add_in_add</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>tei_add_over</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="mediumClass" />
        <xsl:if test="@hand">
          <xsl:text> editorial tooltiptrigger ttMs</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <xsl:call-template name="handSymbol"/>
      <xsl:call-template name="sofortSymbol"/>
      <!--<xsl:call-template name="marginAnchorSymbol"/>-->
      <xsl:call-template name="marginAddSymbol"/>
      <xsl:choose>
        <xsl:when test="parent::tei:add and not(@rend)">
          <span class="symbol_red">&#92;&#92;</span><xsl:value-of select="translate(.,' ','&#160;')"/>
          <span class="symbol_red">/</span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate(.,' ','&#160;')"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="marginAddSymbol"/>
    </span>
    <xsl:call-template name="mediumTooltip">
      <xsl:with-param name="hand">
        <xsl:value-of select="$attHand"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
 
 <xsl:template match="tei:del">
    <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
    <xsl:call-template name="sofortSymbol"/>
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::tei:subst">
            <xsl:text>tei_deletion_subst</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>tei_deletion</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@hand">
          <xsl:text> editorial tooltiptrigger ttMs</xsl:text>
        </xsl:if>
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
    <xsl:call-template name="mediumTooltip">
      <xsl:with-param name="hand">
        <xsl:value-of select="$attHand"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
 
</xsl:stylesheet>

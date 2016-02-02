<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei" xmlns:zte="http://www.topelius.fi">

  <xsl:include href="inc_common.xsl" />
  
  <xsl:template match="tei:teiHeader"/>
  
  <xsl:template match="tei:body">
    <div class="container cont_titlepage">
      <xsl:apply-templates/>
      <xsl:call-template name="listFootnotes" />
      <xsl:call-template name="endSpace"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:head">
    <h3>
    <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </h3>
  </xsl:template>
  
   <xsl:template match="tei:div">
    <xsl:choose>
      <xsl:when test="@type='comments'"/>
      <xsl:otherwise>
        <div>
          <xsl:if test="@id">
            <xsl:attribute name="id">
              <xsl:value-of select="@id"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:opener">
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:ref">
    <a>
      <xsl:attribute name="class">
         <xsl:text>reference</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="tei:lg">
    <p class="strofe">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:l">
    <xsl:if test="(@n mod 5) = 0">
      <span style="position:absolute;left:-12px;width:18px;color:#a9a49a;">
        <xsl:value-of select="@n"/>
      </span>
    </xsl:if>
    <xsl:if test="@rend='indent'">
      <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <br />
  </xsl:template>

  <xsl:template match="tei:address">
    <p style="font-style: italic;">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:dateline">
    <p style="margin-bottom: 1.0em;">
      <xsl:choose>
        <xsl:when test="@rend='italics'">
          <span style="font-style:italic">
            <xsl:apply-templates/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
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
    <span class="placeName">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:persName">
    <span class="person target15 hideTitle">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:p">
    <p>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!--<xsl:template match="tei:choice">
    <span class="choice">
        <xsl:choose>
          <xsl:when test="child::tei:sic">
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
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->

  <xsl:template match="tei:sic">
    <!--<span style="background-color:#EF8066">
      <xsl:apply-templates/>
    </span>-->
  </xsl:template>

  <xsl:template match="tei:corr">
    <span class="corr">
      <xsl:apply-templates/>
    </span>
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

  <!--<xsl:template match="tei:foreign">
    <span class="foreign">
      <xsl:attribute name="onmouseover">
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
      </xsl:attribute>
      <xsl:attribute name="lang">
        <xsl:value-of select="@xml:lang"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
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

  <xsl:template match="tei:pb">
    <xsl:choose>
      <xsl:when test="parent::tei:body or parent::tei:div">
        <p>
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
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template match="tei:figure">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:graphic">
    <img>
      <xsl:attribute name="src">
        <xsl:text>images/tei/</xsl:text>
        <xsl:value-of select="@url"/>
      </xsl:attribute>
    </img>
  </xsl:template>
  
</xsl:stylesheet>
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">

  <xsl:template match="tei:teiHeader"/>
  
  <xsl:param name="personId" />

  <xsl:template match="tei:doc">
    <p style="margin-top:2em;" class="searchHeader">
      <span class="expand toggleParentNext expanded">
        <img src="images/expand-minus.gif" />
      </span>
      <a style="font-weight:bold;">
        <!--<xsl:variable name="itemIdRemove">
          <xsl:call-template name="lastIndexOf">
            <xsl:with-param name="string" select="./tei:name" />
            <xsl:with-param name="char" select="'_'" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="itemId" select="substring(./tei:name, 0, string-length(./tei:name) - string-length($itemIdRemove))"/>-->
        <xsl:variable name="itemId" select="substring(./tei:name, 0, string-length(./tei:name)-7)"/>
        
        <xsl:attribute name="href">
          <xsl:text>?p=texts&amp;bookId=</xsl:text>
          <xsl:value-of select="substring-before($itemId, '_')"/>
          <xsl:text>#itemId=</xsl:text>
          <xsl:value-of select="$itemId"/>
          <!--<xsl:if test="contains(./tei:name, '-ch')">
            <xsl:text>&amp;sectionId=</xsl:text>
            <xsl:value-of select="tei:hits/tei:hit[1]/tei:unique-div/@id"/>
          </xsl:if>-->
        </xsl:attribute>
        
        
        <!--<xsl:value-of select="./tei:hits/tei:hit/tei:doc-title"/>-->
        <xsl:text>{</xsl:text>
        <xsl:value-of select="$itemId"/>
        <xsl:text>}</xsl:text>
        <!--<xsl:if test="contains(./tei:name, '-ch')">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="tei:hits/tei:hit[1]/tei:unique-div"/>
        </xsl:if>-->
        <xsl:text> (</xsl:text>
        <xsl:value-of select="$itemId"/>
        <!--<xsl:if test="contains(./tei:name, '-ch')">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="tei:hits/tei:hit[1]/tei:unique-div/@id"/>
        </xsl:if>-->
        <xsl:text>)</xsl:text>
      </a>
      <xsl:variable name="searchCount" select="tei:count"/>
      <xsl:text>, </xsl:text>
      <span style="font-style:italic;">
        <xsl:value-of select="$searchCount"/>
        <xsl:choose>
          <xsl:when test="$searchCount = '1'">
            <xsl:text> träff</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> träffar</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </span>
    </p>
    <div class="searchHits">
      <xsl:apply-templates select="tei:hits"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:count"/>

  <xsl:template match="tei:hits">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:hit">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:doc-name">
  </xsl:template>
  
  <xsl:template match="tei:doc-title">
  </xsl:template>

  <xsl:template match="tei:name-div">
  </xsl:template>

  <!--<xsl:template match="tei:unique-div"/>-->
  
  <xsl:template match="tei:unique-div">
    <xsl:if test="string-length(@id)&gt;0">
      <xsl:if test="(parent::tei:hit/preceding-sibling::tei:hit[1]/tei:unique-div/@id != @id) or (count(parent::tei:hit/preceding-sibling::tei:hit)&lt;1)">
        <p class="parHalfIndent searchHeader">
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
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>)</xsl:text>
          </a>
          <!--<span>
            <xsl:variable name="thisId" select="@id"/>
            <xsl:value-of select="count(ancestor::tei:hits/tei:hit/tei:unique-div[@id=$thisId])"/>
          </span>-->
        </p>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:doc-meta">
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
        <xsl:text>searchIndent</xsl:text>
        <xsl:if test="ancestor::tei:editor">
          <xsl:text> p_editor</xsl:text>
        </xsl:if>
      </xsl:attribute>
	    <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="p">
    <p>
      <xsl:attribute name="class">
        <xsl:text>searchRow</xsl:text>
        <xsl:if test="ancestor::tei:editor">
          <xsl:text> p_editor</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="parent::tei:sum/@xml:id"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:note" />
  <!--<xsl:template match="tei:note">
    <xsl:choose>
      <xsl:when test="@type='editor'">
        <span class="note_editor">&#160;<xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise>
        <span class="note_foot">&#160;<xsl:apply-templates/></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  
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

  <xsl:template match="tei:sum">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="span">
    <xsl:choose>
      <xsl:when test="@class='hi'">
        <span class="searchHi">
          <xsl:apply-templates/>
        </span>
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


  <!-- define a lastIndexOf named template -->
  <xsl:template name="lastIndexOf">
    <!-- declare that it takes two parameters 
	  - the string and the char -->
    <xsl:param name="string" />
    <xsl:param name="char" />
    <xsl:choose>
      <!-- if the string contains the character... -->
      <xsl:when test="contains($string, $char)">
        <!-- call the template recursively... -->
        <xsl:call-template name="lastIndexOf">
          <!-- with the string being the string after the character
                 -->
          <xsl:with-param name="string"
                          select="substring-after($string, $char)" />
          <!-- and the character being the same as before -->
          <xsl:with-param name="char" select="$char" />
        </xsl:call-template>
      </xsl:when>
      <!-- otherwise, return the value of the string -->
      <xsl:otherwise>
        <xsl:value-of select="$string" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
</xsl:stylesheet>
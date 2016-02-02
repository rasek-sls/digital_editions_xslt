<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei" xmlns:exist="http://exist.sourceforge.net/NS/exist">
  
  <xsl:template match="tei:teiHeader"/>
  
  <xsl:param name="personId" />
  <xsl:param name="placeId" />
  <xsl:param name="langId" />

  <xsl:key name="unique-doc" match="tei:ud" use="tei:ud-name"/>

  <!--<xsl:key name="document-by-filename" match="tei:ud" use="tei:ud-name" />
  <xsl:key name="document-by-bookid" match="tei:ud" use="substring-before(tei:ud-id, '_')" />-->

  <xsl:template match="/">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:doc">

    <xsl:if test="(tei:doc-name != preceding::tei:doc[1]/tei:doc-name or tei:unique-div != preceding::tei:doc[1]/tei:unique-div) or not(preceding::tei:doc)">
    
    <p style="margin-top:1em;padding-bottom:0px;" class="searchHeader">
      <!--<span class="expand toggleParentNext expanded">
      <img src="images/expand-minus.gif" />
    </span>-->

      <xsl:variable name="docName" select="./tei:doc-name"/>
      <!--<xsl:variable name="itemId" select="substring-before(./tei:item-id, ' ')"/>-->
      <!--<xsl:variable name="itemId" select="substring(./tei:doc-name, 0, string-length(./tei:doc-name)-7)"/>-->
      

      <a class="hidden">
        <xsl:attribute name="href">
          <xsl:text>?p=texts&amp;bookId=</xsl:text>
          <xsl:value-of select="substring-before($docName, '_')"/>
          

          <xsl:choose>
            <xsl:when test="contains($docName, '_inl')">
              <xsl:text>#posType=inl&amp;columns=[[|il|,-1],[|lt|,-1]]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>#itemId=</xsl:text>
              <xsl:choose>
                <xsl:when test="contains($docName, '_ms')">
                  <xsl:value-of select="./tei:item-id"/>
                  <xsl:variable name="msIdTmp" select="substring-after($docName, 'ms_')"/>
                  <xsl:variable name="msId" select="substring-before($msIdTmp, '.xml')"/>
                  <xsl:variable name="msIdNum" select="number($msId) * 2"/>
                  <!--<xsl:value-of select="substring($docName, 0, string-length($docName)-8)"/>-->
                  <xsl:text>&amp;posType=ms&amp;columns=[[|ti|,-1],[|lt|,-1],[|ms|,</xsl:text>
                  <xsl:value-of select="$msIdNum"/>
                  <xsl:text>]]</xsl:text>
                </xsl:when>
                <xsl:when test="contains($docName, '_com')">
                  <xsl:value-of select="./tei:item-id"/>
                  <!--<xsl:value-of select="substring($docName, 0, string-length($docName)-7)"/>-->
                  <xsl:text>&amp;posType=com&amp;columns=[[|ti|,-1],[|lt|,-1],[|ko|,-1]]</xsl:text>
                </xsl:when>
                <xsl:when test="contains($docName, '_var')">
                  <xsl:value-of select="./tei:item-id"/>
                  <xsl:variable name="varIdTmp" select="substring-after($docName, 'var_')"/>
                  <xsl:variable name="varId" select="substring-before($varIdTmp, '.xml')"/>
                  <xsl:text>&amp;posType=var&amp;columns=[[|ti|,-1],[|lt|,-1],[|va|,</xsl:text>
                  <xsl:value-of select="number($varId)-1"/>
                  <xsl:text>]]</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="./tei:item-id"/>
                  <!--<xsl:value-of select="substring($docName, 0, string-length($docName)-7)"/>-->
                  <xsl:text>&amp;posType=est</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
          
          <xsl:if test="normalize-space(tei:unique-div)!='' and tei:unique-div/@id">
            <xsl:text>&amp;sectionId=</xsl:text>
            <xsl:value-of select="tei:unique-div/@id"/>
          </xsl:if>

          <xsl:if test="normalize-space(tei:coll-id)!=''">
            <xsl:text>&amp;collectionId=</xsl:text>
            <xsl:value-of select="tei:coll-id"/>
          </xsl:if>
          
          <!--<xsl:if test="contains(./tei:name, '-ch')">
          <xsl:text>&amp;sectionId=</xsl:text>
          <xsl:value-of select="tei:hits/tei:hit[1]/tei:unique-div/@id"/>
        </xsl:if>-->
        </xsl:attribute>
        <xsl:text>&#160;</xsl:text>
      </a>

      <span style="font-weight:bold;">
        <!--<xsl:variable name="itemIdRemove">
        <xsl:call-template name="lastIndexOf">
          <xsl:with-param name="string" select="./tei:name" />
          <xsl:with-param name="char" select="'_'" />
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="itemId" select="substring(./tei:name, 0, string-length(./tei:name) - string-length($itemIdRemove))"/>-->

        <!--<xsl:value-of select="./tei:hits/tei:hit/tei:doc-title"/>-->
        <!--<xsl:text>{</xsl:text>
      <xsl:value-of select="$itemId"/>
      <xsl:text>}</xsl:text>-->
        <xsl:variable name="docTitle">
          <xsl:choose>
            <xsl:when test="string-length(tei:doc-title1)&gt;0">
              <xsl:value-of select="tei:doc-title1"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="./tei:item-id"/>
              <!--<xsl:value-of select="$itemId"/>-->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="contains($docName, '_ms')">
            <xsl:text>Manuskript: </xsl:text>
          </xsl:when>
          <xsl:when test="contains($docName, '_var')">
            <xsl:text>Variant: </xsl:text>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>

        <xsl:value-of select="$docTitle"/>
        
        <!--<xsl:if test="contains(./tei:name, '-ch')">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="tei:hits/tei:hit[1]/tei:unique-div"/>
      </xsl:if>-->
        <!--<xsl:text> (</xsl:text>
      <xsl:value-of select="$itemId"/>-->
        <!--<xsl:if test="contains(./tei:name, '-ch')">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="tei:hits/tei:hit[1]/tei:unique-div/@id"/>
      </xsl:if>-->
        <!--<xsl:text>)</xsl:text>-->
        
        <xsl:if test="normalize-space(tei:unique-div)!=''">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="tei:unique-div"/>
        </xsl:if>
        
      </span>

      <br/>
      <span class="searchMeta">
        <xsl:choose>
          <xsl:when test="contains($docName, '_inl')">
            <xsl:text>INLEDNING</xsl:text>
          </xsl:when>
          <xsl:when test="contains($docName, '_ms')">
            <xsl:text>MANUSKRIPT</xsl:text>
          </xsl:when>
          <xsl:when test="contains($docName, '_com')">
            <xsl:text>KOMMENTAR</xsl:text>
          </xsl:when>
          <xsl:when test="contains($docName, '_var')">
            <xsl:text>VARIANT</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>LÄSTEXT</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:variable name="uniqueDoc" select="key('unique-doc',$docName)"/>
        <xsl:variable name="genre" select="$uniqueDoc/tei:ud-genre"/>
        <xsl:variable name="date" select="$uniqueDoc/tei:ud-date"/>
        <xsl:choose>
          <xsl:when test="$genre='cg_childrensliterature'">
            <xsl:text>, Barnlitteratur</xsl:text>
          </xsl:when>
          <xsl:when test="$genre='cg_letter'">
            <xsl:text>, Brev</xsl:text>
          </xsl:when>
          <xsl:when test="$genre='cg_diary'">
            <xsl:text>, Dagböcker</xsl:text>
          </xsl:when>
          <xsl:when test="$genre='cg_nonfiction'">
            <xsl:text>, Historia och geografi</xsl:text>
          </xsl:when>
          <xsl:when test="$genre='cg_poem'">
            <xsl:text>, Lyrik</xsl:text>
          </xsl:when>
          <xsl:when test="$genre='cg_prose'">
            <xsl:text>, Prosa</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="normalize-space($date)!=''">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="$date"/>
        </xsl:if>
      </span> 
      
      <!--<xsl:variable name="searchCount" select="tei:count"/>
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
    </span>-->
    </p>

    </xsl:if>
    
    <div class="searchHits">
      <!--<xsl:apply-templates select="tei:unique-div"/>-->
      <xsl:apply-templates select="tei:sum"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:distinct-documents"/>

  <!--<xsl:template match="tei:distinct-documents">
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-filename',tei:ud-name)[1])]">
      <xsl:sort select="count(key('document-by-filename', tei:ud-name))" data-type="number" order="descending"/>
      <xsl:value-of select="tei:ud-name"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="count(key('document-by-filename', tei:ud-name))"/>
      <br/>
    </xsl:for-each>-->
    <!--<xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-bookid',tei:ud-name)[1])]">
      <xsl:sort select="count(key('document-by-filename', tei:ud-name))" data-type="number" order="descending"/>
      <xsl:value-of select="tei:ud-name"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="count(key('document-by-filename', tei:ud-name))"/>
      <br/>
    </xsl:for-each>-->
  <!--</xsl:template>-->
  
  <!--<xsl:template match="tei:ud"/>-->

  <xsl:template match="tei:count"/>

  <xsl:template match="tei:hits">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:hit">
    <xsl:apply-templates/>
  </xsl:template>

  
  
  <xsl:template match="tei:doc-name"/>
  
  <xsl:template match="tei:doc-title">
  </xsl:template>

  <xsl:template match="tei:name-div">
  </xsl:template>

  <xsl:template match="tei:unique-div"/>
  
  <!--<xsl:template match="tei:unique-div">
    <xsl:if test="string-length(@id)&gt;0">-->
      <!--<xsl:if test="(parent::tei:hit/preceding-sibling::tei:hit[1]/tei:unique-div/@id != @id) or (count(parent::tei:hit/preceding-sibling::tei:hit)&lt;1)">-->
        <!--<p class="parHalfIndent searchHeader">
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
          </a>-->
          <!--<span>
            <xsl:variable name="thisId" select="@id"/>
            <xsl:value-of select="count(ancestor::tei:hits/tei:hit/tei:unique-div[@id=$thisId])"/>
          </span>-->
        <!--</p>-->
      <!--</xsl:if>-->
    <!--</xsl:if>
  </xsl:template>-->
  
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
    <xsl:choose>
      <xsl:when test="ancestor::tei:sum">
        <p class="searchRow">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lg">
    <xsl:choose>
      <xsl:when test="ancestor::tei:note">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:attribute name="class">
            <xsl:text>searchRow</xsl:text>
            <xsl:if test="ancestor::tei:editor">
              <xsl:text> p_editor</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="parent::tei:sum/@xml:id">
              <xsl:attribute name="id">
                <xsl:value-of select="parent::tei:sum/@xml:id"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="parent::tei:sum/@id">
              <xsl:attribute name="id">
                <xsl:value-of select="parent::tei:sum/@id"/>
              </xsl:attribute>
            </xsl:when>
          </xsl:choose>

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

  <!--<xsl:template match="tei:p">
    <p>
      <xsl:attribute name="class">
        <xsl:text>searchIndent</xsl:text>
        <xsl:if test="ancestor::tei:editor">
          <xsl:text> p_editor</xsl:text>
        </xsl:if>
      </xsl:attribute>
	    <xsl:apply-templates/>
    </p>
  </xsl:template>-->
  <!--<xsl:template match="tei:textStart">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>-->

  <xsl:template match="p|tei:p|tei:sp|tei:list|tei:castList|tei:table">
    <xsl:call-template name="searchRow"/>
  </xsl:template>

  <xsl:template match="tei:note">
    <xsl:choose>
      <xsl:when test="parent::tei:sum">
        <xsl:call-template name="searchRow"/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
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
  
  <xsl:template name="searchRow">
    <p>
      <xsl:attribute name="class">
        <xsl:text>searchRow</xsl:text>
        <xsl:if test="ancestor::tei:editor">
          <xsl:text> p_editor</xsl:text>
        </xsl:if>
        <xsl:if test="tei:seg[@type='noteSection']">
          <xsl:text> </xsl:text>
          <xsl:value-of select="tei:seg[@type='noteSection']"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="descendant::exist:match[1]/ancestor::tei:note">
          <xsl:attribute name="id">
            <xsl:value-of select="descendant::exist:match[1]/ancestor::tei:note/@id"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="parent::tei:sum/@xml:id">
          <xsl:attribute name="id">
            <xsl:value-of select="parent::tei:sum/@xml:id"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="parent::tei:sum/@id">
          <xsl:attribute name="id">
            <xsl:value-of select="parent::tei:sum/@id"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="tei:seg">
    <xsl:choose>
      <xsl:when test="@type='noteSection'"/>
      <xsl:when test="@type='notePosition'"/>
      <xsl:when test="@type='noteLemma'">
        <i>
          <xsl:apply-templates/>
        </i>
        <xsl:text> – </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:persName|tei:rs">
    <xsl:choose>
      <xsl:when test="$personId=@corresp">
        <span class="highlightPerson searchHi">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose> 
  </xsl:template>

  <xsl:template match="tei:foreign">
    <xsl:choose>
      <xsl:when test="$langId=@xml:lang">
        <span class="highlightForeign searchHi">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <xsl:choose>
      <xsl:when test="$placeId=@corresp">
        <span class="highlightPlace searchHi">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:sum">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="exist:match">
    <span class="searchHi">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:del"/>

  <xsl:template match="tei:hi">
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
<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://seesharp.witchmastercreations.com )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei" xmlns:ns0="http://tei-c.org/TextComparator">

  <xsl:include href="inc_common.xsl" />

  <xsl:param name="bookId" />
  <xsl:param name="sectionId" />
  
  <xsl:strip-space elements="tei:choice"/>
  
  <xsl:template match="tei:teiHeader"/>
  
  <xsl:template match="tei:body">
    <!--<p>
      <i>
        <xsl:value-of select="/TEI.2/teiHeader/fileDesc/titleStmt/title"/>
      </i>
    </p>-->
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
    <xsl:choose>
      <xsl:when test="@rend='underline'">
        <p class="noIndent underline">
          <xsl:apply-templates/>
        </p>
        <p class="paragraphSpace" />
      </xsl:when>
      <xsl:otherwise>
        <h3>
          <xsl:if test="$bookId='4' or $bookId='5' or $bookId='15'">
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="@type">
                  <xsl:value-of select="@type"/>
                  <xsl:if test="name(following-sibling::*[1])!='head'">
                    <xsl:text> titleBottomMargin</xsl:text>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>shortstory</xsl:text>
                  <xsl:if test="name(preceding-sibling::*[1])='head'">
                    <xsl:text> titleTopMargin</xsl:text>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </h3>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:div">
    <xsl:choose>
      <xsl:when test="@type='comments'"/>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lg">
    <xsl:if test="name(preceding-sibling::*[1]) = 'p' or name(preceding-sibling::*[1]) = 'pb'">
      <p class="strofeSpacing" />
    </xsl:if>
    <p>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="$bookId='4' or $bookId='5' or $bookId='15'">
            <xsl:text>strofe strofePadding</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>strofe</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@xml:id">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@xml:id"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:if test="@ns0:cid">
        <xsl:attribute name="id">
          <xsl:value-of select="@ns0:cid"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="tei:xptr">
        <span class="var_margin">
          <xsl:choose>
            <xsl:when test="count(tei:xptr[@type='variant'])>3">
              <span class="extVariantsTrigger">
                <img src="images/icon_link_variant_big.png"/>
              </span>
              <span class="extVariants">
                <xsl:call-template name="extVariants"/>
              </span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="extVariants"/>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </xsl:if>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="tei:l">
    <xsl:if test="@rend='indent'">
      <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <br />
  </xsl:template>

  <xsl:template match="tei:p">
    <p>
      <xsl:call-template name="attRend">
        <xsl:with-param name="defaultClasses">
          <xsl:if test="@xml:id">
            <xsl:value-of select="@xml:id"/>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:if test="@rend='noIndent' or @n='1' or parent::tei:postscript">
            <xsl:text>noIndent </xsl:text>
          </xsl:if>
        </xsl:with-param>
      </xsl:call-template>
      <!--<xsl:if test="@rend='noIndent' or @n='1' or parent::tei:postscript">
        <xsl:attribute name="class">
          <xsl:text>noIndent</xsl:text>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:if test="@ns0:cid">
        <xsl:attribute name="id">
          <xsl:value-of select="@ns0:cid"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="tei:xptr">
        <span class="var_margin">
          <xsl:choose>
            <xsl:when test="count(tei:xptr[@type='variant'])>3">
              <span class="extVariantsTrigger">#</span>
              <span class="extVariants">
                <xsl:call-template name="extVariants"/>
              </span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="extVariants"/>
            </xsl:otherwise>
          </xsl:choose>
        </span>
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

  <xsl:template name="extVariants">
    <xsl:for-each select="tei:xptr[@type='variant']">
      <a class="xreference ref_variant tooltiptrigger ttRefVar">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@target"/>
        </xsl:attribute>
        <img src="images/icon_link_variant.png"/>
      </a>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tei:app">
      <span>
        <xsl:attribute name="class">
          <!--<xsl:choose>
            <xsl:when test="@type='sub'">
               <xsl:text>substantial </xsl:text>
            </xsl:when>
	          <xsl:when test="@type='int'">
               <xsl:text>interpunktion </xsl:text>
            </xsl:when>
	          <xsl:when test="@type='ide'">
               <xsl:text>identical </xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>ortographic </xsl:text>
            </xsl:otherwise>
          </xsl:choose>-->
          <xsl:text>lemma </xsl:text>
          <xsl:text>variantScrollTarget </xsl:text>
          <xsl:value-of select="@id" />
        </xsl:attribute>

        <xsl:attribute name="id">
          <xsl:value-of select="@id" />
        </xsl:attribute>
        
        <!--<xsl:attribute name="onmouseover">
          <xsl:text>Tip('</xsl:text>
          <xsl:for-each select="rdg">
            <xsl:value-of select="@wit" /><xsl:text>: </xsl:text><xsl:value-of select="." />
          </xsl:for-each>
          <xsl:text>')</xsl:text>
        </xsl:attribute>-->

        <!--<xsl:attribute name="onclick">
          <xsl:text>top.Highlight('</xsl:text>
          <xsl:value-of select="@id" />
          <xsl:text>')</xsl:text>
        </xsl:attribute>-->
        
        <xsl:apply-templates/>
      </span>
  </xsl:template>

  <xsl:template match="tei:anchor">
    <span class="anchor">
      <xsl:attribute name="class">
        <xsl:text>anchor anchorScrollTarget </xsl:text>
        <xsl:if test="@subtype='ide'">
          <xsl:text>ide </xsl:text>
        </xsl:if>
        <xsl:value-of select="@id" />
      </xsl:attribute>

      <!--<xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>-->
      
      <!--<xsl:attribute name="onclick">
          <xsl:text>top.Highlight('</xsl:text>
          <xsl:value-of select="@id" />
          <xsl:text>')</xsl:text>
        </xsl:attribute>-->

      <xsl:choose>
        <xsl:when test="@subtype='ide'">
          <xsl:choose>
            <xsl:when test="contains(@id, 'a')">
              <img src="images/ms_arrow_right_gray.png"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="images/ms_arrow_left_gray.png"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="contains(@id, 'a')">
              <img src="images/ms_arrow_right.png"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="images/ms_arrow_left.png"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      
    </span>
  </xsl:template>

  <xsl:template match="tei:seg">
    <xsl:text>&#8968;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#8969;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:rdg" />

  <xsl:template match="tei:lem">
    <xsl:choose>
      <xsl:when test="contains(@type, 'empty')"><span class="seg"><img src="images/squared_times.png"/></span></xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:choice">
    <xsl:apply-templates select="tei:sic"/>
  </xsl:template>

  <xsl:template match="tei:corr" />

  <xsl:template match="tei:sic" >
    <xsl:apply-templates/>
  </xsl:template>

  <!--<xsl:template match="tei:note">
    <xsl:if test="contains(@place, 'foot')">
      <span class="footnoteindicator">
        <xsl:attribute name="onmouseover">
          <xsl:text>Tip("</xsl:text>
          <xsl:value-of select="." />
          <xsl:text>")</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="@n" />
      </span>
    </xsl:if>
  </xsl:template>-->

  <xsl:template match="tei:pb" />

  <xsl:template match="tei:name">
    <xsl:apply-templates/>
  </xsl:template>

  <!--<xsl:template match="tei:hi">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
    *<xsl:choose>
      <xsl:when test="@rend='underline'">
        <u>
          <xsl:apply-templates/>
        </u>
      </xsl:when>
      <xsl:when test="@rend='expanded'">
        <span class="expanded">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test="@rend='italics'">
        <span class="italics">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <strong>
          <xsl:apply-templates/>
        </strong>
      </xsl:otherwise>
    </xsl:choose>*
  </xsl:template>-->
  
  <xsl:template match="tei:xptr">
    <xsl:choose>
      <xsl:when test="@type='variant' and (parent::tei:p or parent::tei:lg)" />
      <xsl:otherwise>
        <a>
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="@type='variant'">
                <xsl:text>xreference ref_variant var_margin tooltiptrigger ttRefVar</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <img src="images/icon_link_variant.png"/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:note">
    <xsl:if test="contains(@type, 'editor')">
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
          <xsl:apply-templates mode="tooltip"/>
        </span>
      </span>
    </xsl:if>
  </xsl:template>
    
</xsl:stylesheet>
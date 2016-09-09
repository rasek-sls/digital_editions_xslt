<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://swww.seesharp.fi )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">
  
  <xsl:include href="inc_ms.xsl"/>

  <xsl:param name="bookId" />
  
  <xsl:template match="tei:teiHeader"/>
  
  <xsl:template match="tei:body">
    <div class="container cont_manuscript">
      <!--<xsl:if test="//tei:add[contains(@place, 'Margin')]">
        <xsl:attribute name="class">
          <xsl:text>padded</xsl:text>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:apply-templates/>
      <xsl:call-template name="listFootnotes" />
      <xsl:call-template name="endSpace"/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:div">
    <!--<xsl:if test="@type='poem' and @part='y'">
      <p>
        <xsl:text>¬¬¬</xsl:text>
      </p>
    </xsl:if>-->
    <xsl:if test="@type='letterpart' and @part='f'">
      <p>&#160;</p>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:head">
    <xsl:choose>
      <xsl:when test="preceding-sibling::tei:delSpan">
        <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]"/>
          <xsl:otherwise>
            <xsl:call-template name="tei_head"/>
            <!--<h3>
              <xsl:call-template name="attRend"/>
              <xsl:apply-templates/>
            </h3>-->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="tei_head"/>
        <!--<h3>
          <xsl:call-template name="attRend"/>
          <xsl:apply-templates/>
        </h3>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:trailer">
    <p>
      <xsl:call-template name="attRend">
        <xsl:with-param name="defaultClasses">
          <xsl:text>small</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template name="tei_head">
    <xsl:choose>
      <xsl:when test="@type='letter'">
        <p class="noIndent topMargin bottomMargin">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:when test="@rend='underline'">
        <p class="noIndent underline bottomMargin">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <h3>
          <xsl:call-template name="attRend"/>
          <xsl:apply-templates/>
        </h3>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lg">
    <!--<p>
      <xsl:if test="@part='y'">
        <xsl:text>¬¬</xsl:text>
      </xsl:if>
      <xsl:call-template name="switchPosNumber"/>
      <xsl:apply-templates/>
    </p>-->
    <xsl:choose>
      <xsl:when test="preceding-sibling::tei:delSpan">
        <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]"/>
          <xsl:otherwise>
            <xsl:call-template name="tei_lg"/>
            <!--<p class="strofe">
              <xsl:call-template name="switchPosNumber"/>
              <xsl:apply-templates/>
            </p>-->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="tei_lg"/>
        <!--<p class="strofe">
          <xsl:call-template name="switchPosNumber"/>
          <xsl:apply-templates/>
        </p>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="tei_lg">
    <p>
      <xsl:attribute name="class">
        <xsl:text>strofe</xsl:text>
        <xsl:if test="@xml:id">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@xml:id"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:call-template name="switchPosNumber"/>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="tei:l">
    
    <!--<xsl:if test="@part='y'">
      <xsl:text>¬</xsl:text>
    </xsl:if>
    <xsl:call-template name="switchPosNumber"/>
    <xsl:choose>
      <xsl:when test="preceding-sibling::tei:delSpan">
        <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]">
            <span class="delSpan"><xsl:apply-templates/></span>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::tei:anchor]"/>
      <xsl:otherwise>
        <br />
      </xsl:otherwise>
    </xsl:choose>-->
    <xsl:choose>
      <xsl:when test="preceding-sibling::tei:delSpan">
        <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]"/>
          <xsl:otherwise>
            <xsl:call-template name="tei_l"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="tei_l"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="tei_l">
    <xsl:call-template name="switchPosNumber"/>
    <xsl:apply-templates/>
    <br/>
  </xsl:template>

  <xsl:template match="tei:p">
    <xsl:variable name="paragraphNumber">
      <xsl:number count="tei:p|tei:lg"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="preceding-sibling::tei:delSpan">
        <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]"/>
          <xsl:otherwise>
            <xsl:call-template name="tei_p">
              <xsl:with-param name="paragraphNumber" select="$paragraphNumber"/>
            </xsl:call-template>
            <!--<p><xsl:choose>
                <xsl:when test="$paragraphNumber='1' and $bookId='15'">
                  <xsl:call-template name="attRend">
                    <xsl:with-param name="defaultClasses">
                      <xsl:text>noIndent</xsl:text>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="@rend">
                  <xsl:call-template name="attRend"/>
                </xsl:when>
              </xsl:choose>
              <xsl:call-template name="switchPosNumber"/><xsl:apply-templates/></p>-->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="tei_p">
          <xsl:with-param name="paragraphNumber" select="$paragraphNumber"/>
        </xsl:call-template>
        <!--<p>
          <xsl:choose>
            <xsl:when test="$paragraphNumber='1' and $bookId='15'">
              <xsl:call-template name="attRend">
                <xsl:with-param name="defaultClasses">
                  <xsl:text>noIndent</xsl:text>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="@rend">
              <xsl:call-template name="attRend"/>
            </xsl:when>
          </xsl:choose>
          <xsl:call-template name="switchPosNumber"/>
          <xsl:apply-templates/>
        </p>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="tei_p">
    <xsl:param name="paragraphNumber"/>
    <p>
      <xsl:choose>
        <xsl:when test="($paragraphNumber='1' and $bookId='15') or parent::tei:postscript">
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:text>noIndent</xsl:text>
              <xsl:if test="@xml:id">
                <xsl:text> </xsl:text>
                <xsl:value-of select="@xml:id"/>
              </xsl:if>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="@rend">
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:if test="@xml:id">
                <xsl:value-of select="@xml:id"/>
              </xsl:if>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="@xml:id">
          <xsl:attribute name="class">
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:call-template name="switchPosNumber"/>
      <xsl:call-template name="placeIcon" />
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:choice">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:expan"/>

  <xsl:template match="tei:abbr">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:unclear">
    <xsl:if test="@reason!='overstrike' and @reason!='erased'">
    <span class="unclear tooltiptrigger ttMs">
      <!--<xsl:attribute name="onmouseover">
        <xsl:text>Tip("</xsl:text>
        <xsl:text>Svårläst</xsl:text>
        <xsl:call-template name="attReason"/>
        <xsl:text>", WIDTH, 0)</xsl:text>
      </xsl:attribute>-->
      <xsl:apply-templates/>
    </span>
    <span class="tooltip">
      <!--<xsl:text>Svårläst</xsl:text>-->
      <xsl:call-template name="attReasonUnclear"/>
    </span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:space">
    <span class="space tooltiptrigger ttMs">
      <!--<xsl:attribute name="onmouseover">
        <xsl:text>Tip("</xsl:text>
        <xsl:text>Tomrum</xsl:text>
        <xsl:choose>
          <xsl:when test="@extent and @unit">
            <xsl:text>: </xsl:text>
            <xsl:value-of select="@extent"/>
            <xsl:choose>
              <xsl:when test="@extent='1'">
                <xsl:choose>
                  <xsl:when test="@unit='letters'">
                    <xsl:text> bokstav</xsl:text>
                  </xsl:when>
                  <xsl:when test="@unit='words'">
                    <xsl:text> ord</xsl:text>
                  </xsl:when>
                  <xsl:when test="@unit='lines'">
                    <xsl:text> rad</xsl:text>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="@unit='letters'">
                    <xsl:text> bokstäver</xsl:text>
                  </xsl:when>
                  <xsl:when test="@unit='words'">
                    <xsl:text> ord</xsl:text>
                  </xsl:when>
                  <xsl:when test="@unit='lines'">
                    <xsl:text> rader</xsl:text>
                  </xsl:when>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
        <xsl:text>", WIDTH, 0)</xsl:text>
      </xsl:attribute>-->
      <xsl:call-template name="spaceText"/>
      <!--<xsl:text>[tomrum]</xsl:text>-->
      <!--<xsl:choose>
        <xsl:when test="@extent">
          <xsl:call-template name="printStrings">
            <xsl:with-param name="i">
                <xsl:value-of select="1"/>
            </xsl:with-param>
            <xsl:with-param name="count">
                <xsl:value-of select="@extent"/>
            </xsl:with-param>
            <xsl:with-param name="toPrint">
              <xsl:choose>
                <xsl:when test="@unit='words'">
                  <xsl:text>|...|</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='lines'">
                  <xsl:text>|//|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>|-|</xsl:text>
        </xsl:otherwise>
      </xsl:choose>-->
    </span>
    <span class="tooltip">
      <xsl:call-template name="spaceTooltipText"/>
      <!--<xsl:text>Tomrum</xsl:text>
      <xsl:choose>
        <xsl:when test="@extent and @unit">
          <xsl:text>: </xsl:text>
          <xsl:value-of select="@extent"/>
          <xsl:choose>
            <xsl:when test="@extent='1'">
              <xsl:choose>
                <xsl:when test="@unit='letters'">
                  <xsl:text> bokstav</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='words'">
                  <xsl:text> ord</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='lines'">
                  <xsl:text> rad</xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="@unit='letters'">
                  <xsl:text> bokstäver</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='words'">
                  <xsl:text> ord</xsl:text>
                </xsl:when>
                <xsl:when test="@unit='lines'">
                  <xsl:text> rader</xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>-->
    </span>
  </xsl:template>
  
  <xsl:template match="tei:seg">
    <xsl:choose>
      <xsl:when test="@type='alt'">
        <xsl:apply-templates select="tei:add[@reason='choice']"/>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
                <xsl:text>segment</xsl:text>
          </xsl:attribute>
          <xsl:call-template name="placeIcon" />
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:subst">
    <!--<span class="symbol_red">|</span><span class="substitution"><xsl:apply-templates/></span><span class="symbol_red">|</span>-->
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:add">
    <!--<span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::tei:subst">
            <xsl:text>add_subst</xsl:text>
          </xsl:when>
          <xsl:when test="@reason='choice'">
            <xsl:text>add_choice</xsl:text>
          </xsl:when>
          <xsl:when test="@place='leftMargin' or @place='rightMargin' or @place='topMargin' or @place='bottomMargin'">
            <xsl:text>add_margin</xsl:text>
          </xsl:when>
          <xsl:when test="@place='sublinear'">
            <xsl:text>add_sublinear</xsl:text>
          </xsl:when>
          <xsl:when test="@place='inline'">
            <xsl:text>add_inline</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>add_over</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@place='leftMargin'">
          <img src="images/ms_arrow_left.png"/>
        </xsl:when>
        <xsl:when test="@place='rightMargin'">
          <img src="images/ms_arrow_right.png"/>
        </xsl:when>
        <xsl:when test="@place='topMargin'">
          <img src="images/ms_arrow_up.png"/>
        </xsl:when>
        <xsl:when test="@place='bottomMargin'">
          <img src="images/ms_arrow_down.png"/>
        </xsl:when>
      </xsl:choose>
      <xsl:apply-templates/>
    </span>-->
        <xsl:apply-templates/>
  </xsl:template>
  
  <!--<xsl:template match="tei:addSpan">
    <img src="images/addspan_from.png"/>
  </xsl:template>-->
  <xsl:template match="tei:addSpan"/>
  
  <!--<xsl:template match="tei:anchor">
    <xsl:choose>
    <xsl:when test="contains(@id, 'add')">
      <img src="images/addspan_to.png"/>
    </xsl:when>
    <xsl:when test="contains(@id, 'del')">
      <img src="images/delspan_to.png"/>
    </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::tei:anchor]"/>
      <xsl:otherwise>
        <br/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  <xsl:template match="tei:anchor"/>

  <xsl:template match="tei:del">
    <!--<span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="parent::tei:subst">
            <xsl:text>deletion_subst</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>deletion</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>-->
    <xsl:choose>
      <xsl:when test="ancestor::tei:restore">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
  
  <!--<xsl:template match="tei:delSpan">
    <img src="images/delspan_from.png"/>
  </xsl:template>-->
  <xsl:template match="tei:delSpan"/>
  
  <!--<xsl:template match="tei:restore">
    <span class="restore">
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->
  <xsl:template match="tei:restore"/>

  <xsl:template match="tei:switchPos">
    <xsl:choose>
      <xsl:when test="child::tei:lg">
        <xsl:for-each select="child::tei:lg">
          <xsl:sort select="@n" data-type="number"/>
          <p class="strofe">
            <xsl:apply-templates />
          </p>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="child::tei:l">
        <xsl:for-each select="child::tei:l">
          <xsl:sort select="@n" data-type="number"/>
          <xsl:choose>
            <xsl:when test="preceding-sibling::tei:delSpan">
              <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
              <xsl:choose>
                <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]"/>
                <xsl:otherwise>
                  <xsl:apply-templates/>
                  <br/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates/>
              <br/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="child::tei:item">
        <xsl:variable name="countItems" select="count(child::tei:item)" />
        <xsl:for-each select="child::tei:item">
          <xsl:sort select="@n" data-type="number"/>
          <xsl:apply-templates />
          <xsl:if test="position() != $countItems">
            <xsl:text> </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:item">
    <xsl:choose>
      <xsl:when test="ancestor::tei:switchPos">
        <xsl:call-template name="switchPosNumber"/>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="ancestor::tei:p">
        <xsl:if test="not(preceding-sibling::tei:item)">
          <br/>
        </xsl:if>
        <xsl:apply-templates/>
        <br/>
      </xsl:when>
      <xsl:otherwise>
        <p class="l">
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  
  <xsl:template name="switchPosNumber">
    <xsl:if test="@n and parent::tei:switchPos">
      <span>
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="parent::tei:switchPos[@type='unnumbered']">
              <xsl:text>switchpos_nonumber</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>switchpos_nonumber</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="@n"/>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:emph">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:hi">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:choice">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:orig">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:reg">
    <xsl:choose>
      <xsl:when test="parent::tei:choice"/>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="printStrings">
   <xsl:param name="i"/>
   <xsl:param name="count"/>
   <xsl:param name="toPrint"/>
   <!--begin_: Line_by_Line_Output -->
   <xsl:if test="$i &lt;= $count">
      <xsl:value-of select="$toPrint"/>
   </xsl:if>
   <!--begin_: RepeatTheLoopUntilFinished-->
   <xsl:if test="$i &lt;= $count">
      <xsl:call-template name="printStrings">
          <xsl:with-param name="i">
              <xsl:value-of select="$i + 1"/>
          </xsl:with-param>
          <xsl:with-param name="count">
              <xsl:value-of select="$count"/>
          </xsl:with-param>
        <xsl:with-param name="toPrint">
              <xsl:value-of select="$toPrint"/>
          </xsl:with-param>
      </xsl:call-template>
   </xsl:if>
  </xsl:template>

    
</xsl:stylesheet>
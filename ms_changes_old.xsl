<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://swww.seesharp.fi )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">

  <xsl:include href="inc_common.xsl" />

  <xsl:param name="bookId" />

  <xsl:template match="tei:teiHeader"/>
  
  <xsl:template match="tei:body">
    <div>
      <xsl:attribute name="class">
        <!--<xsl:choose>
          <xsl:when test="//tei:add[contains(@place, 'Margin')]">
            <xsl:text>container cont_manuscript padded</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>cont_manuscript</xsl:text>
          </xsl:otherwise>
        </xsl:choose>-->
        <xsl:text>container cont_manuscript</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:call-template name="listFootnotes" />
      <xsl:call-template name="endSpace"/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:div">
    <xsl:if test="@type='poem' and @part='y'">
      <p class="noIndent">
        <span class="symbol_red">[Oavslutat manuskript]</span>
      </p>
    </xsl:if>
    <xsl:if test="@type='letterpart' and @part='f'">
      <p>&#160;</p>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:head">
    <xsl:choose>
      <xsl:when test="@rend='letter'">
        <p class="noIndent underline topMargin bottomMargin">
          <xsl:call-template name="addSpanStart"/>
          <xsl:call-template name="delSpan"/>
          <xsl:call-template name="addSpanEnd"/>
        </p>
      </xsl:when>
      <xsl:when test="@rend='underline'">
        <p class="noIndent underline bottomMargin">
          <xsl:call-template name="addSpanStart"/>
          <xsl:call-template name="delSpan"/>
          <xsl:call-template name="addSpanEnd"/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <h3>
          <xsl:call-template name="attRend"/>
          <xsl:call-template name="addSpanStart"/>
          <xsl:call-template name="delSpan"/>
          <xsl:call-template name="addSpanEnd"/>
        </h3>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lg">
    <p class="strofe">
      <xsl:call-template name="switchPosNumber"/>
      <xsl:apply-templates/>
      <xsl:if test="@part='y'">
        <span class="symbol_red">...</span><br/>
      </xsl:if>
    </p>
  </xsl:template>
  
  <xsl:template match="tei:l">
    
    <xsl:call-template name="switchPosNumber"/>
    
    <!--<xsl:choose>
      <xsl:when test="preceding-sibling::tei:delSpan">
        <xsl:variable name="delSpanId" select="substring(preceding-sibling::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$delSpanId]">
            <xsl:variable name="insideDelSpan" select="1"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="insideDelSpan" select="0"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="insideDelSpan" select="0"/>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:choose>
      <xsl:when test="preceding-sibling::tei:addSpan">
        <xsl:variable name="addSpanId" select="substring(preceding-sibling::tei:addSpan[1]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following-sibling::tei:anchor[@id=$addSpanId]">
            <xsl:variable name="insideAddSpan" select="1"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="insideAddSpan" select="0"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="insideAddSpan" select="0"/>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:choose>
      <xsl:when test="$insideAddSpan='1' and $insideDelSpan='1'">
      
      </xsl:when>
    </xsl:choose>-->
    
  	<xsl:call-template name="addSpanStart"/>
    <xsl:call-template name="delSpan"/>
    <xsl:call-template name="addSpanEnd"/>
    
    <xsl:if test="@part='y'">
      <xsl:text> </xsl:text>
      <!--<span class="symbol_red" onmouseover="Tip('Ofullständig versrad')">...</span>-->
      <span class="symbol_red tooltiptrigger ttMs">...</span>
      <span class="tooltip">Ofullständig versrad</span>
    </xsl:if>
    
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::tei:anchor]"/>
      <xsl:otherwise>
        <br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:p">
    <xsl:variable name="paragraphNumber">
      <xsl:number count="tei:p|tei:lg"/>
    </xsl:variable>
    <p>
      <xsl:choose>
        <xsl:when test="($paragraphNumber='1' and $bookId='15') or parent::tei:postscript">
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
	    <xsl:call-template name="addSpanStart"/>
      <xsl:call-template name="delSpan"/>
      <xsl:call-template name="addSpanEnd"/>
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
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@reason='overstrike'">
            <xsl:text>unclear deletion tooltiptrigger ttMs</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>unclear tooltiptrigger ttMs</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <!--<xsl:attribute name="onmouseover">
        <xsl:text>Tip("</xsl:text>
        <xsl:text>Svårläst</xsl:text>
        <xsl:call-template name="attReason"/>
        <xsl:text>", WIDTH, 0)</xsl:text>
      </xsl:attribute>-->
      <xsl:apply-templates/>
    </span>
    <span class="tooltip">
      <xsl:text>Svårläst</xsl:text>
      <xsl:call-template name="attReason"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:supplied">
    <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
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
      <xsl:text>[tomrum]</xsl:text>
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
    </span>
  </xsl:template>
  
  <xsl:template match="tei:seg">
    <span>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@type='alt'">
            <xsl:text>alternative</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>segment</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:subst">
    <xsl:call-template name="sofortSymbol"/>
    <xsl:choose>
      <xsl:when test="not(descendant::tei:del)">
        <span class="symbol_red">|</span><span class="substitution"><xsl:apply-templates/></span><span class="symbol_red">|</span>
      </xsl:when>
      <xsl:otherwise>
        <span class="symbol_red">|</span><xsl:apply-templates/><span class="symbol_red">|</span>
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
      </xsl:attribute>
      <xsl:call-template name="sofortSymbol"/>
      <xsl:call-template name="marginAnchorSymbol"/>
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
  </xsl:template>

  <xsl:template name="marginAnchorSymbol">
    <xsl:if test="@place='leftMargin' or @place='rightMargin' or @place='topMargin' or @place='botMargin'">
      <xsl:choose>
        <xsl:when test="@type='noAnchor'" />
        <xsl:otherwise>
          <img src="images/anchor.png"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="marginAddSymbol">
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
      <xsl:when test="@place='botMargin'">
        <img src="images/ms_arrow_down.png"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="sofortSymbol">
    <xsl:if test="contains(@type, 'immediate')">
      <span class="immediate_symbol"><img src="images/esh.png" /></span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:addSpan">
    <xsl:call-template name="sofortSymbol"/>
    <!--<img src="images/addspan_from.png"/>-->
    <xsl:if test="contains(@place, 'Margin')">
      <xsl:call-template name="marginAnchorSymbol"/>
      <xsl:call-template name="marginAddSymbol"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:anchor">
    <xsl:variable name="anchorId" select="concat('#',@id)"/>
    <xsl:choose>
      <xsl:when test="//tei:addSpan[@spanTo=$anchorId]/@place='rightMargin'">
        <img src="images/ms_arrow_right.png"/>
      </xsl:when>
      <xsl:when test="//tei:addSpan[@spanTo=$anchorId]/@place='leftMargin'">
        <img src="images/ms_arrow_left.png"/>
      </xsl:when>
      <xsl:when test="//tei:addSpan[@spanTo=$anchorId]/@place='topMargin'">
        <img src="images/ms_arrow_up.png"/>
      </xsl:when>
      <xsl:when test="//tei:addSpan[@spanTo=$anchorId]/@place='botMargin'">
        <img src="images/ms_arrow_down.png"/>
      </xsl:when>
    </xsl:choose>
    <!--<xsl:choose>
    <xsl:when test="contains(@id, 'add')">
      <img src="images/addspan_to.png"/>
    </xsl:when>
    <xsl:when test="contains(@id, 'del')">
      <img src="images/delspan_to.png"/>
    </xsl:when>
    </xsl:choose>--> 
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::tei:anchor]"/>
      <xsl:when test="contains(@id, 'del') or contains(@id, 'add')">
        <br/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
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
  </xsl:template>
  
  <xsl:template match="tei:delSpan">
    <xsl:call-template name="sofortSymbol"/>
    <!--<img src="images/delspan_from.png"/>-->
  </xsl:template>
  
  <xsl:template match="tei:restore">
    <xsl:call-template name="sofortSymbol"/>
    <span class="restore">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:switchPos">
    <!--<span style="background-color: #BBBBBB;">
      <xsl:apply-templates/>
    </span>-->
    <xsl:call-template name="sofortSymbol"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:item">
    <xsl:choose>
      <xsl:when test="parent::tei:switchPos">
        <xsl:call-template name="switchPosNumber"/>
        <xsl:choose>
          <xsl:when test="@type='between'">
            <xsl:apply-templates/>
          </xsl:when>
          <xsl:otherwise>
            <span class="symbol_red">|</span>
            <xsl:apply-templates/>
            <span class="symbol_red">|</span>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="following-sibling::*">
            <p class="l">
              <xsl:apply-templates/>
            </p>
          </xsl:when>
          <xsl:otherwise>
            <p class="l">
              <xsl:apply-templates/>
            </p>
          </xsl:otherwise>
        </xsl:choose>
        <!--<xsl:if test="following-sibling::*">
          <br/>
        </xsl:if>-->
      </xsl:otherwise>
    </xsl:choose>
    
    
  </xsl:template>
  
  <xsl:template name="switchPosNumber">
    <xsl:if test="@n and parent::tei:switchPos">
      <xsl:choose>
        <xsl:when test="@type='between'"/>
        <xsl:otherwise>
          <span>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="parent::tei:switchPos[@type='unnumbered']">
                  <xsl:text>switchpos_nonumber</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>switchpos_number</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="@n"/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:emph">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
    <!--<i>
      <xsl:apply-templates/>
    </i>-->
  </xsl:template>

  <xsl:template match="tei:hi">
    <span>
      <xsl:call-template name="attRend"/>
      <xsl:apply-templates/>
    </span>
    <!--<xsl:choose>
      <xsl:when test="@rend='underline'">
        <u>
          <xsl:apply-templates/>
        </u>
      </xsl:when>
      <xsl:otherwise>
        <strong>
          <xsl:apply-templates/>
        </strong>
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>
  
  <xsl:template name="addSpanStart">
    <xsl:choose>
      <xsl:when test="preceding::tei:addSpan">
        <xsl:variable name="addSpanId1" select="substring(preceding::tei:addSpan[1]/@spanTo, 2)" />
        <xsl:variable name="addSpanId2" select="substring(preceding::tei:addSpan[2]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following::tei:anchor[@id=$addSpanId1] or following::tei:anchor[@id=$addSpanId2]">
            <xsl:variable name="test">&lt;span class=addSpan&gt;</xsl:variable>
            <xsl:value-of select="$test" disable-output-escaping="yes"/>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="addSpanEnd">
    <xsl:choose>
      <xsl:when test="preceding::tei:addSpan">
        <xsl:variable name="addSpanId1" select="substring(preceding::tei:addSpan[1]/@spanTo, 2)" />
        <xsl:variable name="addSpanId2" select="substring(preceding::tei:addSpan[2]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following::tei:anchor[@id=$addSpanId1] or following::tei:anchor[@id=$addSpanId2]">
            <xsl:variable name="test">&lt;/span&gt;</xsl:variable>
            <xsl:value-of select="$test" disable-output-escaping="yes"/>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="delSpan">
    <xsl:choose>
      <xsl:when test="preceding::tei:delSpan">
        <xsl:variable name="delSpanId1" select="substring(preceding::tei:delSpan[1]/@spanTo, 2)" />
        <xsl:variable name="delSpanId2" select="substring(preceding::tei:delSpan[2]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following::tei:anchor[@id=$delSpanId1]">
            <xsl:choose>
              <xsl:when test="preceding::tei:delSpan[1]/@rend = 'strikethrough'">
                <span class="deletion"><xsl:apply-templates/></span>
              </xsl:when>
              <xsl:otherwise>
                <span class="delSpan"><xsl:apply-templates/></span>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="following::tei:anchor[@id=$delSpanId2]">
            <xsl:choose>
              <xsl:when test="preceding::tei:delSpan[2]/@rend = 'strikethrough'">
                <span class="deletion"><xsl:apply-templates/></span>
              </xsl:when>
              <xsl:otherwise>
                <span class="delSpan"><xsl:apply-templates/></span>
              </xsl:otherwise>
            </xsl:choose>
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
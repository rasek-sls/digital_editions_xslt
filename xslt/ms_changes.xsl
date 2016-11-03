<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://swww.seesharp.fi )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:include href="custom.xsl"/>

  <xsl:include href="inc_ms.xsl"/>

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
        <span class="symbol_red">[oavslutat manuskript]</span>
      </p>
    </xsl:if>
    <xsl:if test="@type='letterpart' and @part='f'">
      <p>&#160;</p>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:lg">
    <p>
      <xsl:attribute name="class">
        <xsl:text>strofe</xsl:text>
        <xsl:if test="parent::tei:switchPos[@medium]">
          <xsl:text> medium tooltiptrigger ttMs</xsl:text>
        </xsl:if>
        <xsl:if test="@xml:id">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@xml:id"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:call-template name="switchPosNumber"/>
      <xsl:apply-templates/>
      <xsl:if test="@part='y'">
        <span class="symbol_red">...</span><br/>
      </xsl:if>
    </p>
    <xsl:if test="parent::tei:switchPos[@medium]">
      <span class="tooltip">
        <xsl:call-template name="inks">
          <xsl:with-param name="ink" select="parent::tei:switchPos/@medium"/>
        </xsl:call-template>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:l">

    <span>
      <xsl:if test="contains(following-sibling::*[1][self::tei:addSpan]/@reason, 'choice')">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="contains(following-sibling::*[4][self::tei:addSpan]/@reason, 'choice')">
              <xsl:text>tei_l_choice_3</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>tei_l_choice_master</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="contains(following-sibling::*[1][self::tei:anchor]/@id, 'cho')">
        <xsl:if test="contains(following-sibling::*[2][self::tei:addSpan]/@reason, 'choice')">
        <xsl:attribute name="class">
          <xsl:text>tei_l_choice_3</xsl:text>
        </xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:if test="contains(following-sibling::*[1][self::tei:anchor]/@id, 'del')">
        <xsl:if test="contains(following-sibling::*[2][self::tei:addSpan]/@reason, 'choice')">
          <xsl:attribute name="class">
            <xsl:text>tei_l_choice_master</xsl:text>
          </xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:if test="parent::tei:switchPos[@medium]">
        <xsl:attribute name="class">
          <xsl:text> medium tooltiptrigger ttMs</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@rend='indent' or @rend='center'">
        <xsl:attribute name="class">
          <xsl:text>tei_indent</xsl:text>
        </xsl:attribute>
      </xsl:if>
    
      <xsl:call-template name="switchPosNumber"/>

      <xsl:call-template name="addSpanStart"/>
      <xsl:call-template name="delSpan"/>
      <xsl:call-template name="addSpanEnd"/>
    </span>
    <xsl:if test="parent::tei:switchPos[@medium]">
      <span class="tooltip">
        <xsl:call-template name="inks">
          <xsl:with-param name="ink" select="parent::tei:switchPos/@medium"/>
        </xsl:call-template>
      </span>
    </xsl:if>

    <xsl:if test="@part='y'">
      <xsl:text> </xsl:text>
      <!--<span class="symbol_red" onmouseover="Tip('Ofullständig versrad')">...</span>-->
      <span class="symbol_red tooltiptrigger ttMs">...</span>
      <span class="tooltip">ofullständig versrad</span>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="contains(following-sibling::*[1][self::tei:addSpan]/@reason, 'choice')"/>
      <xsl:when test="following-sibling::*[1][self::tei:anchor]"/>
      <xsl:otherwise>
        <br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:lb">
    <xsl:choose>
      <xsl:when test="ancestor::tei:p or ancestor::tei:head or ancestor::tei:note or ancestor::tei:opener or ancestor::tei:closer">
        <br />
      </xsl:when>
      <xsl:when test="ancestor::tei:l">
        <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
      </xsl:when>
      <xsl:otherwise>
        <p>&#160;</p>
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
              <xsl:if test="parent::tei:switchPos[@medium]">
                <xsl:text> medium tooltiptrigger ttMs</xsl:text>
              </xsl:if>
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
              <xsl:if test="parent::tei:switchPos[@medium]">
                <xsl:text>medium</xsl:text>
              </xsl:if>
              <xsl:if test="@xml:id">
                <xsl:text> </xsl:text>
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
	    <xsl:call-template name="addSpanStart"/>
      <xsl:call-template name="delSpan"/>
      <xsl:call-template name="addSpanEnd"/>
    </p>
    <xsl:if test="parent::tei:switchPos[@medium]">
      <span class="tooltip">
        <xsl:call-template name="inks">
          <xsl:with-param name="ink" select="parent::tei:switchPos/@medium"/>
        </xsl:call-template>
      </span>
    </xsl:if>
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
        <xsl:call-template name="mediumClass"/>
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
      <!--<xsl:text>Svårläst</xsl:text>-->
      <xsl:call-template name="attReasonUnclear"/>
      <xsl:if test="@medium">
        <br/>
        <xsl:call-template name="inks">
          <xsl:with-param name="ink" select="@medium"/>
        </xsl:call-template>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="tei:supplied">
    <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:space">
    <span class="space tooltiptrigger ttMs">
      <xsl:call-template name="spaceText"/>
      <!--<xsl:text>[tomrum]</xsl:text>-->
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
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_subst_table</xsl:text>
            <xsl:if test="ancestor::tei:p[@rend='noIndent'] or ancestor::tei:l or ancestor::tei:head">
              <xsl:text>_noIndent</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_tbody</xsl:text>
            </xsl:attribute>
            <span>
              <xsl:attribute name="class">
                <xsl:text>tei_tr</xsl:text>
              </xsl:attribute>
              <span>
                <xsl:attribute name="class">
                  <xsl:text>tei_td_del</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates mode="notAdd" />
              </span>
            </span>
            <xsl:apply-templates select="child::tei:add[@reason='choice']" />
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@type='split'">
            <span>
              <xsl:attribute name="class">
                <xsl:text>seg</xsl:text>
              </xsl:attribute>
              <img src="images/split.png" />
              <xsl:apply-templates />
            </span>
          </xsl:when>
          <xsl:when test="@type='join'">
            <span>
              <xsl:attribute name="class">
                <xsl:text>seg</xsl:text>
              </xsl:attribute>
              <img src="images/join.png" />
              <xsl:apply-templates />
            </span>
          </xsl:when>
          <xsl:otherwise>
            <span>
              <xsl:attribute name="class">
                <xsl:text>segment</xsl:text>
              </xsl:attribute>
              <xsl:call-template name="placeIcon" />
              <xsl:apply-templates />
            </span>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:add[@reason='choice']" mode="notAdd"/>
  

  <xsl:template match="tei:del" mode="notAdd">
    <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
    <xsl:variable name="medium" select="@medium" />
    <xsl:choose>
      <xsl:when test="@medium">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_deletion_medium_wrapper</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_deletion_editorial tooltiptrigger ttMs</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates />
          </span>
          <xsl:call-template name="mediumTooltip">
            <xsl:with-param name="hand">
              <xsl:value-of select="$attHand" />
            </xsl:with-param>
            <xsl:with-param name="medium">
              <xsl:value-of select="$medium" />
            </xsl:with-param>
          </xsl:call-template>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:text>deletion</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:handShift">
    <xsl:choose>
      <xsl:when test="ancestor::tei:p or ancestor::tei:opener or ancestor::tei:closer or ancestor::tei:l">
        <xsl:call-template name="handSymbol" />
      </xsl:when>
      <xsl:otherwise>
        <p class="noIndent">
          <xsl:call-template name="handSymbol" />
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="handSymbol">
    <xsl:if test="@hand or @new">
      <img src="images/hand.png" class="tooltiptrigger ttMs" />
      <span class="tooltip">
        <xsl:variable name="handId">
          <xsl:choose>
            <xsl:when test="@new">
              <xsl:value-of select="substring(@new,2)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring(@hand,2)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!--<xsl:value-of select="$handId"/>-->
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:handNotes/tei:handNote[@id=$handId]"/>
      </span>
    </xsl:if>
  </xsl:template>

  <!--<xsl:template name="marginAnchorSymbol">
    <xsl:if test="@place='leftMargin' or @place='rightMargin' or @place='topMargin' or @place='botMargin'">
      <xsl:choose>
        <xsl:when test="@type='noAnchor'" />
        <xsl:otherwise>
          <img src="images/anchor.png"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>-->
  
<!--   <xsl:template name="marginAddSymbol">
    <xsl:param name="place" />
    <xsl:choose>
      <xsl:when test="@place='leftMargin' or $place='leftMargin'">
        <img src="images/ms_arrow_left.png"/>
      </xsl:when>
      <xsl:when test="@place='rightMargin' or $place='rightMargin'">
        <img src="images/ms_arrow_right.png"/>
      </xsl:when>
      <xsl:when test="@place='topMargin' or $place='topMargin'">
        <img src="images/ms_arrow_up.png"/>
      </xsl:when>
      <xsl:when test="@place='botMargin' or $place='botMargin'">
        <img src="images/ms_arrow_down.png"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>  -->
  
  <xsl:template name="sofortSymbol">
    <xsl:if test="contains(@type, 'immediate')">
      <span class="immediate_symbol"><img src="images/esh.png" /></span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="noAnchorSymbol">
    <xsl:if test="@type='noAnchor'">
      <span class="symbol_red">
        <xsl:text>&#936;?</xsl:text>
      </span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:addSpan">
    <xsl:call-template name="sofortSymbol"/>
    <xsl:call-template name="noAnchorSymbol"/>
    <!--<img src="images/addspan_from.png"/>-->
    <xsl:if test="contains(@place, 'Margin')">
      <!--<xsl:call-template name="marginAnchorSymbol"/>-->
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
      <xsl:when test="following-sibling::*[1][self::tei:addSpan/@reason='choice']"/>
      <xsl:when test="following-sibling::*[1][self::tei:addSpan/@reason='choice']"/>
      <xsl:when test="contains(@id, 'del') or contains(@id, 'add') or contains(@id, 'st') or contains(@id, 'cho')">
        <br/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:delSpan">
    <xsl:call-template name="sofortSymbol"/>
    <!--<img src="images/delspan_from.png"/>-->
  </xsl:template>
  
  <xsl:template match="tei:restore">
    <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
    <xsl:variable name="medium" select="@medium" />
    <xsl:call-template name="sofortSymbol"/>
    <xsl:choose>
      <xsl:when test="@hand">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_restore_editorial_wrapper</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_deletion tooltiptrigger ttMs</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
          <xsl:call-template name="mediumTooltip">
            <xsl:with-param name="hand">
              <xsl:value-of select="$attHand"/>
            </xsl:with-param>
            <xsl:with-param name="medium">
              <xsl:value-of select="$medium"/>
            </xsl:with-param>
          </xsl:call-template>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:text>restore</xsl:text>
            <xsl:call-template name="mediumClass" />
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip"/>
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
        <span>
          <xsl:if test="parent::tei:switchPos[@medium]">
            <xsl:attribute name="class">
              <xsl:text>medium</xsl:text>
            </xsl:attribute>
          </xsl:if>
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
        </span>
        <xsl:if test="parent::tei:switchPos[@medium]">
          <span class="tooltip">
            <xsl:call-template name="inks">
              <xsl:with-param name="ink" select="parent::tei:switchPos/@medium"/>
            </xsl:call-template>
          </span>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="ancestor::tei:p">
            <xsl:if test="not(preceding-sibling::tei:item)">
              <br/>
            </xsl:if>
            <xsl:apply-templates/>
            <br/>
          </xsl:when>
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

  <xsl:template match="tei:date">
    <xsl:choose>
      <xsl:when test="@rend and @medium">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>_medium</xsl:text>
            <xsl:text> tooltiptrigger ttMs</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:when test="@rend">
        <span>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:call-template name="mediumClass"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:if test="@medium">
            <xsl:attribute name="class">
              <xsl:text>medium</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates />
        </span> 
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>

  <xsl:template match="tei:dateline">
    <xsl:choose>
      <xsl:when test="ancestor::tei:opener or ancestor::tei:closer">
        <xsl:if test="preceding-sibling::*">
          <br />
          <br />
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@rend and @medium">
            <span>
              <xsl:attribute name="class">
                <xsl:text>tei_</xsl:text>
                <xsl:value-of select="@rend"/>
                <xsl:text>_medium</xsl:text>
                <xsl:text> tooltiptrigger ttMs</xsl:text>
              </xsl:attribute>
              <span>
                <xsl:attribute name="class">
                  <xsl:text>tei_hi_medium</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
              </span>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <span>
              <xsl:call-template name="attRend">
                <xsl:with-param name="defaultClasses">
                  <xsl:call-template name="mediumClass" />
                </xsl:with-param>
              </xsl:call-template>
              <xsl:apply-templates/>
            </span>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="mediumTooltip"/>
      </xsl:when>
      <xsl:otherwise>
        <p class="dateline noIndent">
          <xsl:choose>
            <xsl:when test="@rend and @medium">
              <span>
                <xsl:attribute name="class">
                  <xsl:text>tei_</xsl:text>
                  <xsl:value-of select="@rend"/>
                  <xsl:text>_medium</xsl:text>
                  <xsl:text> tooltiptrigger ttMs</xsl:text>
                </xsl:attribute>
                <span>
                  <xsl:attribute name="class">
                    <xsl:text>tei_hi_medium</xsl:text>
                  </xsl:attribute>
                  <xsl:apply-templates/>
                </span>
              </span>
            </xsl:when>
            <xsl:otherwise>
              <span>
                <xsl:call-template name="attRend">
                  <xsl:with-param name="defaultClasses">
                    <xsl:call-template name="mediumClass" />
                  </xsl:with-param>
                </xsl:call-template>
                <xsl:apply-templates/>
              </span>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:call-template name="mediumTooltip"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:foreign">
    <xsl:choose>
      <xsl:when test="@rend and @medium">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>_medium</xsl:text>
            <xsl:text> foreign tooltiptrigger ttLang ttMs</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:text>foreign tooltiptrigger ttLang</xsl:text>
              <xsl:call-template name="mediumClass"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:attribute name="lang">
            <xsl:value-of select="@xml:lang"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="xmlLang"/>
    <xsl:call-template name="mediumTooltip"/>
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
    <xsl:choose>
      <xsl:when test="@medium['underline'] or @medium['underline2'] or @medium['dashUnderline'] or @medium['encircled']">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>_medium</xsl:text>
            <xsl:text> tooltiptrigger ttMs</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:when test="@hand">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_hi_editorial_wrapper</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_editorial</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:when test="@rend='expanded'">
        <span>
          <xsl:attribute name="class">
            <xsl:text>expandedTT</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:call-template name="mediumClass"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip" />
  </xsl:template>

  <xsl:template match="tei:persName|tei:rs">
    <xsl:choose>
      <xsl:when test="@rend and @medium">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>_medium</xsl:text>
            <xsl:text> person tooltiptrigger ttPerson ttMs</xsl:text>
            <xsl:if test="@correspUncert='Y'">
              <xsl:text> uncertain</xsl:text>
            </xsl:if>
            <xsl:if test="@role='fictional'">
              <xsl:text> fictional</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="@corresp"/>
            </xsl:attribute>
          </xsl:if>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:text>person tooltiptrigger ttPerson</xsl:text>
              <xsl:if test="@correspUncert='Y'">
                <xsl:text> uncertain</xsl:text>
              </xsl:if>
              <xsl:if test="@role='fictional'">
                <xsl:text> fictional</xsl:text>
              </xsl:if>
              <xsl:call-template name="mediumClass"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="@corresp"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <xsl:choose>
      <xsl:when test="@rend and @medium">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>_medium</xsl:text>
            <xsl:text> placeName tooltiptrigger ttPlace ttMs</xsl:text>
            <xsl:if test="@correspUncert='Y'">
              <xsl:text> uncertain</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="@corresp"/>
            </xsl:attribute>
          </xsl:if>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:text>placeName tooltiptrigger ttPlace</xsl:text>
              <xsl:if test="@correspUncert='Y'">
                <xsl:text> uncertain</xsl:text>
              </xsl:if>
              <xsl:call-template name="mediumClass"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="@corresp"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>

  <xsl:template match="tei:title">
    <xsl:choose>
      <xsl:when test="@rend and @medium">
        <span>
          <xsl:attribute name="class">
            <xsl:text>tei_</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text>_medium</xsl:text>
            <xsl:text> title tooltiptrigger ttTitle ttMs</xsl:text>
            <xsl:if test="@correspUncert='Y'">
              <xsl:text> uncertain</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="@corresp"/>
            </xsl:attribute>
          </xsl:if>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:text>title tooltiptrigger ttTitle</xsl:text>
              <xsl:call-template name="mediumClass"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="@corresp"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>
  
  <xsl:template name="addSpanStart">
    <xsl:choose>
      <xsl:when test="preceding::tei:addSpan">
        <xsl:variable name="addSpanId1" select="substring(preceding::tei:addSpan[1]/@spanTo, 2)" />
        <xsl:variable name="addSpanId2" select="substring(preceding::tei:addSpan[2]/@spanTo, 2)" />
        <xsl:choose>
          <xsl:when test="following::tei:anchor[@id=$addSpanId1] or following::tei:anchor[@id=$addSpanId2]">
            <xsl:variable name="test">
              <xsl:text>&lt;span class=&quot;addSpan</xsl:text>
              <xsl:choose>
                <xsl:when test="preceding::tei:addSpan[1][@hand]">
                  <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                </xsl:when>
                <xsl:when test="preceding::tei:addSpan[1][@medium]">
                  <xsl:text> medium tooltiptrigger ttMs</xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:text>&quot;&gt;</xsl:text>
            </xsl:variable>
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
            <xsl:variable name="test">
              <xsl:text>&lt;/span&gt;</xsl:text>
            </xsl:variable>
            <xsl:value-of select="$test" disable-output-escaping="yes"/>
            <xsl:if test="preceding::tei:addSpan[@medium] or preceding::tei:addSpan[@hand]">
              <span class="tooltip">
                <xsl:call-template name="inks">
                  <xsl:with-param name="ink" select="preceding::tei:addSpan/@medium"/>
                  <xsl:with-param name="attHand" select="translate(preceding::tei:addSpan/@hand, '#', '')"/>
                </xsl:call-template>
              </span>
            </xsl:if>
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
            <span>
              <xsl:attribute name="class">
                <xsl:choose>
                  <xsl:when test="preceding::tei:delSpan[1]/@rend = 'strikethrough'">
                    <xsl:text>deletion</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>delSpan</xsl:text>
                    <xsl:if test="@rend='noIndent' or contains(name(), 'head') or (name()='l')">
                      <xsl:text>_noIndent</xsl:text>
                    </xsl:if>
                    <xsl:if test="preceding::tei:delSpan[1][@hand]">
                      <xsl:text>_editorial tooltiptrigger ttMs</xsl:text>
                    </xsl:if>
                    <xsl:if test="preceding::tei:delSpan[1][@medium] and not(preceding::tei:delSpan[1][@hand])">
                      <xsl:text>_medium tooltiptrigger ttMs</xsl:text>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:apply-templates/>
            </span>
            <xsl:if test="preceding::tei:delSpan[1][@medium] or preceding::tei:delSpan[1][@hand]">
              <span class="tooltip">
                <xsl:call-template name="inks">
                  <xsl:with-param name="ink" select="preceding::tei:delSpan[1]/@medium"/>
                  <xsl:with-param name="attHand" select="translate(preceding::tei:delSpan[1]/@hand, '#', '')"/>
                </xsl:call-template>
              </span>
            </xsl:if>
            <!--<xsl:choose>
              <xsl:when test="preceding::tei:delSpan[1]/@rend = 'strikethrough'">
                <span class="deletion"><xsl:apply-templates/></span>
              </xsl:when>
              <xsl:otherwise>
                <span class="delSpan"><xsl:apply-templates/></span>
              </xsl:otherwise>
            </xsl:choose>-->
          </xsl:when>
          <xsl:when test="following::tei:anchor[@id=$delSpanId2]">
            <span>
              <xsl:attribute name="class">
                <xsl:choose>
                  <xsl:when test="preceding::tei:delSpan[2]/@rend = 'strikethrough'">
                    <xsl:text>deletion</xsl:text>
                    <xsl:if test="preceding::tei:delSpan[2][@medium]">
                      <xsl:text> medium tooltiptrigger ttMs</xsl:text>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>delSpan</xsl:text>
                    <xsl:if test="preceding::tei:delSpan[2][@medium]">
                      <xsl:text> medium tooltiptrigger ttMs</xsl:text>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:apply-templates/>
            </span>
            <xsl:if test="preceding::tei:delSpan[2][@medium]">
              <span class="tooltip">
                <xsl:call-template name="inks">
                  <xsl:with-param name="ink" select="preceding::tei:delSpan[2]/@medium"/>
                </xsl:call-template>
              </span>
            </xsl:if>
            <!--<xsl:choose>
              <xsl:when test="preceding::tei:delSpan[2]/@rend = 'strikethrough'">
                <span class="deletion"><xsl:apply-templates/></span>
              </xsl:when>
              <xsl:otherwise>
                <span class="delSpan"><xsl:apply-templates/></span>
              </xsl:otherwise>
            </xsl:choose>-->
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
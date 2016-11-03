<?xml version="1.0" encoding="utf-8"?>
<!--
This is a parland custom xsl file
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

<xsl:template match="tei:subst">
  <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
  <xsl:variable name="medium" select="@medium" />
    <xsl:call-template name="sofortSymbol"/>
        <span>
          <xsl:attribute name="class">
            <xsl:if test="not(@hand)">
              <xsl:call-template name="mediumClass" />
            </xsl:if>
            <xsl:if test="@hand">
              <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="not(child::tei:add[@place='inline'])">
              <xsl:element name="span">
                <xsl:attribute name="class">
                  <xsl:text>tei_subst_table</xsl:text>
                  <xsl:if test="ancestor::tei:p[@rend='noIndent'] or ancestor::tei:l or ancestor::tei:head">
                    <xsl:text>_noIndent</xsl:text>
                  </xsl:if>
                </xsl:attribute>
                <xsl:element name="span">
                  <xsl:attribute name="class">
                    <xsl:text>tei_tbody</xsl:text>
                  </xsl:attribute>
                  <xsl:apply-templates/>
                </xsl:element>
              </xsl:element>
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
    <xsl:with-param name="medium">
      <xsl:value-of select="$medium"/>
    </xsl:with-param>
  </xsl:call-template>
  </xsl:template>

  <xsl:template match="tei:add">
    <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
    <xsl:variable name="medium" select="@medium" />
    <xsl:choose>
      <xsl:when test="parent::tei:subst">
        <xsl:choose>
          <xsl:when test="count(preceding-sibling::tei:del)=2"/>
          <xsl:otherwise>
            
            <xsl:element name="span">
              <xsl:attribute name="class">
                <xsl:text>tei_tr_add</xsl:text>
              </xsl:attribute>
              <xsl:element name="span">
                <xsl:attribute name="class">
                  <xsl:text>tei_td_add</xsl:text>
                  <xsl:if test="@place='sublinear'">
                    <xsl:text>_sublinear</xsl:text>
                  </xsl:if>
                </xsl:attribute>
                <span>
                  <xsl:attribute name="class">
                    <xsl:choose>
                      <xsl:when test="parent::tei:subst[@hand] or @hand">
                        <xsl:text>tei_editorial</xsl:text>
                      </xsl:when>
                      <xsl:when test="parent::tei:subst[@medium] or @medium">
                        <xsl:text>medium</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>tei_add_subst_zts</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="not(@hand)">
                      <xsl:call-template name="mediumClass" />
                    </xsl:if>
                    <xsl:if test="@hand">
                      <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <xsl:call-template name="sofortSymbol" />
                  <xsl:call-template name="noAnchorSymbol"/>
                  <!--<xsl:call-template name="marginAnchorSymbol"/>-->
                  <xsl:call-template name="marginAddSymbol" />
                  <xsl:if test="ancestor::tei:del">
                    
                    <xsl:variable name="test">
                      <xsl:text>&lt;span class=&quot;tei_deletion_add</xsl:text>
                      <xsl:if test="@medium">
                        <xsl:text> medium tooltipTrigger ttMs</xsl:text>
                      </xsl:if>
                      <xsl:text>&quot;&gt;</xsl:text>
                    </xsl:variable>
                    <xsl:value-of select="$test" disable-output-escaping="yes"/>
                  </xsl:if>
                  <xsl:apply-templates />
                  <xsl:if test="ancestor::tei:del">
                    <xsl:variable name="test">
                      <xsl:text>&lt;/span&gt;</xsl:text>
                    </xsl:variable>
                    <xsl:value-of select="$test" disable-output-escaping="yes"/>
                  </xsl:if>
                  <xsl:call-template name="marginAddSymbol" />
                </span>
                <xsl:call-template name="mediumTooltip">
                  <xsl:with-param name="hand">
                    <xsl:value-of select="$attHand"/>
                  </xsl:with-param>
                  <xsl:with-param name="medium">
                    <xsl:value-of select="$medium"/>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:element>
            </xsl:element>
            
          </xsl:otherwise>
        </xsl:choose>
        

      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="(ancestor::tei:p[@rend='noIndent'] or ancestor::tei:l) and @reason='choice'">
                <xsl:text>tei_add_choice_noIndent</xsl:text>
                <xsl:if test="@place='sublinear'">
                  <xsl:text>_sublinear</xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:when test="(not(ancestor::tei:p[@rend='noIndent']) or not(ancestor::tei:l)) and @reason='choice'">
                <xsl:text>tei_add_choice</xsl:text>
                <xsl:if test="@place='sublinear'">
                  <xsl:text>_sublinear</xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:when test="@place='leftMargin' or @place='rightMargin' or @place='topMargin' or @place='botMargin'">
                <xsl:text>tei_add_margin</xsl:text>
              </xsl:when>
              <xsl:when test="@place='sublinear'">
                <xsl:text>tei_add_sublinear</xsl:text>
              </xsl:when>
              <xsl:when test="@place='inline'">
                <xsl:text>tei_add_subst_zts</xsl:text>
              </xsl:when>
              <xsl:when test="parent::tei:add and not(parent::tei:add[@place='inline'])">
                <xsl:text>tei_add_subst_zts</xsl:text>
                <xsl:if test="@medium or ancestor::tei:subst[@medium] or parent::tei:add[@medium]">
                  <xsl:text> medium</xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:when test="parent::tei:del and (../preceding-sibling::tei:del)"/>
              
              <xsl:otherwise>
                <xsl:text>tei_add_over_hps</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="not(@hand)">
              <xsl:call-template name="mediumClass" />
            </xsl:if>
            <xsl:if test="@hand">
              <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:call-template name="sofortSymbol" />
          <xsl:call-template name="noAnchorSymbol"/>
          <!--<xsl:call-template name="marginAnchorSymbol"/>-->
          <xsl:call-template name="marginAddSymbol" />
          <xsl:if test="parent::tei:add and not(parent::tei:add[@place='inline'])">
            <span>
              <xsl:attribute name="class">
                <xsl:text>symbol_red</xsl:text>
              </xsl:attribute>
              <xsl:text>&#92;&#92;</xsl:text>
            </span>
          </xsl:if>
          <xsl:apply-templates />
          <xsl:if test="parent::tei:add and not(parent::tei:add[@place='inline'])">
            <span>
              <xsl:attribute name="class">
                <xsl:text>symbol_red</xsl:text>
              </xsl:attribute>
              <xsl:text>/</xsl:text>
            </span>
          </xsl:if>
          <xsl:call-template name="marginAddSymbol" />
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip">
      <xsl:with-param name="hand">
        <xsl:value-of select="$attHand"/>
      </xsl:with-param>
      <xsl:with-param name="medium">
        <xsl:value-of select="$medium"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="tei:add" mode="add_in_second_del">
    <xsl:apply-templates/>
  </xsl:template>
 
 <xsl:template match="tei:del">
   <xsl:variable name="attHand" select="translate(@hand, '#', '')" />
   <xsl:variable name="medium" select="@medium" />
   <xsl:call-template name="sofortSymbol"/>
   
   <xsl:choose>
     <xsl:when test="parent::tei:subst and not(preceding-sibling::tei:del)">
       <xsl:element name="span">
         <xsl:attribute name="class">
           <xsl:text>tei_tr</xsl:text>
         </xsl:attribute>
         <xsl:element name="span">
           <xsl:attribute name="class">
             <xsl:text>tei_td_del</xsl:text>
           </xsl:attribute>
           <xsl:choose>
             <xsl:when test="ancestor::tei:del">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_del_in_del</xsl:text>
                 </xsl:attribute>
                 <span>
                   <xsl:attribute name="class">
                     <xsl:text>tei_deletion_del_subst</xsl:text>
                     <xsl:if test="@hand">
                       <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                     </xsl:if>
                     <xsl:if test="not(@hand)">
                       <xsl:call-template name="mediumClass" />
                     </xsl:if>
                   </xsl:attribute>
                   <xsl:apply-templates/>
                 </span>
               </span>
             </xsl:when>
             <xsl:when test="parent::tei:subst[@hand] or @hand">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_deletion_editorial_wrapper</xsl:text>
                 </xsl:attribute>
                 <span>
                   <xsl:attribute name="class">
                     <xsl:text>tei_deletion_editorial tooltiptrigger ttMs</xsl:text>
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
             <xsl:when test="parent::tei:subst[@medium] or @medium">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_deletion_medium_wrapper</xsl:text>
                 </xsl:attribute>
                 <span>
                   <xsl:attribute name="class">
                     <xsl:text>tei_deletion_editorial tooltiptrigger ttMs</xsl:text>
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
             <xsl:when test="parent::tei:add">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_deletion_add</xsl:text>
                   <xsl:if test="ancestor::tei:subst[@medium] or @medium">
                     <xsl:text>_medium</xsl:text>
                   </xsl:if>
                 </xsl:attribute>
                 <xsl:apply-templates/>
               </span>
             </xsl:when>
             <xsl:otherwise>
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
                     <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                   </xsl:if>
                 </xsl:attribute>
                 <xsl:choose>
                   <xsl:when test="ancestor::tei:subst">
                     <xsl:element name="tr">
                       <xsl:element name="td">
                         <xsl:apply-templates/>
                       </xsl:element>
                     </xsl:element>
                   </xsl:when>
                   <xsl:otherwise>
                     <xsl:apply-templates/>
                   </xsl:otherwise>
                 </xsl:choose>
               </span>
             </xsl:otherwise>
           </xsl:choose>
           
         </xsl:element>
       </xsl:element>
     </xsl:when>
     <xsl:when test="parent::tei:subst and preceding-sibling::tei:del">
       <xsl:element name="span">
         <xsl:attribute name="class">
           <xsl:text>tei_tr_add</xsl:text>
         </xsl:attribute>
         <xsl:element name="span">
           <xsl:attribute name="class">
             <xsl:text>tei_td_add</xsl:text>
           </xsl:attribute>
           <xsl:choose>
             <xsl:when test="ancestor::tei:del">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_del_in_del</xsl:text>
                 </xsl:attribute>
                 <span>
                   <xsl:attribute name="class">
                     <xsl:text>tei_deletion_del_subst</xsl:text>
                     <xsl:if test="@hand">
                       <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                     </xsl:if>
                     <xsl:if test="not(@hand)">
                       <xsl:call-template name="mediumClass" />
                     </xsl:if>
                   </xsl:attribute>
                   <xsl:apply-templates/>
                 </span>
               </span>
             </xsl:when>
             <xsl:when test="parent::tei:subst[@hand] or @hand">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_deletion_editorial_wrapper</xsl:text>
                 </xsl:attribute>
                 <span>
                   <xsl:attribute name="class">
                     <xsl:text>tei_editorial tooltiptrigger ttMs</xsl:text>
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
             <xsl:when test="parent::tei:subst[@medium] or @medium">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_deletion_medium_wrapper</xsl:text>
                 </xsl:attribute>
                 <span>
                   <xsl:attribute name="class">
                     <xsl:text>medium tooltiptrigger ttMs</xsl:text>
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
             <xsl:when test="parent::tei:add">
               <span>
                 <xsl:attribute name="class">
                   <xsl:text>tei_deletion_add</xsl:text>
                   <xsl:if test="ancestor::tei:subst[@medium] or @medium">
                     <xsl:text>_medium</xsl:text>
                   </xsl:if>
                 </xsl:attribute>
                 <xsl:apply-templates/>
               </span>
             </xsl:when>
             <xsl:otherwise>
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
                     <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                   </xsl:if>
                 </xsl:attribute>
                 <xsl:choose>
                   <xsl:when test="ancestor::tei:subst">
                     <xsl:element name="tr">
                       <xsl:element name="td">
                         <xsl:apply-templates/>
                       </xsl:element>
                     </xsl:element>
                   </xsl:when>
                   <xsl:otherwise>
                     <xsl:apply-templates/>
                   </xsl:otherwise>
                 </xsl:choose>
               </span>
             </xsl:otherwise>
           </xsl:choose>
            <span>
              <xsl:attribute name="class">
                <xsl:choose>
                  <xsl:when test="@hand or ancestor::tei:subst[@hand]">
                    <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                  </xsl:when>
                  <xsl:when test="@medium or ancestor::tei:subst[@medium]">
                    <xsl:text> medium tooltiptrigger ttMs</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>tei_add_subst_zts</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="following-sibling::tei:add" mode="add_in_second_del" />
            </span>
         </xsl:element>
       </xsl:element>
     </xsl:when>
     <xsl:otherwise>
       
       <xsl:choose>
         <xsl:when test="ancestor::tei:del">
           <span>
             <xsl:attribute name="class">
               <xsl:text>tei_del_in_del</xsl:text>
             </xsl:attribute>
             <span>
               <xsl:attribute name="class">
                 <xsl:text>tei_deletion_del</xsl:text>
                 <xsl:if test="ancestor::tei:add and not(@hand)">
                   <xsl:text>_add</xsl:text>
                 </xsl:if>
                 <xsl:if test="@hand">
                   <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
                 </xsl:if>
                 <xsl:if test="not(@hand)">
                   <xsl:call-template name="mediumClass" />
                 </xsl:if>
               </xsl:attribute>
               <xsl:apply-templates/>
             </span>
           </span>
         </xsl:when>
         <xsl:when test="parent::tei:subst[@hand] or @hand">
           <span>
             <xsl:attribute name="class">
               <xsl:text>tei_deletion_editorial_wrapper</xsl:text>
             </xsl:attribute>
             <span>
               <xsl:attribute name="class">
                 <xsl:text>tei_deletion_editorial tooltiptrigger ttMs</xsl:text>
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
         <xsl:when test="@medium">
           <span>
             <xsl:attribute name="class">
               <xsl:text>tei_deletion_medium_wrapper</xsl:text>
             </xsl:attribute>
             <span>
               <xsl:attribute name="class">
                 <xsl:text>tei_deletion_editorial tooltiptrigger ttMs</xsl:text>
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
         <xsl:when test="parent::tei:add">
           <span>
             <xsl:attribute name="class">
               <xsl:text>tei_deletion_add</xsl:text>
               <xsl:if test="ancestor::tei:subst[@medium] or @medium">
                 <xsl:text>_medium</xsl:text>
               </xsl:if>
             </xsl:attribute>
             <xsl:apply-templates/>
           </span>
         </xsl:when>
         <xsl:otherwise>
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
                 <xsl:text> tei_editorial tooltiptrigger ttMs</xsl:text>
               </xsl:if>
             </xsl:attribute>
             <xsl:choose>
               <xsl:when test="ancestor::tei:subst">
                 <xsl:element name="tr">
                   <xsl:element name="td">
                     <xsl:apply-templates/>
                   </xsl:element>
                 </xsl:element>
               </xsl:when>
               <xsl:otherwise>
                 <xsl:apply-templates/>
               </xsl:otherwise>
             </xsl:choose>
           </span>
         </xsl:otherwise>
       </xsl:choose>
       
     </xsl:otherwise>
   </xsl:choose>
    <xsl:call-template name="mediumTooltip">
      <xsl:with-param name="hand">
        <xsl:value-of select="$attHand"/>
      </xsl:with-param>
      <xsl:with-param name="medium">
        <xsl:value-of select="$medium"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="tei:head">
    <xsl:choose>
      <xsl:when test="@type='letter'">
        <p>
          <xsl:attribute name="class">
            <xsl:text>noIndent underline topMargin bottomMargin</xsl:text>
            <xsl:call-template name="mediumClass"/>
          </xsl:attribute>
          <xsl:call-template name="addSpanStart"/>
          <xsl:call-template name="delSpan"/>
          <xsl:call-template name="addSpanEnd"/>
        </p>
      </xsl:when>
      <xsl:when test="@rend='underline' and @medium">
        <p>
          <xsl:attribute name="class">
            <xsl:text>noIndent tei_underline_medium</xsl:text>
          </xsl:attribute>
          <span>
            <xsl:attribute name="class">
              <xsl:text>tei_hi_medium</xsl:text>
            </xsl:attribute>
            <xsl:call-template name="addSpanStart"/>
            <xsl:call-template name="delSpan"/>
            <xsl:call-template name="addSpanEnd"/>
          </span>
        </p>
      </xsl:when>
      <xsl:when test="@rend='underline'">
        <h3>
          <xsl:attribute name="class">
            <xsl:text>title1 underline</xsl:text>
            <xsl:call-template name="mediumClass"/>
          </xsl:attribute>
          <xsl:call-template name="addSpanStart"/>
          <xsl:call-template name="delSpan"/>
          <xsl:call-template name="addSpanEnd"/>
        </h3>
      </xsl:when>
      <xsl:otherwise>
        <h3>
          <xsl:call-template name="attRend">
            <xsl:with-param name="defaultClasses">
              <xsl:call-template name="mediumClass"/>
                <xsl:choose>
                  <xsl:when test="@type='motto'">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@type"/>
                    <xsl:text>_ms</xsl:text>
                  </xsl:when>
                 <xsl:when test="@type">
                   <xsl:text> </xsl:text>
                   <xsl:value-of select="@type"/>
                 </xsl:when>
                 <xsl:otherwise>
                   <xsl:text>title1</xsl:text>
                 </xsl:otherwise>
               </xsl:choose>  
            </xsl:with-param>
          </xsl:call-template>
          
          <xsl:call-template name="addSpanStart"/>
          <xsl:call-template name="delSpan"/>
          <xsl:call-template name="addSpanEnd"/>
        </h3>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="mediumTooltip"/>
  </xsl:template>
  
 </xsl:stylesheet>

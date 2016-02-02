<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://seesharp.witchmastercreations.com )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei" xmlns:ns0="http://tei-c.org/TextComparator">

  <xsl:output method="text" version="1.0" encoding="utf-8" indent="no"/>
 
  <xsl:param name="paragraphId" />

  <xsl:template match="tei:teiHeader">
    <xsl:text>{'title': '</xsl:text>
    <xsl:value-of select="//tei:titleStmt//tei:title"/>
    <xsl:text>'</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:body">
    <xsl:if test="//tei:div[@id=$paragraphId]">
      <xsl:text>, 'chapterTitle' : '</xsl:text>
      <xsl:value-of select="//tei:div[@id=$paragraphId]/@title"/>
      <xsl:text>'</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>
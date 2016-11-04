<?xml version="1.0" encoding="utf-8"?>
<!--
This notice must be visible at all times.

Copyright (c) 2010 Mikael Norrgård (See Sharp IT). All rights reserved.
Created 2010 by Mikael Norrgård (Web: http://swww.seesharp.fi )
email: seesharp@witchmastercreations.com or mikael.norrgard@gmail.com

Rights to use and further develop given to Svenska litteratursällskapet i Finland.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">

  <!--<xsl:output method="html" version="1.0" encoding="utf-8" indent="no"/>-->
  <xsl:output method="xml" version="1.0" encoding="utf-8" indent="no" omit-xml-declaration="no"/>

  <xsl:template match="tei:subst|tei:add|tei:reg|tei:choice">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:del|tei:orig"/>
 
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
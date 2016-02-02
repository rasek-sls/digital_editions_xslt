<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.sls.fi/tei">

  <xsl:output method="text" version="1.0" encoding="utf-8" indent="no"/>

  <xsl:key name="document-by-filename" match="tei:ud" use="tei:ud-name" />
  <xsl:key name="document-by-genre" match="tei:ud" use="tei:ud-genre" />
  <xsl:key name="document-by-type" match="tei:ud" use="tei:ud-type" />
  <xsl:key name="document-by-bookid" match="tei:ud" use="substring-before(tei:ud-id, '_')" />
  <xsl:key name="document-by-sender" match="tei:ud" use="tei:ud-sender" />
  <xsl:key name="document-by-adressee" match="tei:ud" use="tei:ud-adressee" />
  <xsl:key name="document-by-place-sender" match="tei:ud" use="tei:ud-place-sender" />
  <xsl:key name="document-by-place-adressee" match="tei:ud" use="tei:ud-place-adressee" />

  <xsl:template match="tei:doc"/>

  <xsl:template match="tei:distinct-documents">
    <xsl:text>{"data" : {</xsl:text>
    
    <xsl:text>"Bookids" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-bookid',substring-before(tei:ud-id, '_'))[1])]">
      <xsl:sort select="count(key('document-by-bookid', substring-before(tei:ud-id, '_')))" data-type="number" order="descending"/>
      <xsl:if test="string-length(tei:ud-id)&gt;0">
        <xsl:text>{"id" : "</xsl:text>
        <xsl:value-of select="substring-before(tei:ud-id, '_')"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-bookid', substring-before(tei:ud-id, '_')))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"Genres" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-genre',tei:ud-genre)[1])]">
      <xsl:sort select="tei:ud-genre" data-type="text" order="ascending"/>
      <!--<xsl:sort select="count(key('document-by-genre', tei:ud-genre))" data-type="number" order="descending"/>-->
      <xsl:if test="string-length(tei:ud-genre)&gt;0">
        <xsl:text>{"genre" : "</xsl:text>
        <xsl:value-of select="tei:ud-genre"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-genre', tei:ud-genre))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"Types" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-type',tei:ud-type)[1])]">
      <xsl:sort select="tei:ud-type" data-type="text" order="ascending"/>
      <!--<xsl:sort select="count(key('document-by-type', tei:ud-type))" data-type="number" order="descending"/>-->
      <xsl:if test="string-length(tei:ud-type)&gt;0">
        <xsl:text>{"type" : "</xsl:text>
        <xsl:value-of select="tei:ud-type"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-type', tei:ud-type))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"Documents" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-filename',tei:ud-name)[1])]">
      <xsl:sort select="count(key('document-by-filename', tei:ud-name))" data-type="number" order="descending"/>
      <xsl:if test="string-length(tei:ud-name)&gt;0">
        <xsl:text>{"doc" : "</xsl:text>
        <xsl:value-of select="tei:ud-name"/>
        <xsl:text>", "title" : "</xsl:text>
        <xsl:value-of select="tei:ud-title"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-filename', tei:ud-name))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"Senders" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-sender',tei:ud-sender)[1])]">
      <xsl:sort select="tei:ud-sender" data-type="text" order="ascending"/>
      <xsl:if test="string-length(tei:ud-sender)&gt;0">
        <xsl:text>{"sender" : "</xsl:text>
        <xsl:value-of select="tei:ud-sender"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-sender', tei:ud-sender))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"Adressees" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-adressee',tei:ud-adressee)[1])]">
      <xsl:sort select="tei:ud-adressee" data-type="text" order="ascending"/>
      <xsl:if test="string-length(tei:ud-adressee)&gt;0">
        <xsl:text>{"adressee" : "</xsl:text>
        <xsl:value-of select="tei:ud-adressee"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-adressee', tei:ud-adressee))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"PlacesSender" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-place-sender',tei:ud-place-sender)[1])]">
      <xsl:sort select="tei:ud-place-sender" data-type="text" order="ascending"/>
      <xsl:if test="string-length(tei:ud-place-sender)&gt;0">
        <xsl:text>{"placeSender" : "</xsl:text>
        <xsl:value-of select="tei:ud-place-sender"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-place-sender', tei:ud-place-sender))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>],</xsl:text>

    <xsl:text>"PlacesAdressee" : [</xsl:text>
    <xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-place-adressee',tei:ud-place-adressee)[1])]">
      <xsl:sort select="tei:ud-place-adressee" data-type="text" order="ascending"/>
      <xsl:if test="string-length(tei:ud-place-adressee)&gt;0">
        <xsl:text>{"placeAdressee" : "</xsl:text>
        <xsl:value-of select="tei:ud-place-adressee"/>
        <xsl:text>", "count" : "</xsl:text>
        <xsl:value-of select="count(key('document-by-place-adressee', tei:ud-place-adressee))"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>]</xsl:text>
    
    <!--<xsl:for-each select="//tei:ud[generate-id()=generate-id(key('document-by-filename',tei:ud-name)[1])]">
      <xsl:sort select="count(key('document-by-filename', tei:ud-name))" data-type="number" order="descending"/>
      <xsl:value-of select="tei:ud-name"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="count(key('document-by-filename', tei:ud-name))"/>
      <br/>
    </xsl:for-each>-->
    <xsl:text>}}</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:ud"/>
    
</xsl:stylesheet>
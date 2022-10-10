<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs" version="2.0">

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6
            http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed: 1. Distributed under a Creative Commons
            Attribution-ShareAlike 3.0 Unported License
            http://creativecommons.org/licenses/by-sa/3.0/ 2.
            http://www.opensource.org/licenses/BSD-2-Clause Redistribution and use in source and
            binary forms, with or without modification, are permitted provided that the following
            conditions are met: * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer. * Redistributions in
            binary form must reproduce the above copyright notice, this list of conditions and the
            following disclaimer in the documentation and/or other materials provided with the
            distribution. This software is provided by the copyright holders and contributors "as
            is" and any express or implied warranties, including, but not limited to, the implied
            warranties of merchantability and fitness for a particular purpose are disclaimed. In no
            event shall the copyright holder or contributors be liable for any direct, indirect,
            incidental, special, exemplary, or consequential damages (including, but not limited to,
            procurement of substitute goods or services; loss of use, data, or profits; or business
            interruption) however caused and on any theory of liability, whether in contract, strict
            liability, or tort (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage. </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>

   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>

   <xsl:param name="homeLabel">Domov</xsl:param>
   <xsl:param name="homeURL">https://sistory.github.io/TheLegacyofAdvancedInformatization</xsl:param>

   <!--<xsl:param name="splitLevel">1</xsl:param>-->

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <xsl:param name="documentationLanguage">en</xsl:param>
   
   <xsl:param name="languages-locale">true</xsl:param>
   <xsl:param name="languages-locale-primary">en</xsl:param>
   
   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"/>
   <xsl:param name="numberFrontTables"/>
   <xsl:param name="numberHeadings"/>
   <xsl:param name="numberParagraphs"/>
   <xsl:param name="numberTables"/>

   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">Zapuščina napredne informatizacije / The Legacy of Advanced Informatization</xsl:param>
   <xsl:param name="keywords">Računalniški muzej, konferenca, zbornik</xsl:param>
   <xsl:param name="title">Zapuščina napredne informatizacije / The Legacy of Advanced Informatization</xsl:param>

   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc/>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of
            select="concat($path-general, 'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css"
         rel="stylesheet" type="text/css"/>
      <link
         href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}"
         rel="stylesheet" type="text/css"/>
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"
         rel="stylesheet" type="text/css"/>
      <!-- dodam projektno specifičen css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
      <link href="project.css" rel="stylesheet" type="text/css"/>
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"/>
      <!-- za highcharts -->
      <xsl:if
         test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile"
            select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"/>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan css jstree (mora biti za jquery.js -->
      <link
         href="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/themes/default/style.min.css')}"
         rel="stylesheet" type="text/css"/>
      <!-- dodan jstree -->
      <script src="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/jstree.min.js')}"/>
   </xsl:template>
  

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc/>
      <param name="tei-id"/>
      <param name="sistoryAbsolutePath"/>
   </doc>
   <xsl:template name="tipuesearch_content">
      <xsl:param name="tei-id"/>
      <xsl:param name="sistoryAbsolutePath"/>
      <xsl:variable name="datoteka-js" select="concat($outputDir, 'tipuesearch_content.js')"/>
      <xsl:result-document href="{$datoteka-js}" method="text" encoding="UTF-8">
         <!-- ZAČETEK JavaScript dokumenta -->
         <xsl:text>var tipuesearch = {"pages": [
                                    </xsl:text>
         <!-- Shrani celotno besedilo v indeks za:
                     - vse child elemente od div, ki imajo @xml:id;
                     - vse child elemente od izbranih list elementov:
                         - list element ne sme imeti @xml:id,
                         - child element mora imeti @xml:id
                -->
         <xsl:for-each select="
               //node()[ancestor::tei:TEI/@xml:id = $tei-id][@xml:id][ancestor::tei:text][parent::tei:div][not(self::tei:div)] |
               //tei:listPerson[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listPlace[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listOrg[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listEvent[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listBibl[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:list[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id]">
            <!--<xsl:variable name="ancestorChapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>-->
            <xsl:variable name="generatedLink">
               <!--<xsl:apply-templates mode="generateLink" select="."/>-->
               <!-- Drugače procesiram: upoštevam div[@rend='nosplit'] -->
               <xsl:value-of
                  select="concat(ancestor::tei:div[@xml:id][not(@rend = 'nosplit')][1]/@xml:id, '.html#', @xml:id)"
               />
            </xsl:variable>
            <xsl:variable name="besedilo">
               <xsl:apply-templates mode="besedilo"/>
            </xsl:variable>
            <xsl:variable name="title-first">
               <xsl:apply-templates select="parent::tei:div/tei:head[1]" mode="chapters-head"/>
            </xsl:variable>

            <xsl:text>{ "title": "</xsl:text>
            <xsl:value-of
               select="normalize-space(translate(translate($title-first, '&#xA;', ' '), '&quot;', ''))"/>
            <!--<xsl:value-of select="normalize-space(translate(translate(ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/tei:head[1],'&#xA;',' '),'&quot;',''))"/>-->
            <xsl:text>", "text": "</xsl:text>
            <xsl:value-of
               select="normalize-space(translate($besedilo, '&#xA;&quot;&#92;', '&#x20;'))"/>
            <xsl:text>", "tags": "</xsl:text>
            <xsl:text>", "url": "</xsl:text>
            <xsl:value-of select="concat($sistoryAbsolutePath, $generatedLink)"/>
            <!--<xsl:value-of select="concat($ancestorChapter-id,'.html#',@xml:id)"/>-->
            <xsl:text>" }</xsl:text>
            <xsl:if test="position() != last()">
               <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:text>&#xA;</xsl:text>
         </xsl:for-each>

         <!-- KONEC JavaScript dokumenta -->
         <xsl:text>
                     ]};
                </xsl:text>
      </xsl:result-document>
   </xsl:template>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Vključi youtube kodo</desc>
   </doc>
   <xsl:template match="tei:media[@mimeType = 'video/youtube' or @mimeType = 'video/x-youtube']">
      <div class="responsive-embed">
         <iframe width="560" height="315"
            src="https://www.youtube.com/embed/{tokenize(@url,'/')[last()]}" frameborder="0"
            allowfullscreen=""/>
      </div>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>video prikaz</desc>
   </doc>
   <xsl:template match="tei:media[@mimeType = 'video/mp4']">
      <video width="650" height="420" controls="">
         <source src="{@url}" type="video/mp4"/> Your browser does not support the video tag.
      </video>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodatno za kolofon: procesiranje idno</desc>
   </doc>
   <xsl:template match="tei:publicationStmt" mode="kolofon">
      <xsl:apply-templates select="tei:publisher" mode="kolofon"/>
      <xsl:apply-templates select="tei:date" mode="kolofon"/>
      <xsl:apply-templates select="tei:pubPlace" mode="kolofon"/>
      <xsl:apply-templates select="tei:availability" mode="kolofon"/>
      <xsl:apply-templates select="tei:idno" mode="kolofon"/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:idno" mode="kolofon">
      <p>
         <xsl:choose>
            <xsl:when test="matches(.,'https?://')">
               <a href="{.}">
                  <xsl:value-of select="."/>
               </a>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(@type,' ',.)"/>
            </xsl:otherwise>
         </xsl:choose>
      </p>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>orgName v respStmt</desc>
   </doc>
   <xsl:template match="tei:respStmt" mode="kolofon">
      <xsl:apply-templates select="tei:resp" mode="kolofon"/>
   </xsl:template>
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:resp" mode="kolofon">
      <p>
         <em>
            <xsl:value-of select="concat(.,':')"/>
         </em>
         <br />
         <xsl:for-each select="following-sibling::tei:name">
            <span itemprop="contributor">
               <xsl:apply-templates/>
            </span>
            <br />
         </xsl:for-each>
         <xsl:for-each select="following-sibling::tei:orgName">
            <span itemprop="contributor">
               <xsl:apply-templates/>
            </span>
            <br />
         </xsl:for-each>
      </p>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>izpis spremnih študij, glede na število back/div</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-study-head">
      <xsl:param name="thisLanguage"/>
      <xsl:choose>
         <xsl:when test="matches(@xml:lang, 'en')">
      <xsl:text>About the Authors</xsl:text>
         </xsl:when>
         <xsl:when test="matches(@xml:lang, 'sl')">
            <xsl:text>O avtorjih</xsl:text>
         </xsl:when>
      </xsl:choose>
   </xsl:template>



</xsl:stylesheet>

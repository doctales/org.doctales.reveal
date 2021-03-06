<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
    This file is part of the DITA Open Toolkit plugin 'org.doctales.reveal'.
    The plugin is hosted on Github.com. The plugin is based on
    the JavaScript framework 'reveal.js'. 
-->

<xsl:stylesheet version="2.0" 
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    
    <xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <!-- 
        **************************************************
        Parameters
        **************************************************
    -->
    
    <xsl:param name="args.reveal.autoslide"/>
    <xsl:param name="args.reveal.autoslidestoppable"/>
    <xsl:param name="args.reveal.backgroundtransition"/>
    <xsl:param name="args.reveal.center"/>
    <xsl:param name="args.reveal.controls"/>
    <xsl:param name="args.reveal.controlsLayout" as="xs:string"/>
    <xsl:param name="args.reveal.css"/>
    <xsl:param name="args.reveal.embedded"/>
    <xsl:param name="args.reveal.fragments"/>
    <xsl:param name="args.reveal.generate.vertical.slides"/>
    <xsl:param name="args.reveal.height"/>
    <xsl:param name="args.reveal.hideaddressbar"/>
    <xsl:param name="args.reveal.history"/>
    <xsl:param name="args.reveal.keyboard"/>
    <xsl:param name="args.reveal.loop"/>
    <xsl:param name="args.reveal.margin"/>
    <xsl:param name="args.reveal.maxScale"/>
    <xsl:param name="args.reveal.minScale"/>
    <xsl:param name="args.reveal.mousewheel"/>
    <xsl:param name="args.reveal.overview"/>
    <xsl:param name="args.reveal.parallaxbackgroundimage"/>
    <xsl:param name="args.reveal.parallaxbackgroundsize"/>
    <xsl:param name="args.reveal.previewlinks"/>
    <xsl:param name="args.reveal.progress"/>
    <xsl:param name="args.reveal.rtl"/>
    <xsl:param name="args.reveal.slidenumber"/>
    <xsl:param name="args.reveal.theme"/>
    <xsl:param name="args.reveal.touch"/>
    <xsl:param name="args.reveal.transition"/>
    <xsl:param name="args.reveal.transitionspeed"/>
    <xsl:param name="args.reveal.viewdistance"/>
    <xsl:param name="args.reveal.width"/>
    
    <!--
        **************************************************
        Templates
        **************************************************
    -->
    
    <xsl:template match="/">
        <xsl:apply-imports/>
    </xsl:template>
    
    <!-- Add reveal.js styles by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-styles">
        
        <meta name="apple-mobile-web-app-capable" content="yes"><!----></meta>
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"><!----></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui"><!----></meta>
        
        <link rel="stylesheet" href="dist/reset.css"><!----></link>
        <link rel="stylesheet" href="dist/reveal.css"><!----></link>
        <xsl:choose>
            <xsl:when test="not(contains($args.reveal.theme, 'null'))">
                <link rel="stylesheet" href="css/theme/{$args.reveal.theme}.css" id="theme"><!----></link>    
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="dist/reveal.css" id="theme"><!----></link>
            </xsl:otherwise>
        </xsl:choose>
                    
        <!-- Theme used for syntax highlighted code -->
        <link rel="stylesheet" href="plugin/highlight/monokai.css" id="highlight-theme"><!----></link>

        <!-- For print -->
        
        <!-- Printing and PDF exports -->
        <!--<script>
            var link = document.createElement( 'link' );
            link.rel = 'stylesheet';
            link.type = 'text/css';
            link.href = window.location.search.match( /print-pdf/gi ) ? 'css/print/pdf.css' : 'css/print/paper.css';
            document.getElementsByTagName( 'head' )[0].appendChild( link );
        </script>-->
        
    </xsl:template>
    
    <!-- Add title by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-panel-title-pfx"></xsl:template>
    
    <!--
        This template overrides the template 'chapterBody' defined in the 'dita2htmlimpl.xsl'.
        It injects a <div class="reveal"> and a <div class="slides"> element.
    -->
    <xsl:template name="chapterBody">
        <xsl:apply-templates select="." mode="chapterBody"/>
    </xsl:template>
    
    <xsl:template match="*" mode="chapterBody">
        <!--<body onload="removeDisposableSections()">--> 
        <body> 
            <div class="reveal">
                <!-- Any section element inside of this container is displayed as a slide -->
                <div class="slides">
                    <!-- Already put xml:lang on <html>; do not copy to body with commonattributes -->
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/@outputclass" mode="add-ditaval-style"/>
                    <!--output parent or first "topic" tag's outputclass as class -->
                    <xsl:if test="@outputclass">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@outputclass" />
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="self::dita">
                        <xsl:if test="*[contains(@class, ' topic/topic ')][1]/@outputclass">
                            <xsl:attribute name="class">
                                <xsl:value-of select="*[contains(@class, ' topic/topic ')][1]/@outputclass" />
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:if>
                    <xsl:apply-templates select="." mode="addAttributesToBody"/>
                    <xsl:value-of select="$newline"/>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
                    <xsl:variable name="bodyContent">
                        <xsl:apply-templates/>
                    </xsl:variable>
                    <!-- Post-process all the topic container elements and generate proper sections for them -->
                    <xsl:for-each select="$bodyContent/*">
                        <xsl:choose>
                            <xsl:when test="count(.//topicContainer) > 0">
                                <!-- We need to bring all slides to the top level -->
                                <xsl:variable name="allSlidesAsFirstLevel">
                                    <!-- The slide which contains other slides, copied to output but ignoring sub-slides -->
                                    <section>
                                        <xsl:apply-templates mode="all-but-topicContainer"/>
                                    </section>
                                    <!-- For each subslide, copy to output but ignore sub-slides -->
                                    <xsl:for-each select=".//topicContainer">
                                        <section>
                                            <xsl:apply-templates mode="all-but-topicContainer"/>
                                        </section>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$args.reveal.generate.vertical.slides = 'true'">
                                        <!-- Generate vertical slides, so wrap in a <section> element -->
                                        <section>
                                            <xsl:copy-of select="$allSlidesAsFirstLevel"/>
                                        </section>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!-- No vertical slides generation -->
                                        <xsl:copy-of select="$allSlidesAsFirstLevel"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <section>
                                    <xsl:apply-templates mode="all-but-topicContainer"/>
                                </section>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
                </div>
            </div>
            
            <script src="dist/reveal.js"><!----></script>
            <script src="plugin/notes/notes.js"><!----></script>
            <script src="plugin/markdown/markdown.js"><!----></script>
            <script src="plugin/highlight/highlight.js"><!----></script>
            
            <script type="text/javascript">
                <!-- 
                    Full list of configuration options available here:
                    https://github.com/hakimel/reveal.js#configuration
                -->
               
                // More info about initialization and config:
                // - https://revealjs.com/initialization/
                // - https://revealjs.com/config/
                Reveal.initialize({
                
                    // parallaxBackgroundHorizontal: null,
                    // parallaxBackgroundImage: '<xsl:value-of select="$args.reveal.parallaxbackgroundimage"/>',
                    // parallaxBackgroundSize: '<xsl:value-of select="$args.reveal.parallaxbackgroundsize"/>',
                    // parallaxBackgroundVertical: null,
                    autoSlide: <xsl:value-of select="$args.reveal.autoslide"/>,
                    autoSlideStoppable: <xsl:value-of select="$args.reveal.autoslidestoppable"/>,
                    backgroundTransition: '<xsl:value-of select="$args.reveal.backgroundtransition"/>',
                    center: <xsl:value-of select="$args.reveal.center"/>,
                    controls: <xsl:value-of select="$args.reveal.controls"/>,
                    controlsLayout: '<xsl:value-of select="$args.reveal.controlsLayout"/>',
                    embedded: <xsl:value-of select="$args.reveal.embedded"/>,
                    fragments: <xsl:value-of select="$args.reveal.fragments"/>,
                    hash: true,
                    height: <xsl:value-of select="$args.reveal.height"/>,
                    hideAddressBar: <xsl:value-of select="$args.reveal.hideaddressbar"/>,
                    history: <xsl:value-of select="$args.reveal.hideaddressbar"/>,
                    keyboard: <xsl:value-of select="$args.reveal.keyboard"/>,
                    loop: <xsl:value-of select="$args.reveal.loop"/>,
                    margin: <xsl:value-of select="$args.reveal.margin"/>,
                    maxScale: <xsl:value-of select="$args.reveal.maxScale"/>,
                    minScale: <xsl:value-of select="$args.reveal.minScale"/>,
                    mouseWheel: <xsl:value-of select="$args.reveal.mousewheel"/>,
                    overview: <xsl:value-of select="$args.reveal.overview"/>,
                    plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ],
                    previewLinks: <xsl:value-of select="$args.reveal.previewlinks"/>,
                    progress: <xsl:value-of select="$args.reveal.progress"/>,
                    rtl: <xsl:value-of select="$args.reveal.rtl"/>,
                    slideNumber: <xsl:value-of select="$args.reveal.slidenumber"/>,
                    touch: <xsl:value-of select="$args.reveal.touch"/>,
                    transition: '<xsl:value-of select="$args.reveal.transition"/>',
                    transitionSpeed: '<xsl:value-of select="$args.reveal.transitionspeed"/>',
                    viewDistance: <xsl:value-of select="$args.reveal.viewdistance"/>,
                    width: <xsl:value-of select="$args.reveal.width"/>
                });
                
                Reveal.addEventListener( 'slidechanged', function( event ) {
                    zoomSection();
                } );
                
                $( document ).ready(function() {});
            </script>
        </body>
    </xsl:template>    
    
    <!--
        Process topics.
    -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]|*[contains(@class, ' slide/slide ')]">
        <!-- Just a placeholder which will be replaced with <section> -->
        <topicContainer>
            <xsl:apply-templates/>
        </topicContainer>
    </xsl:template>
    
<!--    <!-\- Override template to remove related-links block -\->
    <xsl:template match="*[contains(@class, ' topic/related-links ')]" name="topic.related-links">
        <!-\- Do nothing -\->
    </xsl:template>
    
    <!-\- Override template to remove nav titles -\->
    <xsl:template match="*" mode="get-navtitle">
        <!-\- Do nothing -\->
    </xsl:template>-->
        
    
    <!--
        Process codeblock elements.
        The attribute @outputclass defines the highlighted language.
        The highlighting is done by highlight.js.
        The supported languages of highlight.js can be found here:
        https://highlightjs.org/static/test.html
        
        You have to prefix the value of the @outputclass element with 'language-'.
        Example:
        To highlight a Java-codeblock, write:
        <codeblock outputclass="language-java">
            public void foo(String bar) {
                System.out.println("bar");
            }
        </codeblock>
    -->
    <xsl:template match="*[contains(@class,' pr-d/codeblock ')][contains(@outputclass, 'language-')]">
        <pre>
            <code>
                <xsl:attribute name="class">hljs <xsl:value-of select="substring-after(@outputclass,'language-')"/></xsl:attribute>
                <xsl:apply-templates/>
            </code>
        </pre>
    </xsl:template>
    
    <!-- Process slides - Override template from dita2xhtml-util.xsl -->
    <xsl:template match="nav | section | figure | article" mode="add-xhtml-ns" priority="20">
        <xsl:element name="section" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@* except @role | node()" mode="add-xhtml-ns"/>
        </xsl:element>
    </xsl:template>
    
    <!-- 
        Override template from dita2htmlImpl.xsl.
        DITA <section> elements have to be transformed to <div> elements,
        because reveal.js handles <section> elements as slides.
    -->
    <!-- section processor - div with no generated title -->
    <xsl:template match="*[contains(@class, ' topic/section ')]" name="topic.section">
        <div class="section">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="gen-toc-id"/>
            <xsl:call-template name="setidaname"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
            
            <!--<xsl:apply-templates select="." mode="dita2html:section-heading"/>-->
            
            <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))] | text() | comment() | processing-instruction()"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
        </div><xsl:value-of select="$newline"/>
    </xsl:template>
    
    <!-- Deep copy template -->
    <xsl:template match="*|text()|@*" mode="all-but-topicContainer">
        <xsl:choose>
            <xsl:when test="'topicContainer' = local-name()">
                <!-- Ignore -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates mode="all-but-topicContainer" select="@*"/>
                    <xsl:apply-templates mode="all-but-topicContainer"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Speaker notes -->
    <xsl:template match="*[contains(@class, ' topic/div ')][contains(@outputclass, 'notes')]|*[contains(@class, ' slide/speakernotes ')]">
        <aside class="notes">
            <xsl:apply-templates/>
        </aside>
    </xsl:template>
    
    <!-- reveal.js fragment elements -->
    <xsl:template match="*[contains(@class, ' topic/p ')]" name="topic.p">
        <xsl:choose>
            <xsl:when test="descendant::*[dita-ot:is-block(.)]">
                <div class="p">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setid"/>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:if test="@type">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@class"/>
                            <xsl:value-of select="@outputclass"/>
                            <xsl:value-of select="'fragment '"/>
                            <xsl:value-of select="@type"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@data-fragment-index">
                        <xsl:attribute name="data-fragment-index" select="@data-fragment-index"/>
                    </xsl:if>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setid"/>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>

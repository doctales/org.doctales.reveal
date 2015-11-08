<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
    This file is part of the DITA Open Toolkit plugin 'org.doctales.reveal'.
    The plugin is hosted on Github.com. The plugin is based on
    the JavaScript framework 'reveal.js'. 
-->

<xsl:stylesheet version="2.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Import the DITA2XHTML stylesheet to use its templates -->
    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    <!--<xsl:import href="plugin:org.dita.xhtml:xsl/xslhtml/dita2htmlImpl.xsl"/>-->
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <!-- <xsl:output method="html" encoding="utf-8" indent="yes"/> -->
    
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
    
    <!--
        The parameter $reveal.css defines the used theme.
        Possible values:
        "black", "beige", "blood", "league",
        "moon", "night", "serif", "simple",
        "sky", "solarized", "white"
    -->
    <xsl:param name="reveal.css" select="'black'"/>
    
    <!-- Display controls in the bottom right corner. -->
    <xsl:param name="reveal.controls" select="true()"/>
    
    <!-- Display a presentation progress bar. -->
    <xsl:param name="reveal.progress" select="true()"/>
    
    <!-- Display the page number of the current slide. -->
    <xsl:param name="reveal.slidenumber" select="false()"/>
    
    <!-- Push each slide change to the browser history. -->
    <xsl:param name="reveal.history" select="false()"/>
    
    <!-- Enable keyboard shortcuts for navigation. -->
    <xsl:param name="reveal.keyboard" select="true()"/>
    
    <!-- Enable the slide overview mode. -->
    <xsl:param name="reveal.overview" select="true()"/>
    
    <!-- Enable the vertical centering of slides. -->
    <xsl:param name="reveal.center" select="true()"/>
    
    <!-- Enable touch navigation on devices with touch input. -->
    <xsl:param name="reveal.touch" select="true()"/>
    
    <!-- Loop the presentation. -->
    <xsl:param name="reveal.loop" select="false()"/>
    
    <!-- Change the presentation direction to be right-to-left. -->
    <xsl:param name="reveal.rtl" select="false()"/>
    
    <!-- Turn fragments on and off globally. -->
    <xsl:param name="reveal.fragments" select="true()"/>
    
    <!--
        Flags if the presentation is running in an embedded mode,
        i.e. contained within a limited portion of the screen.
    -->
    <xsl:param name="reveal.embedded" select="false()"/>
    
    <!--
        Number of milliseconds between automatically proceeding to the
        next slide, disabled when set to 0, this value can be overwritten
        by using a data-autoslide attribute on your slides.
    -->
    <xsl:param name="reveal.autoslide" select="'0'"/>
    
    <!-- Stop auto-sliding after user input. -->
    <xsl:param name="reveal.autoslidestoppable" select="true()"/>
    
    <!-- Enable slide navigation via mouse wheel. -->
    <xsl:param name="reveal.mousewheel" select="false()"/>
    
    <!-- Hide the address bar on mobile devices. -->
    <xsl:param name="reveal.hideaddressbar" select="true()"/>
    
    <!-- Open links in an iframe preview overlay. -->
    <xsl:param name="reveal.previewlinks" select="false()"/>
    
    <!--
        Set the transition style. Possible values:
        "default", "cube", "page", "concave",
        "zoom", "linear", "fade", "none"
    -->
    <xsl:param name="reveal.transition" select="'default'"/>
    
    <!--
        Set the transition speed. Possible values:
        "default", "fast", "slow"
    -->
    <xsl:param name="reveal.transitionspeed" select="'default'"/>
    
    <!--
        Set the transition style for full page
        slide backgrounds. Possible values:
        "default", "none", "slide", "concave", "convex", "zoom"
    -->
    <xsl:param name="reveal.backgroundtransition" select="'default'"/>
    
    <!-- Set the number of slides away from the current that are visible. -->
    <xsl:param name="reveal.viewdistance" select="'3'"/>
    
    <!--
        Set the parallax background image.
        Example:
        "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"
    -->
    <xsl:param name="reveal.parallaxbackgroundimage" select="''" />
    
    <!--
        Set the parallax background size.
        Example:
        "2100px 900px"
    -->
    <xsl:param name="reveal.parallaxbackgroundsize" select="''"/>
    
    <!-- Generate vertical slides -->
    <xsl:param name="reveal.generate.vertical.slides" select="'true'"/>
    
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
        <link href="css/reveal.css" rel="stylesheet" />
        <link id="theme" href="css/theme/{$reveal.css}.css" rel="stylesheet"/>
        <!-- For syntax highlighting -->
        <link href="css/theme/zenburn.css" rel="stylesheet"/>
        <!-- For print -->
        <link href="css/print/paper.css" rel="stylesheet"/>
        <xsl:value-of select="$newline"/>
        <style type="text/css">
            div.body {
                overflow-y: auto  !important;
                overflow-x: hidden !important;
                height: 400px;
            }
            ::-webkit-scrollbar { 
                display: none; 
            }
            * {
                margin: 0;
            }
            html, body {
                height: 100%;
            }
            div.footer {
                background-color: green !important;
                position: relative !important;
                bottom: 0 !important;
                height: 100px !important;
                width: 300px !importants;
            }
        </style>
        <xsl:value-of select="$newline"/>
    </xsl:template>
    
    <!-- Add reveal.js metadata by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template name="generateDefaultCopyright">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    </xsl:template>
    
    <!-- Add title by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-panel-title-pfx">
        reveal.js
    </xsl:template>
    
    <!-- Add reveal.js scripts by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-scripts">
        <script src="js/jquery-1.11.3.min.js" type="text/javascript">
            <xsl:value-of select="$newline"/>
        </script>
        <script type="text/javascript">
            <!-- If the query includes 'print-pdf', include the PDF print sheet -->
            if (window.location.search.match(/print-pdf/gi)) {
            var link = document.createElement( 'link' );
            link.rel = 'stylesheet';
            link.type = 'text/css';
            link.href = 'css/print/pdf.css';
            document.getElementsByTagName( 'head' )[0].appendChild( link );
            }

            /*            
            function zoomSection() {
            }
            */
        </script>
        <!-- 
            [if lt IE 9]>
            <xsl:value-of select="$newline"/>
            <script src="lib/js/html5shiv.js"></script>
            <xsl:value-of select="$newline"/>
            <![endif]
        -->
        <xsl:value-of select="$newline"/>
    </xsl:template>
    
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
            <xsl:value-of select="$newline"/>
            <div class="reveal">
                <!-- Any section element inside of this container is displayed as a slide -->
                <xsl:value-of select="$newline"/>
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
                                    <section class="slide">
                                        <xsl:apply-templates mode="all-but-topicContainer"/>
                                    </section>
                                    <!-- For each subslide, copy to output but ignore sub-slides -->
                                    <xsl:for-each select=".//topicContainer">
                                        <section class="slide">
                                            <xsl:apply-templates mode="all-but-topicContainer"/>
                                        </section>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="'true' = $reveal.generate.vertical.slides">
                                        <!-- Generate vertical slides, so wrap in a <section> element -->
                                        <section class="slide">
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
                                <section class="slide">
                                    <xsl:apply-templates mode="all-but-topicContainer"/>
                                </section>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
                </div>
            </div>
        </body>
        <!--
            The $newline is necessary to avoid that the <script> tag
            will be collapsed to its shortform: <script/>
            The collapsed <script> tag might not be correctly displayed
            in the browser.
        -->
        <script src="lib/js/head.min.js" type="text/javascript">
            <xsl:value-of select="$newline"/>
        </script>
        <script src="js/reveal.js" type="text/javascript">
            <xsl:value-of select="$newline"/>
        </script>
        <script type="text/javascript">
            <!-- 
                Full list of configuration options available here:
                https://github.com/hakimel/reveal.js#configuration
            -->
            Reveal.initialize({
            controls: <xsl:value-of select="$reveal.controls"/>,
            progress: <xsl:value-of select="$reveal.progress"/>,
            slideNumber: <xsl:value-of select="$reveal.slidenumber"/>,
            history: <xsl:value-of select="$reveal.hideaddressbar"/>,
            keyboard: <xsl:value-of select="$reveal.keyboard"/>,
            overview: <xsl:value-of select="$reveal.overview"/>,
            center: <xsl:value-of select="$reveal.center"/>,
            touch: <xsl:value-of select="$reveal.touch"/>,
            loop: <xsl:value-of select="$reveal.loop"/>,
            rtl: <xsl:value-of select="$reveal.rtl"/>,
            fragments: <xsl:value-of select="$reveal.fragments"/>,
            embedded: <xsl:value-of select="$reveal.embedded"/>,
            autoSlide: <xsl:value-of select="$reveal.autoslide"/>,
            autoSlideStoppable: <xsl:value-of select="$reveal.autoslidestoppable"/>,
            mouseWheel: <xsl:value-of select="$reveal.mousewheel"/>,
            hideAddressBar: <xsl:value-of select="$reveal.hideaddressbar"/>,
            previewLinks: <xsl:value-of select="$reveal.previewlinks"/>,
            // transition: <xsl:value-of select="$reveal.transition"/>,
            // transitionSpeed: <xsl:value-of select="$reveal.transitionspeed"/>,
            // backgroundTransition: <xsl:value-of select="$reveal.backgroundtransition"/>,
            viewDistance: <xsl:value-of select="$reveal.viewdistance"/>,
            
            
            
            // The "normal" size of the presentation, aspect ratio will be preserved
            // when the presentation is scaled to fit different resolutions. Can be
            // specified using percentage units.
            width: 960,
            height: 700,
            
            // Factor of the display size that should remain empty around the content
            margin: 0.1,
            
            // Bounds for smallest/largest possible scale to apply to content
            minScale: 0.1,
            maxScale: 1.0,
            
            // Parallax scrolling
            // parallaxBackgroundImage: <xsl:value-of select="$reveal.parallaxbackgroundimage"/>,
            // parallaxBackgroundSize: <xsl:value-of select="$reveal.parallaxbackgroundsize"/>,
            
            theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
            transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none
            
            // Optional libraries used to extend on reveal.js
            dependencies: [
                { src: 'lib/js/classList.js', condition: function() { return !document.body.classList; } },
                { src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                { src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                { src: 'plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
                { src: 'plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
                { src: 'plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
            ]
            });
            
            Reveal.addEventListener( 'slidechanged', function( event ) {
            zoomSection();
            } );
            
            $( document ).ready(function() {
              alert('Hello JQuery');
              // Unwrap all sections that are not slide sections
              // $("section").not(".slide").unwrap();
              $("section").not(".slide").each(function() {
                $( this ).children().unwrap();
              });
            });
        </script>
    </xsl:template>    
    
    <!--
        Process topics.
    -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]">
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
                <xsl:attribute name="class">
                    hljs <xsl:value-of select="substring-after(@outputclass,'language-')" />
                </xsl:attribute>
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
    
</xsl:stylesheet>

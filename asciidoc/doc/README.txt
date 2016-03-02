README für das Generieren der Dokumentation via asciidoc
========================================================

== Ursprung und Links
Die Dokumentation basiert auf asciidoc (http://www.methods.co.nz/asciidoc/).

* User Guide: http://www.methods.co.nz/asciidoc/userguide.html
* Cheat Sheet: http://powerman.name/doc/asciidoc
* Maven-Integrationen: 
** https://github.com/wisdom-framework/wisdom/tree/master/extensions/wisdom-asciidoc-maven-plugin
** http://mvnrepository.com/artifact/org.wisdom-framework/wisdom-asciidoc-maven-plugin/0.8.0
** http://asciidoc.r-w-x.net/introduction.html

== Installationen

* Um die Dokumentation in HTML5-Format zu erhalten benötigt man die asciidoc-Distribution (z.B. von http://sourceforge.net/projects/asciidoc/files/latest/download) und einen Python-Interpreter (z.B. in Cygwin).
* Für das Funktionieren des Source-Highlightings braucht es zudem das Shell-Kommando source-highlight (Default in asciidoc.conf). Dazu ggf. das Cygwin-Paket source-highlight installieren.

== Verwendung
Gestartet wird die Übersetzung mit
[source,shell]
----
python <asciidoc-install-dir>/asciidoc.py <text-document-in-asciidoc-format>
----

=== Live Preview
Für kurze Change-Process-View-Zyklen zu erreichen gibt es (z.T. auf asciidoctor basierend) verschiedene Tools, s. z.B. https://plus.google.com/114112334290393746697/posts/14Pc4LXK5GU. Ein "poor-man's approach" ist das beiliegende autoasciidoc.sh zu verwenden um Änderungen in .txt-Files automatisch in HTML-Files zu übersetzen und ein Browser-Plugin (z.B. für Firefox das Add-On "Auto Reload") zu verwenden um die generierte HTML-Seite neu zu laden.

[source,shell]
----
. autoasciidoc.sh
----


<cfscript>
        a   = createObject('java','coldfusion.tools.CommandLineInvoker').init();
        b = a.main(['Compiler','-deploy','-webinf','WEBINF','-webroot','$webroot','-cfroot','$CFUSION_HOME','-srcdir', '$srcdir','-deploydir','$deploydir']);
        writedump(b);
        writedump(a);abort;
    writedump(a);
</cfscript>
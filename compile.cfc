component accessors=true {
    property name='artifactService' inject='artifactService'; 
    variables.echo = false;
    function run() {
        var serv = command('server info ').params(property="serverHomeDirectory").run(returnOutput=true, echo=variables.echo).trim();

        var WEBINF = fileSystemUtil.resolvePath( "#serv#/WEB-INF" );
        var CFUSION_HOME = "#WEBINF#cfusion"
        var WWWROOT = command('server info ').params(property="webroot").run(returnOutput=true, echo=variables.echo).trim();
        var JAVA_HOME = command('server info ').params(property="javaHome").run(returnOutput=true, echo=variables.echo).trim();
        var WEBINF = fileSystemUtil.resolvePath( "#CFUSION_HOME#/.." );
        var APP = fileSystemUtil.resolvePath( "./app" );
        var APP_COMPILED = fileSystemUtil.resolvePath( "./app_2" );
        var J2EEJAR = getInstance( 'HomeDir@constants' ) & '/lib/runwar-3.6.1-SNAPSHOT.jar';
        var classPath = "#J2EEJAR#:#WEBINF#\lib\*";
        print.line("J2EEJAR: #J2EEJAR#");
        print.line("CFUSION_HOME: #CFUSION_HOME#");
        print.line("WEBINF: #WEBINF#");
        print.line("APP: #APP#");
        print.line("APP_COMPILED: #APP_COMPILED#");
        print.line("WWWROOT: #WWWROOT#");
        print.line("JAVA_HOME: #JAVA_HOME#");

        var cfcompile = fileSystemUtil.resolvePath( "./cfCompilePassAll/cfcompile-pass-all.sh" );
        command('!sh #cfcompile#').params(CFUSION_HOME,classPath,WEBINF,WWWROOT,APP,APP_COMPILED,JAVA_HOME).run(echo=true);

    }
}
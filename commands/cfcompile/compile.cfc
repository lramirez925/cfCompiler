component accessors=true {
    property name='shell' inject='shell';
    
    function run(string pathToCompile="", string pathToCompileTo="", string serverName = '', boolean verbose = false) {
        var serverDetails ={};
        // If there's a name, check for a server with that name
		if( arguments.serverName.len() ) {
			serverDetails =  getInstance( 'serverService' ).resolveServerDetails( { name : arguments.serverName } );
		// If there's no from, check for a server in this working directory
		} else {
			serverDetails = getInstance( 'serverService' ).resolveServerDetails( { directory : shell.pwd() } );
		}

        //print.line(serializeJson(serverDetails)).toConsole();

        var foundServerName = serverDetails.SERVERINFO.NAME;
        var serverJsonString = command('server info').params(name=foundServerName).flags('json').run(returnOutput=true,echo=arguments.verbose).trim();

        var serverJson = deserializeJson(serverJsonString);
        var serv = serverDetails.serverinfo.serverHomeDirectory.trim();
        
        var WEBINF = fileSystemUtil.resolvePath( "#serv#/WEB-INF" );
        var CFUSION_HOME = "#WEBINF#cfusion"
        var WWWROOT = serverJson.webRoot.trim();
        var JAVA_HOME = serverJson.javaHome.trim();
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
        print.line("JAVA_HOME: #JAVA_HOME#").toConsole();

        var cfcompile = fileSystemUtil.resolvePath( "./modules/cfCompilePassAll/cfcompile-pass-all.sh" );
        print.redLine(cfcompile);
        print.MagentaLine(expandPath('.'));
        command('!sh #cfcompile#').params(CFUSION_HOME,classPath,WEBINF,WWWROOT,APP,APP_COMPILED,JAVA_HOME).run(echo=true);

    }
}
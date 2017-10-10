component accessors=true {
    
    function run(string pathToCompile="", string pathToCompileTo="", string serverName = '', boolean verbose = false) {
        var serverDetails ={};
        // If there's a name, check for a server with that name
		if( arguments.serverName.len() ) {
			serverDetails =  getInstance( 'serverService' ).resolveServerDetails( { name : arguments.serverName } );
		// If there's no serverName, check for a server in this working directory
		} else {
			serverDetails = getInstance( 'serverService' ).resolveServerDetails( { directory : shell.pwd() } );
		}

        var foundServerName = serverDetails.SERVERINFO.NAME;
        var serverJsonString = command('server info').params(name=foundServerName).flags('json').run(returnOutput=true,echo=arguments.verbose).trim();

        var serverJson = deserializeJson(serverJsonString);
        var serv = serverDetails.serverinfo.serverHomeDirectory.trim();
        
        var WEBINF = fileSystemUtil.resolvePath( "#serv#/WEB-INF" );
        var CFUSION_HOME = "#WEBINF#cfusion";
        var WWWROOT = serverJson.webRoot.trim();
        var JAVA_HOME = serverJson.javaHome.trim();
        var APP = fileSystemUtil.resolvePath( pathToCompile );
        var APP_COMPILED = arguments.pathToCompileTo;
        if(!len(APP_COMPILED)) {
            APP_COMPILED = fileSystemUtil.resolvePath( "#pathToCompile#_compiled" );
        }

        var J2EEJAR = getInstance( 'HomeDir@constants' ) & '/lib/runwar-3.6.1-SNAPSHOT.jar';
        var classPath = "#J2EEJAR#:#WEBINF#\lib\*";

        var cfcompile = fileSystemUtil.resolvePath( "/cfCompilePassAll/cfcompile-pass-all.sh" );
        print.line("J2EEJAR: #J2EEJAR#")
            .line("CFUSION_HOME: #CFUSION_HOME#")
            .line("WEBINF: #WEBINF#")
            .line("APP: #APP#")
            .line("APP_COMPILED: #APP_COMPILED#")
            .line("WWWROOT: #WWWROOT#")
            .line("JAVA_HOME: #JAVA_HOME#")
            .line("CFCOMPILE Path: #cfcompile#").toConsole();

        command('!sh #cfcompile#').params(CFUSION_HOME,classPath,WEBINF,WWWROOT,APP,APP_COMPILED,JAVA_HOME).run(echo=arguments.verbose);

    }
}
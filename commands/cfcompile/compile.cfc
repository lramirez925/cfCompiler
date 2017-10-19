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
        var classPath = "#J2EEJAR#:#WEBINF#lib/*";

        var cfcompile =  "/cfCompilePassAll/cfcompile-pass-all.sh";
        if(fileSystemUtil.isWindows()) {
            cfcompile = "/cfCompilePassAll/cfcompile-pass-all.bat";
        } 

        cfcompile = expandPath(cfcompile);

        print.line("J2EEJAR: #J2EEJAR#")
            .line("CFUSION_HOME: #CFUSION_HOME#")
            .line("WEBINF: #WEBINF#")
            .line("APP: #APP#")
            .line("APP_COMPILED: #APP_COMPILED#")
            .line("WWWROOT: #WWWROOT#")
            .line("JAVA_HOME: #JAVA_HOME#")
            .line("CFCOMPILE Path: #cfcompile#").toConsole();
  
        command('!#JAVA_HOME# -cp "#classPath#:#WEBINF#/lib/cfmx_bootstrap.jar:#WEBINF#/lib/cfx.jar" -Dcoldfusion.classPath=#CFUSION_HOME#/lib/updates,#CFUSION_HOME#/lib -Dcoldfusion.libPath=#CFUSION_HOME#/lib coldfusion.tools.CommandLineInvoker Compiler -deploy -webinf "#WEBINF#" -webroot "#WWWROOT#" -cfroot "#CFUSION_HOME#" -srcdir "#APP#" -deploydir "#APP_COMPILED#"').run(echo=arguments.verbose);

    }
}
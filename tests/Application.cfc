/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.ortussolutions.com
**************************************************************************************
*/
component{
	this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
	// any other application.cfc stuff goes below:
	this.sessionManagement = true;

	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/testbox" ] = expandPath("/testbox");
	this.mappings[ "/tests" ] = expandPath("/tests");
	//So we can test compiled vs uncompiled to make sure the same things are returned we can map both. 
	this.mappings[ "/app"] = expandPath("/app");
	this.mappings[ "/appCompiled"] = expandPath("/app_compile");
	//writedump(this);abort;
	// any orm definitions go here.

	// request start
	public boolean function onRequestStart( String targetPage ){

		return true;
	}
}
# cfCompiler
[![Build Status](https://travis-ci.org/lramirez925/cfCompiler.svg?branch=master)](https://travis-ci.org/lramirez925/cfCompiler)

Coldfusion compiler for command box

## To Use:
1. run the following command in the box environment. 
    * install git://github.com/lramirez925/cfCompiler.git
2. Start your coldfusion server to make sure the server files have been downloaded and installed in the correct locations. 
3. Run:
    * cfcompile compile ./app ./app_compiled
    * this will compile the app folder into a app_compiled folder. 
4. If you have multiple servers running you can pass a server name as a final parameter and it will use that server instance. 

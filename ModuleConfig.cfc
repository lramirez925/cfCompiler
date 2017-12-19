component {
	
	this.title 				= "CFCompile CI";
	this.modelNamespace		= "commandbox-cfcompile";
	this.cfmapping			= "commandbox-cfcompile";
	this.autoMapModels		= true;
	// Need these loaded up first so I can do my job.
	this.dependencies 		= [  ];

	function configure() {
		/*settings = {
			'exportOnStop' = false,
			'autoTransferOnUpgrade' = true
		};*/
		
		interceptors = [
			
		];
	}
}

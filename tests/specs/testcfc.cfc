component extends="testbox.system.BaseSpec" {
	function run(){

		/** 
		* describe() starts a suite group of spec tests.
		* Arguments:
		* @title The title of the suite, Usually how you want to name the desired behavior
		* @body A closure that will resemble the tests to execute.
		* @labels The list or array of labels this suite group belongs to
		* @asyncAll If you want to parallelize the execution of the defined specs in this suite group.
		* @skip A flag that tells TestBox to skip this suite group from testing if true
		*/
		describe( "A Spec which test the testcfc to make sure it is the same when compiled", function(){
		//Make sure everything compiles the same. If things are found to be different then we can expand here. for now these are almost simply smoke tests

			it("testString simply returns a string make sure they are the same. ", function(){
				var original  = new app.testcfc();
				var compiled  = new appCompiled.testcfc();
				expect( compiled.testReturnString() ).toBe( original.testReturnString() );
			});
			
			it("testReturnNumber simply returns a string make sure they are the same. ", function(){
				var original  = new app.testcfc();
				var compiled  = new appCompiled.testcfc();
				expect( compiled.testReturnNumber() ).toBe( original.testReturnNumber() );
			});
			
			
		
		});


	}
}
$('button').click(function(){

	console.log('Simple Width', $('#dom01').width());
	console.log('Simple Height', $('#dom01').height());
	console.log('Actual Width', $('#dom01').innerWidth());	// Including Padding without Border Width if exists
	console.log('Actual Height', $('#dom01').innerHeight());	// Including Padding without Border Width if exists
	console.log('Total Width', $('#dom01').outerWidth());	// Including Padding, Border Width if exists
	console.log('Total Height', $('#dom01').outerHeight());	// Including Padding, Border Width if exists

});
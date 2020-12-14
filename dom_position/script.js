$('button').click(function(){

	console.log('Left', $('#dom01').offset().left);
	console.log('Top', $('#dom01').offset().top);
	console.log('Left of Dom 2', $('#dom02').offset().left);    // Position from Screen Left
	console.log('Left of Dom 2 (related to Parent)', $('#dom02').position().left); // Position Left related to Parent DOM
	console.log('Top of Dom 2', $('#dom02').offset().top);    // Position from Screen Top
	console.log('Top of Dom 2 (related to Parent)', $('#dom02').position().top); // Position Top related to Parent DOM
	console.log('Left of Dom 3', $('#dom03').offset().left);    // Position from Screen Left
	console.log('Left of Dom 3 (related to Parent)', $('#dom03').position().left); // Position Left related to Parent DOM
	console.log('Top of Dom 3', $('#dom03').offset().top);    // Position from Screen Top
	console.log('Top of Dom 3 (related to Parent)', $('#dom03').position().top); // Position Top related to Parent DOM

});
// ************** ADD Class ************** //
$('.action.add').click(function(){

	$('#css_styling').addClass('smaller');

});

// *********** REMOVE Class ************* //
$('.action.remove').click(function(){

	$('#css_styling').removeClass('smaller');

});

// *********** CHECK Class ************* //
$('.action.check').click(function(){

	if($('#css_styling').hasClass('smaller')){
		alert("Yes");
	} else {
		alert('No');
	}

});
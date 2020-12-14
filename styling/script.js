// ************** ADD STYLING ************** //
$('.action.add').click(function(){

	// Apply CSS Styling with Single Styling
	// $('#css_styling').css("borderColor", "red");
	// $('#css_styling').css("border-color", "red");

	// CSS Styling ( Multiple Effects )
	// $('#css_styling').css({
	// 	"border-color": "red",
	// 	"width": "125px",
	// 	"height": "125px",
	// });

	// CSS Styling with Animatioin ( 500 milli-seconds)
	$('#css_styling').css({
		"border-color": "red",
		"background-color": "red"
	});

	$('#css_styling').animate({
		"width": "125px",
		"height": "125px",
	}, 500);

});

// *********** REMOVE STYLING ************* //
$('.action.remove').click(function(){

	$('#css_styling').css('background-color', '');

});

// *********** REMOVE ALL STYLING ************* //
$('.action.remove_all').click(function(){

	$('#css_styling').removeAttr('style');

});
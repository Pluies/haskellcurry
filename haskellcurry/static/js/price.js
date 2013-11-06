$(function() {
	window.Curry = {
		veggie: false,
		garlicNaan: false,
		price: function() {
			return (this.veggie ? 10 : 11) + (this.garlicNaan ? 1 : 0);
		},
		displayPrice: function() {
			$('#price #amount').html(this.price());
		}
	};

	$('select').change(function(e){
		var selected = $("option:selected", this)[0].innerHTML;
		if (selected === 'Hot' || selected === 'Medium' || selected === 'Mild') return; // don't care

		window.Curry.veggie = !!selected.match(/vegetable|aloo|dal makhani/i);
		window.Curry.displayPrice();
	});

	$('input[type=radio]').change(function(e){
		window.Curry.garlicNaan = ($(this).val() === "1"); // yesod is weird
		window.Curry.displayPrice();
	});

	// Pre-select "no" for garlic naan
	$($('input[type=radio]')[1]).click();
	window.Curry.displayPrice();
});

/// <reference path="jquery-1.4.1-vsdoc.js"/>
autocalculateIsEnableForField = function (betTypeId) {
	var availableBetElement = $('#fields_' + betTypeId);

	if (availableBetElement.find('.calculated-check:checked').length > 0)
		return false;
	return true;
}

// Uses the availableBetData to fill the available bet fields
setAvailableBetData = function (availableBetData) {
	var availableBetElement = $('#fields_' + availableBetData.BetTypeId);

	// Manually dispatch change event (used by 'Auto disable invalid bets')
	availableBetElement.find('.global-score').val(availableBetData.Score).change();
	availableBetElement.find('.local-score').val(availableBetData.ScoreLocal).change();
	availableBetElement.find('.visitor-score').val(availableBetData.ScoreVisitor).change();

	availableBetElement.find('.visitor-spread').val(availableBetData.SpreadVisitor).change();
	availableBetElement.find('.local-spread').val(availableBetData.SpreadLocal).change();

	availableBetElement.find('.visitor').val(availableBetData.Visitor).change();
	availableBetElement.find('.local').val(availableBetData.Local).change();

	availableBetElement.find('.global-over').val(availableBetData.PriceOver).change();
	availableBetElement.find('.local-over').val(availableBetData.OverLocal).change();
	availableBetElement.find('.visitor-over').val(availableBetData.OverVisitor).change();
	availableBetElement.find('.global-under').val(availableBetData.PriceUnder).change();
	availableBetElement.find('.local-under').val(availableBetData.UnderLocal).change();
	availableBetElement.find('.visitor-under').val(availableBetData.UnderVisitor).change();
	availableBetElement.find('.proposition').val(availableBetData.PropositionPrice).change();
	disableAutoCalculate(availableBetElement);
}

// Update labels using the visitor team name
updateVisitorLabels = function (visitorAlias) {
	$('#tabs .visitor').each(function () {
		$('[for=' + this.id + ']').html("Precio " + visitorAlias.PrintName + ":");
	});

	$('#tabs .visitor-score').each(function () {
		$('[for=' + this.id + ']').html("Puntaje/Carreraje " + visitorAlias.PrintName + ":");
	});

	$('#tabs .visitor-spread').each(function () {
		$('[for=' + this.id + ']').html("Gavela " + visitorAlias.PrintName + ":");
	});

	$('#tabs .visitor-over').each(function () {
		$('[for=' + this.id + ']').html("Precio (+) " + visitorAlias.PrintName + ":");
	});

	$('#tabs .visitor-under').each(function () {
		$('[for=' + this.id + ']').html("Precio (-) " + visitorAlias.PrintName + ":");
	});
}

// Update labels using the local team name
updateLocalLabels = function (localAlias) {
	$('#tabs .local').each(function () {
		$('[for=' + this.id + ']').html("Precio " + localAlias.PrintName + ":");
	});

	$('#tabs .local-score').each(function () {
		$('[for=' + this.id + ']').html("Puntaje/Carreraje " + localAlias.PrintName + ":");
	});

	$('#tabs .local-spread').each(function () {
		$('[for=' + this.id + ']').html("Gavela " + localAlias.PrintName + ":");
	});

	$('#tabs .local-over').each(function () {
		$('[for=' + this.id + ']').html("Precio (+) " + localAlias.PrintName + ":");
	});

	$('#tabs .local-under').each(function () {
		$('[for=' + this.id + ']').html("Precio (-) " + localAlias.PrintName + ":");
	});
}

// Autocalculate lines
var loader = $('<img />').attr('src', '/Content/Images/ajax-loader-small.gif').addClass('loader');
autocalculateLines = function () {
	$(this).parent().find('.loader').remove();
	$(this).after(loader);

	ApplyMathematicalSplitToSpread();

	// Get 'game' category bets
	var GameDefaultBetType = $('#DefaultBetType');
	$.getJSON(ControllerActions.CalculateLineValues, {
		Visitor: GameDefaultBetType.find('.visitor').val(),
		Local: GameDefaultBetType.find('.local').val(),
		SpreadVisitor: GameDefaultBetType.find('.visitor-spread').val(),
		SpreadLocal: GameDefaultBetType.find('.local-spread').val(),
		PriceOver: GameDefaultBetType.find('.global-over').val(),
		PriceUnder: GameDefaultBetType.find('.global-under').val(),
		OverLocal: GameDefaultBetType.find('.local-over').val(),
		OverVisitor: GameDefaultBetType.find('.visitor-over').val(),
		UnderLocal: GameDefaultBetType.find('.local-under').val(),
		UnderVisitor: GameDefaultBetType.find('.visitor-under').val(),
		Score: GameDefaultBetType.find('.global-score').val(),
		ScoreVisitor: GameDefaultBetType.find('.visitor-score').val(),
		ScoreLocal: GameDefaultBetType.find('.local-score').val(),
		PropositionPrice: GameDefaultBetType.find('.proposition').val(),
		BetTypeId: GameDefaultBetType.find('.bettype').val(),
		DivisionId: $('#DivisionCode').val(),
		Type: GameTemplateType
	},
		function (response) {
			$.each(response, function (i, item) {
				if (autocalculateIsEnableForField(item.BetTypeId))
					setAvailableBetData(item);
			});

			ApplyMathematicalSplitToGlobalScores();

			CalculateTotalsLineValues();
		}
	);
}

CalculateTotalsLineValues = function () {
	// Get 'totals' category bets
	var TotalsDefaultBetType = $('#DefaultBetTypeForTotals');
	$.getJSON(ControllerActions.CalculateLineValues, {
		Visitor: TotalsDefaultBetType.find('.visitor').val(),
		Local: TotalsDefaultBetType.find('.local').val(),
		SpreadVisitor: TotalsDefaultBetType.find('.visitor-spread').val(),
		SpreadLocal: TotalsDefaultBetType.find('.local-spread').val(),
		PriceOver: TotalsDefaultBetType.find('.global-over').val(),
		PriceUnder: TotalsDefaultBetType.find('.global-under').val(),
		OverLocal: TotalsDefaultBetType.find('.local-over').val(),
		OverVisitor: TotalsDefaultBetType.find('.visitor-over').val(),
		UnderLocal: TotalsDefaultBetType.find('.local-under').val(),
		UnderVisitor: TotalsDefaultBetType.find('.visitor-under').val(),
		Score: TotalsDefaultBetType.find('.global-score').val(),
		ScoreVisitor: TotalsDefaultBetType.find('.visitor-score').val(),
		ScoreLocal: TotalsDefaultBetType.find('.local-score').val(),
		PropositionPrice: TotalsDefaultBetType.find('.proposition').val(),
		BetTypeId: TotalsDefaultBetType.find('.bettype').val(),
		DivisionId: $('#DivisionCode').val(),
		Type: TotalsTemplateType
	}, function (response) {
		$.each(response, function (i, item) {
			if (autocalculateIsEnableForField(item.BetTypeId))
				setAvailableBetData(item);
		});

		ApplySplitToIndividualScores(null, false);
	});
}

ApplyMathematicalSplitToGlobalScores = function () {
	// Get global score
	var GlobalScore = $('#DefaultBetTypeForTotals').find('.global-score').val();
	if ( GlobalScore  == undefined || GlobalScore == null)
		return;

	// Divide global score among periods
	var Periods = {};
	DivideValueAmongPeriods( GlobalScore, Periods );

	// Fill the global score fields
	$('#game-lines .global-score').each(function (i, item) {
		// Get period div
		var PeriodDivision = $(this).parent().parent().parent();

		// Get period info
		var PeriodFrequency = PeriodDivision.find('input[name=PeriodFrequency]').val();
		var PeriodIndex = PeriodDivision.find('input[name=PeriodIndex]').val();

		//set computed value
		$(this).val(Periods[PeriodFrequency + '_' + PeriodIndex]);
		$(this).change();
	});
}

ApplyMathematicalSplitToSpread = function () {
	// This split only applies to sports whose default bet type for game has a spread
	var DefaultSpread = $('#DefaultBetType').find('.visitor-spread').val();
	if (DefaultSpread == undefined || DefaultSpread == null)
		return;

	// Get default bet prices
	var VisitorPrice = $('#DefaultBetType').find('.visitor').val();
	var LocalPrice = $('#DefaultBetType').find('.local').val();

	// Divide spreads among periods
	var Spreads = {};
	DivideValueAmongPeriods(Math.abs(DefaultSpread), Spreads);

	// Fill the visitor spread
	$('#game-lines .visitor-spread').each(function (i, item) {
		// Get period div
		var PeriodDivision = $(this).parent().parent().parent();
		
		// Get period info
		var PeriodFrequency = PeriodDivision.find('input[name=PeriodFrequency]').val();
		var PeriodIndex = PeriodDivision.find('input[name=PeriodIndex]').val();

		// Get period spread
		var PeriodSpread = Spreads[PeriodFrequency + '_' + PeriodIndex];

		// Assign spread
		if (localIsMale())
			$(this).val(PeriodSpread);
		else
			$(this).val(-PeriodSpread);

		// Assign price
		var betContainer = $(this).parent().parent();
		betContainer.find('.visitor').val(VisitorPrice);

		$(this).change();
	});

	// Fill the visitor spread
	$('#game-lines .local-spread').each(function (i, item) {
		// Get period div
		var PeriodDivision = $(this).parent().parent().parent();

		// Get period info
		var PeriodFrequency = PeriodDivision.find('input[name=PeriodFrequency]').val();
		var PeriodIndex = PeriodDivision.find('input[name=PeriodIndex]').val();

		// Get period spread
		var PeriodSpread = Spreads[PeriodFrequency + '_' + PeriodIndex];

		// Assign spread
		if (localIsMale())
			$(this).val(-PeriodSpread);
		else
			$(this).val(PeriodSpread);

		// Assign price
		var betContainer = $(this).parent().parent();
		betContainer.find('.local').val(LocalPrice);

		$(this).change();
	});
}

function DivideValueAmongPeriods( Value, Periods ) {
	var FloorValue = Math.floor(Value);

	// Syntax ResultArray["PeriodFrequency_PeriodIndex"]
	// Examples:
	//  Periods['2_1'] -> First half
	//  Periods['3_2'] -> Second third
	//  Periods['9_4'] -> Fourth innning
	
	// Divide periods unto halfs
	Periods['2_2'] = FloorValue / 2;
	Periods['2_1'] = Value - Periods['2_2'];

	// Divide periods unto thirds
	Periods['3_1'] = Math.ceil(Value / 3);
	Periods['3_2'] = Math.ceil((Value - Periods['3_1']) / 2);
	Periods['3_3'] = Value - Periods['3_1'] - Periods['3_2'];

	// Divide periods unto quarters
	Periods['4_2'] = Math.floor(Periods['2_1']) / 2;
	Periods['4_1'] = Periods['2_1'] - Periods['4_2'];
	Periods['4_4'] = Math.floor(Periods['2_2']) / 2;
	Periods['4_3'] = Periods['2_2'] - Periods['4_4'];
}

ApplySplitToIndividualScores = function (targetPeriodDiv, ignoreAutomaticCalcLock) {
	$.getJSON(
		ControllerActions.GetSport,
		{
			SportId: $('#Sport').val()
		},
		function (response) {
			if (response.CalcPointsFromTable) {
				ApplySplitToIndividualScoresFromTable(targetPeriodDiv, ignoreAutomaticCalcLock);
			}
			else
				ApplyMathematicalSplitToIndividualScores(targetPeriodDiv, ignoreAutomaticCalcLock);
		}
	);
}

ApplySplitToIndividualScoresFromTable = function (targetPeriodDiv, ignoreAutomaticCalcLock) {
	// Get 'game' category bets
	var GameDefaultBetType = $('#DefaultBetType');
	$.getJSON(ControllerActions.GetTemplatePeriods, {
		Visitor: GameDefaultBetType.find('.visitor').val(),
		Local: GameDefaultBetType.find('.local').val(),
		SpreadVisitor: GameDefaultBetType.find('.visitor-spread').val(),
		SpreadLocal: GameDefaultBetType.find('.local-spread').val(),
		PriceOver: GameDefaultBetType.find('.global-over').val(),
		PriceUnder: GameDefaultBetType.find('.global-under').val(),
		OverLocal: GameDefaultBetType.find('.local-over').val(),
		OverVisitor: GameDefaultBetType.find('.visitor-over').val(),
		UnderLocal: GameDefaultBetType.find('.local-under').val(),
		UnderVisitor: GameDefaultBetType.find('.visitor-under').val(),
		Score: GameDefaultBetType.find('.global-score').val(),
		ScoreVisitor: GameDefaultBetType.find('.visitor-score').val(),
		ScoreLocal: GameDefaultBetType.find('.local-score').val(),
		PropositionPrice: GameDefaultBetType.find('.proposition').val(),
		BetTypeId: GameDefaultBetType.find('.bettype').val(),
		DivisionId: $('#DivisionCode').val(),
		Type: GameTemplateType
	},
		function (response) {
			ApplyTableSplitToIndividualScores(response, targetPeriodDiv, ignoreAutomaticCalcLock);
			loader.remove();
		}
	);
}

ApplyTableSplitToIndividualScores = function (TemplatePeriods, targetPeriodDiv, ignoreAutomaticCalcLock) {
	var target = $('#game-lines #BetTypes').children('div');
	if (targetPeriodDiv != null)
		target = targetPeriodDiv;

	target.each(function (i, item) {
		var PeriodDiv = $(this);

		// Get period info
		var PeriodId = PeriodDiv.find('input[name=PeriodId]').val();

		// Get global score
		var GlobalScore = GetPeriodGlobalScore(PeriodDiv);
		if (GlobalScore == null)
			return;
		var FloorGlobalScore = Math.floor(GlobalScore);

		// Determine 'IsInteger'
		var IsInteger;
		if (GlobalScore == FloorGlobalScore)
			IsInteger = true;
		else
			IsInteger = false;

		var TemplatePeriod = GetTemplatePeriod(TemplatePeriods, PeriodId, IsInteger);

		// Compute solos score
		var FemaleScore = (FloorGlobalScore / 2);
		var MaleScore = GlobalScore - FemaleScore;

		// Validate that automatic calculation is enabled
		var SoloBetTypeIdString = PeriodDiv.find('.local-score').parent().parent().attr("id");
		if (SoloBetTypeIdString == null && SoloBetTypeIdString == undefined)
			return;
		var betTypeId = /\bfields_([\S]*)\b/.exec(SoloBetTypeIdString)[1];
		if ( !ignoreAutomaticCalcLock && !autocalculateIsEnableForField(betTypeId))
			return;

		// Apply values
		if (localIsMale() == true) {
			PeriodDiv.find('.local-score').val(MaleScore + parseFloat(TemplatePeriod.AddToLocal)).change();
			PeriodDiv.find('.visitor-score').val(FemaleScore + parseFloat(TemplatePeriod.AddToVisitor)).change();
		}
		else {
			PeriodDiv.find('.local-score').val(FemaleScore + parseFloat(TemplatePeriod.AddToLocal)).change();
			PeriodDiv.find('.visitor-score').val(MaleScore + parseFloat(TemplatePeriod.AddToVisitor)).change();
		}

		// Set further autocalculate block
		PeriodDiv.find('.local-score').each(function (index, element) {
			disableAutoCalculate($(element).parent().parent());
		});
	});
}

GetTemplatePeriod = function (TemplatePeriods, PeriodId, IsInteger) {
	var Period = null;
	$.each(TemplatePeriods, function (index, item) {
		if (item.IsInteger == IsInteger && item.PeriodId == PeriodId)
			Period = item;
	});

	if (Period != null)
		return Period;

	Period = new Object();
	Period.AddToLocal = 0;
	Period.AddToVisitor = 0;
	return Period;
}

ApplyMathematicalSplitToIndividualScores = function (targetPeriodDiv, ignoreAutomaticCalcLock) {
	var target = $('#game-lines #BetTypes').children('div');
	if (targetPeriodDiv != null)
		target = targetPeriodDiv;

	target.each(function (i, item) {
		var PeriodDiv = $(this);
		// Get global score
		var GlobalScore = GetPeriodGlobalScore(PeriodDiv);
		if (GlobalScore == null)
			return;

		// Compute solos score
		var Spread = GetPeriodSpread(PeriodDiv);
		if (Spread == null)
			return;
		var FemaleSpread = Math.floor(Spread) / 2;
		var MaleSpread = -(Spread - FemaleSpread);

		var FloorGlobalScore = Math.floor(GlobalScore);
		var FemaleScore = (FloorGlobalScore / 2) - FemaleSpread;
		var MaleScore = GlobalScore - FemaleScore;

		// Validate that automatic calculation is enabled
		var SoloBetTypeIdString = PeriodDiv.find('.local-score').parent().parent().attr("id");
		if (SoloBetTypeIdString == null && SoloBetTypeIdString == undefined)
			return;
		var betTypeId = /\bfields_([\S]*)\b/.exec(SoloBetTypeIdString)[1];
		if ( !ignoreAutomaticCalcLock && !autocalculateIsEnableForField(betTypeId))
			return;

		// Apply values
		if (localIsMale() == true) {
			PeriodDiv.find('.local-score').val(MaleScore).change();
			PeriodDiv.find('.visitor-score').val(FemaleScore).change();
		}
		else {
			PeriodDiv.find('.local-score').val(FemaleScore).change();
			PeriodDiv.find('.visitor-score').val(MaleScore).change();
		}

		// Set further autocalculate block
		PeriodDiv.find('.local-score').each(function (index, element) {
			disableAutoCalculate($(element).parent().parent());
		});
	});
	loader.remove();
}

GetPeriodGlobalScore = function (PeriodDiv) {
	// Get global score
	var GlobalScore;

	// Get 'default bet type for totals' in order to calculate the 'solo' score for full game
	if (PeriodDiv.find('input[name=PeriodFrequency]').val() != 1) {
		GlobalScore = $(PeriodDiv).find('.global-score').val();
	}
	else {
		GlobalScore = $('#DefaultBetTypeForTotals').find('.global-score').val();
	}

	if (GlobalScore == undefined || GlobalScore == null)
		return null;

	return GlobalScore;
}

GetPeriodSpread = function (PeriodDiv) {
	var Spread;

	if (PeriodDiv.find('input[name=PeriodFrequency]').val() == 1 &&
			$('#DefaultBetType').find('.local-spread').length > 0)
		Spread = $('#DefaultBetType').find('.local-spread:first').val();
	else
		Spread = PeriodDiv.find('.local-spread:first').val();

	return Math.abs(parseFloat(Spread));
}

localIsMale = function () {
	var GameDefaultBetType = $('#DefaultBetType');
	var Visitor = parseFloat(GameDefaultBetType.find('.visitor').val());
	var Local = parseFloat(GameDefaultBetType.find('.local').val());
	var SpreadVisitor = parseFloat(GameDefaultBetType.find('.visitor-spread').val());
	var SpreadLocal = parseFloat(GameDefaultBetType.find('.local-spread').val());

	return Local < Visitor || SpreadLocal < SpreadVisitor;
}

$(function () {
	// Autocalculate lines button
	$('#autocalc-btn').click(autocalculateLines);

	// Spread auto-completion
	$('#tabs .visitor-spread').live('blur', function () {
		var currentBetContainer = $(this).parent().parent();
		currentBetContainer.find('.local-spread').val(-$(this).val()).change();
	});

	// Price auto-completion
	$('#tabs .visitor').live('blur', function () {
		autoCompletePrice($(this), '.local');
	});

	// Price auto-completion
	$('#tabs .visitor-over').live('blur', function () {
		autoCompletePrice($(this), '.visitor-under');
	});

	// Price auto-completion
	$('#tabs .local-over').live('blur', function () {
		autoCompletePrice($(this), '.local-under');
	});

	// Price auto-completion
	$('#tabs .global-over').live('blur', function () {
		autoCompletePrice($(this), '.global-under');
	});

	// Price auto-completion
	$('#BetTypes .global-score').live('blur', function () {
		ApplySplitToIndividualScores($(this).parent().parent().parent(), true);
	});

	// Get the equivalent price for current element and set it on destinationSelector
	// @Param sourceElement element containing base price
	// @Param destinationSelector element that will be filled with the equivalence price
	autoCompletePrice = function (sourceElement, destinationSelector) {
		// Add loader image
		sourceElement.parent().find('img').remove();
		var loader = $('<img />').attr('src', LoaderImgUrl);
		sourceElement.parent().append(loader);

		// Get other nomial
		var currentFieldParent = sourceElement.parent();
		var currentBetContainer = sourceElement.parent().parent();
		$.getJSON(ControllerActions.GetNomialValue, { BaseNomial: sourceElement.val(), SportCode: $('#Sport').val() }, function (data) {
			// Remove loader image
			currentFieldParent.find('img').fadeOut('slow', function () {
				currentFieldParent.find('img').remove();
			});

			currentBetContainer.find(destinationSelector).val(data).change();
		});
	}


	// Auto disable invalid bets
	$('.availableBet :text').live('change',
	function () {
		var parentAvailableBet = $(this).closest('.availableBet');
		var elements = parentAvailableBet.find(':text');
		var emptyElementFound = false;
		elements.each(function (index, element) {
			if (isNaN($(element).val()) || Math.abs($(element).val()) == 0)
				emptyElementFound = true;
		});

		if (emptyElementFound) {
			// Disabled
			parentAvailableBet.find('.active-check').removeAttr('checked').attr('disabled', 'disabled');
		} else {
			// Enabled
			parentAvailableBet.find('.active-check').attr('checked', 'checked').removeAttr('disabled');
		}
	});
});

// trigger AutoDisableAvailableBets
triggerAutoDisableAvailableBets = function () {
	// Trigger validation for existant elements
	$('.availableBet :text').change();
}

// Set further autocalculate block
disableAutoCalculate = function (availableBet) {
	availableBet.find('.calculated-check').attr('checked', true);
}

function selectChange(varColumn)
{
	// Check for special case of "All" filter
	var filt = cboDept.options[cboDept.selectedIndex].text;
	if (filt == 'All')
	{
		tdcStaff.FilterColumn = '';
		tdcStaff.FilterValue = '';
		tdcStaff.FilterCriterion = '';
	}
	else
	{
		tdcStaff.FilterColumn = varColumn;
		tdcStaff.FilterValue = filt;
		tdcStaff.FilterCriterion = '=';
	}

	tdcStaff.Reset();
}


function colSort(varColumn)
{
	//Check to see if we are sorting on the same column
	//If so assume user simply wishes to invert sort order
	if (varColumn == tdcStaff.SortColumn)
	{
		//Invert order
		tdcStaff.SortAscending = !tdcStaff.SortAscending;
	}
	else
	{
		//Use current sort order for new column sort
		tdcStaff.SortColumn = varColumn;
	}
	tdcStaff.Reset();
}

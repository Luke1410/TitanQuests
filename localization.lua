function TitanQuestsLocalize()
   local locale = GetLocale()
	
   if ( locale == "enUS" ) then
      TitanQuestLocalizeEN()
	elseif ( locale == "deDE" ) then
		TitanQuestLocalizeDE()
	elseif ( locale == "frFR" ) then
		TitanQuestLocalizeFR();
	elseif ( locale == "esES" ) then
		TitanQuestLocalizeES();
	elseif ( locale == "mxMX" ) then
		TitanQuestLocalizeMX();
	elseif ( locale == "ruRU" ) then
		TitanQuestLocalizeRU();
	end
end
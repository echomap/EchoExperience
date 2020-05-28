-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
  SI_ECHOEXP_MESSAGE = " ist aktiv!",

  ------------------------------

}
------------------------------
-- 
--TODO use GetChatFontSize()  to get size
--https://wiki.esoui.com/Text_Formatting
for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end
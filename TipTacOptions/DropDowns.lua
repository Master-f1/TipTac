TipTacDropDowns = {};
local cfg = TipTac_Config;

-- Shared Media
local LSM = LibStub and LibStub("LibSharedMedia-3.0",1);

-- DropDown Lists
TipTacDropDowns.FontFlags = {
	["Нет"] = "",
	["Тонкий"] = "OUTLINE",
	["Толстый"] = "THICKOUTLINE",
};
TipTacDropDowns.AnchorType = {
	["Обычный"] = "normal",
	["Указатель мыши"] = "mouse",
	["Исходный"] = "parent",
};

TipTacDropDowns.AnchorPos = {
	["Сверху"] = "TOP",
	["Сверху слева"] = "TOPLEFT",
	["Сверху справа"] = "TOPRIGHT",
	["Снизу"] = "BOTTOM",
	["Снизу слева"] = "BOTTOMLEFT",
	["Снизу справа"] = "BOTTOMRIGHT",
	["Слева"] = "LEFT",
	["Справа"] = "RIGHT",
	["Центр"] = "CENTER",
};

TipTacDropDowns.BarTextFormat = {
	["Не показывать"] = "none",
	["Процент"] = "percent",
	["Число"] = "value",
	["Число (кратко)"] = "auto",
	["Нехватка"] = "deficit",
};

--------------------------------------------------------------------------------------------------------
--                                        Default DropDown Init                                       --
--------------------------------------------------------------------------------------------------------

local function Default_SelectValue(dropDown,entry,index)
	cfg[dropDown.option.var] = entry.value;
	TipTac:ApplySettings();
end

function TipTacDropDowns.Default_Init(dropDown,list)
	dropDown.SelectValueFunc = Default_SelectValue;
	local tbl;
	for text, option in next, dropDown.option.list do
		tbl = list[#list + 1]
		tbl.text = text; tbl.value = option;
	end
end;

--------------------------------------------------------------------------------------------------------
--                                          Lib Shared Media                                          --
--------------------------------------------------------------------------------------------------------

local LibSharedMediaSubstitute = not LSM and {
	["font"] = {
		["Friz Quadrata TT"] = "Fonts\\FRIZQT__.TTF",
		["Arial Narrow"] = "Fonts\\ARIALN.TTF",
		["Skurri"] = "Fonts\\SKURRI.TTF",
		["Morpheus"] = "Fonts\\MORPHEUS.TTF",
	},
	["background"] = {
		["Blizzard Tooltip"] = "Interface\\Tooltips\\UI-Tooltip-Background",
		["Solid"] = "Interface\\Buttons\\WHITE8X8",
	},
	["border"] = {
		["Нет"] = "Interface\\None",
		["Blizzard Dialog"]  = "Interface\\DialogFrame\\UI-DialogBox-Border",
		["Blizzard Tooltip"] = "Interface\\Tooltips\\UI-Tooltip-Border",
		["Solid"] = "Interface\\Buttons\\WHITE8X8",
	},
	["statusbar"] = {
		["Blizzard StatusBar"] = "Interface\\TargetingFrame\\UI-StatusBar",
	},
} or nil;

if (LSM) then
	LSM:Register("border","Solid","Interface\\Buttons\\WHITE8X8");
end

function TipTacDropDowns.SharedMediaLib_Init(dropDown,list)
	local query = dropDown.option.media;
	dropDown.SelectValueFunc = Default_SelectValue;
	local tbl;
	if (LSM) then
		for _, name in next, LSM:List(query) do
			tbl = list[#list + 1];
			tbl.text = name; tbl.value = LSM:Fetch(query,name);
		end
	else
		for name, value in next, LibSharedMediaSubstitute[query] do
			tbl = list[#list + 1];
			tbl.text = name; tbl.value = value;
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Layout Presets                                           --
--------------------------------------------------------------------------------------------------------

local layout_presets = {
	-- TipTac Layout
	["TipTac NewStyle"] = {
		showTarget = "last",
		targetYouText = "<Вы>",

		tipBackdropBG = "Interface\\Buttons\\WHITE8X8",
		tipBackdropEdge = "Interface\\Tooltips\\UI-Tooltip-Border",
		backdropEdgeSize = 14,
		backdropInsets = 2.5,
		tipColor = { 0.1, 0.1, 0.2, 1.0 },
		tipBorderColor = { 0.3, 0.3, 0.4, 1.0 },
		gradientTip = true,
		gradientColor = { 0.8, 0.8, 0.8, 0.2 },

		reactColoredBackdrop = false,

		colSameGuild = "|cffff32ff",
		colRace = "|cffffffff",
		colLevel = "|cffc0c0c0",

		colorNameByClass = false,
		classColoredBorder = false,

		barFontFace = "Fonts\\ARIALN.TTF",
		barFontSize = 10,
		barFontFlags = "OUTLINE",
		barHeight = 6,

		classification_normal = "%s ",
		classification_elite = "+%s ",
		classification_worldboss = "%s|r (Босс) ",
		classification_rare = "%s|r (Редкий) ",
		classification_rareelite = "+%s|r (Элитный) ",

		overrideFade = true,
		preFadeTime = 0.1,
		fadeTime = 0.1,
		hideWorldTips = true,

		hideDefaultBar = true,
		healthBar = true,
		healthBarClassColor = true,
		healthBarText = "value",
		healthBarColor = { 0.3, 0.9, 0.3, 1 },
		manaBar = false,
		powerBar = false,
	},
	-- TipTac Layout
	["TipTac OldStyle"] = {
		showTarget = "second",
		targetYouText = "<<Вы>>",

		tipBackdropBG = "Interface\\Tooltips\\UI-Tooltip-Background",
		tipBackdropEdge = "Interface\\Tooltips\\UI-Tooltip-Border",
		backdropEdgeSize = 16,
		backdropInsets = 4,
		tipColor = { 0.1, 0.1, 0.2, 1.0 },
		tipBorderColor = { 0.3, 0.3, 0.4, 1.0 },
		gradientTip = false,

		reactColoredBackdrop = false,

		colSameGuild = "|cffff32ff",
		colRace = "|cffffffff",
		colLevel = "|cffc0c0c0",

		colorNameByClass = false,
		classColoredBorder = false,

		barFontFace = "Fonts\\FRIZQT__.TTF",
		barFontSize = 12,
		barFontFlags = "OUTLINE",
		barHeight = 6,

		classification_normal = "%s ",
		classification_elite = "+%s ",
		classification_worldboss = "%s|r (Босс) ",
		classification_rare = "%s|r (Редкий) ",
		classification_rareelite = "+%s|r (Элитный) ",

		hideDefaultBar = true,
		healthBar = true,
		healthBarClassColor = true,
		healthBarText = "value",
		healthBarColor = { 0.3, 0.9, 0.3, 1 },
		manaBar = false,
		powerBar = false,
	},
	-- TipBuddy Layout
	["TipBuddy"] = {
		showTarget = "first",
		targetYouText = "[Вы]",

		tipBackdropBG = "Interface\\Tooltips\\UI-Tooltip-Background",
		tipBackdropEdge = "Interface\\Tooltips\\UI-Tooltip-Border",
		backdropEdgeSize = 16,
		backdropInsets = 4,
		tipColor = { 0.1, 0.1, 0.1, 0.8 },
		tipBorderColor = { 0.8, 0.8, 0.9, 1.0 },

		reactColoredBackdrop = false,

		colSameGuild = "|cffff32ff",
		colRace = "|cffffffff",
		colLevel = "|cffc0c0c0",

		colorNameByClass = false,
		classColoredBorder = false,

		barFontFace = "Fonts\\ARIALN.TTF",
		barFontSize = 12,
		barFontFlags = "OUTLINE",
		barHeight = 6,

		classification_normal = "%s ",
		classification_elite = "+%s ",
		classification_worldboss = "%s|r (Босс) ",
		classification_rare = "%s|r (Редкий) ",
		classification_rareelite = "+%s|r (Элитный) ",

		hideDefaultBar = false,
		healthBar = false,
		manaBar = false,
		powerBar = false,
	},
	-- TinyTip Layout
	["TinyTip"] = {
		showTarget = "last",
		targetYouText = "<Вы>",

		tipBackdropBG = "Interface\\Tooltips\\UI-Tooltip-Background",
		tipBackdropEdge = "Interface\\Tooltips\\UI-Tooltip-Border",
		backdropEdgeSize = 16,
		backdropInsets = 4,
		tipColor = { 0, 0, 0, 1 },
		tipBorderColor = { 0, 0, 0, 1 },

		reactColoredBackdrop = true,

		colRace = "|cffddeeaa",
		colLevel = "|cffffcc00",

		classification_normal = "Лвл %s",
		classification_elite = "Лвл %s|cffffcc00 Элитный",
		classification_worldboss = "Лвл %s|cffff0000 Босс",
		classification_rare = "Лвл %s|cffff66ff Редкий",
		classification_rareelite = "Лвл %s|cffffaaff Редкий элитный",

		hideDefaultBar = false,
		healthBar = false,
		manaBar = false,
		powerBar = false,
	},
	-- Solid Border Layout
	["Solid Border"] = {
		showTarget = "last",
		targetYouText = "|cffff0000<<Вы>>",

		tipBackdropBG = "Interface\\Buttons\\WHITE8X8",
		tipBackdropEdge = "Interface\\Buttons\\WHITE8X8",
		backdropEdgeSize = 2.5,
		backdropInsets = 0,
		tipColor = { 0.09, 0.09, 0.19, 1.0 },
		tipBorderColor = { 0.6, 0.6, 0.6, 1.0 },

		reactColoredBackdrop = false,

		colorNameByClass = false,
		classColoredBorder = true,
	},
};

local function LoadLayout_SelectValue(dropDown,entry,index)
	for name, value in next, layout_presets[entry.value] do
		cfg[name] = value;
	end
	TipTac:ApplySettings();
	dropDown.label:SetText("|cff80ff80Загружено");
end

local function DeleteLayout_SelectValue(dropDown,entry,index)
	layout_presets[entry.value] = nil;
	dropDown.label:SetText("|cffff8080Удалено!");
end

function TipTacDropDowns.LoadLayout_Init(dropDown,list)
	dropDown.SelectValueFunc = LoadLayout_SelectValue;
	local tbl;
	for name in next, layout_presets do
		tbl = list[#list + 1];
		tbl.text = name; tbl.value = name;
	end
	dropDown.label:SetText("|cff00ff00Выберите для загрузки");
end

function TipTacDropDowns.DeleteLayout_Init(dropDown,list)
	dropDown.SelectValueFunc = DeleteLayout_SelectValue;
	local tbl;
	for name in next, layout_presets do
		tbl = list[#list + 1];
		tbl.text = name; tbl.value = name;
	end
	dropDown.label:SetText("|cff00ff00Выберите для удаления");
end

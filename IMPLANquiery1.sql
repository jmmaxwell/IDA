SELECT E.DataYear as YR, E.ComboFIPS as FIPS, E.NameTagPlace as CTY, E.StatePO as ST, 
	E.IndustryCode as IC, TotalIndustryOutput as TIP, Employment_Value as EMP, VAEMP.VA_Amount as VAEMP, VAGOS.VA_Amount as VAGOS,
	VAMPI.VA_Amount as VAMPI, VATPI.VA_Amount as VATPI
FROM dbo_Employment2008 E, dbo_Output2008 O, 
(SELECT * FROM dbo_ValueAdded2008 VA WHERE VA_Type = "PoW Employee Compensation") VAEMP,
(SELECT * FROM dbo_ValueAdded2008 VA WHERE VA_Type = "PoW Gross Operating Surplus (Other Property Income)") VAGOS,
(SELECT * FROM dbo_ValueAdded2008 VA WHERE VA_Type = "PoW Mixed (Proprietary) Income") VAMPI,
(SELECT * FROM dbo_ValueAdded2008 VA WHERE VA_Type = "VA_Type
Taxes on Production and Imports (Indirect Business Taxes)") VATPI
WHERE (E.ComboFIPS = VAEMP.ComboFIPS and E.IndustryCode = VAEMP.IndustryCode) and
	(E.ComboFIPS = VAGOS.ComboFIPS and E.IndustryCode = VAGOS.IndustryCode) and
	(E.ComboFIPS = VAMPI.ComboFIPS and E.IndustryCode = VAMPI.IndustryCode) and
	(E.ComboFIPS = VATPI.ComboFIPS and E.IndustryCode = VATPI.IndustryCode) and
	(E.ComboFIPS = O.ComboFIPS and E.IndustryCode = O.IndustryCode);
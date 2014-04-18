SELECT 
	VAEMP.DataYear as YR, 
	VAEMP.ComboFIPS as FIPS, 
	VAEMP.IndustryCode as IC, 
	VAEMP.VA_Amount as VAEMP, 
	VAGOS.VA_Amount as VAGOS,
	VAMPI.VA_Amount as VAMPI, 
	VATPI.VA_Amount as VATPI
FROM ((((SELECT DataYear, ComboFIPS, IndustryCode, VA_Amount FROM dbo_ValueAdded2008 VA WHERE VA_Type = "PoW Employee Compensation") as VAEMP)
	INNER JOIN (SELECT ComboFIPS, IndustryCode, VA_Amount FROM dbo_ValueAdded2008 VA WHERE VA_Type = "PoW Gross Operating Surplus (Other Property Income)") as VAGOS
		ON VAEMP.ComboFIPS = VAGOS.ComboFIPS and VAEMP.IndustryCode = VAGOS.IndustryCode)
	INNER JOIN (SELECT ComboFIPS, IndustryCode, VA_Amount FROM dbo_ValueAdded2008 VA WHERE VA_Type = "PoW Mixed (Proprietary) Income") VAMPI
		ON VAEMP.ComboFIPS = VAMPI.ComboFIPS and VAEMP.IndustryCode = VAMPI.IndustryCode)
	INNER JOIN (SELECT ComboFIPS, IndustryCode, VA_Amount FROM dbo_ValueAdded2008 VA WHERE VA_Type = "Taxes on Production and Imports (Indirect Business Taxes)") VATPI
		ON VAEMP.ComboFIPS = VATPI.ComboFIPS and VAEMP.IndustryCode = VATPI.IndustryCode
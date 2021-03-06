USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_TFSOLP106180_Update_Cost]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_TFSOLP106180_Update_Cost] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE TFSOLP106180
	SET CostString=dbo.DistibutionReport_fun_Get_Cost(T$ITEM,T$PLNT,T$DATE)

	UPDATE TFSOLP106180
	SET UNITSET=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('UNITSET',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('UNITSET',CostString))-CHARINDEX('=',CostString,CHARINDEX('UNITSET',CostString))-1),
		PnlINCHW=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('PnlINCHW',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('PnlINCHW',CostString))-CHARINDEX('=',CostString,CHARINDEX('PnlINCHW',CostString))-1),
		PnlINCHL=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('PnlINCHL',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('PnlINCHL',CostString))-CHARINDEX('=',CostString,CHARINDEX('PnlINCHL',CostString))-1),
		PNLSQFTA=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('PNLSQFTA',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('PNLSQFTA',CostString))-CHARINDEX('=',CostString,CHARINDEX('PNLSQFTA',CostString))-1),
		CESU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('CESU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('CESU',CostString))-CHARINDEX('=',CostString,CHARINDEX('CESU',CostString))-1),
		CISU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('CISU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('CISU',CostString))-CHARINDEX('=',CostString,CHARINDEX('CISU',CostString))-1),
		DLIU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('DLIU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('DLIU',CostString))-CHARINDEX('=',CostString,CHARINDEX('DLIU',CostString))-1),
		ILIU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('ILIU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('ILIU',CostString))-CHARINDEX('=',CostString,CHARINDEX('ILIU',CostString))-1),
		MDSU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('MDSU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('MDSU',CostString))-CHARINDEX('=',CostString,CHARINDEX('MDSU',CostString))-1),
		LDIU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('LDIU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('LDIU',CostString))-CHARINDEX('=',CostString,CHARINDEX('LDIU',CostString))-1),
		LDMU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('LDMU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('LDMU',CostString))-CHARINDEX('=',CostString,CHARINDEX('LDMU',CostString))-1),
		TCIU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('TCIU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('TCIU',CostString))-CHARINDEX('=',CostString,CHARINDEX('TCIU',CostString))-1),
		GSRU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('GSRU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('GSRU',CostString))-CHARINDEX('=',CostString,CHARINDEX('GSRU',CostString))-1),
		TCUU=SUBSTRING(CostString,CHARINDEX('=',CostString,CHARINDEX('TCUU',CostString))+1,CHARINDEX(',',CostString,CHARINDEX('TCUU',CostString))-CHARINDEX('=',CostString,CHARINDEX('TCUU',CostString))-1)
END
GO

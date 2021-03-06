USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_sync_data_From_Baan]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MSS_sync_data_From_Baan]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS(SELECT TOP 1 * FROM TFSOLP122180 WHERE T$JDAT = CONVERT(CHAR(10),GETDATE(),120))
		BEGIN
			DROP TABLE TFSOLP122180_new
			SELECT * INTO TFSOLP122180_new
			FROM OPENQUERY
			(
			as1p1,'select
							  t$orno,
							  t$pono,
							  t$cotp,
							  t$sern,
							  to_char(t$jdat,''YYYY-MM-DD'') as t$jdat,
							  t$odat,
							  t$pdat,
							  t$year,
							  t$prno,
							  t$fiwk,
							  t$item,
							  t$nama,
							  t$cupn,
							  t$dsca,
							  t$plnt,
							  t$pric,
							  t$orua,
							  t$ouua,
							  t$faua,
							  t$foua,
							  t$cwar,
							  t$ormn,
							  t$oumn,
							  t$famn,
							  t$fomn,
							  t$orsq,
							  t$ousq,
							  t$fasq,
							  t$fosq,
							  t$sitm,
							  t$flag,
							  t$type,
							  to_char(t$trdt,''YYYY-MM-DD'') AS t$trdt,
							  to_char(t$ajsd,''YYYY-MM-DD'') AS t$ajsd,
							  t$styp,
							  t$prdn
						from baan.TFSOLP122180
						order by t$jdat desc'
			)

			UPDATE TFSOLP122180_new set T$TRDT = '1900-01-01' from TFSOLP122180_new where T$TRDT = '0000-00-00'
			UPDATE TFSOLP122180_new set T$AJSD = '1900-01-01' from TFSOLP122180_new where T$AJSD = '0000-00-00'

			TRUNCATE TABLE TFSOLP122180
			INSERT INTO TFSOLP122180
			SELECT *, 0,0 FROM TFSOLP122180_new

		END
END

GO

USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Tracibility_Query_Details]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Tracibility_Query_Details]
	-- Add the parameters for the stored procedure here
	@Plant			NVARCHAR(5),
	@Project		NVARCHAR(30),
	@Work		NVARCHAR(5),
	@Stamp		NVARCHAR(5),
	@Lot		NVARCHAR(33),
	@Supplier		NVARCHAR(35),
	@Material		NVARCHAR(12),
	@Machine	NVARCHAR(30),
	@Packing NVARCHAR(30),
	@DateCode	NVARCHAR(30),
	@InpuFrom	NVARCHAR(30),
	@InputTo		NVARCHAR(30)
	
                                
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    --IF CAST(@InputDate as datetime) = CAST(getdate())
	SELECT
	--top 30
		T$PLNT,
		T$LTNO,
		T$CWOC,
		T$SEQU,
		T$MACH,
		T$MATR,
		t$DDEC,
		(T$suno+' - '+t$DESC) AS t$SUNO,
		T$TOOL,
		T$REMK,
		CONVERT(VARCHAR(10),T$DATE,120) AS T$DATE,
		--(case len(T$TIME)
		--	when 4 then '0'+CAST(LEFT(T$TIME,1) AS NVARCHAR(1))+':0'+CAST(right(left(T$TIME,2),1) as NVARCHAR(1))+':'+CAST(RIGHT(T$TIME,2) AS NVARCHAR(2))
		--	when 5 then '0'+CAST(LEFT(T$TIME,1) AS NVARCHAR(1))+':'+CAST(right(left(T$TIME,3),2) as NVARCHAR(2))+':'+CAST(RIGHT(T$TIME,2) AS NVARCHAR(2))
		--	when 6  then CAST(LEFT(T$TIME,2) AS NVARCHAR(2))+':'+CAST(right(left(T$TIME,4),2) as NVARCHAR(2))+':'+CAST(RIGHT(T$TIME,2) AS NVARCHAR(2)) END
		--) AS T$TIME,
		T$TIME,
		T$USER,
		T$MBCD,
		T$DCDE,
		T$PCDE,
		T$PROJ,
		T$PJNO,
		T$MNWC,
		T$BCDE,
		T$TQTY,
		T$TRCD,
		T$OULN,
		T$SPLN,
		T$STMP,
		T$MTYP,
		T$LCQT
	FROM Traceability_Details
	WHERE CONVERT(VARCHAR(10),T$DATE,120) = @InpuFrom
END

GO

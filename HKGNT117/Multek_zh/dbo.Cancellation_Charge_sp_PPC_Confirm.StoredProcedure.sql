USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_PPC_Confirm]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_PPC_Confirm]
@So	NVARCHAR(6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@LOOP INT,@MAX INT,@pos INT,@cost DECIMAL(18,4)
	DECLARE	@ITEM	NVARCHAR(35),@FirstChar	NVARCHAR(1),@Plant NVARCHAR(3)

    -- Insert statements for procedure here
	SET @SO = ISNULL(@SO,0)
	
	-- GET STANDARD COST 
	UPDATE dbo.Cancellation_Charge_Order_Details SET T$COPR = B.T$COPR FROM FactoryLoading.dbo.TTIITM001180 AS B,dbo.Cancellation_Charge_Order_Details AS A
	WHERE A.T$ITEM = B.T$ITEM
	
	-- CHECK IF SAMPLE PROJECT,and Cost sheet is zero
	IF EXISTS(SELECT TOP 1 * FROM dbo.Cancellation_Charge_Order_Details WHERE LEFT(LTRIM(RTRIM(T$ITEM)),1) IN ('H','F','Q','S','P') AND T$PLNT <> '2F' AND T$ORNO = @SO AND T$COPR = 0)
		BEGIN
			UPDATE dbo.Cancellation_Charge_Order_Header SET [STATUS] = 'Waiting ME' FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO
		END
	ELSE
		BEGIN -- CHECK B2F IF EXISTS SAMPLE PROJECT
			IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#B2Fsample') AND TYPE = 'U')
				DROP TABLE #B2Fsample
			SELECT ROW_NUMBER() OVER(ORDER BY T$ITEM ASC) AS ID,T$ITEM,T$COPR INTO #B2Fsample FROM dbo.Cancellation_Charge_Order_Details WHERE T$PLNT = '2F' AND T$ORNO = @SO GROUP BY T$ITEM,T$COPR
			SET @LOOP = 1
			SET @MAX  = 0
			SET @COST = 0
			SELECT @MAX = MAX(ID) FROM #B2Fsample
			IF @MAX <> 0
				BEGIN
					WHILE @LOOP <= @MAX
						BEGIN
							SELECT @ITEM = T$ITEM,@COST = T$COPR FROM #B2Fsample WHERE ID = @LOOP
							SET @POS = CHARINDEX('-',@ITEM)
							SET @FirstChar = SUBSTRING(@ITEM,@POS,1)
							IF 	(@FirstChar = '7' OR @FirstChar = '9' OR @FirstChar = 'P' OR @FirstChar = 'S') AND @COST = 0  -- after 2010/10 ,add P,S
								BEGIN
									UPDATE dbo.Cancellation_Charge_Order_Header SET [STATUS] = 'Waiting ME' FROM dbo.Cancellation_Charge_Order_Header WHERE SO = @SO
								END
							SET @LOOP = @LOOP + 1
						END
				END
		END
		
	-- AFTER ABOVE CHECK , THE PROJECT EXIST COST PRICE.
	IF EXISTS(SELECT TOP 1 * FROM dbo.Cancellation_Charge_Order_HEADER WHERE [STATUS] = 'Waiting PPC' AND SO = @SO)
		BEGIN
			-- IF ONE SO EXISTS TWO ITEM,ECN
			--IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#ProjectList') AND TYPE = 'U')
			--	DROP TABLE #ProjectList
			
			--SELECT T$PLNT,T$ITEM,T$PRIC,T$COPR,CASE(T$PRIC WHEN 0 THEN 0 ELSE (T$PRIC-T$COPR)/T$PRIC END) AS VAM,ROW_NUMBER OVER(GROUP BY T$PLNT,T$ITEM,T$PRIC,T$COPR  ASC) AS ID FROM dbo.Cancellation_Charge_Order_Details 
			--INTO #ProjectList
			--WHERE T$ORNO = @SO GROUP BY T$PLNT,T$ITEM,T$PRIC,T$COPR 
			--SET @LOOP = 1
			--SET @MAX  = 0
			--SELECT @MAX = MAX(ID) FROM #ProjectList
			
			--WHILE @LOOP <=@MAX
			--	BEGIN
			--		SELECT @ITEM = T$ITEM FROM #ProjectList
					-- Insert common data
					 SELECT @Plant = T$PLNT FROM dbo.Cancellation_Charge_Order_Details WHERE T$ORNO = @SO GROUP BY T$PLNT

					-- INSERT FG  -- Cancellation_Charge_fun_Query_CostSheet(A.T$ITEM,@Plant)
					
						INSERT INTO dbo.Cancellation_Charge_Summary([TYPE],ITEM,SO,WIP_Status,WIP_Qty,Attrition_Rate,Qty,Unit_Cost,Total_Cost,Selling_Price,Sales)
						SELECT  'FG',A.T$ITEM,A.T$ORNO,'FG',A.T$QUAN,0,A.T$QUAN*(1-0),0,0,0,0
						FROM Cancellation_Charge_PPC_FG AS A
						WHERE A.T$ORNO = @SO
						
						UPDATE 	Cancellation_Charge_Summary SET Unit_Cost = B.T$COPR,Selling_Price = CASE T$PRIC WHEN 0 THEN B.T$COPR ELSE (B.T$COPR /(1-(T$PRIC-T$COPR)/T$PRIC)) END
						FROM Cancellation_Charge_Summary AS A,dbo.Cancellation_Charge_Order_Details AS B
						WHERE A.[TYPE] = 'FG'
						AND A.SO = @SO
						AND B.T$ORNO = @SO
						AND A.ITEM = B.T$ITEM

					-- INSERT WIP
						INSERT INTO dbo.Cancellation_Charge_Summary([TYPE],ITEM,SO,WIP_Status,WIP_Qty,Attrition_Rate,Qty,Unit_Cost,Total_Cost,Selling_Price,Sales)
						SELECT 'WIP',ITEM,SO,WORK_CENTER,Quantity,rate,(Quantity * (1-rate)),dbo.Cancellation_Charge_fun_Query_WIP_CostSheet(ITEM,WORK_CENTER,@Plant),0,0,0
						FROM	Cancellation_Charge_PPC_WIP
						
						UPDATE Cancellation_Charge_Summary SET Total_Cost = A.Qty * A.Unit_Cost,Selling_Price = CASE T$PRIC WHEN 0 THEN B.T$COPR ELSE (B.T$COPR /(1-(T$PRIC-T$COPR)/T$PRIC)) END
						FROM Cancellation_Charge_Summary AS A,dbo.Cancellation_Charge_Order_Details AS B
						WHERE A.[TYPE] = 'WIP'
						AND A.SO = @SO
						AND B.T$ORNO = @SO
						AND A.ITEM = B.T$ITEM
						
					-- INFSERT MATERIAL
						INSERT INTO dbo.Cancellation_Charge_Summary([TYPE],ITEM,SO,WIP_Status,WIP_Qty,Attrition_Rate,Qty,Unit_Cost,Total_Cost,Selling_Price,Sales)
						SELECT	'MATERIAL',A.T$ITEM,A.T$ORNO,A.T$PJNO,A.T$aqua,0,A.T$aqua,B.T$COPR,A.T$aqua*B.T$COPR,B.T$COPR*1.01,0
						FROM	dbo.Cancellation_Charge_PPC_Material AS A,FactoryLoading.dbo.TTIITM001180 as B
						WHERE	A.T$ITEM = B.T$ITEM
			
					-- UPDATE OTHERS CALC FIELD
						UPDATE 	Cancellation_Charge_Summary SET Total_Cost		= Qty * Unit_Cost FROM Cancellation_Charge_Summary where SO = @SO
						UPDATE 	Cancellation_Charge_Summary SET Sales			= Qty * Selling_Price  where SO = @SO
						
						UPDATE dbo.Cancellation_Charge_Order_Header SET [STATUS] = 'Complete' ,
						Sales = (SELECT sum(Sales) FROM [Multek_ZH].[dbo].[Cancellation_Charge_Summary] where SO=@SO)
						FROM dbo.Cancellation_Charge_Order_Header
						WHERE SO = @SO
				END
		END

GO

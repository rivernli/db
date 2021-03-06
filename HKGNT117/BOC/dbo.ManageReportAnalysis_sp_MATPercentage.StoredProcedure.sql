USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_MATPercentage]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2011/8/02>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[ManageReportAnalysis_sp_MATPercentage]

	@ID INT=null,
	@Value  decimal(18, 2)=null,
	@Operators nvarchar(50)=null,
	@Text  nvarchar(50)=null,
	@ForeColor nvarchar(50)=null,
	@Show bit=true,
	@Plant  nvarchar(50)=null,
	@Report nvarchar(50)=null,
	
	@Operatation nvarchar(20)
AS
BEGIN


    -- Insert 
	IF @Operatation = 'Insert'
		BEGIN
            INSERT INTO MAT_Percentage(Plant, Report, Value, [Text], ForeColor, Show, Operators)
			VALUES     (@Plant,@Report,@Value,@Text,@ForeColor,@Show,@Operators)
		END
	-- Update
	IF @Operatation = 'Update'
		BEGIN
			UPDATE    MAT_Percentage
            SET       Plant=@Plant, Report=@Report, Value =@Value, [Text] =@Text, ForeColor =@ForeColor, Show=@Show, Operators=@Operators
			WHERE     ([ID]= @ID) 
		END		
	-- Delete
	IF @Operatation = 'Delete'
		BEGIN
			DELETE FROM MAT_Percentage WHERE    ([ID] = @ID)
		END	
    -- Query
	IF @Operatation = 'Query'
		BEGIN
			SELECT     [ID], Plant, Report, Value, [Text], ForeColor, Show, Operators
            FROM         MAT_Percentage
			WHERE     ([ID] = @ID)
		END	
   
	IF @Operatation = 'Bind'
		BEGIN
			IF @Report = 'ALL'
			BEGIN
				SELECT     [ID], Plant, Report, Value, [Text], ForeColor, Show, Operators
				FROM         MAT_Percentage
				ORDER BY [ID] DESC
			END	
			ElSE
			BEGIN
				SELECT     [ID], Plant, Report, Value, [Text], ForeColor, Show, Operators
				FROM         MAT_Percentage
				WHERE       Report=@Report
				ORDER BY [ID] DESC
			END	
		END	
	IF @Operatation = 'BindByShow'
	BEGIN
		SELECT     [ID], Plant, Report, Value, Operators, [Text], ForeColor, Show, (Operators+ convert(nvarchar,Value) ) as OperatorsValue
        FROM         MAT_Percentage
        WHERE       Show=@Show and Plant=@Plant and Report=@Report
        ORDER BY [Value] DESC
	END	
	IF @Operatation = 'BindByReport'
	BEGIN
		SELECT     [ID], Plant, Report, Value, Operators, [Text], ForeColor, Show, (Operators+ convert(nvarchar,Value) ) as OperatorsValue
        FROM         MAT_Percentage
        WHERE       Plant=@Plant and Report=@Report
        ORDER BY [Value] DESC
	END	
END





GO

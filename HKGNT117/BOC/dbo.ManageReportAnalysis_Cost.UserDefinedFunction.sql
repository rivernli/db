USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[ManageReportAnalysis_Cost]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ManageReportAnalysis_Cost](@id  int )
    RETURNS NVARCHAR(4000)
AS
BEGIN
    
    declare @output nvarchar(4000)
    
    select @output = coalesce(@output + '+' , '') + [TFSAMI040180].[T$DSCA]  From  dbo.[TFSAMI040180] where [TFSAMI040180].[T$MNWC] in(select [value] From  dbo.SplitToTable((SELECT  [TFIATT006180].[T$ASTR] FROM [TFIATT006180],[CostDetail] where  [CostDetail].[ID]=@id and [TFIATT006180].[T$ITEM] = [CostDetail].[Project] and [TFIATT006180].[T$ATTR]='surf'), '+'))
     
    RETURN @output
END

GO

USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Product]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Query_Product]
AS

SET NOCOUNT ON

SELECT * FROM Product ORDER BY AutoID DESC
GO

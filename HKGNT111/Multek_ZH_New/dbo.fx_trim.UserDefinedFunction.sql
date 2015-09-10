USE [Multek_ZH_New]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_trim]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fx_trim](@string nvarchar(255))
returns nvarchar(255)
as
begin 
	return replace(ltrim(rtrim(isnull(@string,''))),'''','''''');
--return ltrim(rtrim(isnull(@string,'')));

end
GO

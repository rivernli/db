USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_QMS_quotationAdd]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_QMS_quotationAdd]
@xmlData xml
,@id int output
,@rfq nvarchar(20) output
as

select * from QMS_quotation;
insert into QMS_quotation 
select 'xxx' as RFQ,
t.value('(supporter/text())[1]','nvarchar(100)'),
t.value('(createDate/text())[1]','nvarchar(100)'),
t.value('(outDate/text())[1]','nvarchar(100)'),
t.value('(OEM/text())[1]','nvarchar(100)'),
t.value('(CEM/text())[1]','nvarchar(100)'),
t.value('(contact/text())[1]','nvarchar(100)'),
t.value('(shipmentTerms/text())[1]','nvarchar(100)'),
t.value('(shipmentTermsAdder/text())[1]','nvarchar(100)'),
t.value('(paymentTerms/text())[1]','nvarchar(100)'),
t.value('(leadTime/text())[1]','nvarchar(100)'),
t.value('(currency/text())[1]','nvarchar(100)'),
t.value('(exchangeRate/text())[1]','nvarchar(100)'),
t.value('(setupCharge/text())[1]','nvarchar(100)'),
t.value('(eTestCharge/text())[1]','nvarchar(100)'),
t.value('(toolingCharge/text())[1]','nvarchar(100)'),
t.value('(status/text())[1]','nvarchar(100)')
from  @XMLdata.nodes('/quotation')AS TempTable(t);

set @id =scope_Identity();
update QMS_quotation set rfq = 'MQ'+ right(convert(char(9),100000000 + quoteId),8) where RFQ = 'xx';
select @rfq =rfq from QMS_quotation where quoteId=@id;
GO

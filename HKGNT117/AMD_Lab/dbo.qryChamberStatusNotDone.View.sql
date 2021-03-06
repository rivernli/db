USE [AMD_Lab]
GO
/****** Object:  View [dbo].[qryChamberStatusNotDone]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[qryChamberStatusNotDone]
as
SELECT tblChamberLog.Chamber, tblChamberLog.TN, 
(SELECT qrySamplesLocation.location FROM qrySamplesLocation  WHERE  qrySamplesLocation.locationID=tblChamberLog.Bldg) as Bldg,
tblChamberLog.Dept, tblChamberLog.Applicant, 
tblChamberLog.Customer, tblChamberLog.[Project#], tblChamberLog.TestName, tblChamberLog.Hours, 
tblChamberLog.Temp, tblChamberLog.[%RH], 
convert(varchar(12),tblChamberLog.DateReceived,101) as DateReceived,
convert(varchar(12),tblChamberLog.DueDate,101) as DueDate,
convert(varchar(12),tblChamberLog.DateIn,101) as DateIn,
convert(varchar(12),tblChamberLog.DateOut,101) as DateOut,
(select Analyst from tblAnalyst where  AnalystID=tblChamberLog.Leader) as LeaderName,
(select Status from tblStatus where  StatusID=tblChamberLog.Status) as StatusName,
tblChamberLog.Notes 

FROM tblChamberLog 
WHERE (((tblChamberLog.Status)<>1 And (tblChamberLog.Status)<>19)) OR (((tblChamberLog.Status) Is Null))

GO

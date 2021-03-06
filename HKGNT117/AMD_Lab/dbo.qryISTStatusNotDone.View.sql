USE [AMD_Lab]
GO
/****** Object:  View [dbo].[qryISTStatusNotDone]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[qryISTStatusNotDone]
as
SELECT tblISTLog.Equipment,tblISTLog.TN, tblAMDSamples.AnalyticalTest, tblAMDSamples.Applicant, tblAMDSamples.location, 
(select location from tbllocation where tbllocation.locationID=tblAMDSamples.location) as locationname,
(select Analyst from tblAnalyst where tblAnalyst.AnalystID=tblAMDSamples.Analyst) as Analystname,
tblAMDSamples.Analyst, tblAMDSamples.Dept, tblAMDSamples.ProjectName, tblAMDSamples.[Sample descripton], 
tblAMDSamples.ProjDesc, tblAMDSamples.Customer, tblAMDSamples.[Project#], tblISTLog.notes, tblISTLog.MaxCycles, 
tblISTLog.[#samples], tblISTLog.LoadsDone, tblISTLog.TotalLoads, 
(SELECT Status FROM tblStatus WHERE StatusID=tblISTLog.Status) as StatusName , 
convert(varchar(12),tblISTLog.DateReceived,101) as DateReceived,
convert(varchar(12),tblISTLog.DueDate,101) as DueDate, 
convert(varchar(12),tblISTLog.StartDate,101) as StartDate, 
convert(varchar(12),tblISTLog.FinishDate,101) as FinishDate,
 tblISTLog.days, 
CONVERT(varchar(20),tblISTLog.LoadsDone)+'/'+CONVERT(varchar(20),tblISTLog.TotalLoads) as LoadValue 
FROM tblISTLog INNER JOIN tblAMDSamples ON tblISTLog.TN = tblAMDSamples.TN
WHERE (((tblAMDSamples.AnalyticalTest)=15) AND ((tblISTLog.Status)<>1 And (tblISTLog.Status)<>19)) OR (((tblISTLog.Status) Is Null))

GO

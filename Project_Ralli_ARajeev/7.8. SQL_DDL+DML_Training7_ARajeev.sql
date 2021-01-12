--loading customer Table DDL Statements
CREATE TABLE [dbo].[DIM_RALLI_SQL_Customer_ARajeev](
CUSTOMER_KEY INT IDENTITY(1,1),
[Customer_id] int NULL,
[Firstname] [nvarchar](255) NULL,
[Lastname] [nvarchar](255) NULL,
[Contactphone] [nvarchar](255) NULL,
[Contactaddress] [nvarchar](255) NULL,
[Contact_email] [nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO
--drop table DIM_RALLI_SQL_Customer_ARajeev


--DML Statements for Customer Table
select * from DIM_RALLI_INFA_Customer_ARajeev

INSERT INTO [dbo].[DIM_RALLI_SQL_Customer_ARajeev]
select 
CASE
	WHEN Customer_id=NULL THEN -1
	ELSE LTRIM(RTRIM(UPPER(Customer_id)))
END as Customer_id,
CASE
	WHEN Firstname=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(UPPER(Firstname)))
END as FirstName, 
CASE 
	WHEN Lastname=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(UPPER(Lastname)))
END as LastName,

CASE 
	WHEN Contactphone=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(SUBSTRING(Contactphone, (LEN(Contactphone)-11), 12)))
END as Contactphone,
CASE
	WHEN Contactaddress=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(concat(concat('No: ',concat(substring(Contactaddress, PATINDEX('%[0-9]%', Contactaddress),PATINDEX('%[0-9] %', Contactaddress)),',')), SUBSTRING(Contactaddress, PATINDEX('%[0-9] %', Contactaddress)+1, len(Contactaddress)))))
END as Contactaddress,
CASE 
	WHEN Contact_email=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Contact_email))
END as Contact_email,
GETDATE(),
GETDATE()
from RALLI.[dbo].[Customer] 


select * from DIM_RALLI_SQL_Customer_ARajeev
--select * from [dbo].[DIM_RALLI_INFA_Customer_ARajeev]


--DDL statements For Location
--Loading Location
--drop table DIM_RALLI_SQL_Location_ARajeev
CREATE TABLE [dbo].[DIM_RALLI_SQL_Location_ARajeev](
LOCATION_KEY INT IDENTITY(1,1),
[LocationID] int NULL,
[LocationType] [nvarchar](255) NULL,
[LocationDescription] [nvarchar](255) NULL,
[Region] [nvarchar](255) NULL,
[RegionManagerUser_KEY] int,
[Address] [nvarchar](255) NULL,
[City] [nvarchar](255) NULL,
[PostalCode] [nvarchar](255) NULL,
[PhoneNumber] [nvarchar](255) NULL,
[Fax] [nvarchar](255) NULL,
[Email] [nvarchar](255) NULL,
[StoreManagerUser_KEY] int,
[IsDelegateServiceCenter] [nvarchar](255) NULL,
[Enabled] [nvarchar](255) NULL,
[IsPartWareHouse] [nvarchar](255) NULL,
[FRTRate] [nvarchar](255) NULL,
[CurrencyCode] [nvarchar](255) NULL,
[Market] [nvarchar](255) NULL,
[CriticalPartReportLocationTitle] [nvarchar](255) NULL,
[IsMRBWareHouse] [nvarchar](255) NULL,
[WeekDayWorkHours] [nvarchar](255) NULL,
[IsEngineering] [nvarchar](255) NULL,
[PreferredLanguage] [nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO


--DML Statements For Location
--drop table DIM_RALLI_SQL_Location_ARajeev
INSERT INTO [dbo].[DIM_RALLI_SQL_Location_ARajeev]
select 
CASE 
	WHEN LocationID=NULL THEN -1
	ELSE LTRIM(RTRIM(LocationID))
END as LocationID,
CASE 
	WHEN LocationType=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(LocationType))
END as LocationType,
CASE 
	WHEN LocationDescription=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(concat(upper(substring(LocationDescription,1,1)), substring(LocationDescription,2,len(LocationDescription)))))
END as LocationDescription,
CASE
	WHEN Region=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.RegionFilter(Region)))
END as Region,
CASE
	WHEN b.USER_KEY is NULL THEN -1
	ELSE LTRIM(RTRIM(b.USER_KEY))
END as RegionManagerUser_KEY,
CASE
	WHEN Address=NULL THEN 'UNK'
	ELSE concat(LTRIM(RTRIM(concat(concat('No: ',concat(substring(Address, PATINDEX('%[0-9]%', Address),PATINDEX('%[0-9] %', Address)),',')), SUBSTRING(Address, PATINDEX('%[0-9] %', Address)+1, len(Address))))),'.')
END as Address,
CASE
	WHEN City=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(City))
END as City,
CASE
	WHEN PostalCode=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(PostalCode))
END as PostalCode,
CASE 
	WHEN PhoneNumber=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(replace(PhoneNumber,'-',' ')))
END as PhoneNumber,
CASE 
	WHEN Fax=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(REPLACE(Fax,'-',' ')))
END as Fax,
CASE
	WHEN a.Email=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(a.Email))
END as Email,
CASE
	WHEN c.User_KEY is NULL THEN -1
	ELSE LTRIM(RTRIM(c.User_KEY))
END as StoreManagerUser_KEY,
CASE
	WHEN IsDelegateServiceCenter is NULL THEN 'UNK'
	WHEN IsDelegateServiceCenter=-1 THEN 'Y'
	WHEN IsDelegateServiceCenter=0 THEN 'N'
END as IsDelegateServiceCenter,
CASE
	WHEN a.Enabled is NULL THEN 'UNK'
	WHEN a.Enabled=-1 THEN 'Y'
	WHEN a.Enabled=0 THEN 'N'
END as Enabled,
CASE
	WHEN IsPartWareHouse is NULL THEN 'UNK'
	WHEN IsPartWareHouse=-1 THEN 'Y'
	WHEN IsPartWareHouse=0 THEN 'N'
END as IsPartWareHouse,
CASE 
	WHEN FRTRate=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(FRTRate))
END as FRTRate,
CASE 
	WHEN CurrencyCode=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CurrencyCode))
END as CurrencyCode,
CASE 
	WHEN Market=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Market))
END as Market,
CASE 
	WHEN CriticalPartReportLocationTitle=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CriticalPartReportLocationTitle))
END as CriticalPartReportLocationTitle,
CASE
	WHEN IsMRBWareHouse is NULL THEN 'UNK'
	WHEN IsMRBWareHouse=-1 THEN 'Y'
	WHEN IsMRBWareHouse=0 THEN 'N'
END as IsMRBWareHouse,
CASE
	WHEN WeekDayWorkHours is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(convert(varchar, WeekDayWorkHours, 108)))
END as WeekDayWorkHours,
CASE
	WHEN IsEngineering is NULL THEN 'UNK'
	WHEN IsEngineering=-1 THEN 'Y'
	WHEN IsEngineering=0 THEN 'N'
END as IsEngineering,
CASE 
	WHEN PreferredLanguage=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(UPPER(PreferredLanguage)))
END as PreferredLanguage,
GETDATE(),
GETDATE()
from RALLI.[dbo].Location a left join DIM_RALLI_SQL_Users_ARajeev b on a.RegionManagerUserID = b.UserID
							left join DIM_RALLI_SQL_Users_ARajeev c on a.StoreManagerUserID = c.UserID

select * from RALLI.[dbo].Location where RegionManagerUserID is NULL or StoreManagerUserID is NULL


select * from DIM_RALLI_SQL_Location_ARajeev 



--DDL Statements For Part
--loading Part
--drop table DIM_RALLI_SQL_Part_ARajeev
CREATE TABLE [dbo].[DIM_RALLI_SQL_Part_ARajeev](
PART_KEY INT IDENTITY(1,1),
[PartId] int NULL,
[PartNumber] [nvarchar](255) NULL,
[PartSystem] [nvarchar](255) NULL,
[PartSubSystem] [nvarchar](255) NULL,
[SupplierCode] [nvarchar](255) NULL,
[Name] [nvarchar](255)NULL,
[Description] [nvarchar](255) NULL,
[PlanningLeadtime] [nvarchar](255) NULL,
[UnitPrice] [nvarchar](255) NULL,
[Orderpoint] [nvarchar](255) NULL,
[SafetyStockQuantity] [nvarchar](255) NULL,
[FabricatedFlag] [nvarchar](255) NULL,
[PurchasedFlag] [nvarchar](255) NULL,
[StockedFlag] [nvarchar](255) NULL,
[InspectionRequiredFlag] [nvarchar](255) NULL,
[HazardousMaterialFlag] [nvarchar](255) NULL,
[Version] [nvarchar](255) NULL,
[ENABLED] [nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO



--DML Statements For Part
Insert into [dbo].[DIM_RALLI_SQL_Part_ARajeev]
select 
CASE
	WHEN PartId is NULL THEN -1 --int default value
	ELSE LTRIM(RTRIM((PartId)))
END as PartId,
CASE
	WHEN PartNumber is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM((PartNumber)))
END as PartNumber,
CASE
	WHEN PartSystem is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.Capword(PartSystem)))
END as PartSystem,
CASE
	WHEN PartSubSystem is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.Capword(PartSubSystem)))
END as PartSubsystem,
CASE
	WHEN SupplierCode is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(SupplierCode))
END as SupplierCode,
CASE
	WHEN Name is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
       REPLACE(REPLACE(REPLACE(REPLACE(Name,
        '!',''),'@',''),'/',''),'"',''),'#',''),
        '.',' '),'&',''),'*',''),'-',' ')))
END as Name,
CASE
	WHEN Description is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.Capword(Description)))
END as Description,
CASE
	WHEN PlanningLeadTime is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(PlanningLeadTime))
END as PlanningLeadTime,
CASE
	WHEN UnitPrice is NULL THEN 'UNK' --float default value
	ELSE LTRIM(RTRIM(UnitPrice))
END as UnitPrice,
CASE
	WHEN Orderpoint is NULL THEN 'UNK' --float default value
	ELSE LTRIM(RTRIM(Orderpoint))
END as Orderpoint,
CASE
	WHEN SafetyStockQuantity is NULL THEN 'UNK' --int default value
	ELSE LTRIM(RTRIM(SafetyStockQuantity))
END as SafetyStockQuantity,
CASE
	WHEN FabricatedFlag is NULL THEN 'UNK'
	WHEN FabricatedFlag=-1 THEN 'Y'
	WHEN FabricatedFlag=0 THEN 'N'
END as FabricatedFlag,
CASE
	WHEN PurchasedFlag is NULL THEN 'UNK'
	WHEN PurchasedFlag=-1 THEN 'Y'
	WHEN PurchasedFlag=0 THEN 'N'
END as PurchasedFlag,
CASE
	WHEN StockedFlag is NULL THEN 'UNK'
	WHEN StockedFlag=-1 THEN 'Y'
	WHEN StockedFlag=0 THEN 'N'
END as StockedFlag,
CASE
	WHEN InspectionRequiredFlag is NULL THEN 'UNK'
	WHEN InspectionRequiredFlag=-1 THEN 'Y'
	WHEN InspectionRequiredFlag=0 THEN 'N'
END as InspectionRequiredFlag,
CASE
	WHEN HazardousMaterialFlag is NULL THEN 'UNK'
	WHEN HazardousMaterialFlag=-1 THEN 'Y'
	WHEN HazardousMaterialFlag=0 THEN 'N'
END as HazardousMaterialFlag,
CASE
	WHEN Version is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Version))
END as Version,
CASE
	WHEN ENABLED is NULL THEN 'UNK'
	WHEN ENABLED=-1 THEN 'Y'
	WHEN ENABLED=0 THEN 'N'
END as ENABLED,
GETDATE(),
GETDATE()
from RALLI.[dbo].Part

select * from DIM_RALLI_SQL_Part_ARajeev



--DDL Statements for users
--drop table DIM_RALLI_SQL_Users_ARajeev
CREATE TABLE [dbo].[DIM_RALLI_SQL_Users_ARajeev](
USER_KEY INT IDENTITY(1,1),
[UserID] int NULL,
[FirstName] [nvarchar](255) NULL,
[LastName] [nvarchar](255) NULL,
[DisplayName] [nvarchar](255) NULL,
[Department] [nvarchar](255) NULL,
[Title] [nvarchar](255) NULL,
[Manager] [nvarchar](255) NULL,
[Email] [nvarchar](255) NULL,
[Enabled] [nvarchar](255) NULL,
[Division] [nvarchar](255) NULL,
[ManagerUserID] int NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO


--DML Statements for users
insert into [dbo].[DIM_RALLI_SQL_Users_ARajeev]
select
CASE
	WHEN UserID is NULL THEN -1
	ELSE LTRIM(RTRIM(UserID))
END as userID,
CASE
	WHEN FirstName is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.Capword(FirstName)))
END as FirstName,
CASE
	WHEN LastName is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.Capword(LastName)))
END as LastName,
CASE
	WHEN DisplayName is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(DisplayName))
END as DisplayName,
CASE
	WHEN Department is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Department))
END as Department,
CASE
	WHEN Title is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Title))
END as Title,
CASE
	WHEN Manager is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Manager))
END as Manager,
CASE
	WHEN Email is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Email))
END as Email,
CASE
	WHEN ENABLED is NULL THEN 'UNK'
	WHEN ENABLED=-1 THEN 'Y'
	WHEN ENABLED=0 THEN 'N'
END as ENABLED,
CASE
	WHEN Division is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Division))
END as Division,
CASE
	WHEN ManagerUserID is NULL THEN -1
	ELSE LTRIM(RTRIM(ManagerUserID))
END as Division,
GETDATE(),
GETDATE()
from RALLI.[dbo].users

select * from DIM_RALLI_SQL_Users_ARajeev 



--DDL Statements for VehicleVIN
--drop table DIM_RALLI_SQL_VehicleVIN_ARajeev
CREATE TABLE [dbo].[DIM_RALLI_SQL_VehicleVIN_ARajeev](
VEHICLEVIN_KEY INT IDENTITY(1,1),
[VehicleVINID] int NULL,
[VehicleVIN][nvarchar](255) NULL,
[VehicleModelCode][nvarchar](255) NULL,
[VehicleModel][nvarchar](255) NULL,
[ModelCategory][nvarchar](255) NULL,
[ModelYear] int NULL,
[DriveOrientation][nvarchar](255) NULL,
[Actualdeliveryeddate][nvarchar](255) NULL,
[Enabled][nvarchar](255) NULL,
[NearestServiceLocationID] int NULL,
[FactoryGateDate][nvarchar](255) NULL,
[VehicleColor][nvarchar](255) NULL,
[VehicleTitle][nvarchar](255) NULL,
[LastOdometer] [nvarchar](255) NULL,
[InventoryVehicle][nvarchar](255) NULL,
[NewUsed][nvarchar](255) NULL,
[Market][nvarchar](255) NULL,
[DeliveryRegion][nvarchar](255) NULL,
[OdometerType][nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO


--DML Statements for VehicleVIN
insert into [dbo].DIM_RALLI_SQL_VehicleVIN_ARajeev
select 
CASE
	WHEN VehicleVINID is NULL THEN -1
	ELSE LTRIM(RTRIM(VehicleVINID))	
END as VehicleVINID,
CASE
	WHEN VehicleVIN is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(VehicleVIN))	
END as VehicleVIN,
CASE
	WHEN VehicleModelCode is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(VehicleModelCode))	
END as VehicleModelCode,
CASE
	WHEN VehicleModel is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(VehicleModel))	
END as VehicleModel,
CASE
	WHEN ModelCategory is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ModelCategory))	
END as ModelCategory,
CASE
	WHEN ModelYear is NULL THEN -1
	ELSE LTRIM(RTRIM(ModelYear))	
END as ModelYear,
CASE
	WHEN DriveOrientation is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(DriveOrientation))	
END as DriveOrientation,
CASE
	WHEN Actualdeliveryeddate is NULL THEN '01-01-1900'
	ELSE convert(varchar, Actualdeliveryeddate, 100)
END as Actualdeliveryeddate,
CASE
	WHEN ENABLED is NULL THEN 'UNK'
	WHEN ENABLED=-1 THEN 'Y'
	WHEN ENABLED=0 THEN 'N'
END as ENABLED,
CASE
	WHEN NearestServiceLocationID is NULL THEN -1
	ELSE LTRIM(RTRIM(NearestServiceLocationID))	
END as NearestServiceLocationID,
CASE
	WHEN FactoryGateDate is NULL THEN '01-01-1900'
	ELSE LTRIM(RTRIM(convert(varchar, FactoryGateDate, 112)))
END as FactoryGateDate,
CASE
	WHEN VehicleColor is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(VehicleColor))	
END as VehicleColor,
CASE
	WHEN VehicleTitle is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(VehicleTitle))	
END as VehicleTitle,
CASE
	WHEN LastOdometer is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(LastOdometer))	
END as LastOdometer,
CASE
	WHEN InventoryVehicle is NULL THEN 'UNK'
	WHEN InventoryVehicle=-1 THEN 'Y'
	WHEN InventoryVehicle=0 THEN 'N'
END as InventoryVehicle,
CASE
	WHEN NewUsed is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(NewUsed))	
END as NewUsed,
CASE
	WHEN Market is NULL THEN 'UNK'
	WHEN Market = 'EU' THEN 'European Union'
	WHEN Market = 'EUO' THEN 'European Union O'
	WHEN Market = 'APAC' THEN 'Asia Pacific'
	WHEN Market = 'NA' THEN 'Nortth America'
END as Market,
CASE
	WHEN DeliveryRegion is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Replace(DeliveryRegion,' ','')))
END as DeliveryRegion,
CASE
	WHEN OdometerType is NULL THEN 'UNK'
	WHEN OdometerType = 'Kilometers' THEN 'km'
	WHEN OdometerType = 'Miles' THEN 'mi'	
END as OdometerType,
GETDATE(),
GETDATE()
from RALLI.[dbo].VehicleVIN 

select * from DIM_RALLI_SQL_VehicleVIN_ARajeev



--DDL Statements for Orders
--loading orders
CREATE TABLE [dbo].[FACT_RALLI_SQL_Orders_ARajeev](
ORDER_KEY INT IDENTITY(1,1),
[OrderID] [nvarchar](255) NULL,
[OrderNumber] [nvarchar](255) NULL,
[DateTime] DATETIME,
[VehicleVIN_KEY] int,
[Odometer] [nvarchar](255) NULL,
[ServiceAdvisorUser_KEY] int,
[ServiceLocation_KEY] int,
[PaymentType] [nvarchar](255) NULL,
[PaymentReceivedByUser_KEY] int,
[OrderStatus] [nvarchar](255) NULL,
[TotalPartPrice] money NULL,
[TotalLaborAmount] money NULL,
[TotalTaxAmount] money NULL,
[TotalAmount] money NULL,
[IsCustomerPickUp] [nvarchar](255) NULL,
[IsRangerDrop] [nvarchar](255) NULL,
[ShippingAmount] money NULL,
[OrderCloseDate] DATETIME,
[DiscountAmount] money NULL,
[ReadyForInvoiceDate] DATETIME,
[IsRepeatedIssueReviewed] [nvarchar](255) NULL,
[IsReadyForDelivery] [nvarchar](255) NULL,
[LeadTechnicianID] [nvarchar](255) NULL,
[IsCPO] [nvarchar](255) NULL,
[IsCPOCompliant] [nvarchar](255) NULL,
[Customer_KEY] int,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO


select count(*) from FACT_RALLI_SQL_Orders_Arajeev


--DML Statements for VehicleVIN
--drop table FACT_RALLI_SQL_Orders_ARajeev
insert into [dbo].[FACT_RALLI_SQL_Orders_ARajeev]
select 
CASE
	WHEN OrderID is NULL THEN -1
	ELSE LTRIM(RTRIM(OrderID))
END as OrderID,
CASE
	WHEN OrderNumber is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(OrderNumber))
END as OrderNumber,
CASE
	WHEN DateTime is NULL THEN '01-01-1900'
	ELSE LTRIM(RTRIM(DateTime))
END as DateTime,
CASE
	WHEN b.VEHICLEVIN_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(b.VEHICLEVIN_KEY))
END as VEHICLEVIN_KEY,
CASE
	WHEN Odometer is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Odometer))
END as Odometer,
CASE
	WHEN c.USER_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(c.USER_KEY))
END as USER_KEY,
CASE
	WHEN ServiceLocationID is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(d.Location_Key))
END as ServiceLocationID,
CASE
	WHEN PaymentType is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(PaymentType))
END as PaymentType,
CASE
	WHEN c.USER_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(c.USER_KEY))
END as PaymentRecievedByUser_KEY,
CASE
	WHEN OrderStatus is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(dbo.Capword(OrderStatus)))
END as OrderStatus,
CASE
	WHEN TotalPartPrice is NULL THEN '0'
	ELSE FORMAT(TotalPartPrice, 'N2')
END as TotallPartPrice,
CASE
	WHEN TotalLaborAmount is NULL THEN '0'
	ELSE FORMAT(TotalLaborAmount, 'N2')
END as TotalLaborAmount,
CASE
	WHEN TotalTaxAmount is NULL THEN '0'
	ELSE FORMAT(TotalTaxAmount, 'N2')
END as TotaTaxAmount,
CASE
	WHEN TotalAmount is NULL THEN '0'
	ELSE FORMAT(TotalAmount, 'N2')
END as TotaAmount,
CASE
	WHEN IsCustomerPickUp=NULL THEN 'UNK'
	WHEN IsCustomerPickUp=0 THEN 'Y'
	WHEN IsCustomerPickUp=-1 THEN 'N'
END as IsCustomerPickUp,
CASE
	WHEN IsRangerDrop=NULL THEN 'UNK'
	WHEN IsRangerDrop=0 THEN 'Y'
	WHEN IsRangerDrop=-1 THEN 'N'
END as IsRangerDrop,
CASE
	WHEN ShippingAmount is NULL THEN '0'
	ELSE FORMAT(ShippingAmount, 'N2')
END as ShippingAmount,
CASE
	WHEN OrderCloseDate is NULL THEN '01-01-1900'
	ELSE FORMAT(OrderCloseDate,'yyyy/MM/dd hh:mm:ss')
END as OrderCloseDate,

CASE
	WHEN DiscountAmount is NULL THEN '0'
	ELSE FORMAT(DiscountAmount, 'N2')
END as DiscountAmount,
CASE
	WHEN ReadyForInvoiceDate is NULL THEN '01-01-1900'
	ELSE FORMAT(ReadyForInvoiceDate,'yyyy/MM/dd hh:mm:ss')
END as ReadyForInvoiceDate,
CASE
	WHEN IsRepeatedIssueReviewed=NULL THEN 'UNK'
	WHEN IsRepeatedIssueReviewed=0 THEN 'Y'
	WHEN IsRepeatedIssueReviewed=-1 THEN 'N'
END as IsRepeatedIssueReviewed,
CASE
	WHEN IsReadyForDelivery=NULL THEN 'UNK'
	WHEN IsReadyForDelivery=0 THEN 'Y'
	WHEN IsReadyForDelivery=-1 THEN 'N'
END as IsReadyForDelivery,
CASE
	WHEN LeadTechnicianID is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(LeadTechnicianID))
END as LeadTechnicianID,
CASE
	WHEN IsCPO=NULL THEN 'UNK'
	WHEN IsCPO=0 THEN 'Y'
	WHEN IsCPO=-1 THEN 'N'
END as IsCPO,
CASE
	WHEN IsCPOCompliant=NULL THEN 'UNK'
	WHEN IsCPOCompliant=0 THEN 'Y'
	WHEN IsCPOCompliant=-1 THEN 'N'
END as IsCPOCompliant,
CASE
	WHEN f.CUSTOMER_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(f.CUSTOMER_KEY))
END as Customer_KEY,
GETDATE(),
GETDATE()
from RALLI.[dbo].[orders] a left join DIM_RALLI_SQL_VehicleVIN_ARajeev b on a.VIN = b.VehicleVIN
							left join DIM_RALLI_SQL_Users_ARajeev c on a.ServiceAdvisorUserID = c.UserID
							left join DIM_RALLI_SQL_Location_ARajeev d on a.ServiceLocationID = d.LocationID
							left join DIM_RALLI_SQL_Users_ARajeev e on a.PaymentRecievedByUserID = e.UserID
							left join DIM_RALLI_SQL_Customer_ARajeev f on a.Customer_id = f.Customer_id
WHERE b.enabled='Y' and d.enabled='Y'




select * from RALLI.[dbo].orders
where TotalAmount > 0 and IsCustomerPickUp='Y'


select count(*) from FACT_RALLI_SQL_OrderJob_ARajeev

--DDL Statements for OrderJob
--drop table FACT_RALLI_SQL_OrderJob_ARajeev
CREATE TABLE [dbo].[FACT_RALLI_SQL_OrderJob_ARajeev](
ORDERJOB_KEY INT IDENTITY(1,1),
[OrderJobID] int,
[Order_KEY] int,
[OrderJobStatus] [nvarchar](255) NULL,
[LaborPrice] money NULL,
[LaborAmount] money NULL,
[TotalAmount] money NULL,
[TotalPartPrice] money NULL,
[Paymethod][nvarchar](255) NULL,
[ComplaintNarrative] ntext NULL,
[CauseNarrative] ntext NULL,
[Enabled] [nvarchar](255) NULL,
[CustomerConcernDetailID] [nvarchar](255),
[VOR] [nvarchar](255) NULL,
[OrderJobClosedate] DATETIME,
[Category][nvarchar](255) NULL,
[IsDuplicatedSymptom] [nvarchar](255) NULL,
[IsDuplicatedCorrection] [nvarchar](255) NULL,
[IsTow] [nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO

select Len(ComplaintNarrative), CauseNarrative from RALLI.[dbo].OrderJob order by Len(ComplaintNarrative) desc


--DDL Statements for OrderJob
insert into [dbo].[FACT_RALLI_SQL_OrderJob_ARajeev]
select 
CASE
	WHEN OrderJobID is NULL THEN -1
	ELSE LTRIM(RTRIM(OrderJobID))
END as OrderJobID,
CASE
	WHEN b.ORDER_KEY is NULL THEN -1
	ELSE LTRIM(RTRIM(b.ORDER_KEY))
END as Order_KEY,
CASE
	WHEN OrderJobStatus is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(OrderJobStatus))
END as OrderJobStatus,
CASE 
	WHEN LaborPrice is NULL THEN '0'
	ELSE FORMAT(LaborPrice, 'N2')
END as LabourPrice,
CASE 
	WHEN LaborAmount is NULL THEN '0'
	ELSE FORMAT(LaborAmount, 'N2')
END as LaborAmount,
CASE 
	WHEN a.TotalAmount is NULL THEN '0'
	ELSE FORMAT(a.TotalAmount, 'N2')
END as TotalAmount,
CASE 
	WHEN a.TotalPartPrice is NULL THEN '0'
	ELSE FORMAT(a.TotalPartPrice, 'N2')
END as TotalPartPrice,
CASE
	WHEN PayMethod is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(PayMethod))
END as PayMethod,
CASE
	WHEN ComplaintNarrative is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ComplaintNarrative))
END as ComplaintNarrative,
CASE
	WHEN CauseNarrative is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CauseNarrative))
END as CauseNarrative,
CASE
	WHEN Enabled=NULL THEN 'UNK'
	WHEN Enabled=1 THEN 'Y'
	WHEN Enabled=0 THEN 'N'
END as Enabled,
CASE
	WHEN CustomerConcernDetailID is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CustomerConcernDetailID))
END as CustomerConcernDetailID,
CASE
	WHEN VOR=NULL THEN 'UNK'
	WHEN VOR=1 THEN 'Y'
	WHEN VOR=0 THEN 'N'
END as VOR,
CASE
	WHEN OrderJobCloseDate is NULL THEN '01-01-1900'
	ELSE LTRIM(RTRIM(OrderJobCloseDate))
END as OrderJobCloseDate,
CASE
	WHEN Category is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Category))
END as Category,
CASE
	WHEN IsDuplicatedSymptom=NULL THEN 'UNK'
	WHEN IsDuplicatedSymptom=1 THEN 'Y'
	WHEN IsDuplicatedSymptom=0 THEN 'N'
END as IsDuplicatedSymptom,
CASE
	WHEN IsDuplicatedCorrection=NULL THEN 'UNK'
	WHEN IsDuplicatedCorrection=1 THEN 'Y'
	WHEN IsDuplicatedCorrection=0 THEN 'N'
END as IsDuplicatedCorrection,
CASE
	WHEN IsTow=NULL THEN 'UNK'
	WHEN IsTow=1 THEN 'Y'
	WHEN IsTow=0 THEN 'N'
END as IsTow,
GETDATE(),
GETDATE()
from RALLI.[dbo].OrderJob a left join FACT_RALLI_SQL_Orders_ARajeev b on a.OrderID = b.OrderID

select * from FACT_RALLI_SQL_OrderJob_ARajeev 




--DDL Statements for OrderJobServiceCorrection
CREATE TABLE [dbo].[FACT_RALLI_SQL_OrderJobServiceCorrection_ARajeev](
ORDERJOBSERVICECORRECTION_KEY INT IDENTITY(1,1),
[OrderJobServiceCorrectionId] int,
[OrderJob_KEY] int,
[ServiceCatalogCode] [nvarchar](255) NULL,
[ServiceCatalog] [nvarchar](255) NULL,
[CorrectionNarrative] ntext,
[CorrectionLoaborHours] [nvarchar](255) NULL,
[CorrectionActualLoaborHours] [nvarchar](255) NULL,
[CorrectionLaborPrice] money NULL,
[IsWorkCompleted] [nvarchar](255) NULL,
[Enabled] [nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO

--DML Statements for OrderJobServiceCorrection
--drop table FACT_RALLI_SQL_OrderJobServiceCorrection_ARajeev
insert into FACT_RALLI_SQL_OrderJobServiceCorrection_ARajeev
select 
CASE
	WHEN OrderJobServiceCorrectionId is NULL THEN -1
	ELSE LTRIM(RTRIM(OrderJobServiceCorrectionId))
END as OrderJobServiceCorrectionId,
CASE
	WHEN b.ORDERJOB_KEY is NULL THEN -1
	ELSE LTRIM(RTRIM(b.ORDERJOB_KEY))
END as OrderJob_KEY,
CASE
	WHEN ServiceCatalogCode is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ServiceCatalogCode))
END as ServiceCatalogCode,
CASE
	WHEN ServiceCatalog is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ServiceCatalog))
END as ServiceCatalog,
CASE
	WHEN CorrectionNarrative is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CorrectionNarrative))
END as CorrectionNarrative,
CASE
	WHEN CorrectionLaborHours is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CorrectionLaborHours))
END as CorrectionLaborHours,
CASE
	WHEN CorrectionActualLaborHours is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(CorrectionActualLaborHours))
END as CorrectionActualLaborHours,
CASE 
	WHEN CorrectionLaborPrice is NULL THEN '0'
	ELSE FORMAT(CorrectionLaborPrice, 'N2')
END as CorrectionLaborPrice,
CASE
	WHEN IsWorkCompleted=NULL THEN '-1'
	WHEN IsWorkCompleted=1 THEN 'Y'
	WHEN IsWorkCompleted=0 THEN 'N'
END as IsWorkCompleted,
CASE
	WHEN a.Enabled=NULL THEN 'UNK'
	WHEN a.Enabled=1 THEN 'Y'
	WHEN a.Enabled=0 THEN 'N'
END as Enabled,
GETDATE(),
GETDATE()
from RALLI.[dbo].OrderJobServiceCorrection a left join FACT_RALLI_SQL_OrderJob_ARajeev b on a.OrderJobId = b.OrderJobID

select * from FACT_RALLI_SQL_OrderJobServiceCorrection_ARajeev


----DDL Statements for  OrderJobservicCorrectionPart
CREATE TABLE [dbo].[FACT_RALLI_SQL_OrderJobServiceCorrectionPart_ARajeev](
ORDERJOBSERVICECORRECTIONPART_KEY INT IDENTITY(1,1),
[OrderJobServiceCorrectionPartId] int,
[OrderJobPart_KEY] int,
[Part_KEY] [nvarchar](255) NULL,
[Quantity] [varchar](255) NULL,
[Unitprice] money NULL,
[Enabled] [nvarchar](255) NULL,
[Partcost] money NULL,
[IsCustomPart] [nvarchar](255) NULL,
[InventoryQuantityConsumed] [nvarchar](255) NULL,
[IsInventoryConsumed] [nvarchar](255) NULL,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO
--drop table FACT_RALLI_SQL_OrderJobServiceCorrectionPart_ARajeev


----DML Statements for  OrderJobservicCorrectionPart
insert into dbo.FACT_RALLI_SQL_OrderJobServiceCorrectionPart_ARajeev
select 
CASE
	WHEN a.OrderJobServiceCorrectionId is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(a.OrderJobServiceCorrectionId))
END as OrderJobServiceCorrectionId,
CASE
	WHEN b.ORDERJOBSERVICECORRECTION_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(b.ORDERJOBSERVICECORRECTION_KEY))
END as ORDERJOBSERVICECORRECTION_KEY,
CASE
	WHEN c.PART_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(c.PART_KEY))
END as Partnumber,
CASE
	WHEN Quantity is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(Quantity))
END as Quantity,
CASE 
	WHEN a.Unitprice is NULL THEN '0'
	ELSE FORMAT(a.Unitprice, 'N2')
END as Unitprice,
CASE
	WHEN a.Enabled=NULL THEN 'UNK'
	WHEN a.Enabled=1 THEN 'Y'
	WHEN a.Enabled=0 THEN 'N'
END as Enabled,
CASE 
	WHEN Partcost is NULL THEN '0'
	ELSE FORMAT(Partcost, 'N2')
END as Partcost,
CASE
	WHEN IsCustomPart=NULL THEN 'UNK'
	WHEN IsCustomPart=1 THEN 'Y'
	WHEN IsCustomPart=0 THEN 'N'
END as IsCustomPart,
CASE
	WHEN InventoryQuantityConsumed is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(InventoryQuantityConsumed))
END as InventoryQuantityConsumed,
CASE
	WHEN IsInventoryConsumed=NULL THEN 'UNK'
	WHEN IsInventoryConsumed=1 THEN 'Y'
	WHEN IsInventoryConsumed=0 THEN 'N'
END as IsInventoryConsumed,
GETDATE(),
GETDATE()
from RALLI.[dbo].OrderJobServiceCorrectionPart a left join FACT_RALLI_SQL_OrderJobServiceCorrection_ARajeev b on a.OrderJobServiceCorrectionId = b.OrderJobServiceCorrectionId
												 left join DIM_RALLI_SQL_Part_ARajeev c on a.Partnumber = c.PartNumber
												 where c.ENABLED='Y'

select * from FACT_RALLI_SQL_OrderJobServiceCorrectionPart_ARajeev



----DDL Statements for  customerComplaint
--loading CustomerComplaint
CREATE TABLE [dbo].[FACT_RALLI_SQL_CustomerComplaint_ARajeev](
[CUSTOEMERComplaint_KEY] int IDENTITY(1,1),
[CustomerComplaintID] int,
[VehicleVIN_KEY] int,
[Location_KEY] int,
[Enabled][varchar](255),
[CreateDate] DATETIME,
[Customer_KEY] int,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO


----DML Statements for  customerComplaint
--drop table FACT_RALLI_SQL_CustomerComplaint_ARajeev
insert into dbo.FACT_RALLI_SQL_CustomerComplaint_ARajeev
select
CASE
	WHEN CustomerComplaintID is NULL THEN -1
	ELSE LTRIM(RTRIM(CustomerComplaintID))
END as CustomerComplaintID,
CASE
	WHEN b.VEHICLEVIN_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(b.VEHICLEVIN_KEY))
END as VehicleVIN_KEY,
CASE
	WHEN c.LOCATION_KEY is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(c.LOCATION_KEY))
END as Location_KEY,
CASE
	WHEN a.Enabled=NULL THEN 'UNK'
	WHEN a.Enabled=-1 THEN 'Y'
	WHEN a.Enabled=0 THEN 'N'
END as Enabled,
CASE
	WHEN CreatedDate is NULL THEN '01-01-1900'
	ELSE convert(datetime, CreatedDate,103) 
END as CreateDate, 
CASE
	WHEN a.Customer_id is NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(a.Customer_id))
END as Customer_KEY,
GETDATE(),
GETDATE()
from RALLI.[dbo].CustomerComplaint a left join DIM_RALLI_SQL_VehicleVIN_ARajeev b on a.VIN = b.VehicleVIN and b.Enabled='Y'
									 left join DIM_RALLI_SQL_Location_ARajeev c on a.LocationID = c.LocationID
									 left join DIM_RALLI_SQL_Customer_ARajeev d on a.Customer_id = d.Customer_id
									 where b.Enabled='Y' and c.Enabled='Y'

--9997 rows




----DDL Statements for  customerComplaintDetail

--loading CustomerComplaintDetail
CREATE TABLE [dbo].[FACT_RALLI_SQL_CustomerComplaintDetail_ARajeev](
[CustomerComplaintDetail_KEY] int IDENTITY(1,1),
[CustomerComplaintDetail_ID] int,
[CustomerComplaint_KEY] int,
[ComplaintStatus] [varchar](255) NULL,
[ComplaintType] [varchar](255) NULL,
[ActionType] [varchar](255) NULL,
[Description] [nvarchar](255) NULL,
[ShortDescription] [nvarchar](255) NULL,
[IsVehicleOperable] [nvarchar](255) NULL,
[IsTow] [nvarchar](255) NULL,
[ServiceLocation_KEY] int,
[CreateDate] DATETIME,
[ComplaintCloseDate] DATETIME,
[CreatedByUser_KEY] int,
--AUDIT COLUMNS
DW_CREATED_DATE DATETIME,
DW_UPDATED_DATE DATETIME,
) ON [PRIMARY]
GO


----DML Statements for  customerComplaintDetail
select count(*) from FACT_RALLI_SQL_CustomerComplaintDetail_ARajeev
--drop table FACT_RALLI_SQL_CustomerComplaintDetail_ARajeev
insert into FACT_RALLI_SQL_CustomerComplaintDetail_ARajeev
select 
CASE
	WHEN CustomerComplaintDetail_ID=NULL THEN -1
	ELSE LTRIM(RTRIM(CustomerComplaintDetail_ID))
END as CustomerComplaintDetail_ID,
CASE
	WHEN b.CUSTOEMERComplaint_KEY = NULL THEN -1
	ELSE LTRIM(RTRIM(b.CUSTOEMERComplaint_KEY))
END as CustomerComplaint_KEY,
CASE
	WHEN ComplaintStatus=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ComplaintStatus))
END as ComplaintStatus,
CASE
	WHEN ComplaintType=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ComplaintType))
END as ComplaintType,
CASE
	WHEN ActionType=NULL THEN 'UNK'
	ELSE LTRIM(RTRIM(ActionType))
END as ActionType,
CASE
	WHEN Description=NULL THEN 'UNK'
	ELSE dbo.RemoveUnwantedChar(Description)
END as Description,
CASE
	WHEN ShortDescription=NULL THEN 'UNK'
	ELSE dbo.RemoveUnwantedChar(ShortDescription)
END as ShortDescription,
CASE 
	WHEN IsVehicleOperable=NULL THEN 'UNK'
	WHEN IsVehicleOperable=1 THEN 'Y'
	WHEN IsVehicleOperable=0 THEN 'N'
END as IsVehicleOperable,
CASE
	WHEN IsTow=NULL THEN 'UNK'
	WHEN IsTow=1 THEN 'Y'
	WHEN IsTow=0 THEN 'N'
END as IsTow,
CASE
	WHEN c.LOCATION_KEY=NULL THEN -1
	ELSE LTRIM(RTRIM(c.LOCATION_KEY))
END as Location_KEY,
CASE
	WHEN a.CreateDate is NULL THEN '01-01-1900'
	ELSE convert(datetime, a.CreateDate, 103)
END as CreateDate,
CASE
	WHEN ComplaintCloseDate is NULL THEN '01-01-1900'
	ELSE convert(datetime, ComplaintCloseDate, 103)
END as CreateDate,
CASE
	WHEN d.USER_KEY=NULL THEN -1
	ELSE LTRIM(RTRIM(d.USER_KEY))
END as CreatedByUser_KEY,
GETDATE(),
GETDATE()
from RALLI.[dbo].CustomerComplaintDetail a left join FACT_RALLI_SQL_CustomerComplaint_ARajeev b on a.CustomerComplaintID = b.CustomerComplaintID
										   left join DIM_RALLI_SQL_Location_ARajeev c on a.ServiceLocationID = c.LocationID 
										   left join DIM_RALLI_SQL_Users_ARajeev d on a.CreatedByUserID = d.UserID
										  



select Description, dbo.RemoveUnwantedChar(Description) from RALLI.[dbo].CustomerComplaintDetail
where PATINDEX('%?%', Description) != 0






--Function for performing initcap of each word operation
-- drop function Capword
create function Capword(@word varchar(255))
returns varchar(255)
as
begin
declare @flag int set @flag =1
declare @newword varchar(255) set @newword = CONCAT(CONCAT(' ',@word),'==')
		while @flag< len(@newword)
			begin
				if ASCII(SUBSTRING(@newword,@flag,1)) =32
				begin
					set @newword = Concat(substring(@newword,1,(@flag)), concat(UPPER(SUBSTRING(@newword,@flag+1,1)), Substring(@newword,@flag+2,len(@newword))))
				end
				set @flag= @flag+1
			end
			set @newword = REPLACE(@newword,'==','')
		return @newword
	end 

declare @res varchar(255)
select @res = dbo.Capword('sanath jayasurya')
print @res

select count(region), region from Ralli.[dbo].Location group by region




--function to filter region(Midsouth --> Mid South)
create function RegionFilter(@word varchar(255))
returns varchar(255)
as
begin
declare @newword varchar(255) set @newword = concat(' ',LOWER(@word))
	if patindex('%north%', @newword) > 1 AND patindex('%northern%', @newword) = 0
	begin
		set @newword = concat(concat(SUBSTRING(@newword, 1, patindex('%north%', @newword)-1),' north '), substring(@newword, patindex('%north%', @newword)+5, len(@newword)))
	end
	if patindex('%south%', @newword) > 1 AND patindex('%southern%', @newword) = 0
	begin
		set @newword = concat(concat(SUBSTRING(@newword, 1, patindex('%south%', @newword)-1),' south '), substring(@newword, patindex('%south%', @newword)+5, len(@newword)))
	end
	if patindex('%east%', @newword) > 1 AND patindex('%eastern%', @newword) = 0
	begin
		set @newword = concat(concat(SUBSTRING(@newword, 1, patindex('%east%', @newword)-1),' east '), substring(@newword, patindex('%east%', @newword)+4, len(@newword)))
	end
	if patindex('%west%', @newword) > 1 AND patindex('%western%', @newword) = 0
	begin
		set @newword = concat(concat(SUBSTRING(@newword, 1, patindex('%west%', @newword)-1),' west '), substring(@newword, patindex('%west%', @newword)+4, len(@newword)))
	end
	return dbo.Capword(replace(@newword,'  ',' '))
end

drop function RegionFilter
declare @re varchar(255)
select @re = dbo.RegionFilter('northwestsoutheast')
print @re



select concat(substring(Region,1, patindex('%north%', Region)-1), 
substring(Region, patindex('%north%', Region)+5, len(Region))), Region 
from DIM_RALLI_SQL_Location_ARajeev
where patindex('%north%', Region) >= 1



--function to remove unwanted characters
create function RemoveUnwantedChar(@word varchar(255))
returns varchar(255)
as
begin
	set @word = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@word,'(',''),')',''),'?',''),
        '!',''),'@',''),'/',''),'"',''),'#',''),
        '.',' '),'&',''),'*',''),'+',' ')))
	return @word
end


drop function RemoveUnwantedChar






--testing
select count(*), Enabled from FACT_RALLI_SQL_CustomerComplaint_ARajeev group by Enabled

select * from DIM_RALLI_SQL_Part_ARajeev
select count(*), OrderJobStatus  from FACT_RALLI_SQL_OrderJob_ARajeev group by OrderJobStatus

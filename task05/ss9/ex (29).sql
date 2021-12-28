SET IDENTITY_INSERT [Person]. [AddressType] ON
MERGE INTO [Person].[AddressType] AS Target
USING (VALUES
  (1,'Billing')
  (2,'Home')
 , (3,'Headquarters')
 ,(4,'Primary')
 , (5,'Shipping')
 , (6,'Archival')
 , (7,'Contact')
  (8, 'Alternative')
 ) AS Source
([AddressTypeID], [Name]) ON (Target.[AddressTypeID] = Source.[AddressTypeID])
WHEN MATCHED AND (Target.[Name] <> Source.[Name]) THEN
    UPDATE SET [Name] = Source.[Name]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([AddressTypeID], [Name]) VALUES (Source. [AddressTypeID],Source.[Name])
WHEN NOT MATCHED BY SOURCE THEN
    DELETE
OUTPUT $action, Inserted. [AddressTypeID], Inserted.Name,
Deleted. [AddressTypeID], Deleted.Name;
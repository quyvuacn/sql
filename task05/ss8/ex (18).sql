use AdventureWorks2014
create table Person.PhoneBilling (
	Bill_ID int Primary key,
	MobileNumber bigint unique,
	CallDetails XML
)
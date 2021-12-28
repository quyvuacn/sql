use AdventureWorks2014
insert into Person.PhoneBilling(Bill_ID, MobileNumber, CallDetails)
	values (
	100,
	9833276605,
	'<Info>
		<Call>Local</Call>
		<Time>45 minutes</Time>
		<Charges>200</Charges>
	</Info>'
	)
select CallDetails from Person.PhoneBilling
go
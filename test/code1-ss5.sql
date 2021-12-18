create database Test

on primary (
	name = 'Test_DB_',
	filename = 'C:\SQL\test\test.mdf'
)

log on (
    name = 'Test_DB_LOG_',
	filename = 'C:\SQL\test\test_db_log.ldf'
)

go
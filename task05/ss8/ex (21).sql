create table SoccerTeam (
	TeamID int identity not null,
	TeamInfo xml(SoccerSchemaCollection)
)
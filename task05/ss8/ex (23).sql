DECLARE @team xml (SoccerSchemaCollection)
SET @team='<MatchDetails><Team country="Australia"></Team></MatchDetails>'
SELECT@team
GO
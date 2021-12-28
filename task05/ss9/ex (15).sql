DECLARE @Cityl geography
SET @Cityl=geography:: STPolyFromText(
 'POLYGON ( (175.3-41.5,178.3-37.9,172.8-34.6,175.3-41.5))', 4326)
DECLARE @City2 geography
SET @City2=geography::STPolyFromText(
 'POLYGON ( (169.3-46.6, 174.3-41.6,172.5-40.7,166.3-45.8,169.3 – 46.6))',
4326)
DECLARE @CombinedCity geography = @Cityl.STUnion (@City2)
SELECT @CombinedCity
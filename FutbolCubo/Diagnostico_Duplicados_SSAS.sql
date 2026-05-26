-- Diagnostico de claves duplicadas/conflictivas para SSAS
-- Ejecutar sobre la base relacional Futbol_DW.

USE Futbol_DW;
GO

-- 1) Meses con mas de un trimestre asociado.
-- Si devuelve filas, SSAS puede fallar al procesar [Dim Time].[Mes].
SELECT
    [year],
    [month],
    COUNT(*) AS filas,
    COUNT(DISTINCT [quarter]) AS trimestres_distintos,
    MIN([quarter]) AS trimestre_min,
    MAX([quarter]) AS trimestre_max
FROM dbo.Dim_Time
GROUP BY [year], [month]
HAVING COUNT(DISTINCT [quarter]) > 1;

-- 2) Dias con mas de un mes/anio asociado.
SELECT
    [year],
    [month],
    [day],
    COUNT(*) AS filas,
    COUNT(DISTINCT date_key) AS fechas_distintas
FROM dbo.Dim_Time
GROUP BY [year], [month], [day]
HAVING COUNT(*) > 1;

-- 3) Ciudades de equipos con pais/continente ambiguo.
SELECT
    ISNULL(country_name, '<NULL>') AS country_name,
    ISNULL(city_name, '<NULL>') AS city_name,
    COUNT(*) AS equipos,
    COUNT(DISTINCT ISNULL(continent_name, '<NULL>')) AS continentes_distintos
FROM dbo.Dim_Teams
GROUP BY ISNULL(country_name, '<NULL>'), ISNULL(city_name, '<NULL>')
HAVING COUNT(DISTINCT ISNULL(continent_name, '<NULL>')) > 1;

-- 4) Competiciones con temporadas ambiguas.
SELECT
    league_title,
    season_title,
    COUNT(*) AS eventos
FROM dbo.Dim_Events
GROUP BY league_title, season_title
HAVING COUNT(*) > 1;

-- 5) Estadios con claves duplicadas o nombres distintos para el mismo id.
SELECT
    ground_id,
    COUNT(*) AS filas,
    COUNT(DISTINCT stadium_name) AS nombres_distintos
FROM dbo.Dim_Estadios
GROUP BY ground_id
HAVING COUNT(*) > 1 OR COUNT(DISTINCT stadium_name) > 1;

-- 6) Jornadas con titulos duplicados dentro del mismo evento/posicion.
SELECT
    event_id,
    pos,
    COUNT(*) AS jornadas,
    COUNT(DISTINCT titulo) AS titulos_distintos
FROM dbo.Dim_Jornada
GROUP BY event_id, pos
HAVING COUNT(*) > 1 OR COUNT(DISTINCT titulo) > 1;

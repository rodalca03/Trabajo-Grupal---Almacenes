# Consultas MDX corregidas para el cubo `Futbol DW`

Estas consultas están ajustadas a los nombres actuales del cubo tras las correcciones:

- Tiempo: `[Dim Time].[Calendario]` con niveles `Anio`, `Trimestre`, `Mes`, `Dia`.
- Día de semana: `[Dim Time].[Dia de la semana]` con nivel `Nombre dia semana`.
- Eventos: `[Dim Events].[Competicion Temporada]` con niveles `Competicion`, `Temporada`.
- Jornadas: `[Dim Jornada].[Jornada Competicion]` con niveles `Evento`, `Orden jornada`, `Jornada`.
- Equipos: `[Team1].[Geografia Equipo]` y `[Team2].[Geografia Equipo]`.
- Estadios: `[Dim Estadios].[Ubicacion Estadio]`.

## 1. Resumen general del cubo

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles],
    [Measures].[Goles Local],
    [Measures].[Goles Visitante],
    [Measures].[Empates]
  } ON COLUMNS
FROM [Futbol DW];
```

## 2. Partidos y goles por año

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles],
    [Measures].[Goles Local],
    [Measures].[Goles Visitante]
  } ON COLUMNS,
  NON EMPTY
    [Dim Time].[Calendario].[Anio].MEMBERS ON ROWS
FROM [Futbol DW];
```

## 3. Evolución mensual de goles

```mdx
WITH
  MEMBER [Measures].[Media Goles Partido] AS
    IIF(
      [Measures].[Recuento Partido] = 0,
      NULL,
      [Measures].[Total Goles] / [Measures].[Recuento Partido]
    ),
    FORMAT_STRING = '0.00'
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles],
    [Measures].[Media Goles Partido]
  } ON COLUMNS,
  NON EMPTY
    [Dim Time].[Calendario].[Mes].MEMBERS ON ROWS
FROM [Futbol DW];
```

## 4. Goles por competición y año

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles]
  } ON COLUMNS,
  NON EMPTY
    CROSSJOIN(
      [Dim Events].[Competicion Temporada].[Competicion].MEMBERS,
      [Dim Time].[Calendario].[Anio].MEMBERS
    ) ON ROWS
FROM [Futbol DW];
```

## 5. Temporadas con más goles

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles]
  } ON COLUMNS,
  NON EMPTY
    TOPCOUNT(
      [Dim Events].[Competicion Temporada].[Temporada].MEMBERS,
      10,
      [Measures].[Total Goles]
    ) ON ROWS
FROM [Futbol DW];
```

## 6. Equipos locales con más goles

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Goles Local],
    [Measures].[Victoria Local]
  } ON COLUMNS,
  NON EMPTY
    TOPCOUNT(
      [Team1].[Geografia Equipo].[Equipo].MEMBERS,
      15,
      [Measures].[Goles Local]
    ) ON ROWS
FROM [Futbol DW];
```

## 7. Equipos visitantes con más goles

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Goles Visitante],
    [Measures].[Victoria Visitante]
  } ON COLUMNS,
  NON EMPTY
    TOPCOUNT(
      [Team2].[Geografia Equipo].[Equipo].MEMBERS,
      15,
      [Measures].[Goles Visitante]
    ) ON ROWS
FROM [Futbol DW];
```

## 8. Rendimiento local por equipo

```mdx
WITH
  MEMBER [Measures].[Porcentaje Victorias Locales] AS
    IIF(
      [Measures].[Recuento Partido] = 0,
      NULL,
      [Measures].[Victoria Local] / [Measures].[Recuento Partido]
    ),
    FORMAT_STRING = 'Percent'
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Victoria Local],
    [Measures].[Porcentaje Victorias Locales]
  } ON COLUMNS,
  NON EMPTY
    [Team1].[Geografia Equipo].[Equipo].MEMBERS ON ROWS
FROM [Futbol DW];
```

## 9. Cruce de país local contra país visitante

```mdx
WITH
  MEMBER [Measures].[Balance Goles Local Visitante] AS
    [Measures].[Goles Local] - [Measures].[Goles Visitante]
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Goles Local],
    [Measures].[Goles Visitante],
    [Measures].[Balance Goles Local Visitante]
  } ON COLUMNS,
  NON EMPTY
    TOPCOUNT(
      CROSSJOIN(
        [Team1].[Geografia Equipo].[Pais].MEMBERS,
        [Team2].[Geografia Equipo].[Pais].MEMBERS
      ),
      25,
      [Measures].[Recuento Partido]
    ) ON ROWS
FROM [Futbol DW];
```

## 10. Distribución de partidos por día de la semana

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles],
    [Measures].[Empates]
  } ON COLUMNS,
  NON EMPTY
    [Dim Time].[Dia de la semana].[Nombre dia semana].MEMBERS ON ROWS
FROM [Futbol DW];
```

## 11. Goles por temporada, mes y día de la semana

```mdx
SELECT
  [Dim Time].[Dia de la semana].[Nombre dia semana].MEMBERS ON COLUMNS,
  NON EMPTY
    CROSSJOIN(
      [Dim Events].[Competicion Temporada].[Temporada].MEMBERS,
      [Dim Time].[Calendario].[Mes].MEMBERS
    ) ON ROWS
FROM [Futbol DW]
WHERE ([Measures].[Total Goles]);
```

## 12. Estadios con más partidos y goles

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles]
  } ON COLUMNS,
  NON EMPTY
    TOPCOUNT(
      [Dim Estadios].[Ubicacion Estadio].[Estadio].MEMBERS,
      15,
      [Measures].[Recuento Partido]
    ) ON ROWS
FROM [Futbol DW];
```

## 13. Goles por estadio

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles]
  } ON COLUMNS,
  NON EMPTY
    [Dim Estadios].[Ubicacion Estadio].[Estadio].MEMBERS ON ROWS
FROM [Futbol DW];
```

## 14. Jornadas con más goles

```mdx
SELECT
  {
    [Measures].[Recuento Partido],
    [Measures].[Total Goles],
    [Measures].[Empates]
  } ON COLUMNS,
  NON EMPTY
    TOPCOUNT(
      [Dim Jornada].[Jornada Competicion].[Jornada].MEMBERS,
      20,
      [Measures].[Total Goles]
    ) ON ROWS
FROM [Futbol DW];
```

## 15. Acumulado de goles por mes dentro del año

```mdx
WITH
  MEMBER [Measures].[Goles Acumulados Anio] AS
    SUM(
      PERIODSTODATE(
        [Dim Time].[Calendario].[Anio],
        [Dim Time].[Calendario].CURRENTMEMBER
      ),
      [Measures].[Total Goles]
    )
SELECT
  {
    [Measures].[Total Goles],
    [Measures].[Goles Acumulados Anio]
  } ON COLUMNS,
  NON EMPTY
    [Dim Time].[Calendario].[Mes].MEMBERS ON ROWS
FROM [Futbol DW];
```

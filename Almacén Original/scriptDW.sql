-- ============================================
-- CREACIÓN DE BASE DE DATOS
-- ============================================
CREATE DATABASE Futbol_DW;
GO

USE Futbol_DW;
GO

-- ============================================
-- TABLAS DE DIMENSIÓN
-- ============================================

-- Dimensión Eventos
CREATE TABLE Dim_Events (
    event_id      INT           IDENTITY(1,1) NOT NULL, -- Autogenerado
    league_title  NVARCHAR(100) NOT NULL,
    season_title  NVARCHAR(100) NOT NULL,
    start_at      DATE          NOT NULL,
    end_at        DATE          NOT NULL,
    CONSTRAINT PK_Dim_Events PRIMARY KEY (event_id)
);
GO

-- Dimensión Equipos
CREATE TABLE Dim_Teams (
    team_id        INT           IDENTITY(1,1) NOT NULL, -- Autogenerado
    team_name      NVARCHAR(100) NOT NULL,
    city_name      NVARCHAR(100) NULL,
    country_name   NVARCHAR(100) NULL,
    continent_name NVARCHAR(100) NULL,
    ground_id      INT           NULL, -- Se rellena tras cargar la dimensión de estadios
    CONSTRAINT PK_Dim_Teams PRIMARY KEY (team_id)
);
GO

-- Dimensión Estadios
CREATE TABLE Dim_Grounds (
    ground_id     INT           IDENTITY(1,1) NOT NULL, -- Autogenerado
    stadium_name  NVARCHAR(150) NOT NULL,
    capacity      INT           NULL,
    city_name     NVARCHAR(100) NULL,
    country_name  NVARCHAR(100) NULL,
    CONSTRAINT PK_Dim_Grounds PRIMARY KEY (ground_id)
);
GO

-- Dimensión Tiempo
-- NOTA: En Data Warehouse, date_key suele ser un entero inteligente (ej: 20260516).
-- Si prefieres que sea secuencial automático, dejamos IDENTITY(1,1).
CREATE TABLE Dim_Time (
    date_key    INT IDENTITY(1,1) NOT NULL, -- Autogenerado
    day         INT NOT NULL,
    month       INT NOT NULL,
    year        INT NOT NULL,
    quarter     INT NOT NULL,
    day_of_week INT NOT NULL,
    CONSTRAINT PK_Dim_Time PRIMARY KEY (date_key)
);
GO

-- ============================================
-- TABLA DE HECHOS
-- ============================================

CREATE TABLE Partido (
    game_id   INT IDENTITY(1,1) NOT NULL, -- Autogenerado
    date_key  INT NOT NULL,
    team1_id  INT NOT NULL,
    team2_id  INT NOT NULL,
    ground_id INT NOT NULL,
    event_id  INT NOT NULL,
    round_id  INT NULL,
    score1    INT NULL,
    score2    INT NULL,
    score1et  INT NULL,  -- Score equipo 1 tiempo extra
    score2et  INT NULL,  -- Score equipo 2 tiempo extra
    score1p   INT NULL,  -- Score equipo 1 penaltis
    score2p   INT NULL,  -- Score equipo 2 penaltis
    score1i   INT NULL,  -- Score equipo 1 (variante)
    score2i   INT NULL,  -- Score equipo 2 (variante)
    CONSTRAINT PK_Partido PRIMARY KEY (game_id),

    -- FK → Dim_Events
    CONSTRAINT FK_Partido_Events
        FOREIGN KEY (event_id)  REFERENCES Dim_Events (event_id),

    -- FK → Dim_Teams (equipo local)
    CONSTRAINT FK_Partido_Team1
        FOREIGN KEY (team1_id) REFERENCES Dim_Teams (team_id),

    -- FK → Dim_Teams (equipo visitante)
    CONSTRAINT FK_Partido_Team2
        FOREIGN KEY (team2_id) REFERENCES Dim_Teams (team_id),

    -- FK → Dim_Grounds
    CONSTRAINT FK_Partido_Grounds
        FOREIGN KEY (ground_id) REFERENCES Dim_Grounds (ground_id),

    -- FK → Dim_Time
    CONSTRAINT FK_Partido_Time
        FOREIGN KEY (date_key)  REFERENCES Dim_Time (date_key)
);
GO

-- ============================================
-- ÍNDICES RECOMENDADOS
-- ============================================

CREATE INDEX IX_Partido_event_id  ON Partido (event_id);
CREATE INDEX IX_Partido_team1_id  ON Partido (team1_id);
CREATE INDEX IX_Partido_team2_id  ON Partido (team2_id);
CREATE INDEX IX_Partido_ground_id ON Partido (ground_id);
CREATE INDEX IX_Partido_date_key  ON Partido (date_key);
GO

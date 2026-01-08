CREATE OR ALTER VIEW DWH.vw_Salarios_Analytics AS
SELECT

Pk_Unica        = CONCAT(s.ID_Historia, '-', v.Nombre_Local),
Pk_Original     = s.ID_Historia,
Fecha_Periodo   = s.Fecha_Periodo,

Lugar_Nomina    = ISNULL(UPPER(TRIM(s.LUGAR)), 'DESCONOCIDO'),
Cargo           = ISNULL(UPPER(TRIM(s.CARGO)), 'DESCONOCIDO'),
Registro        = ISNULL(UPPER(TRIM(s.REGISTRO)), 'N/A'),
Colaborador     = ISNULL(UPPER(TRIM(s.COLABORADOR)), 'DESCONOCIDO'),


Local_Trabajado  = LEFT(v.Nombre_Local, 1), 
Horas_Trabajadas = ISNULL(TRY_CAST(v.Horas_Raw AS DECIMAL(10,2)), 0),

Sueldo_Fijo = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.SUELDO_FIJO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.SUELDO_FIJO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.SUELDO_FIJO, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Comision = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.COMISION, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.COMISION, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.COMISION, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Total_Neto = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.TOTAL, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.TOTAL, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.TOTAL, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 1000, 0)
END AS BIGINT),

Efectivo = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.EFECTIVO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.EFECTIVO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.EFECTIVO, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Valor_Hs_Extras = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_EXTRA, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_EXTRA, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_EXTRA, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Valor_Hs_Feriado = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_FERIADO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_FERIADO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_FERIADO, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)), 0) 
END AS BIGINT),

Valor_Hs_Aus = CAST(ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(s.VALOR_HORAS_AU, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)), 0) AS BIGINT),

Bono_Jefe = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.BONO_JEFE, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.BONO_JEFE, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.BONO_JEFE, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Bono_Director = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.BONO_DIRECTOR, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.BONO_DIRECTOR, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.BONO_DIRECTOR, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Bono_Ventas = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.BONO_X_VENTAS, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.BONO_X_VENTAS, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.BONO_X_VENTAS, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 100, 0)
END AS BIGINT),

Aumento = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.AUMENTO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.AUMENTO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.AUMENTO, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 10, 0)
END AS BIGINT),

Descuento = CAST(CASE 
    WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.DESCUENTO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)) > 1000 
    THEN TRY_CAST(REPLACE(REPLACE(REPLACE(s.DESCUENTO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2))
    ELSE ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(s.DESCUENTO, '$', ''), ' ', ''), '.', ''), ',', '.') AS DECIMAL(18,2)) * 1000, 0)
END AS BIGINT),

Valor_Hora      = CAST(ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(s.VALOR_x_HORA, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)), 0) AS BIGINT),
Transferencia   = CAST(ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(s.TRANSFERENCIA, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)), 0) AS BIGINT),
Redondeo        = CAST(ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(s.REDONDEO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)), 0) AS BIGINT),
Adelanto        = CAST(ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(s.ADELANTO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)), 0) AS BIGINT),
Prestamo        = CAST(ISNULL(TRY_CAST(REPLACE(REPLACE(REPLACE(s.PRESTAMO, '$', ''), ' ', ''), ',', '') AS DECIMAL(18,2)), 0) AS BIGINT),

Cant_Hs_Extras  = ISNULL(TRY_CAST(REPLACE(LOWER(s.HORAS_EXTRA), 'hs', '') AS INT), 0),
Cant_Hs_Aus     = ISNULL(TRY_CAST(REPLACE(LOWER(s.HORAS_AU), 'hs', '') AS INT), 0),
Cant_Hs_Feriado = ISNULL(TRY_CAST(REPLACE(LOWER(s.HORAS_FERIADO), 'hs', '') AS INT), 0)

FROM STAGING.Historico_Salarios s
CROSS APPLY (
VALUES
('Confidencial', s.L1),
('Confidencial',  s.C),
('Confidencial', s.M),
('Confidencial',s.D),
('Confidencial', s.P),
('Confidencial', s.F)
) v(Nombre_Local, Horas_Raw)
WHERE
TRY_CAST(v.Horas_Raw AS DECIMAL(10,2)) IS NOT NULL
AND TRY_CAST(v.Horas_Raw AS DECIMAL(10,2)) > 0
AND s.LUGAR IN ('Confidencial', 'Confidencial', 'Confidencial', 'Confidencial', 'Confidencial', 'Confidencial')
AND UPPER(TRIM(s.CARGO)) NOT IN ('PROMOTOR', 'E-COMMERCE');
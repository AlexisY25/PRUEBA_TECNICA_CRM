/* ============================================= */

WITH VentasConEjecutivo AS
(
    /* Para cada venta, buscamos la última visita (<= FechaVenta) al mismo cliente
       y tomamos el IdEjecutivo de esa visita. */
    SELECT
        ve.IdVenta,
        ve.IdCliente,
        ve.FechaVenta,
        ve.Monto,
        vis.IdEjecutivo
    FROM dbo.Ventas ve
    OUTER APPLY
    (
        SELECT TOP (1) v.IdEjecutivo, v.FechaVisita
        FROM dbo.Visitas v
        WHERE v.IdCliente = ve.IdCliente
          AND v.FechaVisita <= ve.FechaVenta
          --AND v.FechaVisita >= @Desde      -- (opcional)
          --AND v.FechaVisita <  DATEADD(day,1,@Hasta)  -- (opcional)
        ORDER BY v.FechaVisita DESC
    ) vis
    -- Filtro de ventas por periodo (opcional)
    --WHERE ve.FechaVenta >= @Desde
    --  AND ve.FechaVenta <  DATEADD(day,1,@Hasta)
),
AggVisitas AS
(
    /* Agregados de visitas por ejecutivo (y periodo si quieres) */
    SELECT
        v.IdEjecutivo,
        COUNT(*)                           AS TotalVisitas,
        COUNT(DISTINCT v.IdCliente)        AS ClientesVisitados
    FROM dbo.Visitas v
    --WHERE v.FechaVisita >= @Desde
    --  AND v.FechaVisita <  DATEADD(day,1,@Hasta)
    GROUP BY v.IdEjecutivo
),
AggVentas AS
(
    /* Agregados de ventas ya atribuidas a un ejecutivo vía la última visita */
    SELECT
        vce.IdEjecutivo,
        COUNT(*)                           AS Ventas,
        SUM(vce.Monto)                     AS MontoVentas,
        COUNT(DISTINCT vce.IdCliente)      AS ClientesConVenta
    FROM VentasConEjecutivo vce
    WHERE vce.IdEjecutivo IS NOT NULL      -- solo ventas que pudimos atribuir
    GROUP BY vce.IdEjecutivo
)
SELECT
    e.IdEjecutivo,
    e.Nombre + ' ' + e.Apellido           AS Ejecutivo,
    ISNULL(v.TotalVisitas,0)              AS TotalVisitas,
    ISNULL(v.ClientesVisitados,0)         AS ClientesVisitados,
    ISNULL(s.Ventas,0)                    AS VentasAsociadas,
    ISNULL(s.MontoVentas,0.0)             AS MontoVentas,
    ISNULL(s.ClientesConVenta,0)          AS ClientesConVenta,
    /* KPIs */
    CASE WHEN ISNULL(s.Ventas,0) > 0
         THEN CAST(s.MontoVentas*1.0 / s.Ventas AS decimal(18,2))
         ELSE 0 END                        AS TicketPromedio,
    CASE WHEN ISNULL(v.TotalVisitas,0) > 0
         THEN CAST(s.Ventas*1.0 / v.TotalVisitas AS decimal(18,2))
         ELSE 0 END                        AS VentasPorVisita,
    CASE WHEN ISNULL(v.ClientesVisitados,0) > 0
         THEN CAST(s.Ventas*1.0 / v.ClientesVisitados AS decimal(18,2))
         ELSE 0 END                        AS ConversionClientes,
    CASE WHEN ISNULL(v.TotalVisitas,0) > 0
         THEN CAST(s.MontoVentas*1.0 / v.TotalVisitas AS decimal(18,2))
         ELSE 0 END                        AS MontoPorVisita
FROM dbo.Ejecutivos e
LEFT JOIN AggVisitas v ON v.IdEjecutivo = e.IdEjecutivo
LEFT JOIN AggVentas  s ON s.IdEjecutivo = e.IdEjecutivo
ORDER BY MontoVentas DESC, VentasAsociadas DESC;

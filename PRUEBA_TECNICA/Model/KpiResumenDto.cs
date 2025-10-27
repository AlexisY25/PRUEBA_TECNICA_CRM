namespace PRUEBA_TECNICA.Model
{
    public record KpiResumenDto(
    int TotalVisitas,
    int VisitasConVenta,
    decimal TotalVentas,
    int ClientesUnicosConVenta,
    decimal MontoPromedioPorVenta,
    decimal VentasPorCliente,
    decimal VisitasPorEjecutivo
);
}

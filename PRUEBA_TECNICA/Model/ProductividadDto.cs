namespace PRUEBA_TECNICA.Model
{
    public record ProductividadDto(
    int IdEjecutivo,
    string Ejecutivo,
    int TotalVisitas,
    int ClientesVisitados,
    int VentasAsociadas,
    decimal MontoVentas,
    int ClientesConVenta,
    decimal TicketPromedio,
    decimal VentasPorVisita,
    decimal ConversionClientes,
    decimal MontoPorVisita
);
}

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PRUEBA_TECNICA.Model;
using Dapper;

namespace PRUEBA_TECNICA.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class KpiController : Controller
    {
        private readonly SqlConnection _conn;
        public KpiController(SqlConnection conn) => _conn = conn;

        /// <summary>
        /// KPIs generales del SP dbo.sp_KPI_Resumen (sin parámetros).
        /// GET: /api/kpi/resumen
        /// </summary>
        [HttpGet("resumen")]
        public async Task<ActionResult<KpiResumenDto>> GetResumen()
        {
            // El SP debe devolver una sola fila con las columnas del DTO
            var data = await _conn.QuerySingleAsync<KpiResumenDto>(
                "dbo.sp_KPI_Resumen",
                commandType: System.Data.CommandType.StoredProcedure);

            return Ok(data);
        }
    }
}

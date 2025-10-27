using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Dapper;
using PRUEBA_TECNICA.Model;

namespace PRUEBA_TECNICA.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductividadController : Controller
    {
        private readonly SqlConnection _conn;
        public ProductividadController(SqlConnection conn) => _conn = conn;

        /// <summary>
        /// Productividad por ejecutivo (vista dbo.vw_ProductividadPorEjecutivo).
        /// GET: /api/productividad
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductividadDto>>> Get()
        {
            const string sql = "SELECT * FROM dbo.vw_ProductividadPorEjecutivo;";
            var data = await _conn.QueryAsync<ProductividadDto>(sql);
            return Ok(data);
        }
    }
}

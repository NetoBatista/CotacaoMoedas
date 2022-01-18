using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using CotacaoMoeda.Domain.Interfaces.Service;
using System.Threading.Tasks;
using CotacaoMoeda.Domain.DTO;
using System.Collections.Generic;

namespace CotacaoMoeda.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OcurrenceController : ControllerBase
    {
        private readonly ILogger<OcurrenceController> logger;
        private readonly IOcurrenceService ocurrenceService;

        public OcurrenceController(ILogger<OcurrenceController> logger, IOcurrenceService ocurrenceService)
        {
            this.logger = logger;
            this.ocurrenceService = ocurrenceService;
        }

        [HttpGet("{coin}")]
        public async Task<ActionResult<IEnumerable<OcurrenceDTO>>> GetOcurrence(string coin)
        {
            logger.LogInformation("Running Method OcurrenceController.GetOcurrence");
            var response = await ocurrenceService.GetOcurrence(coin);
            return Ok(response);
        }

        [HttpGet("closing/date/{coin}/{startDate}/{endDate}")]
        public async Task<ActionResult<IEnumerable<OcurrenceDTO>>> GetClosingDate(string coin, string startDate, string endDate)
        {
            logger.LogInformation("Running Method OcurrenceController.GetClosingDate");
            var response = await ocurrenceService.GetClosingDate(coin, startDate, endDate);
            return Ok(response);
        }

        [HttpGet("sequential/count/{coin}/{count}/{startDate}/{endDate}")]
        public async Task<ActionResult<IEnumerable<OcurrenceDTO>>> GetSequencialDate(string coin, int count, string startDate, string endDate)
        {
            logger.LogInformation("Running Method OcurrenceController.GetSequencialDate");
            var response = await ocurrenceService.GetSequencialDate(coin, count, startDate, endDate);
            return Ok(response);
        }

    }
}

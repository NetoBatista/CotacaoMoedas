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
    public class CoinController : ControllerBase
    {
        private readonly ILogger<CoinController> _logger;
        private readonly ICoinService _coinService;

        public CoinController(ILogger<CoinController> logger, ICoinService helloWorldService)
        {
            _logger = logger;
            _coinService = helloWorldService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CoinDTO>>> GetAll()
        {
            _logger.LogInformation("Running Method CoinController.GetAll");
            var response = _coinService.GetAll();

            return Ok(response);
        }

        [HttpGet("about")]
        public async Task<ActionResult<IEnumerable<CoinDTO>>> GetAboutCoin([FromQuery] CoinDTO coin)
        {
            _logger.LogInformation("Running Method CoinController.GetAboutCoin");
            var response = _coinService.GetAbout(coin);

            return Ok(response);
        }

        [HttpGet("image/{coinImage}")]
        public async Task<FileStreamResult> GetImage(string coinImage)
        {
            _logger.LogInformation("Running Method CoinController.GetImage");
            var response = _coinService.GetImage(coinImage);
            return File(response, "image/jpg");
        }
    }
}

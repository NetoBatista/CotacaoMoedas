using CotacaoMoeda.Domain.DTO;
using CotacaoMoeda.Domain.Interfaces.Repository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;

namespace CotacaoMoeda.Infra.Repository
{
    public class CoinRepository : BaseRepository, ICoinRepository
    {
        public CoinDTO GetAbout(CoinDTO coin)
        {
            var pathAbout = Environment.GetEnvironmentVariable("PATH_COIN_ABOUT");
            coin.About = File.ReadAllText($"{pathAbout}/{coin.Name.Split("-")[0]}.txt");
            return coin;
        }

        public IEnumerable<CoinDTO> GetAll()
        {
            var coinJson = File.ReadAllText(Environment.GetEnvironmentVariable("PATH_COIN_JSON"));
            var coinList = JsonConvert.DeserializeObject<IEnumerable<CoinDTO>>(coinJson);

            foreach(var coin in coinList)
            {
                coin.Image = $"{Environment.GetEnvironmentVariable("URL_BASE")}/coin/image/{coin.Name.Split("-")[0]}.jpg";
            }

            return coinList;
        }

        public FileStream GetImage(string coinImage)
        {
            var pathCoinFlag = Environment.GetEnvironmentVariable("PATH_COIN_FLAG");
            return File.OpenRead($"{pathCoinFlag}/{coinImage}");
        }
    }
}

using CotacaoMoeda.Domain.DTO;
using CotacaoMoeda.Domain.Interfaces.Repository;
using Pathoschild.Http.Client;
using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Threading.Tasks;

namespace CotacaoMoeda.Infra.Repository
{
    public class AwesomeAPIRepository : BaseRepository, IAwesomeAPIRepository
    {
        private readonly string UrlAwesomeAPI;
        public AwesomeAPIRepository() 
        {
            UrlAwesomeAPI = Environment.GetEnvironmentVariable("AWESOMEAPI_URL");
        }
        public async Task<IEnumerable<OcurrenceDTO>> GetClosingDate(string coin, string closingStartDate, string closingEndDate)
        {
            var response = await new FluentClient().GetAsync($"{UrlAwesomeAPI}/json/daily/{coin}/?start_date={closingStartDate}&end_date={closingEndDate}");
            if (response.Status != System.Net.HttpStatusCode.OK)
            {
                return new List<OcurrenceDTO>();
            }

            return await response.As<IEnumerable<OcurrenceDTO>>();
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetClosingDay(string coin, int closingDays)
        {
            var response = await new FluentClient().GetAsync($"{UrlAwesomeAPI}/json/daily/{coin}/{closingDays}");
            if (response.Status != System.Net.HttpStatusCode.OK)
            {
                return new List<OcurrenceDTO>();
            }

            return await response.As<IEnumerable<OcurrenceDTO>>();
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetOcurrence(string coin)
        {
            var response = await new FluentClient().GetAsync($"{UrlAwesomeAPI}/last/{coin}");
            if (response.Status != System.Net.HttpStatusCode.OK)
            {
                return new List<OcurrenceDTO>();
            }

            var rawJsonObject = await response.AsRawJsonObject();
            return GetOcurrenceDTOList(coin, rawJsonObject);
        }

        private static List<OcurrenceDTO> GetOcurrenceDTOList(string coin, Newtonsoft.Json.Linq.JObject rawJsonObject)
        {
            List<OcurrenceDTO> responseList = new List<OcurrenceDTO>();

            foreach (var _coin in coin.Split(","))
            {
                var jsonCoin = rawJsonObject.GetValue(_coin.Replace("-", "")).ToString();
                responseList.Add(JsonSerializer.Deserialize<OcurrenceDTO>(jsonCoin));
            }

            return responseList;
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetSequencialCount(string coin, int sequentialCount)
        {
            var response = await new FluentClient().GetAsync($"{UrlAwesomeAPI}/{coin}/{sequentialCount}");
            if (response.Status != System.Net.HttpStatusCode.OK)
            {
                return new List<OcurrenceDTO>();
            }

            return await response.As<IEnumerable<OcurrenceDTO>>();
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetSequencialDate(string coin, int sequentialCount, string closingStartDate, string closingEndDate)
        {
            var response = await new FluentClient().GetAsync($"{UrlAwesomeAPI}/{coin}/{sequentialCount}?start_date={closingStartDate}&end_date={closingEndDate}");
            if (response.Status != System.Net.HttpStatusCode.OK)
            {
                return new List<OcurrenceDTO>();
            }

            return await response.As<IEnumerable<OcurrenceDTO>>();
        }
    }
}

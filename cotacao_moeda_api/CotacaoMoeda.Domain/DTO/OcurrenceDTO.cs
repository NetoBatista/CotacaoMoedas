using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace CotacaoMoeda.Domain.DTO
{
    public class OcurrenceDTO
    {
        [JsonPropertyName("code")]
        public string Code { get; set; }

        [JsonPropertyName("codein")]
        public string Codein { get; set; }

        [JsonPropertyName("high")]
        public string High { get; set; }

        [JsonPropertyName("low")]
        public string Low { get; set; }

        [JsonPropertyName("bid")]
        public string Bid { get; set; }

        [JsonPropertyName("ask")]
        public string Ask { get; set; }

        [JsonPropertyName("timestamp")]
        public string TimeStamp { get; set; }

        [JsonPropertyName("varBid")]
        public string VarBid { get; set; }

        [JsonPropertyName("pctChange")]
        public string PctChange { get; set; }
    }
}

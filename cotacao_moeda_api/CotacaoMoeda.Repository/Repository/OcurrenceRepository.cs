using CotacaoMoeda.Domain.DTO;
using CotacaoMoeda.Domain.Interfaces.Repository;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CotacaoMoeda.Infra.Repository
{
    public class OcurrenceRepository : BaseRepository, IOcurrenceRepository
    {
        private readonly IAwesomeAPIRepository awesomeAPIRepository;
        public OcurrenceRepository(IAwesomeAPIRepository awesomeAPIRepository) 
        {
            this.awesomeAPIRepository = awesomeAPIRepository;
        }
        public async Task<IEnumerable<OcurrenceDTO>> GetClosingDate(string coin, string closingStartDate, string closingEndDate)
        {
            return await awesomeAPIRepository.GetClosingDate(coin, closingStartDate, closingEndDate);
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetOcurrence(string coin)
        {
            return await awesomeAPIRepository.GetOcurrence(coin);
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetSequencialDate(string coin, int sequentialCount, string closingStartDate, string closingEndDate)
        {
            return await awesomeAPIRepository.GetSequencialDate(coin, sequentialCount, closingStartDate, closingEndDate);
        }
    }
}

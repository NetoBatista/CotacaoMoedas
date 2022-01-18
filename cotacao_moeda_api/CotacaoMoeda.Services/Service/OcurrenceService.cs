

using CotacaoMoeda.Domain.DTO;
using CotacaoMoeda.Domain.Interfaces.Repository;
using CotacaoMoeda.Domain.Interfaces.Service;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace CotacaoMoeda.Services
{
    public class OcurrenceService : BaseService, IOcurrenceService
    {
        IOcurrenceRepository ocurrenceRepository;

        public OcurrenceService(IOcurrenceRepository ocurrenceRepository) : base()
        {
            this.ocurrenceRepository = ocurrenceRepository;
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetClosingDate(string coin, string closingStartDate, string closingEndDate)
        {
            return await ocurrenceRepository.GetClosingDate(coin, closingStartDate, closingEndDate);
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetOcurrence(string coin)
        {
            return await ocurrenceRepository.GetOcurrence(coin);
        }

        public async Task<IEnumerable<OcurrenceDTO>> GetSequencialDate(string coin, int sequentialCount, string closingStartDate, string closingEndDate)
        {
            return await ocurrenceRepository.GetSequencialDate(coin, sequentialCount, closingStartDate, closingEndDate);
        }
    }
}

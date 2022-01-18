using CotacaoMoeda.Domain.DTO;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace CotacaoMoeda.Domain.Interfaces.Repository
{
    public interface IOcurrenceRepository
    {
        Task<IEnumerable<OcurrenceDTO>> GetOcurrence(string coin);
        Task<IEnumerable<OcurrenceDTO>> GetClosingDate(string coin, string closingStartDate, string closingEndDate);
        Task<IEnumerable<OcurrenceDTO>> GetSequencialDate(string coin, int sequentialCount, string closingStartDate, string closingEndDate);
    }
}

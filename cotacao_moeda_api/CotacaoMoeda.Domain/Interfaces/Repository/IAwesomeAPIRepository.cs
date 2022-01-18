using CotacaoMoeda.Domain.DTO;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace CotacaoMoeda.Domain.Interfaces.Repository
{
    public interface IAwesomeAPIRepository
    {
        Task<IEnumerable<OcurrenceDTO>> GetOcurrence(string coin);
        Task<IEnumerable<OcurrenceDTO>> GetClosingDay(string coin, int closingDays);
        Task<IEnumerable<OcurrenceDTO>> GetClosingDate(string coin, string closingStartDate, string closingEndDate);
        Task<IEnumerable<OcurrenceDTO>> GetSequencialCount(string coin, int sequentialCount);
        Task<IEnumerable<OcurrenceDTO>> GetSequencialDate(string coin, int sequentialCount, string closingStartDate, string closingEndDate);

    }
}

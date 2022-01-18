using CotacaoMoeda.Domain.DTO;
using System.Collections.Generic;
using System.IO;

namespace CotacaoMoeda.Domain.Interfaces.Repository
{
    public interface ICoinRepository
    {
        IEnumerable<CoinDTO> GetAll();
        FileStream GetImage(string coinImage);
        CoinDTO GetAbout(CoinDTO coin);
    }
}

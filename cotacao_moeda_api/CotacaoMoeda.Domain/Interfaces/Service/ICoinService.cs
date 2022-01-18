using CotacaoMoeda.Domain.DTO;
using System.Collections.Generic;
using System.IO;

namespace CotacaoMoeda.Domain.Interfaces.Service
{
    public interface ICoinService
    {
        IEnumerable<CoinDTO> GetAll();
        CoinDTO GetAbout(CoinDTO coin);
        FileStream GetImage(string coinImage);
    }
}

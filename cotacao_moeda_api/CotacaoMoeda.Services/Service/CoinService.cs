

using CotacaoMoeda.Domain.DTO;
using CotacaoMoeda.Domain.Interfaces.Repository;
using CotacaoMoeda.Domain.Interfaces.Service;
using System.Collections.Generic;
using System.IO;

namespace CotacaoMoeda.Services
{
    public class CoinService : BaseService, ICoinService
    {
        ICoinRepository _coinRepository;

        public CoinService(ICoinRepository coinRepository) : base()
        {
            _coinRepository = coinRepository;
        }

        public CoinDTO GetAbout(CoinDTO coin)
        {
            return _coinRepository.GetAbout(coin);
        }

        public IEnumerable<CoinDTO> GetAll()
        {
            return _coinRepository.GetAll();
        }

        public FileStream GetImage(string coinImage)
        {
            return _coinRepository.GetImage(coinImage);
        }
    }
}

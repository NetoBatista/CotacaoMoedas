using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using CotacaoMoeda.Domain.Interfaces.Repository;
using CotacaoMoeda.Domain.Interfaces.Service;
using CotacaoMoeda.Services;
using CotacaoMoeda.Infra.Repository;

namespace CotacaoMoeda.API.Extension
{
    public static class InjectionServicesExtension
    {
       public static void InjectServices(this IServiceCollection services, IConfiguration configuration)
        {
            InjectServices(services);
            InjectRepository(services);
            InjectMappers(services);
            InjectDataBase(services, configuration);
            InjectSwagger(services);
        }

        private static void InjectSwagger(IServiceCollection services)
        {
            SwaggerExtension.ConfigureSwagger(services);
        }

        private static void InjectDataBase(IServiceCollection services, IConfiguration configuration)
        {

        }

        private static void InjectMappers(IServiceCollection services)
        {

        }

        private static void InjectRepository(IServiceCollection services)
        {
            services.AddTransient<ICoinRepository, CoinRepository>();
            services.AddTransient<IOcurrenceRepository, OcurrenceRepository>();
            services.AddTransient<IAwesomeAPIRepository, AwesomeAPIRepository>();
        }

        private static void InjectServices(IServiceCollection services)
        {
            services.AddTransient<ICoinService, CoinService>();
            services.AddTransient<IOcurrenceService, OcurrenceService>();
        }
    }
}

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

#Ajustando localização para pt-br
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=pt_BR.UTF-8
ENV LANG pt_BR.UTF-8 
ENV LC_ALL pt_BR.UTF-8

WORKDIR /app
COPY . ./

ENV PATH_COIN_JSON=External/Coin.json
ENV PATH_COIN_FLAG=External/Flag
ENV PATH_COIN_ABOUT=External/AboutFlags
ENV AWESOMEAPI_URL=https://economia.awesomeapi.com.br
ENV URL_BASE=https://jbsn-apps.ddns.net/cotacao-moeda
ENV ASPNETCORE_URLS=http://+:5000
ENTRYPOINT ["dotnet", "CotacaoMoeda.API.dll"]
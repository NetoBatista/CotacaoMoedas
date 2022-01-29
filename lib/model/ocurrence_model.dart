class OcurrenceModel {
    OcurrenceModel(this.code,this.codein,this.high,this.low,this.bid,this.ask,this.timeStamp,this.pctChange,this.varBid);
    String? code;
    String? codein;
    String high;
    String low;
    String bid;
    String ask;
    String timeStamp;
    String pctChange;
    String varBid;

    Map<String, dynamic> toMap() {
      return {
        'code' : code,
        'codein' : codein,
        'high' : high,
        'low' : low,
        'bid' : bid,
        'ask' : ask,
        'timestamp' : timeStamp,
        'pctChange': pctChange,
        'varBid': varBid
      };
    }

    factory OcurrenceModel.fromJson(Map<String, dynamic> json){
      return OcurrenceModel(json['code'],json['codein'],json['high'],json['low'],json['bid'],json['ask'],json['timestamp'] ?? "", json['varBid'], json['pctChange']);
    }
}
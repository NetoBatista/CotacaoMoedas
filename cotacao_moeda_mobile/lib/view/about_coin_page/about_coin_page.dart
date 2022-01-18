import 'package:cotacao_moeda/components/alert_dialog_component.dart';
import 'package:cotacao_moeda/components/appbar_component.dart';
import 'package:cotacao_moeda/components/button_component.dart';
import 'package:cotacao_moeda/components/center_component.dart';
import 'package:cotacao_moeda/components/column_component.dart';
import 'package:cotacao_moeda/components/container_component.dart';
import 'package:cotacao_moeda/components/dialog_component.dart';
import 'package:cotacao_moeda/components/image_network_component.dart';
import 'package:cotacao_moeda/components/list_view_build_component.dart';
import 'package:cotacao_moeda/components/row_component.dart';
import 'package:cotacao_moeda/components/scaffold_component.dart';
import 'package:cotacao_moeda/components/single_child_scroll_view_component.dart';
import 'package:cotacao_moeda/components/skelton_component.dart';
import 'package:cotacao_moeda/components/text_component.dart';
import 'package:cotacao_moeda/components/visibility_component.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/view/about_coin_page/about_coin_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player/video_player.dart';

class AboutCoinPage extends StatefulWidget {
  CoinModel coinModel;
  AboutCoinPage(this.coinModel, { Key? key }) : super(key: key);

  @override
  _AboutCoinPageState createState() => _AboutCoinPageState();
}

class _AboutCoinPageState extends State<AboutCoinPage> {
  final AboutCoinPageController _aboutCoinPageController = Modular.get<AboutCoinPageController>();
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _aboutCoinPageController.init(widget.coinModel);
    _videoPlayerController = VideoPlayerController.asset("videos/2fd73472-fcff-481e-b647-835adf01ef1d.mp4");
    _videoPlayerController.initialize().then((_) {});
    _videoPlayerController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldComponent(body: buildPage(), customAppBar: AppBarComponent(title: TextComponent(text: widget.coinModel.description )).build());
  }

  Widget buildPage(){
    return SingleChildScrollViewComponent(
      child: ContainerComponent(
        padding: EdgeInsets.all(20),
        child: ColumnComponent(children: [
          CenterComponent(child: ImageNetworkComponent(uri: widget.coinModel.image, heroTag: widget.coinModel.name)),
          ContainerComponent(padding: EdgeInsets.only(top: 10), child: CenterComponent(child: TextComponent(text: widget.coinModel.description, textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))),
          buttonHighlightCurrency(),
          ContainerComponent(padding: EdgeInsets.only(top: 20), child: buildAboutCoin())
    ]),
      ));
  }

  Widget buttonHighlightCurrency(){
    return ValueListenableBuilder<DateTime>(
      valueListenable: _aboutCoinPageController.refreshButtons,
      builder: (BuildContext context, DateTime value, Widget? _widget) {
        return RowComponent(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          VisibilityComponent(isVisible: !_aboutCoinPageController.coinIsFixed(widget.coinModel), 
                              child: ButtonComponent(child: TextComponent(text: "Marcar destaque"), onPressed: () => _aboutCoinPageController.pinCoin(widget.coinModel))),
          VisibilityComponent(isVisible: _aboutCoinPageController.coinIsFixed(widget.coinModel), 
                              child: ButtonComponent(child: TextComponent(text: "Remover destaque"), onPressed: () => _aboutCoinPageController.unPinCoin(), buttonStyle: ElevatedButton.styleFrom(primary: Colors.red))),
          VisibilityComponent(isVisible: _aboutCoinPageController.coinIsFixed(widget.coinModel), 
                              child: ContainerComponent(padding: EdgeInsets.only(left: 10), 
                                                        child: ButtonComponent(child: TextComponent(text: "Criar widget"), onPressed: (){
                                                          _videoPlayerController.play();
                                                          DialogComponent(ContainerComponent(boxDecoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))), 
                                                                          //height: 500, 
                                                                          child: VideoPlayer(_videoPlayerController)), context, "Criar widget");
                                                        }, buttonStyle: ElevatedButton.styleFrom(primary: Colors.blue))))
        ]);
      });
    
  }

  Widget buildAboutCoin(){
    return ValueListenableBuilder<bool>(
      valueListenable: _aboutCoinPageController.getAbout,
      builder: (BuildContext context, bool value, Widget? _widget) {

        if(_aboutCoinPageController.getAbout.value){
          return loadingAbout();
        }

        if(widget.coinModel.about == null){
          return CenterComponent(child: TextComponent(text: "Não foi possível obter os dados da moeda"));
        }

        return TextComponent(text: widget.coinModel.about.toString());
      });
    
  }

  Widget loadingAbout(){
    return ListViewBuilderComponent(count: 15, physics: NeverScrollableScrollPhysics(), itemBuilder: (BuildContext context, int index){
      return ContainerComponent(padding: EdgeInsets.only(top: 10), child: SkeltonComponent(width: MediaQuery.of(context).size.width, height: 30));
    });
  }
}
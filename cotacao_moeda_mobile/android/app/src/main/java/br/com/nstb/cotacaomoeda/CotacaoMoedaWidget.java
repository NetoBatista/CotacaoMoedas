package br.com.nstb.cotacaomoeda;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;

public class CotacaoMoedaWidget  extends AppWidgetProvider  {
    Ocurrence ocurrence;

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        ocurrence = new Ocurrence(context, appWidgetManager, appWidgetIds);

    }

}



package br.com.nstb.cotacaomoeda;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.view.View;
import android.widget.RemoteViews;

import com.android.volley.toolbox.JsonRequest;
import com.squareup.picasso.Picasso;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;
import java.io.File;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import android.graphics.Bitmap;
import java.io.InputStream;
import android.widget.ImageView;
import android.graphics.BitmapFactory;
import android.content.res.AssetManager;
import java.io.FileInputStream;
import android.content.res.AssetFileDescriptor;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.loader.FlutterLoader;
import android.preference.PreferenceManager;
import android.content.SharedPreferences;


public class Ocurrence extends FlutterActivity {
    Context context;
    AppWidgetManager appWidgetManager;
    int[] appWidgetIds;

    Ocurrence(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds){
        this.context = context;
        this.appWidgetManager = appWidgetManager;
        this.appWidgetIds = appWidgetIds;

        UpdateWidget();
    }

    void UpdateWidget(){
        for (int appWidgetId : appWidgetIds) {
            updateAppWidget(appWidgetId);
        }
    }

    private void updateAppWidget(int appWidgetId) {

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.moeda_widget);
        appWidgetManager.updateAppWidget(appWidgetId, views);

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // Construct an Intent object includes web adresss.
        Intent intent = new Intent(context, MainActivity.class);

        // In widget we are not allowing to use intents as usually. We have to use PendingIntent instead of 'startActivity'
        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, intent, 0);

        // Here the basic operations the remote view can do.
        views.setOnClickPendingIntent(R.id.brTo, pendingIntent);
        views.setOnClickPendingIntent(R.id.brFrom, pendingIntent);

        String coinPinned = getCoinPinned();
        if(coinPinned == null || coinPinned == ""){
            appWidgetManager.updateAppWidget(appWidgetId, views);
            appWidgetManager.updateAppWidget(appWidgetId, views);
            return;
        }

        try{
            getImagesBrazil(appWidgetId,views);
            getImagesCoinPinned(coinPinned, appWidgetId, views);
        }
        catch(Exception ex){
        }

        new Thread(() -> {
            try  {
                Thread.sleep(1000);
                getOcurrence(appWidgetId, views);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

    }

    private String getCoinPinned(){
        SharedPreferences prefs = context.getSharedPreferences("FlutterSharedPreferences",MODE_PRIVATE);
        
        return prefs.getString("flutter.COIN_FIXED", "");
    }

    private void getOcurrence(int appWidgetId, RemoteViews views) throws IOException, JSONException {
        String coin = getCoinPinned();

        URL url = new URL("https://economia.awesomeapi.com.br/last/" + coin );
        HttpURLConnection con = (HttpURLConnection) url.openConnection();

        con.setConnectTimeout(60 * 1000);

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));

        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line + "\n");
        }

        reader.close();
        con.disconnect();

        JSONObject jsonObject = new JSONObject(sb.toString());
        String _coin = coin.replace("-","");
        JSONObject coinObject = jsonObject.getJSONObject(_coin);

        
        runOnUiThread(() -> {
            try {
                String bidValue = coinObject.getString("bid");
                updateValues(Double.parseDouble(bidValue), views);
                appWidgetManager.updateAppWidget(appWidgetId, views);
            }catch(Exception ex){

            }
        });

    }

    private void updateValues(Double valueOcurrence, RemoteViews views){
        DecimalFormat decimalFormat = new DecimalFormat("0.00");
        views.setTextViewText(R.id.valueBrazilToCoin, "R$ " + decimalFormat.format(valueOcurrence));

        double valueCoinToBrazil = (1.0 / valueOcurrence);
        views.setTextViewText(R.id.valueCoinToBrazil, "$ " + decimalFormat.format(valueCoinToBrazil));
    }

    private void getImagesBrazil(int appWidgetId, RemoteViews views) throws IOException {
        FlutterLoader loader = FlutterInjector.instance().flutterLoader();

        String image = loader.getLookupKeyForAsset("assets/flag/BRL.jpg");

        AssetManager assetManager = context.getAssets();

        AssetFileDescriptor fd = assetManager.openFd(image);

        FileInputStream is = fd.createInputStream();

        Bitmap bitmap = BitmapFactory.decodeStream(is);

        views.setImageViewBitmap(R.id.imageBrazil,bitmap);

        views.setImageViewBitmap(R.id.imageBrazil2,bitmap);
    }

    private void getImagesCoinPinned(String coinPinned, int appWidgetId, RemoteViews views) throws IOException {
        FlutterLoader loader = FlutterInjector.instance().flutterLoader();

        String image = loader.getLookupKeyForAsset("assets/flag/" + coinPinned.split("-")[0] + ".jpg");

        AssetManager assetManager = context.getAssets();

        AssetFileDescriptor fd = assetManager.openFd(image);

        FileInputStream is = fd.createInputStream();

        Bitmap bitmap = BitmapFactory.decodeStream(is);

        views.setImageViewBitmap(R.id.imageCoinPinned,bitmap);

        views.setImageViewBitmap(R.id.imageCoinPinned2,bitmap);

    }

}

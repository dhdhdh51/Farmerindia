package com.kisanledger;

import android.app.Application;
import androidx.work.PeriodicWorkRequest;
import androidx.work.WorkManager;
import com.kisanledger.notifications.ReminderWorker;
import java.util.concurrent.TimeUnit;

public class KisanLedgerApp extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        PeriodicWorkRequest request = new PeriodicWorkRequest.Builder(ReminderWorker.class, 24, TimeUnit.HOURS).build();
        WorkManager.getInstance(this).enqueue(request);
    }
}

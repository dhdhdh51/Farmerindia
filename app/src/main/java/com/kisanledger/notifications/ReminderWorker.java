package com.kisanledger.notifications;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.kisanledger.R;

public class ReminderWorker extends Worker {
    public ReminderWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) { super(context, workerParams); }

    @NonNull
    @Override
    public Result doWork() {
        NotificationManager nm = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
        nm.createNotificationChannel(new NotificationChannel("kisan_reminders","Kisan Reminders",NotificationManager.IMPORTANCE_DEFAULT));
        nm.notify((int) System.currentTimeMillis(), new NotificationCompat.Builder(getApplicationContext(), "kisan_reminders")
                .setSmallIcon(android.R.drawable.ic_popup_reminder)
                .setContentTitle("Kisan Ledger Reminder")
                .setContentText("Check upcoming fertilizer or watering task")
                .build());
        return Result.success();
    }
}

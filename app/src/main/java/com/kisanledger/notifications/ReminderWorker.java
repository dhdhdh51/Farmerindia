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
    public ReminderWorker(@NonNull Context context, @NonNull WorkerParameters params) { super(context, params); }

    @NonNull @Override
    public Result doWork() {
        NotificationManager nm = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
        nm.createNotificationChannel(new NotificationChannel("farm", "Farm Alerts", NotificationManager.IMPORTANCE_DEFAULT));
        nm.notify((int)System.currentTimeMillis(), new NotificationCompat.Builder(getApplicationContext(), "farm")
                .setSmallIcon(android.R.drawable.ic_dialog_info)
                .setContentTitle("Kisan Ledger Reminder")
                .setContentText("Today has farming activity reminders")
                .build());
        return Result.success();
    }
}

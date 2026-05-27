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

    @NonNull
    @Override
    public Result doWork() {
        String channelId = "kisan_reminders";
        NotificationManager nm = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            nm.createNotificationChannel(new NotificationChannel(channelId, "Kisan Reminders", NotificationManager.IMPORTANCE_DEFAULT));
        }
        NotificationCompat.Builder b = new NotificationCompat.Builder(getApplicationContext(), channelId)
                .setSmallIcon(android.R.drawable.ic_popup_reminder)
                .setContentTitle(getApplicationContext().getString(R.string.app_name))
                .setContentText("Check fertilizer and watering tasks for today.")
                .setPriority(NotificationCompat.PRIORITY_DEFAULT);
        nm.notify(11, b.build());
        return Result.success();
    }
}

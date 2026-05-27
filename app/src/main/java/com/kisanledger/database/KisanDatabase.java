package com.kisanledger.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import com.kisanledger.models.Expense;
import com.kisanledger.models.Field;
import com.kisanledger.models.ReminderItem;

@Database(entities = {Field.class, Expense.class, ReminderItem.class}, version = 1)
public abstract class KisanDatabase extends RoomDatabase {
    private static volatile KisanDatabase INSTANCE;

    public abstract KisanDao dao();

    public static KisanDatabase getInstance(Context context) {
        if (INSTANCE == null) {
            synchronized (KisanDatabase.class) {
                if (INSTANCE == null) {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), KisanDatabase.class, "kisan_ledger.db").build();
                }
            }
        }
        return INSTANCE;
    }
}

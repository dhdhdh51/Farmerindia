package com.kisanledger.database;

import android.content.Context;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import com.kisanledger.models.ExpenseRecord;
import com.kisanledger.models.FieldRecord;

@Database(entities = {FieldRecord.class, ExpenseRecord.class}, version = 1)
public abstract class KisanDatabase extends RoomDatabase {
    private static volatile KisanDatabase INSTANCE;

    public abstract KisanDao kisanDao();

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

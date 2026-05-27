package com.kisanledger.database;

import android.content.Context;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import com.kisanledger.models.*;

@Database(entities = {Field.class, Expense.class, FertilizerLog.class, WateringLog.class, DiaryEntry.class}, version = 1)
public abstract class AppDatabase extends RoomDatabase {
    private static AppDatabase instance;
    public abstract FieldDao fieldDao();
    public abstract ExpenseDao expenseDao();

    public static synchronized AppDatabase get(Context context) {
        if (instance == null) {
            instance = Room.databaseBuilder(context.getApplicationContext(), AppDatabase.class, "kisan_ledger.db")
                    .allowMainThreadQueries().build();
        }
        return instance;
    }
}

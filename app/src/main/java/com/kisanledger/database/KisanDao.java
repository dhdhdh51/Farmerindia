package com.kisanledger.database;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import com.kisanledger.models.Expense;
import com.kisanledger.models.Field;
import com.kisanledger.models.ReminderItem;

import java.util.List;

@Dao
public interface KisanDao {
    @Insert void insertField(Field field);
    @Insert void insertExpense(Expense expense);
    @Insert void insertReminder(ReminderItem item);

    @Query("SELECT * FROM fields ORDER BY id DESC")
    LiveData<List<Field>> getAllFields();

    @Query("SELECT * FROM expenses ORDER BY dateMillis DESC")
    LiveData<List<Expense>> getAllExpenses();

    @Query("SELECT * FROM reminders WHERE targetDateMillis >= :now ORDER BY targetDateMillis ASC")
    LiveData<List<ReminderItem>> getUpcoming(long now);
}

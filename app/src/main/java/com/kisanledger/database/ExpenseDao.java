package com.kisanledger.database;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import com.kisanledger.models.Expense;
import java.util.List;

@Dao
public interface ExpenseDao {
    @Insert long insert(Expense expense);
    @Query("SELECT * FROM Expense ORDER BY date DESC") List<Expense> all();
    @Query("SELECT IFNULL(SUM(amount),0) FROM Expense") double sumAll();
}

package com.kisanledger.database;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import com.kisanledger.models.ExpenseRecord;
import com.kisanledger.models.FieldRecord;
import java.util.List;

@Dao
public interface KisanDao {
    @Insert
    void insertField(FieldRecord field);

    @Insert
    void insertExpense(ExpenseRecord expense);

    @Query("SELECT * FROM FieldRecord ORDER BY id DESC")
    LiveData<List<FieldRecord>> getFields();

    @Query("SELECT * FROM ExpenseRecord ORDER BY date DESC")
    LiveData<List<ExpenseRecord>> getExpenses();
}

package com.kisanledger.database;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import com.kisanledger.models.ExpenseEntity;
import com.kisanledger.models.FieldEntity;

import java.util.List;

@Dao
public interface KisanDao {
    @Insert
    void insertField(FieldEntity field);

    @Insert
    void insertExpense(ExpenseEntity expense);

    @Query("SELECT * FROM fields ORDER BY id DESC")
    LiveData<List<FieldEntity>> getAllFields();

    @Query("SELECT * FROM expenses ORDER BY dateMillis DESC")
    LiveData<List<ExpenseEntity>> getAllExpenses();

    @Query("SELECT IFNULL(SUM(amount),0) FROM expenses")
    LiveData<Double> getTotalExpense();
}

package com.kisanledger.database;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import com.kisanledger.models.Field;
import java.util.List;

@Dao
public interface FieldDao {
    @Insert long insert(Field field);
    @Query("SELECT * FROM Field ORDER BY id DESC") List<Field> all();
    @Query("SELECT COUNT(*) FROM Field") int count();
}

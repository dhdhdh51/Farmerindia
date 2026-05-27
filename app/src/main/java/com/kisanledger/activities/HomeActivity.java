package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import com.kisanledger.R;

public class HomeActivity extends BaseActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);


        int[] ids = {R.id.card_fields,R.id.card_expenses,R.id.card_fertilizer,R.id.card_watering,R.id.card_reports,R.id.card_diary,R.id.card_settings,R.id.card_backup};
        Class<?>[] targets = {FieldListActivity.class,ExpenseActivity.class,FertilizerActivity.class,WateringActivity.class,ReportsActivity.class,DiaryActivity.class,SettingsActivity.class,BackupRestoreActivity.class};
        for (int i=0;i<ids.length;i++) {
            int idx=i;
            findViewById(ids[i]).setOnClickListener(v -> startActivity(new Intent(this, targets[idx])));
        }
    }
}

package com.kisanledger.activities;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.kisanledger.R;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        BottomNavigationView nav = findViewById(R.id.bottomNav);
        nav.setOnItemSelectedListener(item -> {
            Fragment target;
            int id = item.getItemId();
            if (id == R.id.nav_fields) target = SimpleSectionFragment.newInstance("Field Records");
            else if (id == R.id.nav_expense) target = SimpleSectionFragment.newInstance("Expense Tracker");
            else if (id == R.id.nav_schedule) target = SimpleSectionFragment.newInstance("Schedules");
            else if (id == R.id.nav_reports) target = SimpleSectionFragment.newInstance("Reports & Backup");
            else target = DashboardFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, target).commit();
            return true;
        });

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, DashboardFragment.newInstance()).commit();
        }
    }
}

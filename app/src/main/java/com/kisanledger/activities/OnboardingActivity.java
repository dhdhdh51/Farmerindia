package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import com.kisanledger.R;

public class OnboardingActivity extends BaseActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_onboarding);

        findViewById(R.id.btn_continue).setOnClickListener(v -> {
            startActivity(new Intent(this, HomeActivity.class));
            finish();
        });

    }
}

package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import com.kisanledger.R;

public class SplashActivity extends BaseActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        new Handler().postDelayed(() -> {
            startActivity(new Intent(this, OnboardingActivity.class));
            finish();
        }, 1200);


    }
}

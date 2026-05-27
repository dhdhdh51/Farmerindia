package com.kisanledger.utils;

import android.content.Context;
import android.content.SharedPreferences;

public class PrefsManager {
    private static final String PREF = "kisan_ledger_pref";

    public static boolean isOnboardingDone(Context c) {
        return c.getSharedPreferences(PREF, Context.MODE_PRIVATE).getBoolean("onboarding", false);
    }
    public static void setOnboardingDone(Context c, boolean v) {
        c.getSharedPreferences(PREF, Context.MODE_PRIVATE).edit().putBoolean("onboarding", v).apply();
    }
    public static boolean isDarkMode(Context c) {
        return c.getSharedPreferences(PREF, Context.MODE_PRIVATE).getBoolean("dark", false);
    }
}

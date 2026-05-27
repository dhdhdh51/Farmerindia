package com.kisanledger.utils;

import android.content.Context;
import com.google.gson.Gson;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

public class BackupUtils {
    public static File exportEmptyTemplate(Context context) throws IOException {
        File file = new File(context.getExternalFilesDir(null), "kisan_ledger_backup.json");
        FileWriter writer = new FileWriter(file);
        writer.write(new Gson().toJson(new HashMap<>()));
        writer.close();
        return file;
    }
}

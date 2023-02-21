package com.hankfrinkle.flutter_infonline_library_example

import android.os.Bundle
import de.infonline.lib.IOLSession
import de.infonline.lib.IOLSessionPrivacySetting
import de.infonline.lib.IOLSessionType
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        /*IOLSession.init(context)
        IOLSession.getSessionForType(IOLSessionType.SZM)
            .initIOLSession(
                "offerIdentifier",
                true,
                IOLSessionPrivacySetting.ACK
            )*/
    }
}

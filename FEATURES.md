# JARVIS AI V3 — Feature status

This is the updated source package. It has not been compiled or tested on a physical device in this environment. Treat all features as requiring device testing.

## Implemented in source (untested)
| Area | Details |
|---|---|
| AI chat | HTTPS proxy call; last 30 messages; bounded request/response handling; retry for transient network, throttling, and server failures |
| AI proxy | Cloudflare Worker validates requests, limits message count/size, handles OPTIONS, uses configurable model, times out upstream calls, retries transient failures, and returns sanitized errors |
| Voice | Tap-to-listen SpeechRecognizer; TextToSpeech; language/script-aware speech output; stop speaking |
| UI | Existing Compose interface, chat, waveform, settings, notes/tasks, dark theme, splash, adaptive icon |
| Background controls | Foreground-service notification with Listen / Stop; mic only starts after explicit Listen action |
| WhatsApp / SMS | Read-back and confirmation required; opens the chat/composer only; never auto-sends |
| Calls | Opens dialer; user confirms call |
| Alarms / timers | Uses Android Clock intents; user checks/starts them in Clock |
| Scheduled reminders | One-shot reminders such as “remind me to stretch in 10 minutes”; saved in Room, scheduled via AlarmManager, notified when due, pending alarms restored after reboot |
| Notes / tasks | Stored on-device in Room |
| Weather / device commands | Existing V2 behavior retained |

## Platform and product limitations
- Android may defer non-exact reminder alarms during Doze or battery-saving modes. Exact-to-the-second delivery is not promised.
- Reminder notifications require notification permission on Android 13+.
- No always-on wake word or hidden/continuous microphone recording.
- WhatsApp / SMS are not automatically sent; user taps Send in the destination app.
- Calls are not automatically placed.
- Android restricts direct changes to some system settings; JARVIS opens settings pages instead.
- Locked-screen/background app launches remain subject to Android restrictions.
- A public privacy policy, release signing, Play Console declarations, and device testing are still the owner's responsibility.

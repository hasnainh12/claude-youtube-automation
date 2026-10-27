# Google Cloud setup — aapko yeh khud karna hai

Connector code ready hai. Google Cloud ki yeh cheezein sirf aap kar sakte hain,
kyunki wahan aapka account/project hai. Har step ke baad "kya verify karna hai"
bhi likha hai.

## 0. Purana project vs naya project

Semantics: agar aapka purana project (`1086464908506`) kisi shared/unknown
project ka tha jahan quota khatam ho gaya tha, to **naya apna project** banayein.
Ek channel ke liye ek project bilkul kaafi hai.

## 1. Naya project

1. <https://console.cloud.google.com/projectcreate>
2. Name: `lets-discover-connector` (kuch bhi) → **Create**
3. Upar project selector se naya project select karein.
4. **Project ID / number note kar lein** (error messages mein yahi aata hai).

## 2. Teen APIs enable karein

**APIs & Services → Library** mein ja kar, ek ek karke:

| API | Service name | Kahan use hoti hai |
|---|---|---|
| YouTube Data API v3 | `youtube.googleapis.com` | videos, playlists, comments, captions, search |
| YouTube Analytics API | `youtubeanalytics.googleapis.com` | `get_youtube_analytics`, `analytics_*` |
| YouTube Reporting API | `youtubereporting.googleapis.com` | `reach_report_ctr` (impressions + CTR) |

Har API par **Enable** dabayein. Teen minute lagte hain; enable hone ke baad
1–2 minute propagate hota hai.

**Verify:** Library mein search karein — "Manage" dikhe to enabled hai.
Ya error aaye to error ke project number se match karein ke sahi project hai.

> Compliance audit: sirf high quota (bade scale) ke liye chahiye. Single channel
> ke liye default quota kaafi hai; audit request **nahi** karni.

## 3. OAuth consent screen

1. **APIs & Services → OAuth consent screen**
2. User type: **External** → Create
3. App name (jaise `YouTube Connector`), support email, developer email
4. **Scopes → Add or remove scopes** — paanch scopes add karein:
   - `https://www.googleapis.com/auth/youtube`
   - `https://www.googleapis.com/auth/youtube.upload`
   - `https://www.googleapis.com/auth/youtube.force-ssl`
   - `https://www.googleapis.com/auth/youtube.readonly`
   - `https://www.googleapis.com/auth/yt-analytics.readonly`
5. **Test users** mein apna Gmail (channel wala account) add karein
6. **Publish app** dabayein (Testing mode mein refresh token 7 din mein expire
   ho jata hai). Personal use ke liye verification ki zaroorat nahi.

**Verify:** Publishing status = "In production".

## 4. OAuth client

1. **Credentials → Create credentials → OAuth client ID**
2. Application type: **Web application**
3. **Authorized redirect URIs** — bilkul yeh:
   ```
   http://127.0.0.1:51779/callback
   ```
   (Port badalna ho to `YT_MCP_PORT` bhi badlein aur URI bhi match kare.)
4. Create → **Client ID** aur **Client secret** copy karein.

## 5. Secret connector mein daalein

`G:\youtube connector\client-secrets.json`:

```json
{
  "clientId": "....apps.googleusercontent.com",
  "clientSecret": "...."
}
```

(Ya Claude config / env mein `GOOGLE_CLIENT_ID` / `GOOGLE_CLIENT_SECRET`.)
Client secret kabhi chat, git ya screenshot mein na daalein.

## 6. Re-consent (naye scopes ke liye zaroori)

Purane token mein `youtube.upload` scope nahi hai. Is liye:

1. `C:\Users\<aap>\.youtube-mcp\token.json` **delete** karein
2. `setup.bat` dobara chalayein (build + config)
3. Claude Desktop **Quit → restart**
4. Chat mein: "Mere YouTube channel ki details batao" → browser → **Allow**

**Verify:** `get_quota_estimate` chala kar dekhein ke connector jawab de raha
hai; phir `list_my_videos` (1 unit). Analytics ke liye
`get_youtube_analytics` last 28 days.

## 7. Pehli baar Reporting API (reach_report_ctr)

1. Pehli call `jobs.create` karti hai (connector khud karta hai).
2. Pehla report **~24–48 ghante** mein aata hai, usme pichhle 30 din ka data
   hota hai.
3. Us se pehle tool saaf message deta hai: "Report abhi ready nahi hai ... kal
   dobara call karein." Yeh error nahi, expected behaviour hai.

## 8. Quota badhana (optional)

Default 10,000 units/day + 100 search + 100 upload calls rozana. Is channel ke
liye kaafi hai. Zaroorat pare to Console → **IAM & Admin → Quotas** se
`YouTube Data API v3` ki quota request karein (Google audit karta hai, days
lagte hain).

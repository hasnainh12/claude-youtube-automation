# 🎥 YouTube MCP Connector for Claude Desktop (100% FREE)

Stop paying for premium YouTube connectors! This is a free, open-source Model Context Protocol (MCP) server that turns Claude into your personal **YouTube Channel Manager, Content Creator, and Strategist**. 

With this connector, Claude doesn't just manage your channel; it helps you create and grow it. From finding trending ideas to generating thumbnails, creating videos, and uploading them directly — all locally on your machine.

## 🚀 What Claude Can Do With This Connector (The Ultimate Workflow)

When you connect this tool to Claude, you unlock a complete YouTube automation workflow:

- **🎬 Video & Thumbnail Generation:** Claude doesn't just upload; it creates! It can generate custom thumbnails using its AI, write the script, prepare the video assets, and then use this connector to upload everything directly to your channel.
- **📈 Trend Research & Ideas:** Ask Claude to search YouTube for current trends in your niche. It will analyze what's working and suggest the perfect idea for your next video.
- **📤 One-Click Uploads:** Give Claude the path to your generated video and thumbnail, and it will upload them to YouTube with the exact title, description, tags, and privacy settings you want.
- **📊 Deep Analytics & Strategy:** Ask Claude to fetch your channel's analytics. It will analyze your top-performing videos, viewer demographics, and CTR, then tell you exactly what to do differently next time.
- **📂 Playlist & Comment Management:** Tell Claude to create new playlists, organize your videos, or reply to comments automatically.

---

## 🚀 Step-by-Step Installation Guide (No Coding Experience Needed)

### Step 1: Download & Extract the Connector
1. Click the green **"Code"** button at the top of this GitHub page and select **"Download ZIP"**.
2. Go to your Downloads folder. Right-click the downloaded ZIP file and select **"Extract All..."**.
3. Extract it to a simple location, like `C:\youtube-connector`. (Do not put it in a deep folder).

### Step 2: Install Node.js (Required to run the tool)
1. Go to [nodejs.org](https://nodejs.org/) and download the **LTS** version.
2. Run the installer and keep clicking "Next" until it's installed.
3. To check if it worked, press `Win + R`, type `cmd`, and press Enter. In the black window, type `node -v` and press Enter. You should see a version number (e.g., v20.11.0).

### Step 3: Go to Google Cloud Console & Create a Project
**This is 100% free and requires no credit card.**
1. Go to the [Google Cloud Console](https://console.cloud.google.com/) and sign in with your YouTube account.
2. At the top left, click the project dropdown and click **"New Project"**.
3. Name it (e.g., "YouTube Connector") and click **Create**. Make sure it is selected in the top dropdown.

### Step 4: Enable the 3 Required APIs
1. In the top search bar, search **"YouTube Data API v3"**. Click it and click **Enable**.
2. Search **"YouTube Analytics API"**. Click it and click **Enable**.
3. Search **"YouTube Reporting API"**. Click it and click **Enable**.

### Step 5: Configure OAuth Consent Screen
1. On the left sidebar, click **"APIs & Services"** > **"OAuth consent screen"**.
2. Select **"External"** and click **Create**.
3. Fill in the App name, User support email, and Developer email. Click **Save and Continue**.
4. On the "Scopes" screen, just click **Save and Continue**.
5. On the "Test Users" screen, click **"+ ADD USERS"**. Type your own Gmail address and click **Save and Continue**.

### Step 6: Get Your API Keys (Client ID & Secret)
1. On the left sidebar, click **"APIs & Services"** > **"Credentials"**.
2. Click **"+ CREATE CREDENTIALS"** and select **"OAuth client ID"**.
3. Application type: Select **"Web application"**.
4. Name: Type "Claude Connector".
5. Scroll down to **"Authorized redirect URIs"**, click **"+ ADD URI"**, and paste exactly: `http://127.0.0.1:51779/callback`
6. Click **Create**. A window will pop up with your **Client ID** and **Client Secret**. **Copy these two codes and save them in Notepad.** (You will need them in the next step).

### Step 7: Setup the Connector Files on Your PC

**7.1 Add your Keys:**
1. Open the folder you extracted in Step 1 (`C:\youtube-connector`).
2. Find the file `client-secrets.example.json`. Right-click it and select **Rename**. Change the name to `client-secrets.json`.
3. Right-click `client-secrets.json` and select **Open with > Notepad**.
4. Replace `"YOUR_GOOGLE_CLIENT_ID_HERE"` with the Client ID you copied in Step 6.
5. Replace `"YOUR_GOOGLE_CLIENT_SECRET_HERE"` with the Client Secret. Save the file and close Notepad.

**7.2 Open PowerShell (The Easy Way):**
1. Stay inside the `C:\youtube-connector` folder.
2. Click once on the **address bar** at the top (where it says C:\youtube-connector).
3. Type the word `powershell` and press Enter. A blue command window will open.

**7.3 Run the Setup Commands (Step-by-Step):**
*Note: To paste a command into PowerShell, just Right-Click anywhere inside the blue window.*

**Command 1: Fix Windows Security Error**
Copy the command below, Right-Click in PowerShell to paste, and press Enter:
```bash
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
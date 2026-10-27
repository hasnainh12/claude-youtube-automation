import { ensureAccessToken } from './dist/oauth.js';

console.log("Login process shuru ho raha hai...");
ensureAccessToken()
  .then(() => {
    console.log("✅ Success! YouTube connected. Ab aap Claude mein ja sakte hain.");
    process.exit(0);
  })
  .catch((e) => {
    console.error("❌ Error:", e.message);
    process.exit(1);
  });

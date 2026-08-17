# Sole Hub - Roblox Dark UI Library

Roblox Dark UI library with **server-side protection** using Vercel. Script sadece Roblox'tan çalışır, browser'dan açılınca kod görünmez.

## 🚀 Quick Start

### 1. Deploy to Vercel
```bash
# Repoyu fork et veya clone et
# Vercel'e git https://vercel.com connect et
```

### 2. Load Script in Roblox
```lua
loadstring(httpget("https://YOUR-PROJECT.vercel.app/api/script"))()
```

`YOUR-PROJECT` yerine senin Vercel project adını koy.

## 🔒 Güvenlik Özellikleri

- ✅ **Browser'dan açılınca kod görünmez** (403 döndürülür)
- ✅ **Sadece Roblox HttpGet tarafından çalışır**
- ✅ **User ID whitelist** (`loader.lua`'da düzenle)
- ✅ **Server-side kontrol** (Vercel API)

## 📁 Dosyalar

- `api/script.js` - Vercel API endpoint (script döndürür)
- `loader.lua` - Roblox loader script (whitelist ile)
- `src/` - DarkUI library
- `vercel.json` - Vercel konfigürasyonu

## ⚙️ Whitelist Kurulumu

`loader.lua`'da User ID'leri ekle:

```lua
local whitelist = {
    123456789, -- Senin ID'n
    987654321, -- Arkadaş ID'si
}
```

## 📋 Vercel Deployment

1. **Vercel'e giriş yap:** https://vercel.com
2. **"New Project" → GitHub repo seç**
3. **Deploy et**
4. **URL'yi kopyala:** `https://YOUR-PROJECT.vercel.app`
5. **Roblox'ta kullan:**
   ```lua
   loadstring(httpget("https://YOUR-PROJECT.vercel.app/api/script"))()
   ```

## ✨ Test Etme

Terminal'de:
```bash
# Local test
node api/script.js

# Browser'da açarsanız 403 döndürecek
curl https://YOUR-PROJECT.vercel.app/api/script
# > Access denied

# Roblox'ta açarsanız script döndürecek
loadstring(httpget("https://YOUR-PROJECT.vercel.app/api/script"))()
# > ✅ Script loaded
```

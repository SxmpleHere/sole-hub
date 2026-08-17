# Sole Hub - Roblox Dark UI Library

Roblox Dark UI library with **server-side protection** using Vercel. Script sadece Roblox'tan çalışır, browser'dan açılınca kod görünmez.

## 🚀 Quick Start

```lua
loadstring(httpget("https://sole-hub.vercel.app/api/script"))()
```

**Bütün Roblox kullanıcıları** bu kodu kullanabilir! ✅

## 🔒 Güvenlik Özellikleri

- ✅ **Browser'dan açılınca kod görünmez** (public değil)
- ✅ **Sadece Roblox HttpGet**'ten çalışır
- ✅ **Server-side korunması** (Vercel API)
- ✅ **Public erişim** (tüm kullanıcılara açık)

## 📁 Dosyalar

- `api/script.js` - Vercel API endpoint (script döndürür)
- `loader.lua` - Roblox loader script
- `src/` - DarkUI library
- `vercel.json` - Vercel konfigürasyonu

## ✨ Test Etme

```bash
# Browser'da açarsanız kod görmezsiniz
curl https://sole-hub.vercel.app/api/script
# > Hiçbir şey döndürmez (sadece Roblox'a açık)

# Roblox'ta açarsanız script çalışır
loadstring(httpget("https://sole-hub.vercel.app/api/script"))()
# > ✅ Script loaded
```

| | Browser | Roblox |
|---|---|---|
| **Erişim** | ❌ Yok | ✅ Var |
| **Kod görünür mü?** | ❌ Hayır | ✅ Evet |
| **Çalışır mı?** | ❌ Hayır | ✅ Evet |

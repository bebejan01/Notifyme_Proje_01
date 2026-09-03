# NotifyMe

> **Durum: V0 — erken prototip.**
> "Şu an çalışan" bölümündeki özellikler çalışır, **ancak veri kalıcı değildir**: uygulama
> kapandığında her şey sıfırlanır (bellek-içi mock veri). Giriş ekranı yalnızca görseldir —
> **gerçek kimlik doğrulama yoktur**. Kalıcılık, bildirimler, kronometre ve adaptif planlama
> henüz uygulanmadı; bkz. **Yol Haritası**.

## Ne bu uygulama? (vizyon)

NotifyMe sıradan bir "görev ekle → hatırlat → tamamlandı işaretle" uygulaması olmayı
hedeflemiyor. Temel fikir bir döngü:

```
PLAN → UYGULAMA → ÖLÇÜM → ANALİZ → YENİ PLAN → (tekrar ölçüm)
```

Kullanıcı hedef ve görevlerini oluşturur; NotifyMe planlanan davranışı bilir, gerçek davranışı
ölçer, ikisini karşılaştırır ve zamanla bir **performans profili** çıkarır. İlerleyen aşamada
adaptif planlama motoru (önce kural tabanlı, sonra AI) bu profile göre gelecek planları
uyarlar. AI bir süs / sohbet özelliği değil; kullanıcı davranışından üretilen gerçek veriye
dayalı planlama yardımcısıdır.

## Şu an çalışan (V0)

- **3 sekmeli arayüz:** Ana Sayfa · Bildirimler · Profil (+ giriş/kayıt ekranı)
- **Görev yönetimi (bellek-içi):** ekleme (başlık, açıklama, tarih, saat, öncelik),
  tamamlandı işaretleme, silme
- **Öncelik seviyeleri:** Düşük / Orta / Yüksek (renk kodlu)
- **Bildirimler sekmesi:** bugüne ait görevlerin listesi + günlük ilerleme göstergesi
  (tamamlanan / toplam)
- **Profil:** toplam ve tamamlanan görev sayacı, tamamlanan görev geçmişi, çıkış
- `intl` ile tarih/saat biçimlendirme

### Şu an çalışmayan / sahte olan

| Alan | Durum |
| --- | --- |
| Veri kalıcılığı | Yok — `lib/services/task_service.dart` bellek-içi, 3 örnek görevle başlar, kapanışta sıfırlanır |
| Kimlik doğrulama | Yok — giriş/kayıt formları yalnızca alan doğrulaması yapar, arkasında sistem yoktur |
| Çıkış | Yalnızca giriş ekranına dönüş |
| Görev düzenleme | Yok (yalnızca ekle / tamamla / sil) |
| Bildirim / hatırlatma | Yok — "Bildirimler" sekmesi yalnızca bugünün görev listesidir |

## Yol Haritası (henüz YOK — planlanan)

| Faz | Kapsam |
| --- | --- |
| FAZ 0 | Depo temizliği ve güvenlik (bu README dahil) |
| FAZ 1 | Kalıcı yerel veri (SQLite), gerçek CRUD, görev düzenleme |
| FAZ 2 | Yerel bildirimler / zamanlanmış hatırlatma |
| FAZ 3 | Kronometre / çalışma oturumları (StudySession) — pasif süre ölçümü |
| FAZ 4 | Kişisel Performans Profili (tamamlama oranı, planlanan/gerçek süre, erteleme, vb.) |
| FAZ 5 | Adaptif planlama motoru — önce açıklanabilir kural tabanlı, sonra AI/LLM |
| FAZ 6 | Hesap / bulut senkron (opsiyonel; SQLite = kaynak, bulut = yedek/sync) |

> Not: Bu depoda daha önce Supabase, RLS, `tasks` tablosu ve e-posta/şifre kimlik doğrulaması
> anlatan bir README vardı. Bunların **hiçbiri kodda uygulanmamıştı**; ilgili `tasks` şeması
> fikri FAZ 1 / FAZ 6 kapsamında yeniden ele alınacaktır.

## Geliştirme

- Flutter 3.35+ / Dart 3.9+
- `flutter pub get`
- `flutter run`

Backend yok. Tek çalışma bağımlılığı `intl`.

## Mimari (V0)

```
lib/
  main.dart                 uygulama girişi, MaterialApp
  models/task.dart          Task veri modeli
  screens/
    auth_page.dart          görsel giriş/kayıt
    main_screen.dart        alt navigasyon kabuğu
    home_page.dart          görev listesi + ekleme
    notifications_page.dart bugünün görevleri + ilerleme
    profile_page.dart       istatistikler + geçmiş
  services/
    task_service.dart       BELLEK-İÇİ görev deposu (FAZ 1'de SQLite ile değişecek)
```

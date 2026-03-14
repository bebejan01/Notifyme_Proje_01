# Planlama ve Hatırlatma Uygulaması

Flutter ile geliştirilmiş, Supabase veritabanı entegrasyonuna sahip bir görev yönetimi ve hatırlatma uygulaması.

## Özellikler

### Ana Sayfa
- Görev ekleme formu
- Aktif ve yaklaşan görevlerin listesi
- Görev tamamlama işaretleme
- Öncelik seviyeleri (Düşük, Orta, Yüksek)
- Tarih ve saat seçimi

### Bildirimler Sayfası
- Bugüne ait görevlerin listesi
- Günlük ilerleme göstergesi
- Tamamlanan/toplam görev sayacı

### Profil Sayfası
- Kullanıcı bilgileri
- Toplam ve tamamlanan görev istatistikleri
- Geçmiş görevler listesi
- Görev silme özelliği
- Çıkış yapma

## Kurulum

### Gereksinimler
- Flutter SDK (3.0.0 veya üzeri)
- Dart SDK
- Supabase hesabı

### Adımlar

1. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

2. `.env` dosyasını düzenleyin ve Supabase bilgilerinizi ekleyin:
```
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

3. Uygulamayı çalıştırın:
```bash
flutter run
```

## Veritabanı Yapısı

Uygulama, aşağıdaki yapıya sahip `tasks` tablosunu kullanır:

- `id`: UUID (Primary Key)
- `user_id`: UUID (Foreign Key to auth.users)
- `title`: Text (Görev başlığı)
- `description`: Text (Görev açıklaması)
- `due_date`: Timestamp (Bitiş tarihi ve saati)
- `is_completed`: Boolean (Tamamlanma durumu)
- `priority`: Text (Öncelik seviyesi: low, medium, high)
- `created_at`: Timestamp (Oluşturulma tarihi)
- `completed_at`: Timestamp (Tamamlanma tarihi)

## Kullanılan Teknolojiler

- **Flutter**: UI framework
- **Dart**: Programlama dili
- **Supabase**: Backend ve veritabanı
- **intl**: Tarih formatlaması için

## Güvenlik

- Row Level Security (RLS) aktif
- Kullanıcılar sadece kendi görevlerini görebilir ve düzenleyebilir
- Email/şifre ile kimlik doğrulama

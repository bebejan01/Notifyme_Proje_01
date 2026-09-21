# NotifyMe — Tasarım 1 Rakip Araştırması — Aşama 1: Ticari / Gerçek Kullanıcıya Sunulan Ürünler

**Tarih:** 2026-09-20
**Kapsam:** Yalnızca ticari/gerçek kullanıcıya sunulan ürünler. Akademik literatür Aşama 2'nin konusu, buraya girilmedi.
**Amaç:** NotifyMe'nin özgünlüğünü kanıtlamak DEĞİL. Aynı şeyi veya daha gelişmişini yapan ürün var mı, dürüstçe bulmak.

---

## 0. Kanıt seviyesi ve okuma rehberi

Rapor boyunca her iddia şu dört seviyeden biriyle etiketlendi:

- **Var — doğrulandı**: resmi kaynakta (dokümantasyon, help center, resmi blog) açıkça yazıyor.
- **Yok — açıkça doğrulandı**: resmi kaynak özelliğin yokluğunu ima ediyor veya ürünün kapsamı bunu dışlıyor (örn. Todoist'in tüm feature/pricing sayfalarında adaptif yeniden planlama hiç geçmiyor).
- **Kamuya açık kaynaklarda doğrulanamadı**: aradım, resmi/güvenilir kaynak bulamadım. Yokluğunu iddia etmiyorum, sadece kanıt yok.
- **Belirsiz**: kaynaklar birbiriyle çelişiyor veya pazarlama dili teknik gerçeği gizliyor olabilir.

AI/ML/RAG iddialarında özellikle temkinliyim — bir ürün "AI" dediğinde bu çoğu zaman "LLM'e prompt gönderiyoruz" anlamına geliyor, "kullanıcının geçmiş performansını öğrenen model" anlamına gelmiyor. İkisini ayırt etmeye çalıştım.

---

## 1. İncelenen ürünler (11) — özet profiller

### 1.1 Todoist

- **Problem/kitle:** Genel amaçlı görev yönetimi, bireysel + küçük takım. Kitle: "herkes", özellikle capture-first (hızlı not alma) kullanıcılar.
- **Goal→Task ayrımı:** **Yok — açıkça doğrulandı.** Sadece Project→Task→Sub-task hiyerarşisi var (todoist.com/features). "Goal" birinci sınıf bir kavram değil.
- **Günlük/haftalık planlama:** Var — "Today" ve "Upcoming" görünümleri, calendar layout (Pro). Time-blocking Pro'da var (todoist.com/help, "Get started with Todoist Pro").
- **Otomatik schedule/reschedule:** **Yok — açıkça doğrulandı.** Kullanıcı sürükle-bırak ile kendi planlıyor; AI bunu kullanıcı adına otomatik yapmıyor.
- **Planned vs actual:** Kısmen. "Task Durations" (tahmini süre) var (Pro). Gerçekleşen süre alanı **yok**. 2026 Eylül'de eklenen "Project Insights" (Pro'ya genişletildi) proje bazında "what's at risk, how far along you are, finished this week vs last" gösteriyor — bu proje-seviyesinde bir momentum/tamamlanma trendi, görev bazlı planned-vs-actual değil (todoist.com/help "2026 Changelog", 2 Eylül 2026).
- **Performans geçmişi / adaptif işyükü-süre:** **Belirsiz.** Resmi "Todoist Assist" sayfası (todoist.com/todoist-assist) dört özellik listeliyor: Ramble (sesli görev), Task Assist (öneri/parçalama), Email Assist, Filter Assist — **süre tahmini AI'sinden bahsetmiyor**. Buna karşın bağımsız bir inceleme sitesi (aiflowtown.com, 2026-01-16) "Duration Estimates: tracks your actual completion times and suggests realistic durations" diye iddia ediyor. Bu iddia resmi kaynakta doğrulanamadı — üçüncü parti inceleme sitesinin marketing dilini karıştırmış olma ihtimali var. **Sonuç: kamuya açık resmi kaynakta doğrulanamadı.**
- **Yapılandırılmış/serbest metin geri bildirim:** **Yok — açıkça doğrulandı.**
- **AI/ML/LLM:** Var — doğrulandı (Todoist Assist: task/priority öneri, email→task, filtre oluşturma, sesli giriş). Resmi sayfa "we run all of Todoist's AI functionality on our secure infrastructure" diyor, model sağlayıcı adı vermiyor. **RAG kanıtı yok.**
- **NotifyMe'ye en güçlü dersi:** Todoist'in "Project Insights" (momentum/at-risk göstergesi) NotifyMe'nin Goal-trajectory fikrine kavramsal olarak en yakın **mainstream** örnek — ama proje/görev tamamlanma oranı üzerinden, NotifyMe'nin hedeflediği "kalan iş miktarı vs kalan zaman" pace hesaplaması değil.
- **Kaynaklar:** todoist.com/features; todoist.com/todoist-assist; todoist.com/help/articles/set-a-task-duration-L1kYkZv8d; todoist.com/help/articles/2026-changelog-HD3jJAtLd (2026-09-02); todoist.com/help/todoist/billing/... (2026-08-28); aiflowtown.com/todoist-ai-review (2026-01-16, üçüncü parti, düşük güven).

### 1.2 TickTick

- **Problem/kitle:** Genel görev+takvim+alışkanlık, güçlü NLP hızlı giriş, Pomodoro odak.
- **Goal→Task ayrımı:** **Yok — açıkça doğrulandı.** Liste/proje + alışkanlık (habit) ayrı modüller, "Goal" kavramı yok.
- **Planlama:** Günlük/haftalık/aylık takvim görünümleri var (ticktick.com). Time-blocking manuel.
- **Otomatik schedule/reschedule:** **Yok — açıkça doğrulandı.**
- **Planned vs actual / performans geçmişi:** Kısmen — "Statistics: Track tasks, focus duration, and habit logs to get a comprehensive view of your progress" (ticktick.com). Bu tanımlayıcı bir istatistik paneli, **adaptif** bir mekanizma değil (gelecek planı bu verilere göre otomatik değişmiyor).
- **Yapılandırılmış/serbest metin geri bildirim:** **Yok — açıkça doğrulandı.**
- **AI/ML/LLM:** Var, sınırlı — "Voice Capture" (AI tarih/öncelik çıkarımı), "Audio Summary" (toplantı kaydını özetleme). Otomatik zamanlama/adaptasyon için AI kullanılmıyor.
- **NotifyMe'ye ders:** TickTick'in "Automated Workflows" (MCP/CLI ile) ilginç bir genişleme yönü ama NotifyMe'nin vizyonuyla örtüşmüyor.
- **Kaynaklar:** ticktick.com (ana sayfa, erişim 2026-09-20).

### 1.3 Motion

- **Problem/kitle:** Yoğun profesyoneller/ekipler, "AI SuperApp for work" — görev+proje+takvim+toplantı hepsi bir arada, tam otomatik günlük plan.
- **Goal→Task ayrımı:** **Kamuya açık kaynaklarda doğrulanamadı** üst-seviye "Goal" nesnesi olarak; Motion'da "Projects → Tasks" hiyerarşisi var (usemotion.com), Goal-trajectory kavramı ayrı bir varlık olarak görünmüyor.
- **Otomatik schedule/reschedule:** **Var — doğrulandı, en gelişmiş örnek.** "AI Task Manager auto-schedules your days... re-optimizes it hundreds of times a day" (usemotion.com/features/ai-task-manager). Kesinti olduğunda ("Interruptions breaking your focus? Motion reshuffles your plan instantly") ve görev süresi beklenenden uzun sürdüğünde ("If a quick task turns into a longer deep dive, Motion's AI Task Manager intelligently reshuffles the rest of your schedule") **anlık** olarak yeniden planlıyor.
- **Deadline risk / "Do Date ≠ Due Date":** Var — doğrulandı. "When Motion thinks a task is at-risk of missing deadline, it proactively warns you days, weeks, or months in advance" — bu NotifyMe'nin "Goal trajectory" fikrine görev-seviyesinde en yakın **ticari, kanıtlı** örnek. Ama bu görev bazlı risk tahmini; NotifyMe'nin sorduğu "tüm task'lar tamamlansa bile Goal'un gerisinde kalma" sorusuna eşdeğer olduğu **doğrulanamadı** — Motion'ın dokümantasyonunda goal-seviyesinde ayrı bir "pace" metriği yok.
- **Planned vs actual (süre):** **Belirsiz.** Motion görev süresini kullanıcı girdisi + AI tahminiyle zamanlıyor ("hundreds of thousands of datapoints—deadlines, priorities, dependencies"), ama bunun geçmiş **gerçekleşen** süreler üzerinden kişiselleştirilmiş bir öğrenme olup olmadığı resmi dokümantasyonda **açıkça yazmıyor**. help.usemotion.com genel tanımda "based on your tasks, deadlines, priorities, and available time" diyor — geçmiş performans kelimesi geçmiyor.
- **Yapılandırılmış/serbest metin geri bildirim:** **Kamuya açık kaynaklarda doğrulanamadı.**
- **AI/ML/LLM:** Var — doğrulandı, ürünün çekirdeği. Kullanım alanı: otomatik zamanlama optimizasyonu, AI Chat (doğal dil task oluşturma), AI Notetaker, proje otomatik oluşturma ("describe your project," >90% doğrulukla task/deadline/assignee üretiyor). **RAG kanıtı yok.**
- **Bilinen kullanıcı eleştirisi (bağımsız kaynak):** temporal.day (2026-03-15) karşılaştırma yazısı: "The surrender problem. Motion's optimization runs continuously and moves things without asking... Energy-blind. Motion sees open slots. It doesn't see whether that slot is your peak analytical window." — NotifyMe'nin "kullanıcı onayı olmadan karar vermeme" ilkesiyle doğrudan çelişen, gerçek bir kullanıcı şikâyeti.
- **NotifyMe için en önemli emsal:** Motion, "sistem karar veriyor, kullanıcı reddedemiyor/onaylamıyor" ekseninde NotifyMe'nin bilinçli olarak **kaçındığı** UX'in ticari, başarılı (1M+ kullanıcı iddiası) örneği.
- **Kaynaklar:** usemotion.com; usemotion.com/features/ai-task-manager; help.usemotion.com/en; temporal.day/blog/motion-vs-reclaim-vs-clockwise-vs-akiflow-vs-sunsama (2026-03-15, bağımsız karşılaştırma).

### 1.4 Reclaim.ai (2024'ten beri Dropbox bünyesinde)

- **Kurumsal not:** Reclaim.ai, Ağustos 2024'te Dropbox tarafından satın alındı (TechCrunch, GeekWire, reclaim.ai/blog — üç bağımsız kaynak uyumlu, 2024-08-20/22). Ürün Reclaim markasıyla devam ediyor, ayrı bir "Dropbox Learn" eğitim portalı var (learn.dropbox.com/.../reclaim-fundamentals-course).
- **Problem/kitle:** Takvim-merkezli zaman koruma — Habits, Tasks, Focus Time, Smart Meetings tek takvimde.
- **Goal→Task ayrımı:** **Kamuya açık kaynaklarda doğrulanamadı** açık bir "Goal" nesnesi olarak; "Habits... help you stay consistent and achieve your goals" diyor ama Goal ayrı bir varlık değil, Habit'in bir gerekçesi.
- **Otomatik schedule/reschedule:** **Var — doğrulandı, iyi belgelenmiş.** Habits özelliği: kullanıcı min/max süre + tercih edilen zaman aralığı belirtiyor, Reclaim takvimi tarayıp en uygun boşluğu buluyor, çakışma olursa otomatik taşıyor ("Reclaim automatically reschedules your habits so you never lose momentum" — reclaim.ai/features/habits). "Time Defense" seviyeleri (Least/Most Defensive) kullanıcı kontrolünü koruyor — **NotifyMe'nin "öneri, dayatma değil" ilkesine kısmen benzer bir tasarım.**
- **Planned vs actual:** **Kamuya açık kaynaklarda doğrulanamadı.** "Stats" koleksiyonu var (help.reclaim.ai, "How to use Reclaim to analyze your time and your team's time") ama detaylı içeriğine (hangi metrikler, planned/actual karşılaştırması var mı) resmi sayfa erişim hatası (CRAWL_NOT_FOUND) nedeniyle ulaşılamadı.
- **Performans geçmişine göre adaptasyon:** Kısmi kanıt var ama sınırlı — "Reclaim will just let you do it... Once you've moved the Habit, Reclaim will rethink your preferred times so that it adapts to the changes you just made" (reclaim.ai/blog/block-time-automatically-habits-routines, 2020-06-26). Bu, kullanıcının **manuel** taşıma davranışından öğrenen bir adaptasyon — NotifyMe'nin öngördüğü "tamamlanma/gecikme geçmişinden öğrenen" mekanizmadan farklı bir sinyal kaynağı.
- **Yapılandırılmış/serbest metin geri bildirim:** **Yok — açıkça doğrulandı** (bulunan hiçbir sayfada böyle bir mekanizma yok).
- **AI/ML/LLM:** Var — doğrulandı. "AI scheduling agents", "AI chat for Habit planning". Reclaim resmi sayfalarda kendini defalarca "AI agents" diye tanımlıyor ama algoritmanın kural-tabanlı optimizasyon mu, LLM-tabanlı mı olduğu (chat dışında) **belirsiz** — muhtemelen ikisinin karışımı, ama kesin teknik açıklama yok.
- **NotifyMe için ders:** "Time Defense" seviyeleri — kullanıcının sistem agresifliğini kademeli ayarlayabildiği bir UI paterni, NotifyMe'nin "kullanıcı onayı/değişikliği" mekanizması için doğrudan ilham olabilir (öneri şiddeti kullanıcı kontrolünde).
- **Kaynaklar:** reclaim.ai/features/habits; reclaim.ai/features/planner; help.reclaim.ai; learn.dropbox.com/self-guided-learning/reclaim-fundamentals-course/...; reclaim.ai/blog/block-time-automatically-habits-routines (2020-06-26); techcrunch.com/2024/08/22/...; geekwire.com/2024/dropbox-acquires-reclaim...

### 1.5 Structured

- **Problem/kitle:** Görsel günlük zaman çizelgesi (timeline) uygulaması, sadelik/estetik odaklı.
- **Kanıt kalitesi uyarısı:** Resmi site (structured.app) neredeyse tamamen pazarlama/kullanıcı yorumu içeriyor, teknik dokümantasyon/help-center bulunamadı. Aşağıdaki maddelerin çoğu **kamuya açık kaynaklarda doğrulanamadı**.
- **Goal→Task ayrımı:** Kamuya açık kaynaklarda doğrulanamadı.
- **Otomatik schedule/reschedule:** Kamuya açık kaynaklarda doğrulanamadı — ürün "timeline'a kendin sürükle" konseptine dayanıyor gibi görünüyor (manuel), ama kesin değil.
- **Planned vs actual, performans geçmişi, yapılandırılmış geri bildirim:** Kamuya açık kaynaklarda doğrulanamadı.
- **AI/ML/LLM:** Structured'ın kendi sitesinde AI iddiası görülmedi (rakip karşılaştırma yazılarında — örn. dopamind.app blog'unda — "Structured's visual timelines are stunning but high-maintenance" deniyor, yani manuel emek ağır basıyor izlenimi var — ama bu üçüncü parti/rakip kaynağı, tarafsız değil).
- **NotifyMe için ders:** Structured'ın büyüklüğü (15M+ indirme, 500K+ pro kullanıcı — kendi iddiaları, bağımsız doğrulanmadı) basit, AI'sız görsel planlamaya hâlâ büyük talep olduğunu gösteriyor — NotifyMe'nin "sade UI + arkada adaptif motor" kombinasyonu bu segmentte farklılaşabilir.
- **Kaynaklar:** structured.app (ana sayfa); dopamind.app (rakip karşılaştırma blog'u, taraflı kaynak, düşük güven).

### 1.6 Sunsama

- **Problem/kitle:** "Modern profesyoneller" için bilinçli günlük planlama ritüeli, burnout'u önleme odaklı.
- **Goal→Task ayrımı:** Kısmen — "Weekly Objectives" var (haftalık hedefler), Task bunlara "aligned" olarak işaretlenebiliyor, ama bu NotifyMe'nin çok-haftalı/aylık Goal + deadline + trajectory kavramından daha dar (haftalık kapsamla sınırlı).
- **Günlük/haftalık planlama:** **Var — doğrulandı, ürünün özü.** Günlük planlama ritüeli + "Weekly Review" (help.sunsama.com/docs/usage-guides/weekly-objectives/weekly-review/).
- **Planned vs actual:** **Var — doğrulandı, en iyi belgelenmiş örnek.** Resmi "Planned and Actual Times" dokümanı (help.sunsama.com/docs/usage-guides/tasks/planned-and-actual-times/): her görevde ayrı "planned time" ve "actual time" alanı var, workload sayacı ikisini karşılaştırıyor, gün sonunda "actual vs planned" görünümü sunuyor. **Bu, NotifyMe'nin planned/actual veri modeline en yakın canlı emsal.**
- **Haftalık performans analizi:** **Var — doğrulandı.** Weekly Review 3 adımlı: (1) objective'lere göre zaman dağılımı grafiği, (2) haftanın tam işi + günlük zaman dağılımı, (3) serbest metin reflection/journal.
- **Serbest metin geri bildirim:** **Var — doğrulandı.** Haftalık "journal" adımı var, opsiyonel, kapatılabilir.
- **Yapılandırılmış (kategorik) geri bildirim:** **Yok — açıkça doğrulandı.** Journal tamamen serbest metin; "neden tamamlanmadı" gibi kapalı-uçlu seçenek listesi yok.
- **Gelecek planının geçmiş performansa göre OTOMATİK değişmesi:** **Yok — açıkça doğrulandı.** Sunsama veriyi kullanıcıya gösteriyor ("This chart should give you a sense for whether you're spending your time in a way that aligns with your objectives"), ama **kullanıcı kendisi** yorumluyor ve sonraki haftayı kendisi planlıyor. Sistem "60→90 dakika" gibi bir öneri üretmiyor. **Bu, NotifyMe'nin Sunsama'dan tam olarak ayrıldığı nokta: Sunsama "ölçüyor ve gösteriyor", NotifyMe "ölçüyor, analiz ediyor ve öneriyor."**
- **AI/ML/LLM:** Kamuya açık kaynaklarda doğrulanamadı — incelenen sayfalarda AI/LLM iddiası görülmedi; ürün büyük ölçüde manuel/ritüel-tabanlı.
- **NotifyMe için ders:** Sunsama'nın "Planned and Actual Times" veri modeli ve 3 adımlı Weekly Review UX'i, NotifyMe'nin FAZ1 şemasındaki `plannedAmount/actualAmount` ve gelecekteki haftalık analiz ekranı için doğrudan referans alınabilir bir tasarım paterni.
- **Kaynaklar:** sunsama.com; help.sunsama.com/docs/usage-guides/weekly-objectives/weekly-review/; help.sunsama.com/docs/usage-guides/tasks/planned-and-actual-times/; sunsama.com/features/guided-planning-and-reviews; roadmap.sunsama.com/changelog/weekly-review-20; roadmap.sunsama.com/changelog/planned-vs-actual; sunsama.com/blog/how-to-do-weekly-review (2024-04-08).

### 1.7 Akiflow

- **Problem/kitle:** "Founders, operators, obsessed doers" — çoklu araçtan (calendar, task, inbox) tek akışa toplama, hız odaklı.
- **Şirket durumu:** Y Combinator destekli (akiflow.com anasayfa, "Backed by Y Combinator").
- **Goal→Task ayrımı:** Kamuya açık kaynaklarda doğrulanamadı net bir üst-seviye Goal nesnesi olarak; site "Goals" kelimesini bir özellik etiketi olarak listeliyor ("A Productivity Tool Box: Focus Time, Goals, Focus Mode...") ama detay sayfası incelenemedi.
- **Otomatik schedule/reschedule:** Var, kısmen doğrulandı — "Auto-schedule, always in control", "Smart Time Slots that work around you", "Plan your day, week, automatically". Detay mekanizması (hangi sinyallere göre) resmi ana sayfa dışında derinlemesine belgelenmiş bulunamadı.
- **AI asistanı (Aki):** Var — doğrulandı. Doğal dil/sesli komutla görev oluşturma, günlük brifing, "Stay goal-aligned with AI nudges" iddiası var ama nudge mekanizmasının geçmiş performansa dayanıp dayanmadığı **belirsiz**.
- **Planned vs actual / performans geçmişi / yapılandırılmış geri bildirim:** Kamuya açık kaynaklarda doğrulanamadı.
- **AI/ML/LLM:** Var — doğrulandı (Aki asistanı, MCP entegrasyonu var — "Akiflow MCP" navigasyon linki). RAG kanıtı yok.
- **NotifyMe için ders:** Akiflow'un "Universal Inbox" (her araçtan tek gelen kutusuna toplama) paterni NotifyMe'nin kapsamı dışında ama "AI nudges" + "goal-aligned" dili, pazarlamada NotifyMe'nin de karşılaşacağı bir konumlama alanı (rekabetçi terim alanı) olduğunu gösteriyor.
- **Kaynaklar:** akiflow.com (ana sayfa, erişim 2026-09-20).

### 1.8 Trevor AI

- **Problem/kitle:** Bireysel kullanıcılar için AI destekli günlük/haftalık zaman bloklama.
- **Goal→Task ayrımı:** Kamuya açık kaynaklarda doğrulanamadı.
- **Süre tahmini:** **Var — doğrulandı (iddia düzeyinde).** "Trevor predicts the duration of tasks... Trevor adapts to you, continuously" (trevorai.com). Ancak bu tahminin **kullanıcının geçmiş gerçekleşen sürelerinden** mi yoksa genel bir AI modelinden mi geldiği teknik olarak açıklanmıyor.
- **Otomatik schedule/reschedule:** Var — doğrulandı. "Plan My Day" tek tuşla otomatik zamanlama, "Trevor adapts to you with each planning session, allowing him to predict the optimal time for each of your tasks."
- **Pazarlama istatistiği (dikkat):** "old-school lists... only get 40% completion rates... Trevor's AI scheduling helps you finish 85% of your tasks" — **kaynak/metodoloji belirtilmemiş, doğrulanamayan pazarlama iddiası.** Rapora sadece "iddia edilen, doğrulanmamış" olarak not düşülüyor.
- **Planned vs actual, yapılandırılmış geri bildirim, goal trajectory:** Kamuya açık kaynaklarda doğrulanamadı.
- **AI/ML/LLM:** Var — doğrulandı ("Trevor uses the most advanced AI models" — model adı verilmiyor).
- **Kaynaklar:** trevorai.com (ana sayfa, erişim 2026-09-20).

### 1.9 GoalFlow — NotifyMe vizyonuna yakın, küçük/bağımsız ürün

- **Neden dahil edildi:** Todoist/TickTick gibi mainstream ürünlerden çok daha yakın bir kavramsal eşleşme sunuyor: **"success probability" skoru** — davranışa göre güncellenen, hedefe ulaşma olasılığını tahmin eden bir metrik. Bu, NotifyMe'nin "Goal trajectory" fikrine ticari üründe bulduğum **en yakın** doğrudan emsal.
- **Kanıt kalitesi uyarısı:** Küçük/bağımsız bir ürün, tek kaynak (kendi resmi sitesi), bağımsız inceleme/basın kaynağı bulunamadı. Tüm maddeler "yalnızca üreticinin kendi iddiası" düzeyinde okunmalı.
- **Mekanizma (kendi iddiaları):** "Your success probability updates every day based on your real behaviour" — 3 sinyalin birleşimi: **consistency** (alışkanlık tamamlama sıklığı), **momentum** (son trend), **clarity** (hedefin ne kadar net tanımlandığı). "GoalFlow's prediction engine calculates your score daily from three behavioral signals."
- **Goal→Task/Habit ayrımı:** Var (kısmi) — Goal üst seviyede, altında günlük "Habits" var; NotifyMe'nin Goal→Task esnekliği (Task'ın Goal'suz da var olabilmesi) ile birebir örtüşmüyor, GoalFlow'da her şey bir Goal'e bağlı görünüyor.
- **Yapılandırılmış/serbest metin geri bildirim, planned-vs-actual (süre/miktar):** Kamuya açık kaynaklarda doğrulanamadı — GoalFlow'un birimi "habit tamamlandı mı" (binary), NotifyMe'nin plannedAmount/actualAmount gibi nicel bir planlı-iş-miktarı karşılaştırması yok gibi görünüyor.
- **AI/ML/LLM:** Belirsiz — "prediction engine" deniyor, LLM mi klasik bir skor formülü mü olduğu belirtilmiyor; muhtemelen kural/istatistik tabanlı (üç sinyalin ağırlıklı toplamı), "AI" pazarlama dili olabilir.
- **NotifyMe için ders / risk:** GoalFlow, "her gün güncellenen tek bir olasılık skoru" fikrinin ticari olarak zaten var olduğunu gösteriyor — NotifyMe'nin Goal trajectory fikri **kavramsal olarak özgün değil**, ama NotifyMe'nin planned-vs-actual iş miktarı + deadline'a göre nicel hız hesabı (GoalFlow'da olmayan bir derinlik) burada bir farklılaşma alanı olabilir.
- **Kaynaklar:** goalflow.app (ana sayfa, erişim 2026-09-20; tek kaynak).

### 1.10 Archion — NotifyMe vizyonuna yakın, küçük/bağımsız ürün

- **Neden dahil edildi:** "AI project manager" konumlaması, haftalık AI check-in raporu ve "adjusts the plan when life gets in the way" — NotifyMe'nin geri bildirim→analiz→yeni plan döngüsüne kavramsal olarak en yakın ikinci örnek.
- **Kanıt kalitesi uyarısı:** Küçük/bağımsız ürün (fiyatlandırma Tayland Bahtı ฿ cinsinden — muhtemelen küçük/bölgesel bir ekip), bağımsız basın/inceleme kaynağı bulunamadı.
- **Goal→Task ayrımı:** Var — doğrulandı (kendi iddiası). Goal → fazlara → günlük task'lara bölünüyor ("Archion breaks your goal into phases and daily tasks").
- **Periyodik check-in / neden sorma:** Var — doğrulandı (kendi iddiası, nitel düzeyde). "AI check-in meetings: Periodic reviews where Archion asks what's blocking you and adjusts the plan accordingly." Bu, NotifyMe'nin "neden başarısız oldun" sorusuna en yakın ticari örnek — ama **yapılandırılmış kategori listesi değil**, konuşma tabanlı/açık uçlu görünüyor.
- **Otomatik yeniden planlama:** Var — doğrulandı (kendi iddiası). "Miss a day? The schedule adapts. Get ahead? It pulls work forward." — bu, işi ileri/geri kaydırma mantığı; NotifyMe'nin "60dk→90dk kademeli değişiklik önerisi" gibi bir iş yükü/süre büyütme önerisi olduğu **doğrulanamadı**, daha çok zamanlama kaydırma gibi görünüyor.
- **Haftalık rapor / momentum:** Var — doğrulandı. "Every week, Archion's AI reviews your progress and sends a personalized report" — örnek çıktı: "You completed 8 out of 10 tasks — strong week! ... Consider breaking it into smaller steps."
- **Kullanıcı onayı / öneriyi reddetme:** **Kamuya açık kaynaklarda doğrulanamadı.** Yeniden planlamanın kullanıcı onayı gerektirip gerektirmediği (Motion'daki gibi "sistem otomatik yapar" mı, yoksa öneri mi sunar) net değil — "no guilt, no manual reshuffling" ifadesi otomatik/onaysız yapıldığı izlenimini veriyor, bu NotifyMe'nin "kullanıcı onayı zorunlu" ilkesinden **farklı** olabilir.
- **Adaptasyon sonucunun tekrar ölçülmesi (closed-loop):** Kamuya açık kaynaklarda doğrulanamadı.
- **AI/ML/LLM:** Var — doğrulandı, LLM tabanlı olduğu güçlü ima ediliyor (MCP entegrasyonu: "Connect Claude Desktop, Cursor, VS Code Copilot... to Archion"). RAG kanıtı yok.
- **Kaynaklar:** archionapp.com (ana sayfa, erişim 2026-09-20; tek kaynak).

### 1.11 Serena (withserena.ai) — NotifyMe vizyonuna yakın, küçük/bağımsız ürün

- **Neden dahil edildi:** Ürün açıkça "AI Rescheduler" ve "Weekly Reviews" özelliklerini pazarlama diliyle öne çıkarıyor — isim düzeyinde NotifyMe'nin adaptif yeniden-planlama diline en yakın örnek.
- **Kanıt kalitesi uyarısı:** Çok küçük/erken aşama ürün izlenimi (site büyük ölçüde tek sayfa pazarlama + ürün ekran görüntüsü), bağımsız kaynak yok. Ekran görüntüsündeki tarihler (Mayıs 2026, "AI Product Launch Q1 2025") tutarsız/karışık görünüyor — bu da sitenin demo/placeholder içerik barındırdığına işaret ediyor, gerçek üretim verisi değil.
- **Goal→Task ayrımı:** Kısmi — "Projects" var, "Projects that Stay on Track" başlığı altında "keep big goals connected to the tasks that move them forward" deniyor, ama Goal ayrı bir birinci sınıf nesne olarak modellenmemiş, Project'e daha yakın.
- **AI Rescheduler:** Var — doğrulandı (kendi iddiası). "Ask Serena to push, rebalance, or reschedule work instead of manually shuffling tasks every time priorities change" — bu **kullanıcının talep ettiği** (chat-tabanlı) bir yeniden planlama, Motion/Reclaim'deki gibi sürekli otonom optimizasyon değil.
- **Weekly review / trend:** Var — doğrulandı (kendi iddiası, yüzeysel). "See where work is slowing down, where bottlenecks are forming, and how your week is trending."
- **Planned vs actual, yapılandırılmış geri bildirim, goal trajectory:** Kamuya açık kaynaklarda doğrulanamadı.
- **AI/ML/LLM:** Var — doğrulandı (kendi iddiası), teknik derinlik belirsiz.
- **Kaynaklar:** withserena.ai/features (erişim 2026-09-20; tek kaynak, düşük güven).

---

## 2. Değerlendirilip elenen ürünler

| Ürün | Neden elendi |
| --- | --- |
| Clockwise | Sadece karşılaştırma makalesinde geçti; ana odak takım toplantı optimizasyonu (meeting-centric), NotifyMe'nin bireysel Goal/Task vizyonuyla örtüşmesi zayıf. Ayrı derin inceleme yapılmadı, zaman kısıtı. |
| ClickUp (Gantt/Scrum ürünleri) | Kurumsal proje yönetimi/Gantt aracı, bireysel adaptif planlama vizyonuyla örtüşmüyor. |
| ToDoozer, Beyond Time, Dayloom, ProgressPing, QTR, Telori, TaskFirst, ARETE, Tier, Forge, Nudgrr, Onzy, Daryl, Dopamind, Karya Keeper (AI Forecast) | Arama sonuçlarında bulundu, kısa incelendi; çoğu ya (a) kurumsal proje zaman çizelgesi (ToDoozer, Karya Keeper — CPM/proje yönetimi, bireysel kullanıcı değil), (b) ADHD/motivasyon-koçluğu odaklı ürünler (Onzy, Dopamind, Forge, Nudgrr, TaskFirst, ARETE, Tier, Daryl) — NotifyMe'nin "süreklilik gerektiren hedef" odağından farklı bir problem alanı (anlık başlama frictionı, NotifyMe'nin hedeflediği "haftalar boyu pace" değil), ya da (c) tek sayfalık, çok erken aşama ürünler olup GoalFlow/Archion/Serena'dan daha az örtüşme gösterdiği için zaman kısıtı nedeniyle derin incelemeye alınmadı. Bu ikinci grup (b) ayrıca "AŞAMA 2 akademik literatür" kısmında motivasyon/davranış değişikliği açısından tekrar gündeme gelebilir. |
| GitHub/hackathon/öğrenci projeleri: AI-Task-Planning-Agent, AD-Technology `routine`, `akis-adaptive-planner`, ExecuNova-AI, **Gegmara** (Devpost), LIFELOOP, Producktive, ChronoPlanner | **Aşama 1 kapsamı dışı bırakıldı çünkü ticari/gerçek kullanıcıya sunulan ürün değiller** (açık kaynak kişisel proje / hackathon / öğrenci ödevi). Ancak **önemli bir gözlem**: bu projelerden en az biri (Gegmara — Devpost hackathon projesi) NotifyMe'nin adaptasyon mantığına şaşırtıcı derecede yakın: EMA (exponential moving average) ile kategori bazlı süre öğrenme, "Binary Goal Adherence Score (B-GAS)" ile haftalık uyum skoru, %20 sapma eşiğiyle süre uyarısı, güven seviyesine göre (örnek sayısına dayalı) otomatik-ayarlama kapısı. Bu, **§6 Red Team** ve **§4 Gap Analysis madde D/E**'de tekrar ele alınıyor — çünkü akademik/hackathon düzeyinde bu fikrin defalarca üretildiğini gösteriyor, sadece olgun ticari üründe eksik. |

---

## 3. Özellik Matrisi

Lejant: ✅ Var — doğrulandı · ❌ Yok — açıkça doğrulandı · ➖ Kamuya açık kaynaklarda doğrulanamadı · ❔ Belirsiz

| Özellik | Todoist | TickTick | Motion | Reclaim | Structured | Sunsama | Akiflow | Trevor AI | GoalFlow | Archion | Serena | **NotifyMe** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Goal → Task ayrımı | ❌ | ❌ | ➖ | ➖ | ➖ | ➖(haftalık objective) | ➖ | ➖ | ✅(kısmi) | ✅ | ➖ | **PLANNED** |
| Günlük planlama | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | **CURRENT** |
| Haftalık planlama | ✅ | ➖ | ➖ | ➖ | ➖ | ✅ | ➖ | ➖ | ➖ | ➖ | ➖ | **PLANNED** |
| Time blocking | ✅(Pro) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ➖ | **FUTURE** |
| Otomatik schedule | ❌ | ❌ | ✅ | ✅ | ➖ | ❌(manuel/rehberli) | ✅ | ✅ | ❌ | ✅(task seviyesi) | ➖(talep üzerine) | **FUTURE** |
| Otomatik reschedule | ❌ | ❌ | ✅ | ✅ | ➖ | ❌ | ➖ | ✅ | ❌ | ✅ | ✅(talep üzerine) | **PLANNED** |
| Planned vs actual **süre** | ➖(sadece planned) | ➖ | ➖ | ➖ | ➖ | ✅ | ➖ | ➖ | ❌ | ➖ | ➖ | **PLANNED** |
| Planned vs actual **iş miktarı** | ❌ | ❌ | ❌ | ❌ | ➖ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | **PLANNED** |
| Performans geçmişi kullanımı | ➖(iddia, doğrulanamadı) | ➖(sadece istatistik) | ➖ | ➖(manuel taşımadan) | ➖ | ➖(gösterim, aksiyon değil) | ➖ | ➖ | ✅(momentum sinyali) | ✅(haftalık rapor) | ✅(trend) | **PLANNED** |
| Yapılandırılmış (kategorik) geri bildirim | ❌ | ❌ | ➖ | ❌ | ➖ | ❌ | ➖ | ➖ | ❌ | ➖(nitel, açık uçlu) | ➖ | **PLANNED** |
| Serbest metin geri bildirim | ❌ | ❌ | ➖ | ❌ | ➖ | ✅(journal) | ➖ | ➖ | ➖ | ➖ | ➖ | **PLANNED** |
| Haftalık performans analizi | ✅(proje Insights) | ➖ | ➖ | ➖(Stats, detay belirsiz) | ➖ | ✅ | ➖ | ➖ | ✅ | ✅ | ✅ | **PLANNED** |
| Adaptif işyükü (süre/miktar büyütme-küçültme önerisi) | ❌ | ❌ | ❔ | ❔ | ➖ | ❌ | ➖ | ❔ | ❌ | ❔(kaydırma var, büyütme belirsiz) | ➖ | **FUTURE** |
| Kullanılabilir zamanı hesaba katma | ➖ | ➖ | ✅ | ✅ | ➖ | ✅(workload sayacı) | ✅ | ✅ | ❌ | ➖ | ➖ | **PLANNED** |
| Deadline/Goal trajectory (pace) analizi | ➖(proje momentum'u var, pace yok) | ❌ | ✅(görev-seviye risk uyarısı) | ➖ | ➖ | ❌ | ➖ | ❌ | ✅(en yakın emsal) | ➖ | ➖ | **FUTURE** |
| Task tamamlansa da Goal geride kalma tespiti | ❌ | ❌ | ➖ | ➖ | ➖ | ❌ | ➖ | ❌ | ➖ | ➖ | ➖ | **FUTURE (vizyon, henüz tasarlanmadı)** |
| Kullanıcı-kontrol edilebilir öneri (onay/red/değiştir) | n/a | n/a | ❌(otonom, şikâyet konusu) | ✅(Time Defense seviyeleri) | n/a | n/a | ➖ | ➖ | n/a | ➖ | ➖ | **PLANNED (çekirdek ilke)** |
| AI/ML | ✅(Assist) | ✅(sınırlı) | ✅(çekirdek) | ✅ | ➖ | ❌ | ✅ | ✅ | ❔ | ✅ | ✅ | **FUTURE** |
| LLM kullanımı (kanıtlı) | ✅(chat/öneri) | ➖ | ✅ | ➖ | ➖ | ❌ | ✅ | ➖ | ❔ | ✅(MCP entegrasyonu) | ➖ | **FUTURE (serbest metin sınıflandırma için)** |
| RAG (kanıtlı) | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | **Henüz kararlaştırılmadı** |
| Geri bildirim-güdümlü adaptasyon | ❌ | ❌ | ❔(otomatik, kullanıcı geri bildirimi değil sistem gözlemi) | ❔ | ➖ | ❌ | ➖ | ❔ | ✅(davranış→skor) | ✅(nitel) | ➖ | **PLANNED** |
| Adaptasyon sonucunun tekrar ölçülmesi (closed-loop) | ❌ | ❌ | ➖ | ➖ | ➖ | ❌ | ➖ | ➖ | ➖(skor sürekli güncelleniyor ama "öneri başarılı mıydı" ölçümü yok) | ➖ | ➖ | **FUTURE (vizyon)** |

**NotifyMe sütunu okuma notu:** CURRENT = bugün kodda çalışan (bkz. `Durum-Raporu.md`, `FAZ-1-Data-Model-Audit.md`). PLANNED = FAZ1 şemasında/ürün vizyonunda tanımlı ama henüz implement edilmedi. FUTURE = vizyon dokümanında bahsi geçen ama şema/mimari kararı henüz alınmamış (FAZ5+ adaptif motor, AI/LLM entegrasyonu).

---

## 4. Kritik Gap Analysis (A–M)

**A. NotifyMe'nin düşündüğü hangi özellikler zaten piyasada yaygın?**
Günlük planlama, time-blocking, takvim entegrasyonu, öncelik/etiket sistemi — bunlar Todoist/TickTick/Structured/Sunsama/Akiflow'un hepsinde var, tamamen standart. Otomatik zamanlama/yeniden-zamanlama da (Motion, Reclaim, Trevor AI, kısmen Archion/Serena) artık "AI planner" kategorisinde yaygınlaşmış bir özellik — bu kategori NotifyMe'nin düşündüğünden daha kalabalık.

**B. Hangi özellikleri yalnızca birkaç rakip yapıyor?**
Planned-vs-actual **süre** karşılaştırması net biçimde sadece Sunsama'da (iyi belgelenmiş). Deadline-risk erken uyarısı net biçimde sadece Motion'da. Haftalık AI-üretimi ilerleme raporu Archion'da var. "Success probability" skoru sadece GoalFlow'da var. **Hiçbiri bunların ikisini/üçünü birden yapmıyor.**

**C. NotifyMe'nin gerçekten farklı olabileceği özellik kombinasyonları hangileri?**
Bulunan hiçbir üründe şu üçlünün **birlikte** var olduğu doğrulanamadı: (1) planned-vs-actual **hem süre hem iş miktarı** (Sunsama sadece süre), (2) **yapılandırılmış** (kategorik) başarısızlık nedeni toplama + opsiyonel serbest metin (hiçbirinde kategorik seçenek listesi bulunamadı — en yakını Archion'ın açık-uçlu "what's blocking you" sorusu), (3) kullanıcının önerilen değişikliği (60→90dk gibi) **açıkça onaylayıp/reddedip/kendi değerini girebildiği** kademeli iş yükü önerisi (Reclaim'in Time Defense'i buna yakın ama süre/miktar önerisi değil, zamanlama agresifliği). Bu üçlünün birlikteliği, bulunan 11 üründe **doğrulanmadı** — ama bu "kimse yapmıyor" demek değil, "kamuya açık kaynaklarda bulunamadı" demek (§0 kanıt seviyesi kuralı).

**D. NotifyMe'nin "özgün" sandığımız ama aslında özgün olmayan tarafları var mı?**
Evet, en az üç tanesi: (1) "Goal'suz Task olabilir, zorunlu Goal FK yok" tasarım kararı — Todoist/TickTick zaten Goal kavramı olmadan çalışıyor, yani "task'ın goal'e bağlı olmak zorunda olmaması" fikri sıfırdan değil. (2) "Sistem öneriyor, kullanıcı karar veriyor" ilkesi — Reclaim'in Time Defense seviyeleri ve Archion'ın onay akışı bu ilkeye zaten kısmen sahip. (3) EMA/güven-eşiği tabanlı süre öğrenme — **hackathon projesi Gegmara** (§2, elenenler tablosu) neredeyse birebir bu mimariyi (kategori bazlı EMA öğrenme, örnek-sayısına göre güven seviyesi, %20 sapma eşiği) uygulamış durumda. Ticari üründe olgunlaşmamış olması, fikrin "kimsenin düşünmediği" bir fikir olduğu anlamına gelmiyor.

**E. NotifyMe'den açıkça daha gelişmiş rakipler var mı? Hangi alanlarda?**
Evet, açıkça:
- **Motion** — otomatik zamanlama/yeniden-zamanlama motorunun olgunluğu, deadline-risk erken uyarı sistemi, ölçek (1M+ kullanıcı iddiası), proje-otomatik-oluşturma (AI ile). NotifyMe'nin FAZ1'i bunların hiçbirine henüz sahip değil.
- **Reclaim** — takvim-senkronize otomatik zamanlama, alışkanlık zamanlaması, kurumsal arka plan (Dropbox), 5+ yıllık ürün olgunluğu.
- **Sunsama** — planned-vs-actual veri modeli ve haftalık ritüel UX'i NotifyMe'nin şu anki tasarımından (henüz implement edilmemiş plan) daha olgun ve kullanıcı testinden geçmiş.
- **GoalFlow** — "her gün güncellenen tek olasılık skoru" NotifyMe'nin Goal trajectory vizyonunun basitleştirilmiş ama **bugün çalışan** bir versiyonu.

**F. Rakiplerde olup NotifyMe vizyonunda eksik olan önemli özellikler neler?**
- Takvim (Google/Outlook) çift yönlü senkronizasyonu — NotifyMe vizyonunda hiç geçmiyor, Motion/Reclaim/Akiflow/Sunsama'nın hepsinin temel özelliği.
- Toplantı/etkinlik farkındalığı (meeting-aware scheduling) — NotifyMe'nin Task/Goal modeli bunu düşünmüyor.
- Çoklu entegrasyon (email, Slack, proje yönetim araçları) — NotifyMe scope dışı tutuyor (haklı olarak, MVP için).
- Ekip/paylaşım özellikleri — NotifyMe bilinçli olarak tekil-kullanıcı (bkz. FAZ1: "tek local profil").

**G. Bunlardan hangilerini eklemek mantıklı?**
Takvim senkronizasyonu (salt-okunur, "kullanılabilir zaman" hesaplaması için) orta vadede mantıklı olabilir — Urun-Vizyonu'nda zaten "kullanılabilir zaman" planlanan veri noktalarından biri olarak geçiyor, bunun manuel girilmesi mi yoksa takvimden çekilmesi mi gerektiği açık bir soru (bkz. §7 sonraki sorular).

**H. Hangilerini eklemek scope creep olur?**
Ekip/paylaşım, çoklu takvim/entegrasyon hub'ı (Akiflow tarzı universal inbox), toplantı asistanı (not alma, video entegrasyonu) — bunların hepsi NotifyMe'nin "süreklilik gerektiren kişisel hedef" odağının dışında, Tasarım 1 kapsamında kesinlikle scope creep olur.

**I. Rakiplerin AI kullanımında en yaygın yaklaşım nedir?**
Üç net küme görüldü: (1) **Doğal dil giriş/ayrıştırma** (Todoist Ramble, TickTick Voice Capture, Akiflow Aki, Archion) — en yaygın, en düşük riskli kullanım. (2) **Otomatik zamanlama optimizasyonu** (Motion, Reclaim, Trevor AI) — kural-tabanlı optimizasyon + AI karışımı, "LLM" olup olmadığı çoğu zaman belirsiz. (3) **Periyodik özet/rapor üretimi** (Archion haftalık rapor, Todoist Project Insights) — muhtemelen LLM ile metin üretimi. **Hiçbirinde** RAG kanıtlandı; "AI" çoğunlukla ya kural-tabanlı optimizasyon motorunu pazarlıyor ya da metin üretimi (LLM chat/özet) için kullanılıyor.

**J. Geçmiş performans→analiz→sonraki plan değişikliği döngüsünü GERÇEKTEN uygulayan ürün var mı?**
Kısmen: **Archion** (haftalık AI raporu + "adjusts the plan when life gets in the way") ve **GoalFlow** (davranış→günlük skor güncelleme) bu döngüye en yakın iki ticari örnek. Ama ikisinde de "sonraki dönemin plan **parametresi** (süre/iş yükü) nasıl değişti" ayrıntısı resmi kaynaklarda görülmedi — döngü var gibi görünüyor ama NotifyMe'nin "60dk→90dk önerisi" kadar somut/nicel değil.

**K. Kullanıcının "neden başarısız olduğunu" adaptasyon girdisi olarak kullanan ürün var mı?**
Yapılandırılmış (kategorik) biçimde **hayır, doğrulanamadı**. En yakınları: Sunsama'nın serbest-metin haftalık journal'ı (ama bu adaptasyonu tetiklemiyor, sadece kullanıcıya gösteriliyor) ve Archion'ın "what's blocking you" açık-uçlu check-in sorusu (adaptasyonu tetiklediği iddia ediliyor ama mekanizma kategorik değil).

**L. Adaptasyon önerisinin sonucunu sonraki dönemde tekrar ölçen kapalı-döngü (closed-loop) yaklaşımına benzeyen ürün var mı?**
Kamuya açık kaynaklarda **hiçbir üründe doğrulanamadı.** GoalFlow'un skoru sürekli güncelleniyor ama "geçen hafta önerdiğimiz X, ne kadar işe yaradı" şeklinde bir öneri-başarı ölçümü hiçbir üründe görülmedi. Bu, NotifyMe'nin AI vizyonundaki "adaptasyon önerisinin başarısını da analiz etme" fikrinin, incelenen 11 üründe **kanıtlanmış bir emsali olmayan** bir nokta — hem güçlü bir potansiyel farklılaşma hem de akademik literatürde (Aşama 2) aranması gereken bir kavram.

**M. Goal seviyesinde pace/trajectory analizi yapan ürün var mı?**
En yakın: **Motion** (görev-seviyesinde deadline-risk uyarısı) ve **GoalFlow** (goal-seviyesinde günlük olasılık skoru). Ama "kullanıcı tüm günlük Task'ları tamamlasa bile Goal'un gerisinde kalabilir" senaryosunu **açıkça** ele alan/ölçen bir ürün kamuya açık kaynaklarda bulunamadı. Bu, NotifyMe'nin Urun-Vizyonu'nda özellikle vurguladığı problem (§ "Goal→Task Modeli") — araştırmada bu spesifik çerçevelemeyle eşleşen ticari ürün **yok**.

---

## 5. Özellik Matrisi Sonrası Sonuç Bölümü

1. **Piyasadaki gerçek durum:** "AI planner" kategorisi kalabalık ve olgun (Motion, Reclaim, Trevor AI, Akiflow) — otomatik zamanlama artık farklılaştırıcı değil, tablo stakes. Buna karşın "geçmiş performanstan yapılandırılmış biçimde öğrenip kademeli, kullanıcı-onaylı iş yükü önerisi üreten ve bu önerinin başarısını tekrar ölçen" tam döngü hiçbir ticari üründe eksiksiz bulunamadı.
2. **NotifyMe'nin doğrulanmış benzerlikleri:** Goal-suz Task modeli (Todoist/TickTick zaten böyle), sistem-öneri/kullanıcı-onay ilkesi (Reclaim Time Defense, Archion check-in), planned/actual süre takibi (Sunsama), haftalık ilerleme raporu (Archion, Todoist Insights), goal-seviye olasılık skoru fikri (GoalFlow).
3. **Potansiyel farklılıkları (henüz kanıtlanmamış, sadece rakiplerde bulunamadı):** planned-vs-actual **iş miktarı** (sadece süre değil) takibi; yapılandırılmış (kategorik) başarısızlık nedeni toplama; kademeli iş yükü önerisi + kullanıcının kendi değerini girebilmesi; öneri başarısının kapalı-döngü ölçümü; Task tamamlansa da Goal'un pace'inin geride kalmasını tespit etme.
4. **Henüz kanıtlanmamış farklılık iddiaları (ihtiyatla okunmalı):** Yukarıdaki 3. maddedeki hiçbiri "kimse yapmıyor" anlamına gelmiyor — sadece "kamuya açık kaynaklarda bulunamadı." Özellikle Gegmara (hackathon projesi, §2) neredeyse aynı EMA-tabanlı öğrenme mimarisini uyguluyor; bu fikrin "keşfedilmemiş" olmadığını, sadece "olgun ticari ürün olarak paketlenmemiş" olabileceğini gösteriyor.
5. **En güçlü 3 farklılaşma adayı:** (a) planned-vs-actual **iş miktarı + süre birlikte**, kademeli öneri + kullanıcı override döngüsü; (b) yapılandırılmış başarısızlık nedeni taksonomisi (Urun-Vizyonu'ndaki 6 kategori) + opsiyonel serbest metin, ikisinin LLM ile birlikte sınıflandırılması; (c) Goal-seviye pace/trajectory analizi (Task completion'dan bağımsız, "kalan iş/kalan zaman" hesabı).
6. **En büyük 3 teknik/ürün riski:** (a) Motion/Reclaim gibi olgun otomatik-zamanlama motorlarına kıyasla NotifyMe'nin zamanlama algoritması çok daha basit kalacak (kaynak/zaman kısıtı, tek geliştirici, akademik proje) — "otomatik zamanlama" ekseninde rekabet etmek gerçekçi değil. (b) Kademeli öneri mekanizmasının "bilimsel/açıklanabilir" olup olmadığı — red team'de detaylandırılıyor (§6). (c) Yapılandırılmış geri bildirimin kullanıcı tarafından gerçekten dolduruluyor olması (Sunsama'nın journal'ı bile "skip this step" seçeneğiyle atlanabiliyor — kullanıcılar serbest-metin/kategori doldurmayı sıklıkla atlıyor olabilir, bu adaptasyon motorunun veri açlığı riskini doğuruyor).
7. **Tasarım 1 için araştırılması gereken sonraki sorular:** (i) Takvim entegrasyonu (kullanılabilir zaman hesaplaması) manuel mi kalacak yoksa Google Calendar okuma mı eklenecek? (ii) Kademeli öneri algoritması ("60→90dk") hangi istatistiksel yönteme dayanacak — EMA (Gegmara'daki gibi), basit ortalama, yoksa LLM muhakemesi mi? (iii) Yapılandırılmış geri bildirim taksonomisi (6 kategori: "Planladığım gibi geçti / Zamanım yetmedi / Odaklanamadım / ...") kaç kategoriye, hangi granülerlikte sabitlenecek — bu Aşama 2'de literatürle (self-regulated learning, attribution theory) desteklenmeli.
8. **AŞAMA 2 akademik literatür araştırmasında aranması gereken anahtar kavramlar:** *planning fallacy* (ExecuNova-AI'nin 1.4x buffer'ı gibi ticari uygulamaları var, akademik kökeni Kahneman/Tversky); *self-regulated learning* ve *attribution theory* (başarısızlık nedeni sınıflandırması için); *exponential moving average / Bayesian updating* ile süre tahmini öğrenme (Gegmara'nın EMA'sı, akademik karşılığı "online learning"); *goal-setting theory* (Locke & Latham) — kademeli hedef artırımının psikolojik temeli; *closed-loop control / feedback control systems* metaforu — mühendislik literatüründe adaptasyon-sonucu-tekrar-ölçme mantığının karşılığı; *habit formation & implementation intentions* (Forge'un pazarlama dilinde geçen "300% completion boost" iddiasının akademik kaynağı — Gollwitzer'in implementation intentions literatürü olabilir, doğrulanmalı); *AI-assisted personalized scheduling* / *adaptive learning systems* (eğitim teknolojisi literatüründeki spaced-repetition ve adaptif zorluk ayarlama sistemleriyle paralellik).

---

## 6. Red Team — "NotifyMe'yi Burakhan Hoca neden reddedebilir?"

### İtiraz 1 — "Bu zaten mevcut AI planner'ların yaptığı bir şey."
- **Neden haklı olabilir:** Motion, Reclaim, Trevor AI, Akiflow — hepsi "AI otomatik zamanlıyor, plan bozulunca yeniden zamanlıyor" iddiasında. NotifyMe'nin "adaptif planlama" sloganı, jüri gözünde bu kalabalık kategoriyle aynı kutuya düşebilir.
- **Gidermek için ne yapılabilir:** Sunumda NotifyMe'yi "otomatik zamanlama" değil, "planned-vs-actual ölçüm + yapılandırılmış nedensellik + kademeli, kullanıcı-onaylı öneri döngüsü" olarak çerçevelemek — bu spesifik kombinasyon, §4-C'de gösterildiği gibi hiçbir rakipte doğrulanamadı.
- **Tasarım 1 kapsamında çözülmeli mi:** Evet — konumlandırma/sunum meselesi, kod değil.

### İtiraz 2 — "AI katkısı yüzeysel — sadece serbest metni sınıflandırıyor."
- **Neden haklı olabilir:** NotifyMe'nin AI vizyonu (§ "AI/LLM Vizyonu") esasen "serbest metin geri bildirimini sınıflandır" diyor; bu günümüzde trivial bir LLM görevi (few-shot classification). Motion/Reclaim'in "sürekli optimizasyon çalıştıran AI ajanları" iddiasına kıyasla çok daha dar bir AI kullanımı.
- **Gidermek için ne yapılabilir:** AI'nin katkısını abartmamak, tam tersine "AI burada sınıflandırma gibi dar ve açıklanabilir bir rol oynuyor, kritik karar (kademeli öneri) kural-tabanlı ve şeffaf" diye çerçevelemek — bu aslında NotifyMe'nin "açıklanabilirlik" avantajına dönüştürülebilir (Gegmara'nın "Lightweight & Explainable" ilkesiyle aynı yönde).
- **Tasarım 1 kapsamında çözülmeli mi:** Evet, çerçeveleme meselesi; teknik olarak zaten FAZ1 planı bunu destekliyor (rule-based adaptasyon + LLM sadece metin sınıflandırma).

### İtiraz 3 — "Adaptasyon algoritması henüz tanımlı değil / bilimsel dayanağı belirsiz."
- **Neden haklı olabilir:** FAZ1 dokümanı ve Urun-Vizyonu'nda "60dk→90dk gibi kademeli değişiklik önerebilir" deniyor ama **hangi formülle** (EMA mi, eşik-tabanlı kural mı, ML modeli mi) belirtilmemiş. Gegmara (hackathon projesi) bunu somut bir formülle (EMA, %20 eşik, güven seviyesi kademeleri) yapmış — NotifyMe şu an bu düzeyde bir spesifikasyona sahip değil.
- **Gidermek için ne yapılabilir:** FAZ5 (adaptif motor) için basit, açıklanabilir bir başlangıç formülü (örn. EMA veya eşik-tabanlı kural) Tasarım 1 raporunda somutlaştırılmalı — "ileride hallederiz" demek jüri karşısında zayıf kalır.
- **Tasarım 1 kapsamında çözülmeli mi:** Kısmen — tam implementasyon FAZ5'in işi ama **algoritmanın yüksek seviye tasarımı** (hangi yönteme dayanacağı) Tasarım 1 raporunda belirtilmeli, yoksa "future work" olarak görülür ve puan kaybettirebilir.
- **Yoksa future work mu:** Somut formül seçimi Tasarım 1'de yapılmalı; üretim-kalitesi implementasyonu future work.

### İtiraz 4 — "Kullanıcı geri bildirimi güvenilir değil — kendi kendini değerlendirme sapmalı olabilir."
- **Neden haklı olabilir:** Hiçbir incelenen üründe bu sorun çözülmüş değil (Sunsama'nın journal'ı bile tamamen kullanıcı beyanına dayanıyor, doğrulama mekanizması yok). "Odaklanamadım" diyen kullanıcı aslında görevi hafife almış olabilir — sistem bunu ayırt edemez.
- **Gidermek için ne yapılabilir:** Objektif sinyallerle (planned vs actual süre/miktar — kullanıcının beyanından bağımsız, sistemin kendi ölçtüğü veri) sübjektif geri bildirimi çapraz doğrulamak; "kullanıcı 'zamanım yetmedi' dedi ama actualAmount planned'a çok yakın" gibi tutarsızlıkları not etmek (aksiyon almadan, sadece güvenilirlik sinyali olarak).
- **Tasarım 1 kapsamında çözülmeli mi:** Future work — ama riskin farkında olunduğu, sınırlamanın raporda açıkça yazılması gerekiyor.

### İtiraz 5 — "Değerlendirme yöntemi yetersiz — bu iddiaları nasıl test edeceksin?"
- **Neden haklı olabilir:** Tek kullanıcılı (Mustafa) bir akademik projede, "kademeli öneri kullanıcı memnuniyetini/başarı oranını artırıyor mu" gibi bir iddiayı istatistiksel olarak test etmek mümkün değil — örneklem yok, A/B test yok.
- **Gidermek için ne yapılabilir:** Tasarım 1 sunumunda "başarı" iddiasını küçültmek; bunun yerine "veri modeli + mekanizma tasarımı doğru mu, kullanılabilir mi" sorusuna odaklanan nitel bir değerlendirme (kendi kullanım günlüğü, kod incelemesi, mimari gerekçelendirme) önermek.
- **Tasarım 1 kapsamında çözülmeli mi:** Evet — değerlendirme planı raporun bir parçası olmalı, "iddiayı nasıl test edemeyeceğimi de biliyorum" demek bilimsel olgunluk göstergesi.

### İtiraz 6 — "Proje kapsamı bir dönem için fazla geniş."
- **Neden haklı olabilir:** FAZ1 Audit dokümanı bile 10 implementasyon adımı listeliyor (sadece veri modeli+repository katmanı için), üstüne AI/LLM entegrasyonu (FAZ5+) ve Goal-trajectory analizi (henüz tasarlanmamış) ekleniyor. Motion/Reclaim gibi şirketlerin yıllarca, çok mühendisle inşa ettiği bir kategoriye (otomatik zamanlama) tek kişi, bir dönemde yaklaşmak gerçekçi değil.
- **Gidermek için ne yapılabilir:** Tasarım 1 kapsamını açıkça daraltmak — örn. "bu dönemde sadece Goal/Task veri modeli + manuel planned/actual takip + basit kural-tabanlı öneri (EMA gibi); tam AI/LLM sınıflandırma ve otomatik zamanlama sonraki döneme" diye net bir MVP sınırı çizmek.
- **Tasarım 1 kapsamında çözülmeli mi:** Evet — bu doğrudan kapsam tanımı meselesi, rapor bunu netleştirmeli.

---

## 7. Kullanılan arama sorguları

1. "adaptive scheduling app that reschedules tasks based on your past completion performance"
2. "goal tracking app that analyzes pace toward deadline trajectory not just task completion"
3. "productivity app that asks why you didn't complete a task and uses that feedback to adjust your plan"
4. "Motion Reclaim AI Sunsama Akiflow Trevor AI comparison planned vs actual time task completion"
5. "Reclaim.ai acquired by Dropbox 2025 announcement" (tarih doğrulaması için)
6. "Reclaim.ai Habits feature learns your patterns"
7. "Sunsama weekly review reflection planned vs actual time task feature official"
8. "app that asks user why they missed a task — structured reason options" (sonuç: eşleşme bulunamadı, alakasız içerik döndü)
9. "RAG retrieval augmented generation productivity planner app official documentation" (sonuç: hiçbir tüketici planlayıcı ürününde RAG kanıtı bulunamadı)
10. "Todoist AI or machine learning feature 2026 duration estimate task completion trends premium"
11. Doğrudan resmi kaynak fetch'leri: todoist.com, ticktick.com, usemotion.com + help.usemotion.com, reclaim.ai + help.reclaim.ai, structured.app, sunsama.com + help.sunsama.com, akiflow.com, trevorai.com, goalflow.app, archionapp.com, withserena.ai.

Not: Orijinal talimatta önerilen bazı sorgular (ör. "self adjusting planner", "feedback based planner") ilk geniş taramada (sorgu 1-4) zaten örtüşen sonuçlar döndürdüğü için ayrı ayrı tekrarlanmadı; sonuçlar arasında GoalFlow, Archion, Serena, ProgressPing, Dayloom, QTR, Beyond Time gibi ürünler bu geniş taramadan çıktı.

## 8. İncelenen ürünler (özet liste)

Todoist, TickTick, Motion, Reclaim.ai (Dropbox), Structured, Sunsama, Akiflow, Trevor AI, GoalFlow, Archion, Serena (withserena.ai) — 11 ürün, §1'de detaylı.

## 9. Elenen ürünler

§2 tablosunda detaylı: Clockwise, ClickUp, ToDoozer, Beyond Time, Dayloom, ProgressPing, QTR, Telori, TaskFirst, ARETE, Tier, Forge, Nudgrr, Onzy, Daryl, Dopamind, Karya Keeper, ve 7 hackathon/öğrenci projesi (AI-Task-Planning-Agent, `routine`, `akis-adaptive-planner`, ExecuNova-AI, **Gegmara**, LIFELOOP, Producktive, ChronoPlanner — ticari ürün olmadıkları için Aşama 1 dışı tutuldu, ama Gegmara özellikle Red Team ve Gap Analysis'te referans alındı).

## 10. Kullanılan kaynaklar (toplu liste)

- todoist.com/features, /todoist-assist, /help/articles/set-a-task-duration-L1kYkZv8d, /help/articles/2026-changelog-HD3jJAtLd (2026-09-02), /help/todoist/billing/todoist-plans-pricing-and-billing-faq (2026-08-28), /help/articles/get-started-with-todoist-pro (2026-08-14)
- aiflowtown.com/todoist-ai-review (2026-01-16, üçüncü parti)
- ticktick.com (ana sayfa)
- usemotion.com, /features/ai-task-manager, help.usemotion.com/en
- temporal.day/blog/motion-vs-reclaim-vs-clockwise-vs-akiflow-vs-sunsama (2026-03-15, bağımsız karşılaştırma)
- reclaim.ai/features/habits, /features/planner, /blog/block-time-automatically-habits-routines (2020-06-26), reclaim.ai/blog/dropbox-acquires-reclaim (2024-08-20), help.reclaim.ai, learn.dropbox.com/self-guided-learning/reclaim-fundamentals-course, updates.reclaim.ai/announcements/reclaim-is-now-a-part-of-dropbox
- techcrunch.com/2024/08/22/dropbox-acquires-index-ventures-backed-ai-scheduling-tool-reclaim-ai (2024-08-22)
- geekwire.com/2024/dropbox-acquires-reclaim-a-calendar-app-that-uses-ai-scheduling-to-boost-productivity (2024-08-20)
- structured.app; dopamind.app (rakip blog, taraflı)
- sunsama.com, /features/guided-planning-and-reviews, /blog/how-to-do-weekly-review (2024-04-08), help.sunsama.com/docs/usage-guides/weekly-objectives/weekly-review, help.sunsama.com/docs/usage-guides/tasks/planned-and-actual-times, roadmap.sunsama.com/changelog/weekly-review-20, roadmap.sunsama.com/changelog/planned-vs-actual
- akiflow.com
- trevorai.com
- goalflow.app
- archionapp.com
- withserena.ai/features
- github.com (Gegmara/Devpost, akis-adaptive-planner, AD-Technology/routine, vb. — elenen ürünler, §2)

## 11. Önemli belirsizlikler / dikkat edilmesi gerekenler

1. **GoalFlow, Archion, Serena tek kaynaklı** (yalnızca kendi resmi siteleri) — bağımsız basın, kullanıcı incelemesi veya teknik dokümantasyon bulunamadı. Bu üç ürünün özellik iddiaları üreticinin kendi pazarlama dilinden ibaret, doğrulama seviyesi düşük. İleride bu üç üründen biri Tasarım 1 sunumunda referans gösterilecekse, ek doğrulama (App Store/Product Hunt yorumları, gerçek kullanıcı deneyimi) önerilir.
2. **Todoist'in AI süre-tahmini iddiası** (aiflowtown.com) resmi kaynakta doğrulanamadı — raporda "belirsiz" olarak işaretlendi, sunumda bu iddia kesin bilgi gibi kullanılmamalı.
3. **Reclaim'in "Stats" özelliği** derinlemesine incelenemedi (help center sayfaları crawl hatası verdi) — planned-vs-actual benzeri bir mekanizma içerip içermediği açık kaldı.
4. **Structured** hakkında neredeyse hiçbir teknik detay bulunamadı; resmi site salt pazarlama. Gerekirse App Store/Play Store açıklaması veya bağımsız inceleme ile tekrar araştırılabilir.
5. **Trevor AI'nin "%85 tamamlanma" istatistiği** doğrulanamayan bir pazarlama iddiası — hiçbir koşulda gerçek veri gibi aktarılmamalı.
6. **Serena'nın ekran görüntüsündeki tarih tutarsızlıkları** (2025 Q1 proje, 2026 Mayıs görevler) ürünün ne kadar olgun/gerçek olduğu konusunda şüphe uyandırıyor — bu ürün özellikle ihtiyatla okunmalı.
7. Bu araştırma **tek oturumluk web araması** ile yapıldı; ödeme duvarının arkasındaki (yalnızca kayıtlı kullanıcıya açık) özellik detaylarına (örn. Motion'ın gerçek zamanlama algoritması, Reclaim'in Stats sayfası içeriği) erişilemedi. Bu ürünlerin bazı iddiaları sadece pazarlama sayfalarından derlendi, uygulamanın içine gerçekten girilmedi.
8. Akademik/literatür bağlantıları (planning fallacy, EMA/online learning, goal-setting theory, implementation intentions) bu raporda sadece **isim olarak** düşüldü (§5 madde 8) — bunların gerçek akademik kaynaklarla doğrulanması Aşama 2'nin işi, burada yapılmadı.

---

**Durum:** Aşama 1 tamamlandı. Kod/repo/roadmap değişikliği yapılmadı, commit/push yapılmadı. Aşama 2 (akademik literatür araştırması) bu oturumda başlatılmadı.

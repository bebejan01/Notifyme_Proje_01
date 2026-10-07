# NotifyMe — Phase 3: Research Synthesis → Tasarım 1 Technical Architecture Decision

**Tarih:** 2026-09-21
**Girdi:** 8 araştırma raporu (Phase 1, 2A, 2B, 2C, 2D, Open-Gaps Cleanup A/B/C — hepsi commit `35d6e53`) + mevcut kod tabanı (`notifyme/lib`, `notifyme/test`).
**Bu bir araştırma raporu değildir.** Yeni literatür taraması yapılmadı. Bu, sekiz raporun kanıtını mühendislik kararına dönüştüren bir belge — seçenek üretmek değil, seçenekleri elemek.
**Durum:** Kod/schema/roadmap dosyası değiştirilmedi, commit/push yapılmadı, algoritma implement edilmedi. Bu sadece bir öneri — nihai kararı Mustafa (gerekirse ChatGPT ile karşılaştırdıktan sonra) verecek.
**Revizyon (2026-09-22):** Mustafa'nın ChatGPT ile yaptığı ilk karar turu (`notifyme_phase3_decision_notes.md`) sonrası 5 nokta düzeltildi: `weighted_milestones` → `milestone_based` (isim hesapla çelişiyordu), LEVEL/TREND'in tek, çelişkisiz formüle indirgenmesi ("EWMA-tabanlı LEVEL" ifadesi kaldırıldı), `persistenceWindow=3`'ün engineering-parameter olduğunun tabloda da netleştirilmesi, feedback-taksonomisinin kesin metninin kilitlenmediğinin açık belirtilmesi, re-baselining'de veri-altyapısı (MUST) ile görselleştirme (SHOULD) ayrımı. Ana mimari kararı değişmedi.

---

## 1. Executive Decision

**Ben Tasarım 1 için şu mimariyi öneriyorum:**

NotifyMe'nin çekirdeği, **rule-based, açıklanabilir bir "measurement → deviation detection → uncertainty-aware adaptation" motoru** olmalı — AI/ML/LLM yok, RL/bandit yok, Bayesian/Dempster-Shafer yok, Goal-seviyesinde olasılıksal forecast yok. Sistem üç bileşenden oluşuyor:

1. **Trajectory Engine** — natural-unit Goal'lerde LEVEL (`actual - expected` cumulative-workload farkı, lineer referans-trajektoriye göre, Earned-Schedule-düzeltmeli bir **engineering baseline** — EWMA'ya dayanmaz) + TREND (**EWMA-smoothed** son-dönem hızı); mastery/mixed-unit Goal'lerde sadece workload-progress (mastery/success sinyali asla sentezlenmez).
2. **Evidence & Deviation Layer** — sapma "kalıcı" olduğunda (tek gözlem değil, ardışık ≥3 dönem) tetiklenen, ordinal güven seviyeli (yüksek/orta/düşük — sayısal değil), NO_INTERVENTION/ASK_USER'ı birinci sınıf çıktı sayan bir karar katmanı.
3. **Adaptation Engine** — deterministic, sınırlı-adım (bounded), kullanıcı onayı zorunlu (öner/kabul/red/değiştir) bir kural motoru.

Bu üçü **AI değil, adaptif kontrol/istatistiksel sinyal-işleme** olarak çerçevelenmeli (Aşama 2A §20'nin kendi red-team sonucu) — "basit if/else" değil, 70+ yıllık EWMA/CUSUM/reject-option geleneğine dayanan, ama "öğrenilmiş" (trained) olmayan bir sistem. LLM, **sadece** opsiyonel serbest-metni yapılandırılmış kategoriye eşleyen dar bir bileşen olarak **future work**'e bırakılıyor — Tasarım 1'in ilk teslim edilecek sürümünde yok.

**Gerekçe (tek cümle):** Sekiz raporun ortak sonucu — küçük veri, tek kullanıcı, tek dönem kısıtında akademik olarak savunulabilir tek yol, karmaşık/öğrenilmiş bir model kurmak değil, **basit ama dürüst** bir mimari kurup onu sentetik senaryolarla titizce test etmektir; "AI var" demek hedef değil, "bu sistemin sınırlarını biliyoruz ve söylüyoruz" bilimsel olgunluğun kendisidir.

---

## 2. Problem Definition

Kullanıcının önerdiği tanım:

> "Süreklilik gerektiren hedeflerde yalnızca plan oluşturmak değil, planlanan ilerleme ile gerçekleşen ilerleme arasındaki farkı zaman içinde ölçmek, kalıcı sapmaları tespit etmek, sapmanın bağlamını kullanıcı geri bildirimiyle anlamlandırmak ve sonraki plan için açıklanabilir, kullanıcı kontrollü adaptasyon önerileri üretmek."

**Sekiz rapor bu tanımı büyük ölçüde destekliyor, iki yerde daraltıyor:**

1. **"Planlanan ilerleme ile gerçekleşen ilerleme arasındaki fark"** her Goal için aynı anlama gelmiyor (Cleanup C §9-11) — bazı Goal'lerde bu fark doğrudan ölçülebilir (natural-unit), bazılarında sadece **workload** farkı ölçülebilir, **gerçek ilerleme** (mastery) hiç ölçülemez (BKT'nin veri-gereksinimi NotifyMe'de asla karşılanmıyor). Tanım şuna daraltılmalı: *"planlanan **workload** ile gerçekleşen **workload** arasındaki farkı ölçmek — bazı Goal türlerinde bu fark doğrudan Goal başarısına karşılık gelir, bazılarında sadece bir proxy'dir ve öyle sunulmalıdır."*
2. **"Sapmanın bağlamını kullanıcı geri bildirimiyle anlamlandırmak"** — kullanıcının kendi anlatısı ground truth değil (2B, self-serving bias d=0.96; Cleanup A, discrepancy-as-signal). Tanım şuna daraltılmalı: *"...kullanıcı geri bildirimini, ölçülen davranışla birlikte, ikisi de fallible birer kanıt kaynağı olarak birleştirmek."*

**Kabul edilen, değişmeyen çekirdek:** closed-loop yapı (measure→adapt→measure), kullanıcı kontrolü zorunluluğu, açıklanabilirlik önceliği — bunlar sekiz raporda hiç sorgulanmadı, güçlü destekli.

---

## 3. Research → Architecture Traceability

| Mimari karar | Kaynak rapor(lar) |
|---|---|
| Rule-based (EMA/EWMA+eşik+sınırlı adım), RL/Bayesian/DS değil | 2A §6-13, §20; Cleanup A §8-9, §23 |
| LEVEL/TREND ayrımı, Earned-Schedule düzeltmesi | 2C §4, §8, §10; Cleanup C §18 |
| Meaningful deviation = kalıcılık aranmalı, tek gözlem yeterli değil (**ilke** literatür kaynaklı; `persistenceWindow=3` **sayısının kendisi** literatürden gelmiyor, engineering parameter) | 2A §7-8; Cleanup C §3 (RBF ilkesi — yalnızca ilkeyi destekliyor, sayıyı değil) |
| Uncertainty-aware rule system, ordinal confidence, NO_INTERVENTION/ASK_USER birinci sınıf | Cleanup A §11-12, §23 (Model B) |
| LLM yok (v1), varsa dar/hakem-olmayan rol | 2B §16-17; Cleanup A §25/1 (Authority Inversion); Cleanup B §13 |
| Feedback taksonomisi: 2x2 Weiner + task-difficulty + Diğer + Emin değilim, single-choice, sadece sapmada | Cleanup B §4-5, §10-11, §18 (Model Y) |
| Free-text opsiyonel + ayrı-adım, işlenmeden saklanır | Cleanup B §12, §18 |
| Re-baselining: versioned + segmented history, reset/recalculation değil | Cleanup C §3-4, §19 |
| Mixed-unit Goal: non-aggregated vector, tek yüzde değil | Cleanup C §6-8, §20 |
| Workload progress ≠ Goal outcome, mastery Goal'de sentetik skor yok | 2C §14, §18; 2D §19; Cleanup C §9-10 |
| Trajectory mesajı: descriptive/action-oriented, evaluative değil; zamanlama preparatory-phase | Cleanup C §13, §16 |
| Goal adjustment/disengagement = başarısızlık değil | Cleanup C §14-15 |
| Cloud/sync core değil, local-first yeterli | 2D §23 (Stage 0/Ia); genel semester-scope teması |
| Evaluation: Package A zorunlu, Package B opsiyonel, Package C önerilmiyor | 2D §27 |
| "Ablation" değil "component comparison" | 2D §24 |
| Capacity constraint (multi-goal) mimari kısıt olarak tanınmalı, RCPSP değil | 2C §16-17, §20; Cleanup C §17 |

---

## 4. Minimum Closed Loop

Kullanıcının önerdiği zincir değerlendirildi:

```
GOAL → PLAN → TASK/SESSION EXECUTION → MEASURED BEHAVIOR → LEVEL/TREND →
MEANINGFUL DEVIATION DETECTION → CONTEXTUAL FEEDBACK (gerektiğinde) →
UNCERTAINTY CHECK → ADAPT/NO_INTERVENTION/ASK_USER → RECOMMENDATION →
USER ACCEPT/REJECT/MODIFY → NEW PLAN → NEW OUTCOME
```

| Halka | Sınıf | Gerekçe |
|---|---|---|
| GOAL → PLAN → TASK EXECUTION | **ZORUNLU** | Zaten var (mevcut kod), Tasarım 1'in tabanı |
| MEASURED BEHAVIOR (planned/actual amount+duration) | **ZORUNLU** | Task modelinde `plannedAmount`/`actualAmount` var; `actualDuration` eksik, eklenmeli (§16) |
| LEVEL/TREND (natural-unit Goal'lerde) | **ZORUNLU** | Araştırmanın ana bulgusu, Tasarım 1'in bilimsel çekirdeği |
| LEVEL/TREND (mixed-unit/mastery Goal'lerde) | **ZORUNLU ama kısıtlı** — sadece workload boyutu, outcome boyutu yok | Cleanup C §9-10 |
| MEANINGFUL DEVIATION DETECTION | **ZORUNLU** | EWMA/CUSUM-lite + kalıcılık kuralı, deterministic test edilebilir |
| CONTEXTUAL FEEDBACK (yapılandırılmış, sadece sapmada) | **ZORUNLU** | Cleanup B'nin ana sonucu, düşük maliyetli |
| Free-text feedback | **ZORUNLU ama minimal** (opsiyonel, ayrı-adım, işlenmeden saklanır) | Cleanup B §12 — değer ölçülmüş, maliyet düşük tutulabilir |
| UNCERTAINTY CHECK (ordinal) | **ZORUNLU** | Cleanup A'nın çekirdek önerisi |
| ADAPT/NO_INTERVENTION/ASK_USER | **ZORUNLU** | Reject-option literatürü — düşük implementasyon maliyeti, yüksek bilimsel değer |
| RECOMMENDATION + ACCEPT/REJECT/MODIFY | **ZORUNLU** | Mixed-initiative ilkesi (2A §12), event log ucuz |
| Re-baselining (versioned+segmented) | **ZORUNLU** | Cleanup C — Goal parametreleri değişmeden gerçekçi bir sistem olmaz |
| LLM serbest-metin sınıflandırma | **OPSIYONEL/STRETCH** | 2B/Cleanup A/B — veri hacmi yetersiz, Authority Inversion riski |
| Capacity-aware multi-goal kısıtı (basit üst-sınır) | **OPSIYONEL** | Tam RCPSP değil, ama en az "toplam öneri kullanılabilir zamanı aşmasın" kısıtı |
| StudySession/timer (pasif süre ölçümü) | **OPSIYONEL** | Manuel `actualDuration` girişi yeterli minimum; timer UX iyileştirmesi |
| Blind-then-compare UX (Cleanup A §19) | **STRETCH** | Ampirik test edilmemiş öneri, ek sürtünme riski |
| Closed-loop mediation (öneri→sonraki performans nedensel ölçümü) | **FUTURE WORK** | 2D §16 — Tasarım 1 ölçeğinde istatistiksel olarak anlamsız |
| Population-based reliability learning | **FUTURE WORK** | Cleanup A §15 — popülasyon verisi yok |
| Dinamik taksonomi keşfi (otomatik) | **FUTURE WORK** | Cleanup B §14 — sadece manuel/periyodik inceleme v1'de |
| Multi-baseline SCED, gerçek N-of-1 nedensel iddia | **FUTURE WORK** | 2D §10-11 — WWC standardını karşılamıyor |
| Cloud/sync | **FUTURE WORK** | §18 aşağıda |

**Minimum defensible closed-loop**, tablo yukarıdaki "ZORUNLU" satırlarının tamamı — bunlardan biri eksik olursa closed-loop iddiası zayıflar; "OPSIYONEL"lerin hiçbiri Tasarım 1'in bilimsel iddiasını taşımıyor, sadece UX'i güçlendiriyor.

---

## 5. Goal Measurement Model

**Karar: (B) Tek Goal modeli + `measurementStrategy` alanı — ayrı Goal-type sınıf hiyerarşisi değil.**

Cleanup C §11 literatürün bu mimari soruyu (type vs strategy) doğrudan cevaplamadığını, ama measurement-strategy'nin muhtemelen daha az şema büyümesi gerektirdiğini not ediyor (mühendislik değerlendirmesi, doğrulanmış literatür sonucu değil). `Goal.measurementStrategy ∈ {natural_amount, milestone_based, proxy_unmeasured}`:

- **`natural_amount`** ("3000 soru çöz", "100km koş"): `targetAmount` + `unit` alanı zorunlu; progress = `Σ actualAmount / targetAmount`; LEVEL/TREND tam çalışır.
- **`milestone_based`** ("mobil uygulama geliştir" — task/milestone tabanlı; **isim düzeltildi** — önceki taslakta `weighted_milestones` deniyordu ama hesap `tamamlanan task/toplam task` idi, yani gerçekte **ağırlıksız**; "weighted" ismi hesapla çelişiyordu, Cleanup C §7-8'in kaçınmaya çalıştığı örtük eşit-ağırlıklandırma sorununu geri getiriyordu — 10 dakikalık task ile 8 saatlik task eşit sayılıyordu): varsayılan görünüm **non-aggregated** — tamamlanan/kalan milestone listesi, tek yüzde değil (aşağıdaki mixed-unit Model C' mantığının aynısı). Kullanıcı gerçekten kaba bir özet isterse **ikincil, açıkça etiketli** bir "X/Y görev tamamlandı" oranı ikinci görünüm olarak sunulabilir — ama bu oran hiçbir zaman "ağırlıklı" ya da "progress %" olarak adlandırılmaz, LEVEL/TREND'in birincil girdisi değildir. LEVEL/TREND bu Goal türünde task-count üzerinden **kısıtlı** çalışır, "false precision" riski açıkça etiketlenir.
- **`proxy_unmeasured`** ("Python öğren", "İngilizcemi geliştir"): `targetAmount` yok; sadece **workload progress** (harcanan saat/tamamlanan task) gösterilir, **hiçbir "mastery %" veya "başarı olasılığı" sentezlenmez** (Cleanup C §9-10, BKT'nin veri-gereksinimi karşılanmıyor).

**Mixed-unit Goal'ler (farklı birimdeki Task'lar aynı Goal altında):** Tek ağırlıklı yüzdeye **indirgenmez** (OECD/JRC Handbook, Cleanup C §6-8 — compensability varsayımı genellikle yanlış). Bunun yerine **Model C' — non-aggregated multi-dimensional**: her farklı-birim Task grubu (video saat / soru sayısı / proje sayısı) **ayrı bir boyut** olarak gösterilir (2-4 boyutla sınırlı, Balanced-Scorecard bulgusu — Cleanup C §8). Kullanıcı-tanımlı ağırlık (§10, seçenek C) **v1'de yok** — Handbook'un "ağırlık her zaman değer yargısıdır" uyarısı + kullanıcının kendi tahmininin de planning-fallacy'ye tabi olması (Cleanup C §7).

**Goal success terimi kullanılmaz.** Kullanıcıya ve kod içinde daima **"workload trajectory"** dili kullanılır — "Goal başarı olasılığı" veya benzeri bir dil **hiçbir Goal türünde** üretilmez (2C §12, §26; Cleanup C §12).

---

## 6. LEVEL / TREND

**LEVEL — "Şu anda planın neresindeyim?"** Tek, net formül: `LEVEL(t) = actual_cumulative_workload(t) - expected_cumulative_workload(t)`. `expected_cumulative_workload` başlangıçta **lineer bir referans-trajektori** (geniş tolerans bandıyla — S-curve karmaşıklığına girilmiyor, 2C §9); Earned-Schedule mantığıyla zaman-normalize edilir ki deadline'a yaklaşırken çıplak oranın yapay olarak "iyileşmesi" (klasik SPI hatası, 2C §8) engellensin. Bu, **gerçeğin kendisi değil, açıkça etiketli bir engineering baseline**'dır — LEVEL, EWMA'ya dayanmaz, EWMA'yı hiç kullanmaz.

**TREND — "Son dönemde hangi yöne/hızla ilerliyorum?"** Son N gözlem penceresinin (ör. son 7-14 gün) **EWMA-smoothed** hızı — `α` mühendislik parametresi, literatürden gelmiyor (2A §7), ama makul bir başlangıç değeri (0.3 civarı, inşaat-projesi analojisinden — doğrudan aktarılamaz, sadece başlangıç noktası) kodda **açıkça "engineering parameter" olarak etiketlenir**. EWMA **yalnızca TREND'e aittir** — "EWMA-tabanlı LEVEL" gibi bir ifade kullanılmaz, LEVEL ve TREND'in hesap kaynakları birbirine karıştırılmaz.

**Hangi Goal türlerinde çalışır:** `natural_amount` ve `milestone_based`'ta tam; `proxy_unmeasured`'da **sadece workload boyutunda** (ör. "bu hafta kaç saat çalıştın" trendini gösterebilir, ama "Python'da ne kadar iyileştin" trendini göstermez).

**"Tek kötü güne" karşı korunma:** EMA'nın kendisi yeterli değil (2A §7) — deviation-detection katmanı (§7 aşağıda) ayrı bir kalıcılık kuralı taşır. EWMA/CUSUM'un tam matematiği (Schat ve ark. 2021) Tasarım 1'de **hafifletilmiş** biçimde kullanılır: tam CUSUM kontrol-limiti hesabı yerine, "TREND N ardışık dönemde negatif" gibi basit bir kural — bu, akademik gerekçesi olan ama uygulaması ucuz bir orta yol.

---

## 7. Deviation Detection

Sistem "burada gerçekten bir sapma var" demeden önce:

1. **One-off deviation** → hiçbir aksiyon, log'lanır ama kullanıcıya gösterilmez.
2. **Persistent deviation** (LEVEL negatif VE TREND negatif, **≥3 ardışık gözlem penceresi** — Cleanup C §3'teki RBF ilkesiyle, 2A'nın EWMA/CUSUM mantığıyla tutarlı) → **meaningful deviation**, CONTEXTUAL FEEDBACK tetiklenir.
3. **Capacity mismatch** (kullanıcının `availability`'si workload'u zaten aşıyor) → ayrı bir tetikleyici, CAUSE sorusuna gerek yok (sebep zaten biliniyor), doğrudan ADAPT/ASK_USER.

Sayısal eşik (kaç gün, ne kadar sapma) **literatürden gelmiyor** — açıkça "engineering parameter (ampirik kalibrasyona açık)" olarak etiketlenir, kesin sayı üretilmedi (2A §9, Cleanup C §3'ün kendi uyarısı — "neden 90 neden 70" döngüsüne girilmiyor).

---

## 8. Feedback Model

**Model Y (Cleanup B §18)** benimsenir:

- **Taksonomi (mimari kilitli, metin/sayı KİLİTLİ DEĞİL):** İskelet — Weiner'ın 2x2'si (İçsel×Dışsal × Kontrol-edilebilir/edilemez → 4 kategori) + task-difficulty (ayrı bir kategori) + "Diğer" + "Emin değilim". Aşağıdaki 7 kategori ve Türkçe metinler ("Odaklanamadım/erteledim", "Enerjim/sağlığım düşüktü", "Görev tanımını/planı iyi yapmadım", "Beklenmedik bir şey çıktı", "Görev beklediğimden zordu", "Diğer", "Emin değilim") **sadece taslak/örnektir** — kesin kategori sayısı (4-7 aralığında olabilir) ve kullanıcı-facing metinler **remaining engineering decision**'dır (§27), bu belgede final kabul edilmiyor. Kilitli olan yalnızca **mimari**: single-choice, Weiner-temelli + task-difficulty + Diğer + Emin-değilim yapısı.
- **Single-choice.** Çok-nedenli durumlar free-text'e devredilir (§11, Cleanup B).
- **Trigger:** sadece §7'deki "meaningful deviation"da. Outcome zaten `TaskStatus`'tan türetiliyor — kullanıcıya tekrar "tamamladın mı" sorulmaz.
- **Tekrar bastırma:** aynı kategori ≥3 kez üst üste seçilirse, düşük-yüklü confirmation'a geçilir ("Yine mi zaman yetmedi? [Evet/Hayır]") — JITA-EMA/Ask-Less-Learn-More ilkesi (Cleanup B §8-9).
- **Free-text:** opsiyonel, **ayrı bir adımda** (kategori seçiminden sonra, gömülü değil — Luebker'in ölçtüğü maliyet farkı), sadece saklanır, **işlenmez** (LLM/kural yok v1'de). Periyodik (ör. aylık) manuel inceleme, "Diğer" temalarının tekrarını kontrol eder — taksonomi revizyonu için insan-elle girdi (Cleanup B §14).

---

## 9. Evidence / Uncertainty

**Model B (Cleanup A §23)** benimsenir — Uncertainty-Aware Rule System:

- Terminoloji: `actualAmount`/`actualDuration` **"observed/measured behavioral signal"**, feedback kategorisi **"self-reported signal"** — ikisi de kanıt, hiçbiri ground truth (Cleanup A §3).
- Güven **ordinal** (yüksek/orta/düşük), asla sayısal olasılık — sabit ağırlık (0.7/0.3 gibi) kullanılmaz (kalibrasyon önkoşulu yok).
- Karar mantığı: tek gözlem + düşük güven → **NO_INTERVENTION**; kalıcı sapma + tutarlı self-report → **ADAPT**; güçlü çelişki (davranışsal veri güçlü X diyor, self-report güçlü Y diyor) → **ASK_USER** veya ertele; yetersiz kanıt → **NO_INTERVENTION**.
- **Discrepancy-as-signal:** çelişki zorla çözülmez, kendisi bir sinyal olarak taşınır ve gerekirse açıkça kullanıcıya gösterilir ("Verilerine göre X, sen Y dedin — bu ikisi arasındaki fark ilginç, birlikte bakalım mı?").
- **Self-report'a asla sıfır ağırlık verilmez** (feedback-loop degenerasyon riski, Cleanup A §20) — periyodik "tam ağırlık" yeniden-test.
- **Cold start:** conservative/Model-A-benzeri (sabit öncelik, davranışsal veri öncelikli) davranış, veri biriktikçe kademeli geçiş.
- **Kullanıcıya confidence gösterimi:** asla ham yüzde ("%73 eminiz" YOK) — en fazla kategorik etiket ("emin değiliz"), Cleanup A §18'in ölçülmüş zarar bulgusu gereği.

---

## 10. Adaptation Engine

**Karar: (A/B hibrit) Deterministic rules, statistical-lite (EWMA/threshold) — ML/LLM/RL değil.**

| Aday | Değerlendirme |
|---|---|
| A) Deterministic rules | Temel — açıklanabilir, az veri, hızlı test edilebilir |
| B) Statistical/rule hybrid | **Seçilen** — A + EWMA/TREND (§6) ile zenginleştirilmiş |
| C) ML model | Reddedildi — eğitim verisi yok, tek kullanıcı |
| D) LLM-driven adaptation | Reddedildi — Authority Inversion riski (Cleanup A §25/1), kararın kendisini LLM'e bırakmak asla önerilmiyor |
| E) RL/contextual bandit | Reddedildi — HeartSteps'in kendi veri ihtiyacı (44 kullanıcı×binlerce karar) NotifyMe'nin bir kesri bile değil (2A §11) |

**Girdiler:** LEVEL, TREND, CAUSE kategorisi (ordinal güvenle), historical-reliability sayacı, capacity/availability (varsa).
**Çıktılar:** `ADAPT` (workload/süre önerisi, task-split önerisi, deadline-güncelleme önerisi) / `NO_INTERVENTION` / `ASK_USER`.

**CAUSE→RESPONSE eşleştirmesi** (2B §14'ten miras, **açıkça "engineering hypothesis"** etiketiyle — literatür doğrudan doğrulamıyor):

| CAUSE | Response |
|---|---|
| Odaklanamadım/erteledim | Genelde NO_INTERVENTION (workload artırma **etme**) |
| Enerjim/sağlığım düşüktü | NO_INTERVENTION, tekrarlarsa ASK_USER |
| Görev tanımını/planı iyi yapmadım | Tahmin/süre güncelleme önerisi (estimation-error yolu) |
| Beklenmedik bir şey çıktı | Availability güncelleme önerisi, workload artırma **değil** |
| Görev beklediğimden zordu | Görev bölme / süre-tahmini artırma önerisi |
| Diğer / Emin değilim | NO_INTERVENTION (yetersiz kanıt) |

Bu matrisin hiçbir hücresi "kanıtlanmış gerçek" olarak sunulmaz — Weiner'ın genel mantığından türetilmiş, ampirik doğrulanmamış bir mühendislik hipotezi (2B §14, §17-N).

---

## 11. Capacity Constraints

RCPSP'nin tam formalizmi **kullanılmıyor** (2C §16 — NP-hard, endüstriyel ölçek için, NotifyMe için aşırı). Minimum kısıt: eğer kullanıcının birden fazla aktif Goal'ü varsa, adaptation engine **tek bir Goal'ü izole optimize etmez** — önerilen toplam workload artışı, `availability` (varsa, FAZ2+'da eklenir) sınırını **aşamaz**. Bu, Kruglanski'nin counterfinality bulgusunun (2C §20) mimari karşılığı: bir Goal'e "daha çok çalış" önerisi, diğer Goal'lerin zaman bütçesini görmeden verilmez.

`availability` verisi **mevcut şemada henüz yok** — Phase 3'ün bir sonucu olarak eklenmesi gereken bir alan (§16).

---

## 12. Re-Baselining

**Karar: Versioned Baseline + Segmented History birlikte (Cleanup C §19, seçenek B+C).**

- **Tetikleyici:** `Goal.targetAmount`, `deadline`, veya `successCriterion` (measurementStrategy) değişikliği — yani Goal'ün **tanımının** değişmesi (§5'teki Scope Change ayrımı). Performance deviation (aynı tanım altında beklenenden sapma) rebaseline **tetiklemez**, normal TREND güncellemesidir.
- **Mekanizma:** eski segment'in LEVEL/TREND geçmişi **silinmez**, "donmuş" bir `BaselineVersion` kaydına taşınır; yeni segment kendi başlangıcından (yeni `targetAmount`, mevcut tarih) bağımsız bir LEVEL/TREND hesabı başlatır. Kullanıcıya gösterilen genel trajectory, iki (veya daha fazla) segmentin **ayrıştırılabilir birleşik görünümü**.
- **Full reset ve "recalculation" (geçmişi yeni beklentiyle yeniden yorumlama) reddedildi** — segmented-regression literatürü (Cleanup C §4) ikisinin de epistemik olarak sorunlu olduğunu gösteriyor.
- **Kapsam ayrımı (§20):** MUST HAVE olan yalnızca **veri altyapısı** — `BaselineVersion` tablosu ve doğru segment-ayırma mantığının kendisi. Segmentleri kullanıcıya gösteren **gelişmiş görselleştirme** (ör. grafikte eski/yeni segment ayrımını görsel olarak vurgulayan bir UI) SHOULD HAVE'dir; veri doğru tutulduğu sürece, v1'de basit/düz bir liste görünümü yeterlidir.

---

## 13. Trajectory Messaging

- **LEVEL/TREND internal sinyal**, kullanıcıya ham olarak gösterilmez.
- **Framing:** descriptive ("Son 7 gündeki hızın mevcut planın altında") veya action-oriented ("Bu hız devam ederse haftalık yükü yeniden düzenlemek gerekebilir") — **evaluative** ("Geridesin!"/"Öndesin!") framing **kullanılmaz**, çünkü hem coasting (Thürmer/Fulford, Cleanup C §13) hem disengagement (Wrosch, Cleanup C §14) riski taşıyor.
- **Zamanlama:** pozitif geri bildirim (kullanıcı öndeyken) **immediate değil**, kullanıcı bir sonraki task/session'a başlarken (preparatory phase) gösterilir — Jostmann & Brummelman (2025) bulgusu, ampirik olarak NotifyMe'de test edilmemiş ama üç bağımsız kaynaktan türetilen somut bir tasarım kısıtı.
- **Progress göstergesi her zaman gösterilmez** — eğer ilerleme zaten kullanıcı için belirginse (basit, sık kontrol edilen natural-unit Goal), ekstra bir gösterge "complacency" (Cheema & Bagchi) riski taşıyabilir; belirsiz/karmaşık Goal'lerde (mastery-tipi) gösterge daha faydalı olabilir — bu ayrım v1'de basit bir sezgisel kural olarak (Goal check-in sıklığına göre) uygulanabilir, kesin bir algoritma önerilmiyor (future work).
- **Goal adjustment/disengagement asla "başarısızlık" olarak kodlanmaz** — `GoalStatus.abandoned` zaten mevcut şemada var (iyi bir kazara-doğru karar), UI'da nötr/destekleyici dille sunulmalı.

---

## 14. AI / ML / LLM Decision

| Aday | Gerçek problem | Gerekli veri | Evaluation | Explainability | Maliyet | Akademik değer | Risk | Karar |
|---|---|---|---|---|---|---|---|---|
| LLM free-text classification | Serbest metni kategoriye eşleme | 200-500 örnek doygunluk (2B), NotifyMe'de yok | Zayıf (küçük etiketli set) | Orta | Orta | Düşük-orta | Authority Inversion (Cleanup A) | **Future work / stretch, v1'de yok** |
| LLM recommendation generation | Öneri metni üretme | — | Test edilemez (subjektif kalite) | Düşük | Orta | Düşük | Karar-verici LLM = reddedilen D seçeneği (§10) | **Reddedildi** |
| ML deviation detection | Değişim tespiti | Büyük etiketli seri | — | Düşük | Yüksek | Düşük (EWMA/CUSUM zaten yeterli, 2A) | Gereksiz karmaşıklık | **Reddedildi** |
| ML personalization | Kullanıcı-özgü kalibrasyon | Popülasyon verisi (IntelligentPooling) | — | — | Yüksek | Yüksek (teoride) | Önkoşul yok | **Future work** |
| RL adaptation | Politika öğrenme | Binlerce karar noktası (HeartSteps) | — | Düşük | Çok yüksek | Düşük (mevcut ölçekte) | Akademik olarak savunulamaz (2A §11) | **Reddedildi** |
| No-AI / statistical-rule system | §6-10'daki sistemin kendisi | Sentetik yeterli | Güçlü (Package A) | Yüksek | Düşük | **Yüksek — dürüstlüğün kendisi akademik değer** | Düşük | **SEÇİLEN** |

**Sonuç: Tasarım 1'in ilk sürümünde AI/ML/LLM yok.** Bu, eksiklik değil, sekiz raporun ortak, kanıt-temelli sonucu. Eğer hocaya "nerede AI var" sorusuna cevap gerekiyorsa (§22), cevap: "bilinçli olarak yok — literatür, bu ölçekte AI/ML'in false-precision ve Authority-Inversion riski taşıdığını, rule-based bir sistemin hem daha savunulabilir hem daha test edilebilir olduğunu gösteriyor; adaptif kontrol/istatistiksel sinyal-işleme (EWMA/CUSUM ailesi) kullanılıyor, bu da kendi başına önemsiz bir teknik değil." RAG kelimesi **hiç kullanılmıyor** — hiçbir retrieval mimarisi yok.

---

## 15. Performance Profile

FAZ4'te düşünülen Performance Profile, Tasarım 1 çekirdeğine şu minimumla giriyor (fazlası nice-to-have):

**Zorunlu (adaptation engine'in doğrudan girdisi):**
- Completion rate (task-seviyesi)
- Planned vs actual duration/amount (mevcut `plannedAmount`/`actualAmount`'tan, `actualDuration` eklenerek)
- Postponement/overdue sayısı
- Workload velocity (TREND'in kendisi, §6)

**Nice-to-have (v1'de opsiyonel):**
- Estimation accuracy (gelecek tahminlerini kalibre etmek için — planning-fallacy düzeltmesi, future work'e yakın)
- Category-bazlı performans (birden fazla Goal kategorisi arası karşılaştırma — popülasyon/zaman verisi gerektirir, erken aşamada anlamsız)

Performance Profile, **ayrı bir persistent tablo olarak DEĞİL**, mevcut Task/Goal verisinden **hesaplanan bir görünüm (computed view)** olarak tutulmalı — şema şişirmemek için (§16).

---

## 16. Conceptual Data Model

Mevcut: `UserProfile`, `Goal` (title/description/category/priority/deadline/status), `TaskEntity` (goalId/title/scheduledAt/plannedDuration/plannedAmount/unit/actualAmount/priority/status/completedAt). **`actualDuration` eksik** — Task tamamlanma süresini ölçen tek alan yok, sadece `plannedDuration` var. Bu, §6-8'in doğrudan girdisi olduğu için **eklenmesi gerekiyor**.

| Entity | Amaç | Minimum önemli alanlar | Hangi fazda |
|---|---|---|---|
| `Goal` (genişletilmiş) | Mevcut + ölçüm stratejisi | + `measurementStrategy` (enum), + `targetAmount`/`unit` (nullable, sadece natural_amount'ta) | FAZ1 (GoalDetailPage ile birlikte) |
| `TaskEntity` (genişletilmiş) | Mevcut + gerçekleşen süre | + `actualDuration` (int, nullable) | FAZ1-2 arası |
| `BaselineVersion` | Rebaseline geçmişi | `goalId`, `effectiveFrom`, `targetAmount`, `deadline`, `reason` (free-text, kullanıcı girer) | FAZ2 (Trajectory core) |
| `Feedback` | CAUSE + free-text kaydı | `taskId`/`goalId`, `causeCategory` (enum, §8), `freeText` (nullable), `createdAt` | FAZ2 |
| `Recommendation` | Öneri + kullanıcı yanıtı | `goalId`, `type` (ADAPT/ASK_USER), `payload` (öneri detayı), `status` (pending/accepted/rejected/modified), `createdAt`, `respondedAt` | FAZ2 |
| `StudySession` | Pasif süre ölçümü (timer) | `taskId`, `startedAt`, `endedAt` | FAZ3 (opsiyonel — manuel `actualDuration` girişi FAZ2'de zaten yeterli) |
| `PerformanceProfile` | — | **Ayrı tablo DEĞİL** — computed view | — |
| `UserProfile.availability` | Kullanılabilir zaman (§11) | basit haftalık saat tahmini (nullable) | FAZ2 |

Gereksiz entity üretilmedi — 5 yeni tablo (Goal/Task genişletmesi hariç), her biri doğrudan bir mimari kararın (rebaselining, feedback, adaptation) girdisi.

---

## 17. Technical Architecture

```
Flutter UI (screens/)
    ↓
Services / Repositories (mevcut GoalService/TaskService deseni korunur)
    ↓
Local Persistence (SQLite, mevcut AppDatabase — şema genişletilir)
    ↓
Measurement Engine — Task/Goal verisinden workload progress hesaplar (§5)
    ↓
Trajectory Engine — LEVEL/TREND hesaplar, measurementStrategy'ye göre davranır (§6)
    ↓
Deviation Detector — kalıcılık kuralıyla "meaningful deviation" kararı verir (§7)
    ↓
Feedback / Evidence Layer — CAUSE taksonomisi + ordinal confidence + discrepancy tespiti (§8-9)
    ↓
Adaptation Engine — ADAPT/NO_INTERVENTION/ASK_USER kararı, CAUSE→RESPONSE eşleştirmesi (§10-11)
    ↓
Recommendation Layer — UI'a öneri sunar, accept/reject/modify yakalar, Recommendation tablosuna yazar
```

Her katman **bağımsız test edilebilir** (Package A'nın temel varsayımı, §19) — bu, mevcut `GoalService`/`TaskService`/`GoalRepository`/`TaskRepository` deseninin doğal bir uzantısı, mimari devrim değil.

---

## 18. Local / Cloud Decision

**Cloud, Tasarım 1'in adaptif sistemi için gerekli değil.** LEVEL/TREND, deviation detection, adaptation engine — hepsi tek-cihaz, tek-kullanıcı SQLite verisiyle çalışır. 2D §23'ün ORBIT/Stage-0/Ia konumlandırması ("mekanizma feasibility'si", büyük deployment değil) bunu doğruluyor. FAZ6 (hesap/bulut senkron) **açık biçimde future work** — mevcut roadmap'teki "opsiyonel" etiketi zaten doğru, değişmiyor.

---

## 19. Evaluation Strategy

**ZORUNLU — Package A (2D §27):**

- Unit test seti: LEVEL/TREND hesaplama doğruluğu, bounded-adaptation ihlali sayısı, re-baseline segment-ayırma doğruluğu.
- Sentetik senaryo üreteci: bilinen değişim noktası enjekte edilmiş seri → algoritmanın tespit gecikmesini (EDD benzeri) ve yanlış-alarm oranını (ARL benzeri) ölçmek (2D §7, Schat ve ark. 2021 şablonu).
- MYCIN-tarzı duyarlılık testi (Cleanup A §11, §22): ordinal confidence parametrelerini pertürbe et, nihai ADAPT/NO_INTERVENTION/ASK_USER kararının kaç kez değiştiğini ölç — karar sınırlarının küçük parametre değişikliklerine duyarsız (robust) olduğunu göstermek.
- Cleanup C §21'deki senaryo listesi: history preservation, scope-change sonrası yanlış performans cezası olmaması, LEVEL/TREND continuity, capacity constraint saygısı, geçersiz-birim toplamasının engellenmiş olması.

**Her testin desteklediği claim, `notifyme_academic_evaluation_phase2d.md` §5'teki Claim→Evidence matrisiyle birebir eşleşmeli** — rapor/sunumda bu eşleşme açıkça gösterilmeli.

**OPSİYONEL — Package B unsurları (kaynak izin verirse):**
- 5-15 kişilik formative usability pilotu, **UMUX-LITE** (2 madde, düşük yük — 2D §13'ün önerdiği birincil aday; SUS ikincil).
- Cognitive walkthrough/heuristic evaluation (gerçek kullanıcı gerekmez, düşük maliyetli).

**NE KANITLANAMAZ (2D §30'un birebir aktarımı):**
- "NotifyMe kullanıcıların sonraki performansını iyileştirir" — SCED minimum 3 replikasyon gerektirir (WWC), yok.
- "NotifyMe kullanıcıların Goal başarı oranını artırır" — RCT/büyük-N gerektirir (ORBIT Stage II+), kesinlikle yok.
- "Acceptance rate X% → öneriler kaliteli" — appropriate-reliance'tan ayrıştırılamaz.
- "SUS/UMUX skoru Y → davranışsal olarak etkili" — farklı construct.
- "5-15 kişilik pilot → genel kullanıcı kitlesinde işe yarar" — Faulkner/Spool güven aralığı bunu engelliyor.
- "Sentetik test sonucu → gerçek kullanıcı davranışını temsil eder" — tanım gereği hayır.

---

## 20. Semester Scope

**MUST HAVE:**
- Goal'e `measurementStrategy`/`targetAmount` eklenmesi, GoalDetailPage (mevcut FAZ1'in devamı).
- `TaskEntity.actualDuration` eklenmesi.
- Trajectory Engine (LEVEL/TREND, natural_amount + milestone_based için).
- Deviation Detector (kalıcılık kuralı).
- Feedback taksonomisi + UI (Model Y — **mimari kilitli**: single-choice, Weiner-temelli + task-difficulty + Diğer + Emin-değilim, free-text opsiyonel-ayrı-adım, LLM yok; **kesin kategori sayısı/Türkçe metinleri kilitli değil**, remaining engineering decision, §27).
- Evidence/Uncertainty katmanı (ordinal confidence, NO_INTERVENTION/ASK_USER — kavramsal mantık MUST, uygulamanın inceliği [ör. kaç seviyeli ordinal, discrepancy-UX'in detayı] kapsam baskısı olursa sadeleştirilebilir).
- Adaptation Engine (rule-based, CAUSE→RESPONSE matrisi, bounded step).
- Recommendation + accept/reject/modify UI.
- Re-baselining — **sadece veri altyapısı**: `BaselineVersion` tablosu + doğru segment-ayırma mantığı (gelişmiş segment-görselleştirme SHOULD HAVE'de, aşağıda).
- Package A evaluation (unit test + sentetik senaryo seti).

**SHOULD HAVE:**
- `UserProfile.availability` + basit capacity-aware kısıt (§11).
- Mixed-unit Goal'lerde non-aggregated (vector) gösterim (§5).
- 5-15 kişilik formative usability pilotu (Package B).
- Trajectory messaging'in zamanlama/framing kuralları (preparatory-phase, descriptive dil).
- Gelişmiş segmented-history visualization (re-baselining'in veri modeli MUST HAVE'de, görsel katmanı burada).
- StudySession/timer (manuel `actualDuration` yeterli minimum, timer UX katmanı).

**FUTURE WORK:**
- LLM serbest-metin sınıflandırma.
- Population-based reliability learning.
- Otomatik/dinamik taksonomi keşfi.
- Multi-baseline SCED, gerçek nedensel iddia.
- Cloud/sync (FAZ6).
- Blind-then-compare UX testi.
- Closed-loop mediation analizi.

MUST HAVE listesi zaten Tasarım 1'in tek başına akademik olarak savunulabilir minimumu — SHOULD HAVE'lerin hiçbiri olmadan bile proje "Stage 0/Ia feasibility" iddiasını taşıyabilir.

---

## 21. Revised Roadmap Proposal

Mevcut roadmap (`notifyme/README.md`): FAZ1 (persistence/Goal/Task) → FAZ2 (notifications) → FAZ3 (timer/StudySession) → FAZ4 (Performance Profile) → FAZ5 (Adaptive Planning) → FAZ6 (cloud).

**Bu sırayla ilerlemek, Tasarım 1'in bilimsel çekirdeğini (adaptasyon motoru) en sona bırakıyor** — jüri açısından risk: dönem sonunda zaman kalmazsa, en akademik-değerli kısım hiç bitmez, sadece bir bildirim/timer uygulaması teslim edilir. Önerilen revizyon:

| Yeni sıra | İçerik | Not |
|---|---|---|
| **FAZ 1** (devam) | Persistence + GoalDetailPage + `measurementStrategy`/`targetAmount`/`actualDuration` | Mevcut, sadece Goal-workload alanları eklenir |
| **FAZ 2 (yeniden adlandırıldı) — "Adaptif Çekirdek"** | Trajectory Engine + Deviation Detector + Feedback taksonomisi + Evidence/Uncertainty + Adaptation Engine + Recommendation UI + Re-baselining | **Bildirimlerden ÖNCE** — bu, Tasarım 1'in asıl değerlendirileceği kısım |
| **FAZ 3** | Yerel bildirimler (mevcut FAZ2) | UX katmanı, akademik risk düşük, ertelenebilir |
| **FAZ 4** | Timer/StudySession (mevcut FAZ3) | Opsiyonel — manuel giriş zaten FAZ2'de yeterli |
| **FAZ 5 (küçültüldü)** | Performance Profile UI (hesaplama zaten FAZ2'de var — bu sadece görselleştirme) | Ayrı büyük faz olmaktan çıkıyor |
| **FAZ 6** (değişmedi) | Cloud/sync, opsiyonel | Future work |

Bu bir **zorunlu değişiklik değil**, önerilir çünkü sekiz raporun ortak sonucu (adaptasyon motoru = bilimsel çekirdek) mevcut roadmap'te en sona, en riskli konuma yerleştirilmiş. Dosya değiştirilmedi (talimat gereği), bu sadece bir öneri.

---

## 22. Advisor Defense

1. **"Bu uygulama Todoist/Motion'dan ne fark ediyor?"** — Onlar otomatik zamanlama optimizasyonu yapıyor (Motion/Reclaim), biz workload-trajectory + kalıcı-sapma tespiti + kullanıcı-onaylı kademeli öneri döngüsü yapıyoruz; bu üçlünün birlikte var olduğu ticari ürün bulunamadı (Phase 1 §4-C).
2. **"Teknik olarak zor kısmı ne?"** — Küçük/gürültülü/tek-kullanıcı veriyle, "tek kötü gün" ile "gerçek örüntü"yü ayırt etmek (EWMA/CUSUM), çelişkili kanıt kaynaklarını (davranış vs self-report) false-precision üretmeden birleştirmek, ve Goal'ün ne zaman gerçekten ölçülebilir ne zaman sadece proxy olduğunu ayırt etmek.
3. **"Algoritma tam olarak ne yapıyor?"** — EWMA-tabanlı trend takibi + kalıcılık-eşiği ile sapma tespiti + ordinal-güvenli kural tabanlı karar (ADAPT/NO_INTERVENTION/ASK_USER). Bu bir "if/else" değil, 70+ yıllık istatistiksel süreç kontrolü (SPC) geleneğinin küçük ölçekli uygulaması.
4. **"Nerede AI var?"** — Tasarım 1'in ilk sürümünde yok, bilinçli olarak.
5. **"AI yoksa neden?"** — Çünkü literatür (8 rapor) bu ölçekte (tek kullanıcı, az veri, bir dönem) AI/ML/LLM'in ya veri açlığından çalışmayacağını ya da (LLM özelinde) sistematik yanlılık (Authority Inversion) taşıdığını gösteriyor; rule-based sistem hem daha test edilebilir hem daha açıklanabilir.
6. **"Bu sistemin çalıştığını nasıl göstereceksin?"** — Package A: sentetik senaryolarla algoritma correctness/robustness/bounded-adaptation; ne kanıtlayamayacağımı da (davranışsal etki, Goal başarı artışı) açıkça söylüyorum.
7. **"Hangi veriyi kullanıyorsun?"** — Kullanıcının kendi planned/actual workload+süre verisi + yapılandırılmış CAUSE geri bildirimi; ikisi de "kanıt", hiçbiri "ground truth" değil.
8. **"Bir dönem içinde gerçekten yetişir mi?"** — MUST HAVE listesi (§20) mevcut kod tabanının doğal bir uzantısı, yeni bir framework/mimari devrimi gerektirmiyor; en riskli kısım (adaptasyon motoru) roadmap'te öne alındı (§21).
9. **"Kullanıcı feedback'i yanlışsa ne olacak?"** — Sistem self-report'u ground truth saymıyor; davranışsal veriyle çelişirse discrepancy bir sinyal olarak taşınıyor, otomatik "kullanıcı yanlış" kararı verilmiyor.
10. **"Goal ilerlemesini nasıl ölçüyorsun?"** — Goal türüne göre değişiyor: doğal-birimli Goal'lerde doğrudan, karma-birimli Goal'lerde ayrı boyutlar halinde, mastery-tipi Goal'lerde sadece workload (mastery hiç sentezlenmiyor).
11. **"Neden basit bir if/else sistemi değil?"** — EWMA/CUSUM/reject-option, SPC ve ML literatüründe 50-70 yıllık, matematiksel temeli olan tekniklerdir; "basit" olmaları "temelsiz" oldukları anlamına gelmiyor (2A §20'nin kendi savunması).
12. **"Bunun bilimsel tarafı nerede?"** — Sekiz raporun her kararı bir literatür kaynağına bağlanıyor (§3 traceability tablosu); hangi iddiaların desteklenip hangilerinin desteklenmediği (§19) açıkça ayrıştırılmış — bu ayrımın kendisi bilimsel olgunluğun göstergesi.

**Not — advisor-facing risk, mimari kararı değil:** Madde 1'deki Phase 1 rakip-ürün bulguları (Phase 1 §4) bu belgede tek cümlede geçiyor; Burakhan Hoca ile gerçek görüşmede bu bulgular **ayrıca ve daha belirgin biçimde öne çıkarılmalı** — piyasadaki planlayıcıların hangi yetenekleri zaten yaptığı, NotifyMe'nin hangi kombinasyonu (measurement→persistent-deviation→contextual-evidence→user-controlled-adaptation→re-measure closed-loop) farklı ele aldığı, ve novelty'nin "AI planner" olmadığı dürüstçe anlatılmalı. Bu, mimariyi değiştiren bir karar değil — sunum/pozisyonlama stratejisi, muhtemelen ayrı bir "hoca görüşmesi hazırlık notu"na ait.

---

## 23. Red Team

| Risk | Severity | Neden | Mitigasyon |
|---|---|---|---|
| Overengineering (7 yeni tablo, çok katmanlı motor) | Orta | Tek dönem, tek geliştirici | Entity sayısı zaten minimize edildi (§16); PerformanceProfile tablo değil view |
| Underengineering (hoca "sadece bir planlayıcı" görebilir) | Orta-Yüksek | AI yok, karmaşık algoritma yok | §22 madde 3/11'deki teknik savunma; component comparison (§19) katkıyı ölçülebilir kılıyor |
| Fake AI ("AI var" demek ama içi boş) | Düşük (bu mimaride) | AI zaten yok, iddia edilmiyor | Zaten kaçınılıyor — bu riskin tersi (AI yokluğunu savunmak) asıl risk |
| Çok fazla özellik | Orta | MUST HAVE listesi geniş görünebilir | §20'de net MUST/SHOULD/FUTURE ayrımı; MUST HAVE tek başına savunulabilir |
| Keyfi eşikler (α, kalıcılık N, deviation %) | Yüksek | Literatür kesin sayı vermiyor (tekrarlayan tema) | Her parametre kodda "engineering parameter" olarak etiketlenmeli, sunumda saklanmamalı |
| False precision | Yüksek | Mixed-unit/mastery Goal'lerde tek sayıya indirgeme cazibesi | §5'in non-aggregated/proxy kararları zaten bunu önlüyor — uygulamada sapılmamalı |
| Yetersiz veri | Yüksek (yapısal) | Tek kullanıcı, tek dönem | Package A zaten bunu kabul ediyor, davranışsal iddia yapılmıyor |
| Kullanıcı yükü (burden) | Orta | Feedback + free-text + öneri onayı | §8'deki bastırma mekanizması + sadece-sapmada-sor ilkesi |
| Self-report bias | Yüksek | d=0.96 self-serving bias | §9'daki discrepancy-as-signal + asla tek başına ground truth sayılmaması |
| Proxy gaming | Orta | Kullanıcı kolay Task'ları şişirebilir | §5'teki non-aggregated gösterim + "workload≠success" dili gaming'in ödülünü azaltıyor |
| Scope creep | Orta | Araştırma 8 rapor, çok geniş bir alan kapsıyor | §20'nin MUST HAVE'i dar tutuldu; SHOULD/FUTURE açıkça ayrıldı |
| Evaluation'ın zayıf olması | Yüksek (yapısal, kabul edilmiş) | Tasarım 1 ölçeği | §19'da açıkça "ne kanıtlanamaz" listesi — zayıflığı gizlemek yerine adlandırmak |
| Algoritmanın "süslü if/else" olarak görülmesi | Orta | Kural-tabanlı sistem basit görünebilir | §22 madde 11'deki tarihsel/akademik savunma (SPC, reject-option) |
| Bir dönemde yetişmeme | Orta-Yüksek | 9 yeni entity/katman | §21'deki roadmap revizyonu — çekirdek öne alınıyor, StudySession/cloud ertelenebilir |
| Hocanın basit planlayıcı algısı | Orta | UI görünüşte Todoist'e benzeyebilir | §22 madde 1 — konumlandırma net: fark UI'da değil, ölçüm+adaptasyon döngüsünde |

---

## 24. Recommended Architecture

**Özet (tekrar, §1'in gerekçeli hali):** Rule-based, üç katmanlı (Trajectory Engine / Evidence & Deviation Layer / Adaptation Engine) bir adaptif sistem; ordinal-güvenli, açıklanabilir, kullanıcı-onaylı; Goal ölçüm stratejisine göre davranışını değiştiren (natural/weighted/proxy); re-baselining'i geçmişi silmeden segmentleyen; trajectory mesajını psikolojik riske (coasting/disengagement) göre zamanlayan ve çerçeveleyen; AI/ML/LLM'i v1'de içermeyen; evaluation'ını Package A'ya (sentetik+unit test) dayandıran, davranışsal/populasyon iddialarından açıkça kaçınan bir mimari. Bu, sekiz araştırma raporunun ortak, tekrar eden sonucudur — ayrı ayrı hiçbiri "karmaşık ve iddialı bir model kurun" demiyor, hepsi "basit, dürüst, test edilebilir bir sistem kurun ve sınırlarını açıkça söyleyin" diyor.

---

## 25. Implementation Order

Mevcut durum: **FAZ 1 Step 7 — GoalDetailPage, henüz başlanmadı** (doğrulandı: `lib/screens/` altında Goal detay ekranı yok, `GoalService`'te sadece CRUD var, `Goal` modelinde workload/measurement alanı yok).

1. **GoalDetailPage** (zaten planlı FAZ1 Step 7) — bu adımın içine `measurementStrategy`/`targetAmount`/`unit` alanlarının Goal create/edit formuna eklenmesi dahil edilebilir (küçük genişletme, büyük yeniden yazım değil).
2. **`TaskEntity.actualDuration` eklenmesi** — mevcut migration deseniyle (`_onUpgrade`), küçük, izole değişiklik.
3. **`BaselineVersion` tablosu + basit rebaseline UI** (Goal'ün targetAmount/deadline'ını değiştirme akışı, eski değerleri BaselineVersion'a yazma).
4. **Measurement Engine** — Task verisinden workload-progress hesaplama (saf fonksiyon, DB'ye bağımlı değil, kolay birim-test edilir).
5. **Trajectory Engine** — LEVEL/TREND (§6), yine saf fonksiyonlar + sentetik test seti (Package A'nın çekirdeği burada başlar).
6. **Deviation Detector** (§7) — kalıcılık kuralı, saf fonksiyon.
7. **Feedback taksonomisi + UI** (§8) — `Feedback` tablosu, sapma-tetiklemeli mikro-soru ekranı.
8. **Evidence/Uncertainty katmanı** (§9) — ordinal confidence hesaplama.
9. **Adaptation Engine** (§10) — CAUSE→RESPONSE matrisi, bounded-step önerisi üretme.
10. **Recommendation UI** (§ accept/reject/modify) — `Recommendation` tablosu.
11. **Package A test seti** — adımlar 4-9 ile paralel/hemen sonra yazılmalı, sona bırakılmamalı (her katman kendi biriminde test edilebilir).
12. *(SHOULD HAVE, kaynak kalırsa)* `availability` alanı + basit capacity kısıtı, mixed-unit vector gösterim, formative pilot.

Kod yazılmadı — bu sadece sıralama önerisi.

---

## 26. Explicit Future Work

- LLM tabanlı serbest-metin sınıflandırma (dar, hakem-olmayan rol).
- Population-based reliability learning (çok kullanıcılı hale gelirse).
- Otomatik/dinamik taksonomi keşfi (embedding-tabanlı kümeleme).
- Multi-baseline SCED / gerçek N-of-1 nedensel çalışma (WWC standardında).
- Cloud/hesap senkronizasyonu (FAZ6).
- Blind-then-compare UX deneyi (Cleanup A §19).
- Closed-loop mediation analizi (önerinin nedensel etkisini ölçme).
- Kullanıcı-tanımlı task-ağırlıklarının zamanla-geçerlilik sorunu (Cleanup C §7).
- Framing türlerinin (descriptive/evaluative/action-oriented) doğrudan deneysel karşılaştırması.
- Achievement Goal Theory'nin (mastery/performance orientation) kullanıcı-motivasyon modeline entegrasyonu.
- Longitudinal gerçek-kullanıcı etkinlik çalışması (ORBIT Stage II+).

---

## 27. Remaining Engineering Decisions

Bu kararlar Phase 3'te **verilmedi**, mühendislik/ampirik kalibrasyon gerektiriyor:

- EWMA `α` değeri, kalıcılık kuralının pencere sayısı (kaç ardışık dönem), "meaningful deviation" eşiği — hepsi açıkça "engineering parameter" etiketiyle kodda yer almalı.
- Bounded-adaptation'ın üst/alt sınırı (öneri en fazla ne kadar büyüyebilir/küçülebilir).
- ASK_USER'ı tetikleyen çelişki-büyüklüğü eşiği.
- Feedback tekrar-bastırma eşiği (kaç kez üst üste aynı kategori).
- Usability instrument seçimi: UMUX-LITE mi SUS mü (ikisi de aday, §19).
- Etik/IRB sorusu — Türkiye/kurum-spesifik, danışman hocaya sorulmalı (2D §32'den miras, hâlâ çözülmedi).
- LLM'e geçilirse (future work) gerekli örneklem büyüklüğü (Gwet 2021 formülüyle hesaplanabilir, henüz yapılmadı).
- Taksonomi kategorilerinin kesin kullanıcı-facing metni (Türkçe ifadeler, §8'deki 7 kategori sadece taslak).
- `measurementStrategy` seçiminin Goal-oluşturma UI'ında nasıl sorulacağı (kullanıcıya jargonsuz nasıl sunulur).

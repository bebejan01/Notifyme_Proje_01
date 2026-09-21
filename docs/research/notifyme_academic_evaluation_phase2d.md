# NotifyMe — Tasarım 1 Araştırması — Aşama 2D: Akademik Literatür — Evaluation Methodology + Validation + Claim Boundaries

**Tarih:** 2026-09-21
**Kapsam:** Genel evaluation methodology — NotifyMe'nin tüm bileşenlerinin (adaptasyon algoritması, goal trajectory, feedback/LLM sınıflandırma, closed-loop) hangi seviyede, hangi yöntemle, hangi kanıtla test edilebileceği. Bu, Tasarım 1 araştırma serisinin SON büyük akademik literatür fazıdır.
**Önceki raporlar (okundu, başlangıç bilgisi kabul edildi, tekrar araştırılmadı):** `notifyme_competitor_analysis_phase1.md`, `notifyme_academic_adaptation_closed_loop_phase2a.md`, `notifyme_academic_feedback_human_factors_phase2b.md`, `notifyme_academic_goal_trajectory_phase2c.md`.
**Amaç:** NotifyMe'nin iyi olduğunu kanıtlamak DEĞİL. Hangi bilimsel iddiaların Tasarım 1 kapsamında desteklenebileceğini, hangilerinin desteklenemeyeceğini dürüstçe ortaya çıkarmak.

---

## 1. Executive Summary

Bu araştırmanın çekirdek bulgusu: **NotifyMe tek bir "çalışıyor mu" sorusuna indirgenemez — en az altı farklı iddia türü var, her biri farklı bir evaluation methodology gerektiriyor, ve Tasarım 1 kapsamında bunların yalnızca ilk ikisi-üçü gerçekten test edilebilir.** Bu varsayım literatürle doğrudan destekleniyor: Paramythis, Weibelzahl & Masthoff'un **"layered evaluation of interactive adaptive systems"** çerçevesi (User Modeling and User-Adapted Interaction, konu tam olarak NotifyMe'nin problemi — adaptif sistemlerin "tek bir summative sayı"yla değil, adaptasyon kararının her aşaması ayrı ayrı değerlendirilerek test edilmesi gerektiğini formalize ediyor) — bu araştırmanın en doğrudan uygulanabilir, en güçlü akademik iskeleti.

İkinci büyük bulgu: **N=1/tek-kullanıcı bağlamında "kanıtlanamaz" denilen şey aslında yanlış çerçevelenmiş bir ikilik.** What Works Clearinghouse'un (WWC) resmi Single-Case Design (SCD) standartları — ABD Eğitim Bakanlığı'nın kurumsal, hakemli metodoloji standardı — tek-vaka tasarımların **gerçek nedensel kanıt** üretebileceğini, ama bunun için katı koşullar (en az 3 etki gösterimi, farklı zaman noktalarında, replikasyon) gerektiğini gösteriyor. NotifyMe'nin "bir kullanıcı, bir dönem" senaryosu bu standartların **hiçbirini karşılamıyor** — ama bu "N=1 değersizdir" anlamına gelmiyor, "NotifyMe'nin mevcut planı WWC-kalitesinde SCED değil, daha zayıf bir gözlemsel N=1 anlatısı" anlamına geliyor. Bu ayrım kritik ve önceki fazlarda net değildi.

Üçüncü büyük bulgu: **Nielsen'in "5 kullanıcı yeter" kuralı, kendi literatüründe ciddi biçimde çürütülmüş.** Faulkner (2003, *Behavior Research Methods*) 60 kullanıcılık gerçek bir deneyde, rastgele seçilen 5-kişilik gruplarının sorunların **%55 ile %99'u arasında** değişen bir oranını bulduğunu gösteriyor — yani "5 kullanıcı test ettik" cümlesi tek başına hiçbir güvenilirlik garantisi taşımıyor. Spool & Schroeder (2001) gerçek web sitelerinde ilk 5 kullanıcının sorunların sadece **%35'ini** bulduğunu rapor ediyor. Bu, NotifyMe'nin olası küçük pilotunun (5-10-15-20 kullanıcı) **usability problem discovery** için makul ama **behavioral effectiveness** için anlamsız olduğunu doğruluyor — literatür bu ayrımı zaten net yapıyor.

Dördüncü bulgu: **"Evaluation Without Large Deployment" akademik olarak meşru bir kategori, keyfi bir bahane değil.** NIH Stage Model ve ORBIT çerçevesi (davranışsal müdahale geliştirmenin resmi, kurumsal aşamalandırması) açıkça "Stage 0/Stage I" (erken geliştirme, feasibility, mekanizma testi) aşamalarını "Stage II+" (efficacy/effectiveness) aşamalarından ayırıyor ve Stage I için **20-30 katılımcılık, kontrolsüz, tek-kollu feasibility çalışmasını** yeterli ve meşru sayıyor. NotifyMe'nin Tasarım 1 kapsamı, bu modelde **açıkça Stage 0/Stage Ia** — "mekanizma ve tasarımın mantıklı olduğunu göstermek", "sonuçların gerçek dünyada etkili olduğunu kanıtlamak" değil.

Beşinci bulgu, en rahatsız edici olanı: **"Ablation study" terimi NotifyMe bağlamında akademik olarak yanlış kullanılmış olur.** Ablation, Newell'in 1974'te önerdiği ve modern ML'de "eğitilmiş bir bileşeni çıkar, performans farkını ölç" anlamına gelen, **öğrenilmiş/karmaşık sistemler için** tanımlanmış bir terim. NotifyMe'nin "EMA'lı vs EMA'sız", "LEVEL-only vs LEVEL+TREND" karşılaştırmaları kavramsal olarak makul ama daha doğru terim **"component comparison"** veya **"controlled comparison"** — "ablation" kelimesini kullanmak jüri karşısında yanlış bir ML-ağırlıklı izlenim yaratabilir (bkz. §24).

Genel sonuç: NotifyMe için üç evaluation paketi (§27) önerilebilir, ama **hiçbiri "NotifyMe kullanıcıların hedeflerine ulaşmasını sağlıyor" iddiasını destekleyemez** — bu iddia, mevcut kapsamda literatür tarafından **açıkça reddediliyor** (Stage Model'in kendi mantığı, WWC'nin replikasyon gereksinimi, Smyth ve ark.'ın (Aşama 2C) subjektif-objektif ilerleme ayrışması hepsi aynı yöne işaret ediyor). Bu, olumsuz ama değerli bir sonuç: Tasarım 1'in bilimsel olgunluğu, bu iddiadan **kaçınmasında** yatıyor.

---

## 2. Scope and Methodology

Bu faz, Aşama 2A-2C'nin bulduğu adaptasyon algoritması, feedback taksonomisi ve goal-trajectory tasarım adaylarının **nasıl test edileceğini** ele alıyor — yeni bir algoritma/tasarım kararı önermiyor. Exa web search (`web_search_exa`) ile ~24 hedefli sorgu çalıştırıldı; her sorguya "objective" alanıyla net bir hedef tanımlandı. Öncelik: metodolojik standart/guideline (WWC, IRB), sistematik review, temel/klasik makale, güncel hakemli çalışma. Practitioner/blog kaynakları (özellikle "synthetic test data 2026" araması, §23) düşük kaliteli bulundu ve ayrıştırıldı (bkz. §34).

---

## 3. What Does "Works" Mean?

Kullanıcının A-G iddia listesi literatürle doğrulandı ve genişletildi. Her iddia farklı bir **epistemik kategori**:

| # | İddia | Kategori | Gerekli kanıt türü | Tasarım 1'de test edilebilir mi |
|---|---|---|---|---|
| A | Algoritma matematiksel olarak beklendiği gibi davranıyor | Software correctness | Unit test, deterministic assertion | **Evet** |
| B | Algoritma gürültü ile gerçek değişimi ayırt edebiliyor | Algorithm behavior (statistical) | Sentetik senaryo + ARL/detection delay (§7) | **Evet** |
| C | Sistem doğru zamanda doğru adaptasyon önerisini seçiyor | Algorithm/policy validation | Senaryo kapsamı + iç-tutarlılık testleri | **Kısmen** (bounded/stable mi — evet; "doğru" mu — hayır, "doğru"nun ground truth'u yok) |
| D | Kullanıcı önerileri anlaşılır/faydalı buluyor | HCI / perceived usability | Usability instrument (SUS/UMUX) + walkthrough | **Kısmen** (formative, small-N) |
| E | Kullanıcı önerileri uyguluyor | Behavioral (acceptance) | Event log + acceptance-rate analizi | **Kısmen** (ölçülebilir ama tek başına anlamsız, §15) |
| F | Öneriler sonraki performansı iyileştiriyor | Causal, within-subject | SCED/N-of-1, kontrollü karşılaştırma | **Hayır** (yeterli replikasyon/veri yok, §10) |
| G | NotifyMe Goal başarı oranını artırıyor | Causal, population-level | RCT/comparative behavioral study | **Hayır, kesinlikle değil** |

Bu tablo, Paramythis ve ark.'ın (§4) layered evaluation çerçevesiyle ve ORBIT/NIH Stage Model'in (§23) aşamalandırmasıyla tutarlı — üç ayrı akademik kaynak bağımsız olarak aynı ayrımı doğruluyor. **Kanıt seviyesi: Var — doğrulandı, üç bağımsız çerçeveden yakınsama.**

---

## 4. Evaluation Layers

Kullanıcının önerdiği 6 katman (Software Correctness / Algorithm Behavior / Classification-AI / HCI / Behavioral Effect / Goal Outcome) literatürle **doğrudan ve güçlü destekli**: Paramythis, Weibelzahl & Masthoff, **"Layered Evaluation of Interactive Adaptive Systems: Framework and Formative Methods"** (User Modeling and User-Adapted Interaction) — adaptif sistemlerin evaluation'ını "decomposition" ile ele alan, literatürde kanonik bir çerçeve. Makalenin kendi katmanlandırması NotifyMe'ye şöyle haritalanıyor:

- **Adaptation decisions'ın değerlendirilmesi**: verilen bir kullanıcı-durumu çıkarımına göre alınan kararın (NotifyMe'de: "60→90dk öner") **alternatiflerle karşılaştırıldığında optimal olup olmadığı** — bu, NotifyMe'nin Layer 2/3'üne (Algorithm Behavior, Classification) karşılık geliyor.
- **Total interaction'ın değerlendirilmesi**: adaptasyonun **summative** (bütünsel) etkisi — sistemin ve kullanıcının katkısını ayırt ederek — bu NotifyMe'nin Layer 5/6'sına (Behavioral Effect, Goal Outcome) karşılık geliyor.

Makale özellikle "adaptation decisions" ile "total interaction" değerlendirmesinin **birbirine indirgenemeyeceğini** vurguluyor — bu tam olarak kullanıcının "tek bir accuracy=%X ile bütün sistemi değerlendirmeye çalışmama" hedefiyle örtüşüyor. **Kanıt seviyesi: Var — doğrulandı, kanonik kaynak.**

**Önerilen katmanlandırma revizyonu:** Kullanıcının 6 katmanı doğru ama Layer 3 ("Classification/AI component") NotifyMe'de opsiyonel bir alt-katman — Aşama 2B'nin bulgusuna göre (LLM zorunlu değil) bu katman **koşullu**, her zaman var olmayabilir. Bu revize edilmiş 6+1 katman raporun geri kalanında kullanılıyor.

---

## 5. Claim → Evidence Matrix

Kullanıcının örnek matrisi büyük ölçüde doğrulandı, aşağıda genişletilmiş/düzeltilmiş hali:

| Claim | Required Evidence | Tasarım 1'de mümkün mü | Kaynak |
|---|---|---|---|
| "Algoritma matematiksel olarak doğru çalışır" | Deterministic unit test | Evet | Genel yazılım mühendisliği |
| "Algoritma persistent değişimi gürültüden ayırt eder" | Sentetik senaryo + ARL/EDD/detection delay + false-alarm rate | Evet | §7, Aşama 2A (Schat ve ark. 2021) |
| "Adaptasyon önerisi sınırlı/kararlı (bounded/stable)" | Sentetik stres testi, iç-tutarlılık testleri | Evet | §8, kontrol sistemleri kavramları |
| "Goal trajectory hesaplaması SPI'nin klasik hatasına düşmüyor" | Sentetik senaryo (deadline'a yaklaşırken davranış) | Evet | §9, Aşama 2C (Lipke ES) |
| "LLM sınıflandırması X doğrulukla çalışıyor" | Elle etiketlenmiş test seti + Kappa/macro-F1 | Kısmen (küçük set, geniş güven aralığı) | §17 |
| "Kullanıcı sistemi anlaşılır/kullanılabilir buluyor" | SUS/UMUX + formative küçük pilot (5-15 kişi) | Kısmen (usability problem discovery evet, güvenilir skor hayır) | §12-13 |
| "Kullanıcı önerileri kabul ediyor" | Acceptance-rate log | Evet (ölçülür) ama **tek başına kalite kanıtı değil** | §15 |
| "Öneri sonraki performansı iyileştiriyor" | SCED/N-of-1 (min. 3 etki gösterimi, WWC standardı) veya kontrollü karşılaştırma | **Hayır** — Tasarım 1'de yeterli replikasyon/süre yok | §10 |
| "NotifyMe hedeflere ulaşmayı artırıyor" | RCT / büyük-N longitudinal karşılaştırmalı çalışma | **Kesinlikle hayır** | §23, ORBIT/NIH Stage Model |

Bu matris Phase 3'ün **bilimsel iddia sınırını** belirlemeli — özellikle son iki satır, "gösterilemez" olarak açıkça işaretlenmeli.

---

## 6. Synthetic Evaluation

Aşama 2A'nın §18-19'unda (synthetic can/cannot) başlanan ayrım burada genişletiliyor. **Kanıtlanabilir**: algorithm correctness, robustness, false-positive rate, change-point detection gecikmesi, threshold davranışı, bounded adaptation, edge case'ler, gürültüye dayanıklılık — bunların hepsi **ground truth'un tasarımcı tarafından bilindiği** senaryolar, yani "algoritma kendi varsayımlarıyla tutarlı mı" sorusuna cevap veriyor. **Kanıtlanamaz**: gerçek kullanıcı davranışı, motivasyon, adherence, güven, gerçek goal başarısı — bunlar **insan davranışı** gerektiriyor, sentetik veri tanım gereği önceden belirlenmiş bir modelden üretildiği için "insan gerçekte böyle mi davranıyor" sorusuna cevap veremez.

**Simulation study methodology (parametre aralığı, ground truth, tekrarlı simülasyon, duyarlılık analizi):** genel istatistik/mühendislik pratiğinde iyi kurulmuş bir yöntem ailesi. Aşama 2A'nın Schat ve ark. (2021, DOI 10.1037/met0000447) metodolojisi — bilinen bir değişim noktası enjekte edip algoritmanın tespit gecikmesini/yanlış-alarm oranını ölçmek — burada da şablon olarak kullanılabilir, hem change-detection hem goal-trajectory (Aşama 2C §22) için.

**Kritik uyarı (Red Team ile bağlantılı, §28 Varsayım 1):** Sentetik veride "algoritma çalışıyor" demek, sadece "algoritma tasarımcının modellediği varsayımlar altında tutarlı" demek — bu, **circular** bir doğrulama riski taşır: eğer sentetik veri üreten model ile test edilen algoritmanın varsayımları aynıysa (örn. ikisi de EMA-benzeri bir süreç varsayıyorsa), test "algoritmanın kendi varsayımını doğruladığını" gösterir, dış geçerliliği değil. Bu risk NotifyMe raporunda açıkça belirtilmeli.

---

## 7. Change-Detection Evaluation

Aşama 2A'nın EWMA/CUSUM bulgusu burada resmi evaluation metrikleriyle tamamlanıyor. **Average Run Length (ARL)** ve **Expected Detection Delay (EDD)**, change-point detection literatüründe standart iki metrik: ARL, değişim olmadığı durumda beklenen "alarm verme süresi" (yanlış-alarm oranıyla ilişkili); EDD, gerçek bir değişimden sonra beklenen tespit süresi (arXiv 2210.05181, tutorial-review, Lorden 1971'in klasik alt sınırına atıfla: EDD ≈ log(γ)/D(f₁‖f₂), γ = ARL alt sınırı, D = Kullback-Leibler ıraksaması). Pratik anlamı: **eşik/parametre seçimi bir ARL hedefi (örn. "yanlış alarm ortalama her 30 günde bir olsun") etrafında yapılmalı, ardından o ARL altında EDD ölçülmeli** — bu, Gegmara'nın (Aşama 1) sabit %20 eşiğinden akademik olarak daha savunulabilir bir çerçeve.

**NotifyMe için anlamlı metrikler:** ARL (false-alarm sıklığı), EDD (tespit gecikmesi), change-point lokalizasyon hatası (algoritmanın "değişim burada oldu" dediği nokta ile gerçek enjekte edilen noktanın farkı), gürültü/eksik-veri sağlamlığı. **Precision/recall uygunluğu:** kısmen — bir "olay" (alarm) ikili bir sınıflandırma gibi ele alınabilir ama zaman-serisi bağlamında ARL/EDD daha standart ve daha bilgilendirici (precision/recall zamanı hesaba katmıyor).

**"Stable baseline → known change point → persistent decline" senaryosu üzerinde "algoritma kaç gözlem sonra tespit etti" ölçmek akademik olarak savunulabilir mi?** Evet, kesinlikle — bu tam olarak EDD'nin tanımı, ve Schat ve ark. (2021) zaten psikoloji bağlamında bu tür bir simülasyonu yürütmüş. **Kanıt seviyesi: Var — doğrulandı, doğrudan uygulanabilir.**

---

## 8. Adaptation Policy Evaluation

Aşama 2A'nın §20 Red Team'inde "bu gerçekten adaptasyon mu, birkaç if/else mi" sorusuna verilen cevap ("klasik kontrol/sinyal-işleme anlamında gerçek bir adaptif filtre") burada evaluation açısından derinleştiriliyor. Kontrol sistemleri literatüründeki **stability, convergence, overshoot, oscillation, robustness** kavramları NotifyMe'nin "60dk→90dk" önerisine **kısmen ve dikkatle** aktarılabilir:

- **Bounded**: önerinin önceden tanımlı bir aralığı asla aşmadığı — deterministic unit test ile doğrudan test edilebilir.
- **Oscillation**: ardışık önerilerin sürekli yukarı-aşağı salınıp salınmadığı (örn. 60→90→60→90) — sentetik, tekrarlı-gürültülü veri serisiyle test edilebilir, gerçek kontrol teorisindeki "limit cycle" kavramına gevşek bir paralellik.
- **Convergence**: sabit bir davranış kalıbı altında önerinin bir "denge" değerine yaklaşıp yaklaşmadığı — sentetik sabit-trend senaryosuyla test edilebilir.
- **Overshoot**: NotifyMe'de doğrudan karşılığı zayıf (formal bir "hedef değer" yok, sürekli güncellenen bir tahmin var) — **dikkatli kullanılmalı, doğrudan aktarılmamalı.**

**DİKKAT (kullanıcının talimatındaki uyarıyla tutarlı):** NotifyMe'yi formal bir control system olarak tanımlamak yanlış olur — klasik kontrol teorisi sürekli, diferansiyellenebilir sinyaller varsayıyor, NotifyMe'nin verisi seyrek, gürültülü, insan-üretimi. Bu kavramlar **metafor/ilham düzeyinde**, formal garanti düzeyinde değil kullanılmalı — Aşama 2A'nın kendi uyarısıyla (PID'in doğrudan uygulanabilir olmadığı) tutarlı.

**Availability constraint ihlali, edge case güvenliği:** deterministic unit test + sentetik uç-durum senaryoları (kullanılabilir zaman sıfıra yakınken, workload aşırı büyükken) ile doğrudan test edilebilir — bu, genel yazılım stres testi pratiğinin (STAB, arXiv 2605.27981 — algoritmik kötü-durum senaryosu üretimi; MIT'in MetaEase aracı, sembolik yürütme ile worst-case girdi arama) NotifyMe ölçeğine küçültülmüş hali. **Kanıt seviyesi: Var — doğrulandı (unit/sentetik test düzeyinde), Belirsiz — kontrol-teorisi kavramlarının ne kadar formal aktarılabileceği.**

---

## 9. Goal-Trajectory Evaluation

Aşama 2C'nin §22'sinde başlanan test edilebilirlik analizi burada genişletiliyor. Kullanıcının önerdiği 12 senaryo (sabit-önde, sürekli-geride, toparlanan, gürültülü-ama-stabil, vb.) **algorithm validation** kategorisinde — unit/integration test değil (çünkü çıktı deterministic bir "doğru/yanlış" değil, bir davranış kalıbı), ama tam bir simulation experiment de değil (çünkü insan davranışı içermiyor). En doğru sınıflandırma: **"scenario-based algorithm validation"** — yazılım mühendisliğinde "property-based testing"e yakın bir kategori (belirli bir property'nin — örn. "LEVEL ve TREND ayrı hareket edebilmeli" — her senaryoda korunduğunu doğrulamak).

**Hangi sonuçlar hangi iddiayı destekler:** "Model B (LEVEL+TREND) senaryoların hepsinde tutarlı davranıyor" → algoritma iç-tutarlılığı iddiasını destekler. **Desteklemez:** "Model B gerçek kullanıcılarda Model A'dan daha iyi çalışır" — bu, karşılaştırmalı insan verisi gerektirir, sentetik senaryo veremez (Aşama 2C §22'nin kendi sonucuyla tutarlı).

**Earned-Schedule düzeltmesinin test edilmesi:** Aşama 2C'nin §8'inde bulunan SPI hatası (deadline'a yaklaşırken yapay yakınsama) doğrudan test edilebilir bir property — "remaining_time → 0 iken gösterge davranışı" sentetik senaryoda kolayca simüle edilip Earned-Schedule düzeltmesinin bu hatayı gerçekten önleyip önlemediği doğrulanabilir. **Kanıt seviyesi: Var — doğrulandı (Aşama 2C ile devamlılık içinde).**

---

## 10. SCED / N-of-1

Bu, raporun en kritik metodolojik bölümü. **What Works Clearinghouse (WWC) Single-Case Design (SCD) Technical Documentation** (ies.ed.gov, ABD Eğitim Bakanlığı; ayrıca Kratochwill, Hitchcock, Horner, Levin, Odom, Rindskopf & Shadish, "Single-Case Intervention Research Design Standards", *Remedial and Special Education*, 2012, DOI 10.1177/0741932512452794) — SCED'in akademik dünyada **resmi, kurumsal standardı**:

- **Design Standards** (iç geçerlilik) ve **Evidence Standards** (kanıt gücü) ayrı değerlendiriliyor.
- **Minimum 3 "etki gösterimi"** (demonstration of effect), farklı zaman noktalarında (within-case replikasyon) veya farklı vakalar arasında (inter-case replikasyon) — "an experimental effect is demonstrated when the predicted changes in the dependent measures covary with manipulation of the independent variable."
- **AB/ABAB (reversal) tasarımlar**: standartları eksiksiz karşılamak için **en az 4 faz, fazda en az 5 veri noktası**; "reservations ile" kategori için 3-4 veri noktası.
- **Multiple baseline tasarımlar**: **en az 6 faz, fazda en az 5 veri noktası** ("reservations ile" 3-4).
- **Inter-assessor agreement** (gözlemciler arası uyum): en az %80-90 (yüzde uyum) veya en az Cohen's Kappa 0.60 — ve bu **her koşulda veri noktalarının en az %20'sinde** toplanmalı.
- **Level, trend, variability** terimleri formal olarak tanımlı — Carver & Scheier'in (Aşama 2C) kullandığı terminolojiyle örtüşüyor ama SCED'de görsel analiz aracı olarak.

**NotifyMe'nin gerçekliğine uygulanması:** "bir kullanıcı, bir Goal, bir dönem" senaryosu **WWC standartlarının HİÇBİRİNİ** karşılamıyor — tek bir baseline→intervention geçişi var (1 etki gösterimi, minimum 3 gerekiyor), tek bir gözlemci var (kullanıcının kendisi — inter-assessor agreement kavramsal olarak uygulanamaz), ve müdahalenin "sistematik olarak manipüle edilmesi" (araştırmacının ne zaman/nasıl değişeceğine karar vermesi) NotifyMe'de yok — sistem kendiliğinden adapte oluyor, deneysel bir müdahale değil.

**"Önce kötüydü sonra iyi oldu" neden nedensellik kanıtı değil (kullanıcının sorduğu soru):** arXiv 2406.10360 ("Causal inference for N-of-1 trials") N-of-1 tasarımların **formal bir nedensel çerçeveye (CATE/U-CATE — Conditional Average Treatment Effect, tek-kişi versiyonu) oturtulması gerektiğini**, "basit ortalama fark" tahmincisinin ancak **carryover effect, zaman-trendi, zamanla-değişen ortak nedenler yokken** doğru olduğunu gösteriyor — bu koşullar NotifyMe'de **tam olarak ihlal ediliyor** (davranış zamanla trend gösterir — sınav dönemi, motivasyon dalgalanması; önceki haftanın etkisi sonraki haftaya "carryover" olabilir). Regression to the mean, history, maturation, novelty/Hawthorne effect, seasonality (sınav dönemi) — hepsi NotifyMe'nin senaryosunda **aktif tehdit**: kullanıcı kötü bir haftadan sonra doğal olarak ortalamaya döner (regression to mean), sistemi kullanmaya başlamanın kendisi bir "novelty" etkisi yaratabilir (Hawthorne), dönem başı/sonu (seasonality) performansı bağımsız olarak değiştirir.

**Tasarım 1'de tek kullanıcı/çok küçük N ile savunulabilir iddialar:** SADECE **tanımlayıcı gözlem** ("bu dönemde, bu kullanıcıda şu kalıp görüldü") — **nedensel** ("NotifyMe bu değişimi sağladı") değil. Bu, WWC'nin "Meets Standards"/"No Evidence" ayrımının en uç ucunda — NotifyMe'nin olası tek-kullanıcı verisi WWC terminolojisinde açıkça **"No Evidence"** kategorisine düşer (3 gösterim eşiği karşılanmadığı için), bu bir eksiklik değil, dürüst bir sınıflandırma. **Kanıt seviyesi: Var — doğrulandı, güçlü (kurumsal standart + formal nedensel çerçeve).**

---

## 11. Multiple Baseline Designs

Lanovaz & Turgeon (2020), **"How Many Tiers Do We Need? Type I Errors and Power in Multiple Baseline Designs"** (*Perspectives on Behavior Science*, DOI 10.1007/s40614-020-00263-x) — 10.000 simüle edilmiş multiple-baseline grafiği + 300 gerçek grafiğin görsel-analiz replikasyonu ile: **en az 3 tier (davranış/kişi) olduğunda ve bunlardan 2 veya daha fazlası net değişim gösterdiğinde, Type I error oranı kabul edilebilir düzeyde (<%5) kalırken power de yeterli (>%80) oluyor.** Buna karşılık, **tüm tier'lerin** değişim göstermesini şart koşmak aşırı katı bir kriter, power'ı ciddi biçimde düşürüyor.

**NotifyMe'ye uygulanabilirlik:** Kullanıcının önerdiği "aynı kullanıcıda Goal A/B/C için adaptasyonu farklı zamanlarda başlatma" senaryosu, teorik olarak multiple-baseline mantığına uyuyor — WWC standardı "en az 6 faz" istiyor ama Lanovaz & Turgeon'un simülasyonu **3 tier + 2 net değişim** yeterli power gösteriyor (daha esnek bir alt sınır). **Ama pratik engel büyük:** NotifyMe'nin kullanıcısının aynı anda 3+ aktif Goal'ü olması ve bunlara adaptasyonun **kasıtlı olarak farklı zamanlarda** (araştırmacı kararıyla) başlatılması gerekiyor — bu, ürünün "kullanıcı deneyimine göre organik olarak çalışması" felsefesiyle **gerilimde**: adaptasyonu bilinçli olarak geciktirmek deneysel kontrol sağlar ama ürünün gerçek kullanım senaryosunu bozar.

**Avantajları/dezavantajları NotifyMe için:** Avantaj — tek-baseline AB tasarımından (§10) **çok daha güçlü** nedensel çıkarım (3 ayrı "replikasyon" aynı kullanıcı içinde). Dezavantaj — minimum veri ihtiyacı (3 Goal × birden fazla haftalık gözlem) çoğu erken kullanıcı için gerçekçi değil, ve "farklı zamanlarda başlatma" ürün tasarımına müdahale gerektiriyor (A/B testi gibi bir deneysel kontrol, NotifyMe'nin şu anki mimarisinde yok).

**Sonuç:** NotifyMe için **gereksiz akademik ağırlık değil**, ama **Tasarım 1 kapsamında pratik olarak uygulanabilir değil** — eğer Faz 3/sonrasında gerçek kullanıcı pilotu (§12) yapılırsa ve kullanıcıların birden fazla aktif Goal'ü varsa, **retrospektif olarak** (deneysel kontrol olmadan, doğal olarak farklı zamanlarda başlayan Goal'ler üzerinden) bir "quasi-multiple-baseline" gözlemi mümkün olabilir — bu, WWC standardını karşılamaz ama tek-AB'den daha zengin bir anlatı sağlar. **Kanıt seviyesi: Var — doğrulandı (yöntemin kendisi), Belirsiz/Düşük uygulanabilirlik — NotifyMe'nin mevcut kapsamı için.**

---

## 12. Small-N User Pilot

**Nielsen'in "5 kullanıcı" kuralının eleştirel incelemesi — bu araştırmanın en net "hayır, dikkatli olun" bulgusu:**

- **Faulkner (2003), "Beyond the five-user assumption: Benefits of increased sample sizes in usability testing"** (*Behavior Research Methods, Instruments, & Computers* 35(3), 379-383, DOI 10.3758/BF03195514) — 60 gerçek kullanıcı test edilmiş, rastgele 5-kişilik alt gruplar örneklenmiş: **bazı 5-kişilik gruplar sorunların %99'unu buldu, bazıları sadece %55'ini.** Ortalama %85 (Nielsen'in iddiasıyla tutarlı) ama **standart sapma %9.3, %95 güven aralığı ±%18.5** — yani "5 kullanıcı test ettik, %85 bulduk" demek istatistiksel olarak **yanıltıcı bir kesinlik** taşıyor. 10 kullanıcıyla minimum %80'e, 20 kullanıcıyla minimum %95'e çıkıyor.
- **Spool & Schroeder (2001), "Testing web sites: Five users is nowhere near enough"** (CHI 2001 Extended Abstracts) — 4 gerçek üretim web sitesinde 49 kullanıcı test edilmiş: **ilk 5 kullanıcı sorunların sadece %35'ini** buluyor, 13. ve 15. kullanıcılar bile yeni **ciddi** sorunlar buluyor.
- **Nielsen'in kendi orijinal metni** ("might be enough for many projects") bir **niteleme** içeriyor ama pratikte bu niteleme kayboldu, "5 yeterlidir" olarak basitleştirildi (Faulkner, "Grosvenor 1999" atfıyla).
- **Nielsen'in kendi güncel pozisyonu** (NN/g, "How Many Test Users in a Usability Study?", 2012): "Nitel çalışmalar için 5, **istatistiksel anlamlılık isteyen kantitatif çalışmalar için en az 20**" — yani Nielsen'in kendisi bile usability problem discovery (nitel) ile davranışsal etkinlik ölçümü (kantitatif) arasındaki farkı **açıkça ayırıyor.**

**NotifyMe için sonuç (I sorusu):** 5-10-15-20 kullanıcılık bir pilot ile **usability, comprehension, perceived usefulness, trust, burden, recommendation acceptance** — hepsi **nitel/formative** düzeyde ölçülebilir, ama "NotifyMe başarıyı artırıyor" gibi bir davranışsal etkinlik iddiası **kesinlikle desteklenemez**, hem Faulkner/Spool'un güvenilirlik uyarısı hem de temel örneklem-büyüklüğü mantığı (davranışsal etki için Nielsen'in kendi tavsiyesiyle en az 20, ve bu bile sadece "istatistiksel anlamlılık" için, "gerçek dünya etkisi" için değil) yüzünden. **Kanıt seviyesi: Var — doğrulandı, güçlü (doğrudan deneysel karşı-kanıt).**

---

## 13. Usability Instruments

- **System Usability Scale (SUS)** (Brooke, 1996): 10 madde, 0-100 puan, "quick and dirty" olarak tasarlanmış ama Bangor, Kortum & Miller'ın (2008, DOI 10.1080/10447310802205776) 10+ yıllık verisiyle güvenilirliği (~0.90 civarı) ve geçerliliği güçlü biçimde doğrulanmış — literatürde **fiili altın standart** (post-study anketlerinin ~%43'ünde kullanılıyor). Küçük örneklemde de yorumlanabilir (normlar var) ama güven aralığı geniş olur.
- **UMUX / UMUX-LITE**: UMUX 4 madde, UMUX-LITE 2 madde ("This system's capabilities meet my requirements" + "This system is easy to use"). Lewis, Utesch & Maher (2013, DOI 10.1145/2470654.2481287): güvenilirlik .82-.83 (2 madde için mükemmel), SUS ile korelasyon .81-.83, bir regresyon formülüyle SUS puanlarıyla **neredeyse birebir eşleşiyor** (fark ~%1). Schrepp, Kollmorgen & Thomaschewski (2023, DOI 10.5555/3604890.3604893) — 435 katılımcılı karşılaştırmada SUS ve UMUX-LITE **neredeyse özdeş** sonuç veriyor.
- **UEQ/UEQ-S**: Aynı 2023 çalışmasında SUS/UMUX-LITE'tan **farklı** bir "genel UX kalitesi" boyutu ölçtüğü, dolayısıyla anlam olarak biraz ayrıştığı bulundu.
- **NASA-TLX**: bilişsel/fiziksel yük ölçen bir araç, NotifyMe'nin "response burden" (Aşama 2B §10) sorusuna **teorik olarak uygun** ama NotifyMe için orijinal tasarım amacı (uçuş/simülasyon görevleri) çok farklı — sadece gerçekten "görev yükü" ölçmek isteniyorsa değerlendirilmeli.
- **Tek-madde alternatif (Gräve & Buchner 2024, DOI 10.1177/00187208241237862):** N=1089+1095 katılımcılı deneyde tek maddelik "Adjective Rating Scale"in çok-maddeli SUS/UMUX/ISONORM'dan **daha az değil, hatta bazen daha iyi** ayırt edicilik gösterdiği bulunmuş — "az madde = az bilgi" varsayımı basit arayüzler için abartılı olabilir.

**Lisans/kullanım kısıtı:** SUS ve UMUX-LITE akademik/pratik kullanımda serbestçe atıfla kullanılabilir, ticari lisans engeli bulunamadı.

**NotifyMe için 1-2 aday (nihai seçim yapılmıyor, kullanıcı talimatına uygun):** **UMUX-LITE** en güçlü aday — 2 madde, düşük response burden (Aşama 2B'nin resource-efficiency ilkesiyle uyumlu), SUS ile istatistiksel eşdeğerlik. **SUS** ikinci aday — daha çok norm verisi, daha "tanınır" (jüri/hoca aşinalığı yüksek), ama 10 madde daha fazla yük. **Kanıt seviyesi: Var — doğrulandı, çoklu bağımsız kaynaktan yakınsama.**

---

## 14. Trust / Explainability / Control Evaluation

Aşama 2B §12-13'te temel bulundu (Jafari & Vassileva 2026; Li & Shi 2025 reaktans meta-analizi). Bu fazda **evaluation açısından** ek katkı: **"appropriate reliance"** kavramı — arXiv 2604.23896 ("From Trust to Appropriate Reliance: Measurement Constructs in Human-AI Decision-Making") **"yüksek güven = iyi sistem"** varsayımını doğrudan sorguluyor: kullanıcı sistemin doğruluğuna aşırı güvenip (**overtrust/automation bias**) her önerisini sorgusuz kabul edebilir, veya (**algorithm aversion**) sistemin doğru olduğu durumlarda bile reddedebilir — **ikisi de "uygunsuz güven"**. Makale, sadece "kullanıcı AI ile ne kadar hemfikir" (alignment) ölçmenin yeterli olmadığını, bunun kullanıcının **ne zaman haklı ne zaman haksız olduğunu** ayırt etmediğini vurguluyor.

**NotifyMe için sonuç:** "Kullanıcı önerileri kabul ediyor" (yüksek acceptance rate) tek başına **iyi bir işaret olmayabilir** — eğer kullanıcı öneriyi hiç sorgulamadan her seferinde kabul ediyorsa bu **appropriate reliance değil, olası bir automation-bias işareti** olabilir (özellikle NotifyMe'nin kendisi de bazen yanlış olabileceği için — algoritmanın soğuk-başlangıç veya rejim-değişimi anlarında, Aşama 2A §20). Bu, §15'teki "acceptance rate ≠ quality" bulgusunu güçlendiriyor. **Kanıt seviyesi: Var — doğrulandı, güncel literatür.**

---

## 15. Recommendation Acceptance

**Acceptance rate'in tek başına ne ölçtüğü sorgulandığında**, hazır bir NotifyMe-spesifik literatür bulunamadı ama iki dolaylı güçlü destek var: (1) §14'teki appropriate-reliance ayrımı (yüksek acceptance = trust ama trust ≠ quality), (2) recommender sistemler literatüründe **offline vs online evaluation** ayrımı (Rehorek ve ark., "Comparing Offline and Online Evaluation Results of Recommender Systems") — offline metriklerin (NotifyMe'de: acceptance log) online/gerçek etkiyle **doğrudan ilişkili olmayabileceğini**, hatta bazen **ters ilişki** gösterebileceğini kanıtlıyor.

**"Recommendation accepted → subsequent performance" ilişkisinin değerlendirilmesi:** Bu, tam olarak §16'daki closed-loop/mediation analizi problemine dönüşüyor — "kabul edilen öneri sonrasında performans iyileşti mi" sorusu, basit bir korelasyon değil, **confound'lu bir karşılaştırma** (kabul eden kullanıcılar zaten daha motive olabilir, seçilim yanlılığı — selection bias). Bu ilişkiyi doğru değerlendirmek için ya (a) kabul/red **kullanıcı tarafından rastgele değil** olduğu için basit karşılaştırma yanıltıcı, ya da (b) formal bir mediation/karşı-olgusal çerçeve (§16) gerekiyor — bunların ikisi de Tasarım 1 ölçeğinde **gerçekleştirilebilir değil.**

**Sonuç:** Acceptance rate, NotifyMe'de **ölçülmeli ve raporlanmalı** (event log zaten kolay) ama "recommendation quality"nin bir kanıtı olarak DEĞİL — sadece **kullanılabilirlik/UX sinyali** (kullanıcı öneriyi anlamlı buluyor mu, arayüz sürtünmesi var mı) olarak yorumlanmalı. **Kanıt seviyesi: Dolaylı destekli (appropriate-reliance + offline/online ayrımı), NotifyMe'ye özgü doğrudan çalışma yok.**

---

## 16. Closed-Loop Evaluation

Kullanıcının sorduğu "algoritma doğru tespit ediyor olabilir ama öneri kötü olabilir, öneri iyi olabilir ama kullanıcı uygulamayabilir, kullanıcı uygulayabilir ama Goal outcome iyileşmeyebilir" zinciri, istatistikte formal bir karşılığa sahip: **causal mediation analysis / path analysis (sequentially ordered mediators)**. Modern mediation literatürü (VanderWeele, Imai-Keele-Tingley geleneği; arXiv 2606.02833 "Sequential Causally Ordered Mediation Pathways") tam olarak bu tür **çok-aşamalı nedensel zincirleri** (exposure → M1 → M2 → ... → outcome) ayrıştırmak için tasarlanmış — NotifyMe'nin zinciri (algorithm decision → recommendation → user action → outcome) formal olarak bir **Sequential Causally Ordered Mediators (SCOM)** yapısı.

**Kritik dürüstlük notu:** Bu yöntemler **"sequential ignorability"** (her aşamada ölçülmemiş karıştırıcı olmadığı) gibi güçlü, doğrulanamayan varsayımlara dayanıyor ve genellikle **büyük-N, çok-katılımcılı** veri gerektiriyor (kohort çalışmaları, yüzlerce/binlerce gözlem). NotifyMe'nin tek-kullanıcı, küçük-N verisiyle formal mediation analizi **istatistiksel olarak anlamsız** — güç (power) yok, tahminciler güvenilmez.

**Tasarım 1'de gerçekçi alternatif:** Formal mediation yerine, zincirin **her halkasını ayrı ayrı, bağımsız kanıtla** test etmek (§4'teki layered evaluation mantığıyla tutarlı) — "algoritma doğru tespit ediyor" (§7, sentetik), "öneri bounded/tutarlı" (§8, sentetik), "kullanıcı öneriyi anlıyor" (§13, usability), "kullanıcı kabul ediyor" (§15, log, ama kalite kanıtı değil) — ve **bu halkaları birbirine bağlayan tam zincirin nedensel olarak doğrulandığını iddia ETMEMEK.** Bu, kullanıcının kendi sorusuna ("bütün loop'u test etmek ile tek tek bileşenleri test etmek arasındaki fark") en dürüst cevap: **Tasarım 1'de sadece bileşenler test edilebilir, tam loop'un nedensel bütünlüğü test edilemez.** **Kanıt seviyesi: Var — doğrulandı (formal çerçeve var), Yok — NotifyMe ölçeğinde uygulanabilirlik.**

---

## 17. AI / LLM Evaluation

Aşama 2B §16-17'de temel atıldı (arXiv 2406.08660 fine-tune vs zero-shot; 100-250 örnek + Kappa önerisi). Bu fazda **daha güncel ve doğrudan uygulanabilir** bir kaynak bulundu: Megahed ve ark., **"Reliable decision support with LLMs: a framework for evaluating LLM classification reliability and validity"** (2026, DOI 10.1080/2573234X.2026.2652281) — 14 farklı LLM'i (Claude, GPT-4o, DeepSeek, Gemma, Llama, Phi, Command-R dahil), 5 tekrarlı çalıştırmayla, 1350 makale üzerinde test eden dört-fazlı bir çerçeve (planlama → veri toplama → güvenilirlik analizi → geçerlilik analizi):

- **Intra-rater reliability** (aynı modelin kendi kendiyle tutarlılığı, tekrarlı çalıştırmalarla) VE **inter-rater reliability** (modeller arası tutarlılık) **ayrı ayrı** ölçülmeli — sadece bir modelin "doğruluğu" değil, **kararlılığı** da rapor edilmeli.
- **5 farklı chance-corrected uyum katsayısı** (Conger's Kappa, Fleiss' Kappa, Gwet's AC1, Brennan-Prediger, Krippendorff's Alpha) karşılaştırmalı kullanılmalı — tek bir metriğe güvenmek yanıltıcı olabilir.
- **Örneklem büyüklüğü**, psikometrik tekniklerle (Gwet 2021) **%90 güven, %10 hata payı** hedefiyle belirlenmeli — bu, "kaç örnek etiketlemeliyiz" sorusuna somut bir hesaplama yöntemi sunuyor (NotifyMe'nin küçük veri seti için minimum-uygun N hesaplanabilir).
- **Geçersiz yanıtları** (LLM'in beklenmedik format döndürmesi) ayrı bir kategori olarak işlenmeli (NA-dropped/NA-penalised varyantlar).

**Class imbalance:** Aşama 2B'nin zaten vurguladığı gibi macro-F1 tercih edilmeli; confusion matrix zorunlu.

**Data leakage/overfitting riski (prompt tuning sonrası aynı sette test etme):** Evet, gerçek bir risk — makine öğrenmesi metodolojisinin temel ilkesi (train/dev/test ayrımı) burada da geçerli: eğer prompt, belirli örneklere bakılarak elle ayarlandıysa, o örnekler artık "test" değil "development" seti sayılır; nihai değerlendirme **görülmemiş** bir sette yapılmalı. NotifyMe'nin küçük veri hacminde bu ayrımı yapmak (örn. 100 örnekten 70/30) **istatistiksel gücü daha da azaltır** — bu, küçük-N LLM değerlendirmesinin doğal bir gerilimi, çözümü yok, sadece açıkça belirtilmeli. **Kanıt seviyesi: Var — doğrulandı, güncel ve doğrudan uygulanabilir çerçeve.**

---

## 18. Ground Truth Problem

Aşama 2B §8-9 ve Aşama 2C §7'de (self-serving bias d=0.96, subjektif-objektif R²=.05-.39) zaten çok güçlü temellendirildi. Bu fazda ek olarak: **ground truth'u olmayan kavramlar (gerçek başarısızlık nedeni, öneri gerçekten işe yaradı mı, goal gerçekten öğrenildi mi) davranış bilimi/ML literatüründe standart bir çözümü yok** — en yakın pratik, **birden fazla zayıf sinyali çapraz doğrulamak** (self-report + objektif veri + zaman içindeki tutarlılık) ve **hiçbirini "kesin doğru" saymamak**, bunun yerine güvenilirlik/belirsizlik olarak modellemek (Aşama 2B §9'daki JITAI tailoring-variable-reliability ilkesiyle tutarlı). Bu fazda yeni bir çözüm bulunamadı — sorun, davranış biliminin **açık, çözülmemiş** bir problemi olarak kalıyor, NotifyMe'ye özgü değil. **Kanıt seviyesi: Var — doğrulandı ki sorun yapısal/çözümsüz, NotifyMe'ye özgü bir eksiklik değil.**

---

## 19. Measurement / Construct Validity

**Construct validity** kavramı hem klasik psikometri hem yazılım mühendisliği literatüründe derinlemesine işlenmiş. Ralph & Tempero (2018, DOI 10.1145/3210459.3210461) — yazılım metriklerinin **"gerçekten ölçtüğünü iddia ettiği şeyi ölçüp ölçmediği"** sıklıkla hiç test edilmeden varsayıldığını gösteriyor; 15 yazılım metriğinin detaylı incelemesiyle bu boşluğu somutlaştırıyor. Sjøberg & Bergersen (2021, DOI 10.36227/techrxiv.14141027) construct validity'nin yazılım mühendisliği literatüründe **tutarsız tanımlandığını**, çoğu makalenin sadece "tehdit" olarak yüzeysel bir paragrafla geçiştirdiğini gösteriyor — bu, NotifyMe raporunun **kaçınması gereken** bir hata.

**Convergent/discriminant validity ve proxy metrics:** Bir metriğin (örn. task completion rate) gerçekten iddia edilen kavramı (productivity) ölçüp ölçmediği, o metriğin **teorik olarak benzer olması beklenen başka ölçümlerle korelasyonu** (convergent) ve **farklı olması beklenenlerden ayrışması** (discriminant) ile test edilir — bu, tam olarak Aşama 2C §7'nin (Smyth ve ark., subjektif-objektif R²=.05-.39) yaptığı analiz, ama formal terminolojiyle: NotifyMe'nin "workload tamamlanma oranı" ile "kullanıcının kendi ilerleme algısı" arasındaki zayıf korelasyon, tam olarak **convergent validity'nin düşük olduğunu** gösteriyor — "workload completion" ve "goal success" **farklı construct'lar**, bu Aşama 2C'nin kendi sonucuyla birebir örtüşüyor, burada sadece formal terminolojiyle teyit edildi.

**NotifyMe için hangi validite kaygıları en anlamlı:** (1) task completion rate ≠ productivity (yüksek risk, Aşama 2C §14 Goodhart's Law ile aynı), (2) recommendation acceptance ≠ recommendation quality (§15, §14), (3) SUS/UMUX skoru ≠ davranışsal etkinlik (§13'ün doğal sınırı — usability instrument'lar zaten sadece **algılanan** kullanılabilirliği ölçmek için tasarlanmış, davranışsal etki iddiası taşımıyorlar). **Kanıt seviyesi: Var — doğrulandı, çoklu bağımsız kaynak.**

---

## 20. Statistics for Small-N

Bir ECE/CS deneysel metodoloji kaynağı (arXiv 2605.00428, "How to Do Statistical Evaluations in ECE/CS Papers") somut bir pratik eşik veriyor: **n≥10 seed pratik bir taban, n≥30 rahat**, küçük n (<8) için bootstrap güven aralıkları **iyimser** olur, bunun yerine t-dağılımlı güven aralığı tercih edilmeli (varsayımlar uygunsa) — "hiçbir yöntem küçük n'yi kurtaramaz" notu önemli, yani **n<8 gibi bir durumda (NotifyMe'nin muhtemel gerçekliği) hiçbir istatistiksel numara güvenilir bir p-değeri üretemez.**

**Effect size, confidence interval, descriptive statistics, visual analysis ne zaman daha anlamlı:** WWC'nin kendi SCED standardı (§10) zaten **p-değeri değil görsel analiz** (level/trend/variability/overlap) kullanıyor — bu, akademik dünyanın kendisinin küçük-N'de p-value'dan kaçındığının kurumsal kanıtı. NotifyMe için: **descriptive statistics + effect size (varsa) + visual analysis** kombinasyonu, **p-değeri zorlamaktan** akademik olarak daha savunulabilir — WWC standardıyla, SCED analiz yöntemleriyle (§21) ve ECE/CS kaynağının kendi tavsiyesiyle tutarlı.

**Küçük N'de p-value üretmenin riski:** p-hacking/questionable research practices literatürü (Freuli, Held & Heyard 2023, DOI 10.1214/23-sts904) simülasyonla göstermiş ki cherry-picking (birden fazla sonuçtan en iyisini seçip raporlamak) Type-I hata oranını ciddi artırıyor — bu risk küçük N'de **daha da büyük** çünkü az veri noktasıyla "anlamlı" görünen bir kalıp bulmak şans eseri kolaylaşıyor. **Kanıt seviyesi: Var — doğrulandı, çoklu kaynak.**

---

## 21. SCED Analysis Methods

**Görsel analiz** (level, trend, variability, immediacy of effect, overlap, consistency across phases) — WWC'nin kendi standardının çekirdeği (§10), "en az iki eğitimli WWC reviewer'ının bağımsız olarak aynı sonuca varması" şartıyla formalize edilmiş. **Nicel effect-size/nonoverlap yöntemleri:**

- **PND (Percentage of Non-overlapping Data)** — en eski, en basit, ama düşük istatistiksel güç ve tavan etkisi eleştirileri var.
- **NAP (Nonoverlap of All Pairs)** — Parker & Vannest (2008, DOI 10.1016/j.beth.2008.10.006) — PND'ye göre gelişmiş, tüm baseline-intervention veri çifti karşılaştırmalarına dayanıyor.
- **Tau-U** — Parker, Vannest, Davis & Sauber (2011, DOI 10.1016/j.beth.2010.08.006) — nonoverlap'i **trend düzeltmesiyle birleştiren**, günümüzde en çok önerilen yöntemlerden biri; baseline'daki trendi kontrol edebiliyor (NotifyMe'nin "zaten iyileşme trendindeyken sistemi kullanmaya başlama" karışıklığına doğrudan çözüm).
- **Genel karşılaştırma** (Vannest & Ninci 2015, DOI 10.1002/jcad.12038; Parker, Vannest & Davis 2011, DOI 10.1177/0145445511399147) — 9 farklı nonoverlap tekniğinin sistematik incelemesi, hiçbirinin "evrensel en iyi" olmadığını, veri özelliklerine göre (trend var mı, otokorelasyon var mı) seçilmesi gerektiğini gösteriyor.

**NotifyMe için gerekli mi:** Eğer Tasarım 1'de gerçek bir tek-kullanıcı/az-kullanıcı pilotu yapılırsa, **basit görsel analiz + belki Tau-U** (trend düzeltmesi NotifyMe'nin "zaten trend halindeydi" sorununa doğrudan hitap ettiği için) yeterli ve savunulabilir bir minimum. Randomization testleri, daha karmaşık istatistiksel makine — **NotifyMe'nin veri hacminde gereksiz ağırlık**, "N=1 hiçbir şey kanıtlamaz" gibi yanlış bir genellemeye düşmeden, sadece **orantılı** bir analiz seviyesi seçilmeli. **Kanıt seviyesi: Var — doğrulandı, uygulanabilir bir minimum var (Tau-U + görsel analiz).**

---

## 22. Ethics / Privacy

Bu bir öğrenci projesi olduğu için üniversiteye/kuruma göre kesin hukuki iddia üretilmiyor (kullanıcının talimatına uygun), ama genel akademik/etik çerçeve net:

- Birçok üniversitenin IRB/etik kurul rehberi (Stanford, UMassD, Berkeley, UNC örnekleri incelendi) **"class project"** ile **"research"** arasında net bir ayrım yapıyor: eğer veri **genelleştirilebilir bilgi** üretme/yayınlama amacı taşımıyorsa ve sınıf içinde kalıyorsa, çoğu kurumda **IRB onayı gerekmez** — ama bu **kurumdan kuruma değişir** ve NotifyMe bir bitirme/tasarım projesi olduğu, potansiyel olarak sunulacağı/yayınlanacağı için, "sadece sınıf içi" kategorisine net biçimde girmeyebilir. **Kesin cevap Türkiye/kurum-spesifik, bu oturumda doğrulanamadı — üniversitenin kendi etik kurulu/danışman hocaya sorulmalı.**
- **Minimum etik yaklaşım** (kurumdan bağımsız, evrensel iyi pratik): (1) **informed consent** — katılımcıya ne toplandığı, ne amaçla kullanılacağı, gönüllü olduğu açıkça söylenmeli (basit bir bilgi formu yeterli, ağır bir hukuki belge şart değil — HHS/SACHRP rehberi "minimal risk" araştırmalar için **basitleştirilmiş** onam sürecini destekliyor); (2) **data minimization** — sadece gerekli veri toplanmalı; (3) **anonimleştirme/pseudonimleştirme** — kullanıcı kimliği ile davranış verisi ayrıştırılabilir olmalı; (4) **withdrawal** — katılımcı istediği an çekilebilmeli, verisi silinebilmeli; (5) **serbest-metin geri bildirim** hassas olabilir (kullanıcı stres/motivasyon hakkında yazabilir) — bu veri özellikle korunmalı.
- NotifyMe'nin verisi (üretkenlik/davranış verisi) genellikle **"minimal risk"** kategorisinde sayılır (finansal, sağlık, yasadışı davranış gibi yüksek-riskli kategoriler değil) — ama "davranışsal/productivity data" yine de kişisel ve bazı bağlamlarda hassas olabilir (örn. bir kullanıcının sürekli başarısız olduğunu gösteren veri, öz-saygıyla ilgili).

**Kanıt seviyesi: Var — doğrulandı (genel prensipler), Belirsiz — Türkiye/kurum-spesifik gereklilik.**

---

## 23. Evaluation Without Large Deployment

Bu, Tasarım 1'in en can alıcı pratik sorusu ve literatür **net ve olumlu** bir cevap veriyor: **evet, büyük deployment olmadan da teknik olarak güçlü bir evaluation paketi mümkün — ama sadece belirli iddiaları destekler.**

**NIH Stage Model for Behavioral Intervention Development** (nia.nih.gov) ve **ORBIT Model** (Czajkowski, Powell ve ark. 2015, DOI mevcut PMC4522392) — davranışsal müdahale geliştirmenin resmi, NIH-onaylı aşamalandırması:

- **Stage 0**: temel bilim (mekanizma).
- **Stage I (Ia/Ib)**: müdahale geliştirme, **feasibility ve pilot testing** — "sample sizes only need to be large enough to answer the question of whether the behavioral intervention seems plausible (e.g., 20–30 participants)". Bu aşama **tek-kollu, kontrolsüz** olabilir — kontrol grubu şart değil.
- **Stage II**: tam güçlü (100-400 katılımcı), randomize **efficacy** testi.
- **Stage III/IV**: gerçek-dünya efficacy/effectiveness.
- **Stage V**: yayılım/uygulama.

**NotifyMe'nin Tasarım 1 kapsamı, açıkça Stage 0/Ia'da** — mekanizma tasarımı ve erken feasibility, **efficacy testi değil.** Bu model, bir kombinasyonun (unit test + sentetik simülasyon + algoritma stres testi + etiketli LLM test seti + expert walkthrough + küçük usability testi) **Stage I için tam olarak beklenen, meşru bir evaluation paketi** olduğunu doğruluyor.

**Expert walkthrough'ın gerçek katkısı ve sınırı:** Cognitive walkthrough (Lewis ve ark. 1990; NN/g güncel rehberleri) ve heuristic evaluation (Nielsen & Molich) — **gerçek kullanıcı olmadan** yapılabilen, düşük maliyetli, erken-aşama yöntemler. 3-5 deneyimli değerlendirici, "heuristically identifiable" sorunların **%75'ini** bulabiliyor (Nielsen & Molich'in kendi bulgusu, HCI ders materyallerinde standart olarak aktarılıyor). **Ama** sadece **öğrenilebilirlik/genel usability** sorunlarını yakalıyor — davranışsal etki, motivasyon, gerçek kullanım kalıpları hakkında **hiçbir şey söylemiyor.** Task-Centered User Interface Design (Lewis & Rieman) klasik kaynağı bunu açıkça "walkthrough gerçek kullanıcı testinin **yerine geçmez**, onu **tamamlar**" diye vurguluyor.

**Bu paketle hangi iddialar yapılabilir/yapılamaz (Stage Model'in kendi mantığıyla):**
- **Yapılabilir:** "Algoritma matematiksel olarak doğru", "sentetik senaryolarda değişimi makul gecikmeyle tespit ediyor", "arayüz deneyimli değerlendiricilerin gözünde öğrenilebilir görünüyor", "LLM sınıflandırması X test setinde Y doğrulukla çalışıyor (geniş güven aralığıyla)".
- **Yapılamaz:** "kullanıcılar için işe yarıyor" (Stage II+ gerektirir), "goal başarısını artırıyor" (Stage III/IV gerektirir).

**Kanıt seviyesi: Var — doğrulandı, çok güçlü (NIH/ORBIT kurumsal, iyi kurulmuş çerçeve — bu bölümün en sağlam bulgusu).**

---

## 24. Component Comparisons / Ablation

**Kritik terminolojik düzeltme.** "Ablation" terimi, Newell'in 1974 konuşma-tanıma tutorial'ından (aktaran: Wikipedia "Ablation (artificial intelligence)" makalesi, biyolojideki doku-çıkarma analojisi) türeyen ve modern ML literatüründe **özel bir anlamı** olan bir terim: "eğitilmiş/öğrenilmiş bir bileşeni sistemden çıkar, uçtan-uca metriği ölç" — **graceful degradation** varsayımı içeriyor (sistem bileşen eksikken de çalışmaya devam edebilmeli) ve tipik olarak **yeniden eğitim** gerektiriyor (DistilledPatterns kaynağı: "for components that affect training... retrain the model without that component rather than simply disabling it").

**NotifyMe'nin karşılaştırmaları (EMA'lı vs EMA'sız, LEVEL-only vs LEVEL+TREND, keyword-baseline vs LLM) bir "eğitim" içermiyor** — bunlar **deterministik, kural-tabanlı veya sabit-parametreli bileşenlerin** karşılaştırılması. Bu, "ablation" değil, daha doğru terimle **"component comparison"** veya **"controlled comparison"** (bazı kaynaklarda "configuration comparison", algoritma-konfigürasyon literatüründe — Fawcett & Hoos, "Analysing differences between algorithm configurations through ablation" — ilginç biçimde bu literatür de "ablation" terimini kullanıyor ama **parametre-konfigürasyonları arasında yol bulma** anlamında, NotifyMe'nin basit "var/yok" karşılaştırmasından farklı bir kullanım).

**Akademik olarak ne kadar anlamlı:** Component comparison'ın kendisi (X bileşeni varken vs yokken sistem nasıl davranıyor) **metodolojik olarak sağlam ve değerli** — asıl mesele terminoloji, içerik değil. "SIGIR-experiments" ve "CAV-experiments" gibi güncel deneysel metodoloji rehberleri (arXiv/GitHub kaynakları) "her mekanizma için bir izole edici satır — mekanizmanın X'e katkısı Y puan" ilkesini destekliyor, tam olarak NotifyMe'nin istediği şey — sadece "ablation" kelimesi yerine "component comparison" veya "controlled comparison study" kullanmak daha doğru olur. **Kanıt seviyesi: Var — doğrulandı, terminolojik düzeltme net.**

---

## 25. Baseline Selection

Baseline seçimi konusunda literatür (arXiv 1905.01395 "On the Difficulty of Evaluating Baselines"; ACM TOIS "Examining Additivity and Weak Baselines"; arXiv 2512.16491 "Best Practices for Empirical Meta-Algorithmic Research") tutarlı bir uyarı veriyor: **zayıf/eski baseline'lara karşı kazanmak anlamsız bir üstünlük iddiasıdır** — "the only way to be confident that a new technique is a contribution is to compare it against nothing less than the state of the art" (ACM TOIS). Ayrıca **baseline'ın adil biçimde "ayarlanmış" (tuned) olması gerektiği**, aksi halde karşılaştırma yanıltıcı olduğu vurgulanıyor.

**NotifyMe için pratik anlamı:** Kullanıcının önerdiği baseline'lar (no adaptation, fixed workload, previous-period workload, simple moving average, naive linear trajectory, rule-based text classifier) **hepsi mantıklı ve "zayıf baseline" riskinden kaçınıyor** — çünkü bunlar zaten NotifyMe'nin kendi "basit versiyonları", abartılı biçimde kötüleştirilmiş bir "straw-man" değil. **Her evaluation katmanı farklı baseline gerektirir mi:** Evet — Layer 2 (algoritma davranışı) için "no adaptation/fixed" baseline anlamlı; Layer 3 (LLM/AI) için "rule-based classifier" baseline anlamlı; ama Layer 5-6 (davranışsal/goal outcome) için **hiçbir baseline anlamlı değil, çünkü bu katmanlar zaten Tasarım 1'de test edilemiyor** (§4, §23). **Kanıt seviyesi: Var — doğrulandı.**

---

## 26. Success Criteria

**Predefined evaluation criteria'nın değeri**, klinik araştırma metodolojisinden (pre-registration, outcome switching literatürü) doğrudan aktarılabilir: prospektif olarak (veri görülmeden önce) tanımlanmış bir başarı kriteri, **sonradan seçilen** bir eşikten kategorik olarak daha güvenilir — outcome-switching çalışmaları (Kirkham ve ark.; TRIGGER re-analizi, PMC5932799) aynı verinin **8 farklı tanımla** hem p<0.001 hem p=0.89 sonuç verebildiğini gösteriyor, yani tanımın **ne zaman** seçildiği sonucu köklü biçimde değiştirebiliyor.

**NotifyMe için ayrım (kullanıcının sorduğu "literatürden gelen eşik" vs "mühendislik gereksinimi" vs "keşifsel bulgu"):**

- **Literatürden türetilmiş eşik**: sadece **çok az yerde** mümkün — örn. inter-assessor agreement için Cohen's Kappa ≥0.60 (WWC standardı, §10), ya da Gwet'in (2021) örneklem-büyüklüğü formülü (§17). Bunların dışında NotifyMe'nin alanına özgü literatürden gelen "doğru" bir sayısal eşik neredeyse hiç yok (Aşama 2A-2C'nin defalarca vurguladığı boşluk — adım büyüklüğü, sapma eşiği, vb.).
- **Mühendislik gereksinimi**: "algoritma bounded olmalı", "yanıt süresi X saniyeden az olmalı" gibi — literatürden gelmiyor ama **önceden belirlenip** dürüstçe "mühendislik kararı" olarak etiketlenebilir.
- **Keşifsel bulgu**: post-hoc gözlemler ("bu senaryoda ilginç bir davranış gördük") — **asla "success criterion" olarak sunulmamalı**, sadece "gözlem" olarak.

**Sonuç:** NotifyMe raporunda her eşik/kriterin yanına **hangi kategoriye ait olduğu açıkça etiketlenmeli** — bu, hem bilimsel dürüstlük hem "Hocaya ne diyebiliriz" bölümünün (§30) doğrudan destekleyicisi. **Kanıt seviyesi: Var — doğrulandı, güçlü (klinik metodolojiden doğrudan aktarım).**

---

## 27. Candidate Evaluation Packages

### PACKAGE A — MINIMUM DEFENSIBLE

- **Gerekli implementasyon:** Unit test seti (algoritma correctness), sentetik senaryo üreteci (change-detection + goal-trajectory, §6-9).
- **Katılımcı:** 0 (insan katılımcı gerekmiyor).
- **Süre:** Birkaç hafta (implementasyon + test yazımı).
- **Veri seti:** Tamamen sentetik.
- **Metrikler:** Unit test geçme oranı, ARL/EDD (§7), bounded-adaptation ihlali sayısı (§8).
- **Baseline:** No-adaptation, fixed-workload (§25).
- **İstatistiksel yöntem:** Yok/minimal (deterministik testler, betimsel istatistik).
- **Güçlü yön:** Tamamen tekrarlanabilir, sıfır etik risk, hızlı.
- **Zayıf yön:** İnsan davranışı/kullanılabilirlik hakkında hiçbir şey söylemiyor.
- **Desteklediği iddialar:** A, B, C (kısmen) — §3 tablosu.
- **Desteklemediği iddialar:** D, E, F, G.
- **Bir dönem içinde uygulanabilirlik:** **Yüksek** — en gerçekçi paket.

### PACKAGE B — BALANCED / STRONG

- **Gerekli implementasyon:** Package A + LLM sınıflandırma test seti (§17) + 5-15 kişilik formative usability pilotu (§12-13) + expert/cognitive walkthrough (§23).
- **Katılımcı:** 5-15 (formative, nitel).
- **Süre:** Bir dönem (implementasyon + pilot planlama + veri toplama + analiz).
- **Veri seti:** Sentetik + küçük gerçek kullanıcı verisi (etiketli LLM test seti dahil).
- **Metrikler:** Package A'nın hepsi + SUS/UMUX-LITE skorları (betimsel, güven aralığıyla), macro-F1/Kappa (LLM), heuristic evaluation bulgu sayısı/ciddiyeti.
- **Baseline:** Package A + rule-based text classifier (LLM karşılaştırması için).
- **İstatistiksel yöntem:** Betimsel istatistik + güven aralıkları (§20), görsel analiz (varsa tekrarlı ölçüm, §21).
- **Güçlü yön:** Layer 1-4'ün (§4) çoğunu kapsıyor, NIH Stage I'e (§23) tam denk.
- **Zayıf yön:** Hâlâ davranışsal etki iddiası yok; 5-15 kişilik pilotun güvenilirliği sınırlı (§12'nin Faulkner/Spool uyarısı).
- **Desteklediği iddialar:** A, B, C, D (formative), kısmen E.
- **Desteklemediği iddialar:** F, G.
- **Bir dönem içinde uygulanabilirlik:** **Orta-yüksek** — gerçekçi ama sıkı zaman yönetimi gerektirir; katılımcı bulma riski var.

### PACKAGE C — RESEARCH-HEAVY

- **Gerekli implementasyon:** Package B + multiple-baseline benzeri gözlemsel N-of-1 anlatısı (§10-11, WWC standardına yakınlaştırma denemesi) + Tau-U/görsel analiz (§21) + appropriate-reliance ölçeği (§14) + closed-loop mediation denemesi (§16, zayıf güçle).
- **Katılımcı:** 15-20+, uzun süreli takip (birkaç ay, WWC'nin min. 3-5 veri noktası/faz şartına yaklaşmak için).
- **Süre:** Bir dönemi büyük olasılıkla **aşıyor.**
- **Veri seti:** Gerçek, uzunlamasına kullanıcı verisi.
- **Metrikler:** Package B'nin hepsi + Tau-U effect size, appropriate-reliance skorları, (zayıf) mediation tahminleri.
- **Baseline:** Package B + kullanıcının kendi geçmiş (adaptasyon öncesi) verisi.
- **İstatistiksel yöntem:** Görsel analiz + Tau-U + (çok sınırlı güçle) betimsel mediation.
- **Güçlü yön:** En zengin, en akademik olarak "iddialı" paket.
- **Zayıf yön:** **Açıkça gerçekçi değil** — WWC'nin min. 3 gösterim/6 faz şartı, yeterli katılımcı bulma, IRB/etik süreç zamanlaması (§22), ve zaten Package C bile **G iddiasını (goal başarısı artışı) desteklemiyor** — sadece F'e (sonraki performans iyileşmesi) **çok zayıf, ön-bulgu düzeyinde** bir yaklaşım sağlıyor.
- **Desteklediği iddialar:** A, B, C, D, kısmen E, **çok zayıf/ön-bulgu düzeyinde** F.
- **Desteklemediği iddialar:** G (hiçbir paket desteklemiyor).
- **Bir dönem içinde uygulanabilirlik:** **Düşük — açıkça gerçekçi değil**, tek dönemlik Tasarım 1 kapsamında önerilmiyor.

**Nihai seçim yapılmıyor (kullanıcı talimatına uygun)** ama Package C'nin "açıkça gerçekçi olmadığı" burada net söyleniyor.

---

## 28. Red Team

| # | Varsayım | Destekleyici kanıt | Karşı kanıt | Belirsizlik | Risk | NotifyMe'ye etkisi |
|---|---|---|---|---|---|---|
| 1 | Sentetik veri algoritmanın çalıştığını kanıtlar | Algoritma correctness/robustness için evet (§6) | Circular doğrulama riski — sentetik veri üreteci ile test edilen algoritma aynı varsayımı paylaşırsa dış geçerlilik sıfır | Orta | **YÜKSEK** eğer "çalışıyor" davranışsal anlamda kullanılırsa | Raporda "sentetik veri sadece iç-tutarlılık kanıtlar" net yazılmalı |
| 2 | N=1 çalışma değersizdir | Yok, aşırı genelleme | WWC standardı N=1'i (yeterli replikasyonla) meşru sayıyor (§10) | Düşük | **DÜŞÜK** — yanlış varsayım, düzeltilmeli | "N=1 değersiz" DEMEMELİ, "NotifyMe'nin N=1'i WWC standardını karşılamıyor" DEMELİ |
| 3 | N=1 çalışma nedensellik kanıtlar | AB tasarımı görünüşte nedensel bir anlatı sunar | arXiv 2406.10360 (carryover, trend, confound), WWC'nin 3-gösterim şartı, regression-to-mean vb. (§10) | Düşük | **YÜKSEK** — en tehlikeli yanlış varsayım | Tasarım 1'de kesinlikle kaçınılmalı |
| 4 | 5 kullanıcı usability için her zaman yeterlidir | Nielsen'in orijinal iddiası, ortalama %85 | Faulkner (2003): %55-99 aralığı; Spool & Schroeder: ilk 5 sadece %35 buluyor (§12) | Düşük | **ORTA** — pilot planlanırken abartılı güven riski | 5 kullanıcı "formative", "kesin" değil olarak sunulmalı |
| 5 | SUS yüksekse ürün başarılıdır | SUS geçerli/güvenilir bir usability ölçütü | SUS yalnızca algılanan usability ölçer, davranışsal etkinlikle construct farkı var (§19) | Düşük | **ORTA** | SUS sonucu "kullanılabilir algılanıyor" olarak sunulmalı, "başarılı" değil |
| 6 | Recommendation acceptance yüksekse öneriler iyidir | Sezgisel makul görünüyor | Appropriate-reliance/automation-bias literatürü (§14), offline≠online evaluation farkı (§15) | Orta-yüksek | **ORTA-YÜKSEK** | Acceptance rate UX sinyali olarak sunulmalı, kalite kanıtı değil |
| 7 | User-reported cause ground truth'tur | Yok | Self-serving bias d=0.96 (Aşama 2B), R²=.05-.39 (Aşama 2C) | Düşük | **YÜKSEK** (zaten önceki fazlarda tespit edildi, burada teyit) | Değişmedi |
| 8 | Task completion productivity'dir | Basit görevlerde kısmen | Goodhart's Law, mastery≠activity (Aşama 2C §14), construct validity ayrımı (§19) | Düşük | **YÜKSEK** | Değişmedi, bu fazda formal terminoloji eklendi |
| 9 | Goal workload completion Goal success'tir | Tek-birimli Goal'lerde kısmen | Aynı, §19 construct validity ile pekiştirildi | Düşük | **YÜKSEK** | Değişmedi |
| 10 | LLM accuracy yüksekse AI bileşeni başarılıdır | Kısmen — accuracy önemli bir sinyal | Intra/inter-rater reliability de ayrı ölçülmeli (§17), tek metrik yeterli değil | Orta | **ORTA** | Accuracy + reliability birlikte raporlanmalı |
| 11 | Statistical significance olmadan proje değerlendirilemez | Yok — yanlış varsayım | WWC görsel analiz kullanıyor, ECE/CS kaynağı p-value'suz metodoloji öneriyor (§20-21) | Düşük | **DÜŞÜK** — yanlış varsayım | Raporun kendisi bu varsayımı reddetmeli |
| 12 | Statistical significance varsa sistem gerçek hayatta önemlidir | Yok | Statistical vs practical significance ayrımı klasik bir istatistik hatası; NotifyMe ölçeğinde zaten p-value üretilemeyecek kadar küçük N | Düşük | **DÜŞÜK** (NotifyMe'de zaten gerçekleşmeyecek bir senaryo) | Konu dışı kalabilir |
| 13 | Küçük pilot davranışsal etkinliği kanıtlayabilir | Yok | §12, §23 (Stage Model) ikisi de reddediyor | Düşük | **YÜKSEK** | En kritik sınır — raporun ana teması |
| 14 | Algoritma simulation'da stabilse gerçek kullanıcıda da stabil olur | Sentetik testin amacı bu yönde ipucu vermek | Aşama 2A §20: davranış durağan değil (stationarity ihlali), EMA rejim değişikliğinde yavaş | Orta | **ORTA** | Sentetik stabilite = "gerçek stabilite garantisi" değil, "gerekli ön koşul" olarak sunulmalı |
| 15 | Baseline olmadan adaptif sistemin katkısı gösterilebilir | Yok | Baseline seçimi literatürü (§25) net: baseline olmadan "katkı" iddiası temelsiz | Düşük | **YÜKSEK eğer baseline atlanırsa** | Her evaluation katmanında en az bir baseline zorunlu tutulmalı |
| 16 | Çok fazla metric daha güçlü evaluation demektir | Yok | SIGIR/CAV deneysel metodoloji rehberleri: "pre-committed tek birincil metrik" ilkesi (§26); çok metrik = post-hoc metrik seçme riski | Düşük | **ORTA** | Birincil metrik önceden seçilmeli, diğerleri "keşifsel" etiketlenmeli |

---

## 29. Unexpected Findings / Promptta Olmayan Önemli Bulgular

1. **Layered Evaluation of Interactive Adaptive Systems (Paramythis, Weibelzahl & Masthoff)** — bu, kullanıcının kendi 6-katmanlı çerçevesinin **bağımsız, önceden var olan** akademik karşılığı. Promptta bu makale ismen aranmadı ama "multi-level evaluation framework" araması onu doğrudan buldu — NotifyMe'nin evaluation mimarisi artık **ad hoc bir öneri değil, kanonik bir HCI çerçevesine dayandırılabilir bir tasarım.** Bu, Tasarım 1 sunumunda güçlü bir referans noktası olabilir.
2. **ORBIT/NIH Stage Model** — kullanıcının sorduğu "büyük deployment olmadan güçlü evaluation mümkün mü" sorusuna, promptta adı geçmeyen ama **tam olarak bu soruyu resmi biçimde çözen** bir kurumsal çerçeve bulundu. Bu, Tasarım 1'in kapsamını ("Stage 0/Ia") net biçimde konumlandırmak için kullanılabilir — jüri/hoca karşısında "bu neden yeterli" sorusuna hazır, isimli bir cevap.
3. **Appropriate reliance / automation bias** kavramı — kullanıcı Aşama 2B'de trust/explainability'yi sorguladı ama "yüksek trust her zaman iyi değildir, appropriate reliance farklı bir şeydir" ayrımı promptta yoktu. Bu, §15'teki "acceptance rate = kalite değil" bulgusunu **daha da güçlendiren** ikinci bir bağımsız kaynak.
4. **Nielsen'in kendi 2012 tarihli güncellemesinin** (nitel vs kantitatif ayrımını kendisi de kabul etmesi) bulunması, "5 kullanıcı efsanesi"nin sadece bir dış eleştiri değil, **orijinal yazarın kendi nüanslı pozisyonunun** kayboluşu olduğunu gösterdi — bu, Aşama 2C'deki "Nielsen gibi practitioner kaynaklar peer-reviewed eleştirilerle birlikte değerlendirilmeli" talimatına tam uyan, beklenmedik derecede zengin bir vaka.

---

## 30. Scientifically Defensible Claims for Tasarım 1

**WE CAN CLAIM IF EVALUATED:**

- "Adaptasyon algoritması (EWMA/CUSUM-tabanlı), kontrollü sentetik senaryolarda enjekte edilen kalıcı sapmaları belirli bir tespit gecikmesi (EDD) ve yanlış-alarm oranıyla (ARL) tespit eder."
- "Adaptasyon önerileri, test edilen sentetik senaryoların hepsinde önceden tanımlanmış sınırları aşmamıştır (bounded)."
- "Goal-trajectory formülü, remaining_time sıfıra yaklaşırken klasik EVM/SPI hatasına düşmemektedir (Earned-Schedule-tarzı düzeltme sayesinde)."
- "LLM tabanlı geri bildirim sınıflandırması, N=[X] elle etiketlenmiş örnekte [Y] macro-F1 ve [Z] Kappa değeriyle çalışmaktadır (geniş güven aralığıyla)."
- "Sistemin arayüzü, [N] deneyimli değerlendiricinin cognitive walkthrough/heuristic evaluation sürecinde [M] öğrenilebilirlik sorunu tespit edilmiş ve giderilmiştir."
- "Küçük bir formative pilotta ([5-15] kullanıcı), katılımcılar sistemi UMUX-LITE/SUS ile [X] puanla (geniş güven aralığı, [%95 GA: A-B]) değerlendirmiştir — bu bir formative/keşifsel bulgudur, temsili bir kesinlik iddiası değildir."

**WE CANNOT CLAIM FROM THIS EVIDENCE:**

- "NotifyMe kullanıcıların sonraki performansını iyileştirir" — bu iddia SCED/N-of-1 düzeyinde bile minimum 3 replikasyon gerektirir (WWC standardı), Tasarım 1'in tek-baseline gözlemi bunu karşılamaz.
- "NotifyMe kullanıcıların Goal başarı oranını artırır" — bu, RCT/büyük-N karşılaştırmalı çalışma gerektirir (ORBIT Stage II+), Tasarım 1 kapsamının çok ötesinde.
- "Recommendation acceptance oranı X% olduğu için öneriler kaliteli" — acceptance rate appropriate-reliance'tan ayrıştırılamadığı sürece bu çıkarım geçersizdir.
- "SUS/UMUX skoru Y olduğu için ürün davranışsal olarak etkilidir" — usability instrument'lar sadece algılanan kullanılabilirliği ölçer, bu farklı bir construct'tur.
- "5-15 kişilik pilot, sistemin genel kullanıcı kitlesinde işe yaradığını gösterir" — Faulkner/Spool'un gösterdiği güvenilirlik aralığı (±%18.5, hatta daha geniş) bunu engeller.
- "Sentetik test sonuçları gerçek kullanıcı davranışını temsil eder" — sentetik veri tanım gereği gerçek insan davranışı içermez.

---

## 31. Implications for NotifyMe

1. **Evaluation mimarisi, kullanıcının önerdiği 6 katman + Paramythis ve ark.'ın layered evaluation çerçevesiyle resmileştirilmeli** — Tasarım 1 raporunda bu, ad hoc bir liste değil, kanonik bir HCI kaynağına dayandırılmış bir yapı olarak sunulmalı.
2. **NotifyMe'nin Tasarım 1 kapsamı, ORBIT/NIH Stage Model terminolojisiyle açıkça "Stage 0/Ia (feasibility, mekanizma)" olarak etiketlenmeli** — bu, jüri karşısında "neden büyük bir kullanıcı çalışması yapmadınız" sorusuna hazır, akademik olarak meşru bir cevap sağlar.
3. **Package A (Minimum Defensible) gerçekçi bir taban, Package B (Balanced) hedeflenebilir bir üst sınır — Package C açıkça önerilmiyor.**
4. **Her iddianın yanına, hangi evaluation katmanının hangi kanıtla desteklendiği açıkça yazılmalı** (§5 matrisi) — bu, Tasarım 1'in en önemli bilimsel olgunluk göstergesi olabilir.
5. **"Ablation study" yerine "component comparison" terimi kullanılmalı** (§24) — küçük ama jüri karşısında fark yaratabilecek bir terminoloji düzeltmesi.
6. **Acceptance rate ve SUS/UMUX skorları raporlanmalı ama "başarı kanıtı" değil "formative sinyal" olarak çerçevelenmeli.**

---

## 32. Candidates for Open-Gaps Cleanup

| Soru | Neden önemli | Phase 3 kararını nasıl etkiler | Aciliyet | Ayrı araştırma gerekli mi |
|---|---|---|---|---|
| NotifyMe'nin Türkiye/kurum bağlamında etik kurul onayı gerektirip gerektirmediği | Küçük pilot planlanırsa hukuki/kurumsal gereklilik belirsiz | Package B/C'nin uygulanabilirliğini doğrudan etkiler | **YÜKSEK** | Evet — danışman hocaya doğrudan sorulmalı, literatür araştırması yetersiz |
| Kaç örneklem LLM sınıflandırma test setinde yeterli (Gwet 2021 formülüyle somut hesaplama) | §17'de yöntem bulundu ama NotifyMe'nin spesifik kategori sayısı/dağılımıyla hesaplanmadı | Package B/C'nin LLM evaluation bütçesini belirler | ORTA | Evet — ama kısa, hesaplama düzeyinde bir iş |
| UMUX-LITE mi SUS mü nihai seçim | §13'te iki aday sunuldu, seçim yapılmadı | Pilot anketinin tasarımını doğrudan etkiler | ORTA | Hayır — Phase 3'te doğrudan karar verilebilir, ek araştırma gerekmez |
| Tau-U'nun NotifyMe'nin olası az-veri senaryosunda pratik hesaplanabilirliği | §21'de yöntem önerildi ama gerçek veri karakteristiğiyle test edilmedi | Package C'nin (önerilmeyen ama gelecekte gündeme gelebilecek) analiz planını etkiler | DÜŞÜK | Hayır, şimdilik — Package C zaten önerilmiyor |
| Multiple-baseline'ın (§11) "organik" (araştırmacı müdahalesi olmadan) retrospektif versiyonunun geçerliliği | Kullanıcının birden fazla aktif Goal'ü varsa doğal bir quasi-deneysel fırsat olabilir | Gerçek pilot verisi toplanırsa analiz derinliğini artırabilir | DÜŞÜK | Belki — ama önce gerçek veri toplanmalı, önden araştırma erken |
| Carver & Scheier'in "disengagement/response shift" bulguları (Aşama 2C §27'den taşındı) | Negatif discrepancy sinyalinin goal'den vazgeçmeye yol açması, evaluation'da "başarısızlık" olarak yanlış yorumlanabilir | Goal-trajectory UI tasarımını ve "başarı" tanımını etkiler | ORTA | Evet — ayrı, odaklı bir mini-araştırma değerli olur |

---

## 33. What Phase 3 Must Decide

- Evaluation paketi olarak **Package A mı Package B mi** benimsenecek (Package C açıkça elenmiş durumda).
- Usability instrument olarak **UMUX-LITE mi SUS mü** (veya ikisi de) kullanılacak.
- Küçük kullanıcı pilotu **yapılacak mı yapılmayacak mı** — yapılacaksa etik/IRB sorusu (§32) önce çözülmeli.
- LLM sınıflandırma test seti **ne zaman, kaç örnekle** oluşturulacak, ve **prompt tuning ile test etme arasındaki ayrım** nasıl korunacak (data leakage riskine karşı, §17).
- Raporun "Scientifically Defensible Claims" bölümü (§30) Tasarım 1 sunumuna/yazılı rapora **birebir** dahil edilecek mi, yoksa sadece iç referans olarak mı kalacak.
- "Ablation" yerine "component comparison" terminolojik değişikliği tüm dokümantasyona (roadmap, README, sunum) yansıtılacak mı.
- §32'deki açık sorulardan hangisi (özellikle etik kurul sorusu) **Phase 3 başlamadan önce** çözülmesi gereken bir blocker.

---

## 34. Sources / Search Queries / Weak Sources

### Kullanılan arama sorguları (temsili liste, 24 gerçek Exa sorgusu çalıştırıldı)

1. single-case experimental design SCED methodological standards guideline What Works Clearinghouse
2. single-case experimental design causal inference confounds history maturation regression to the mean N-of-1
3. multiple baseline design across behaviors causal inference minimum data requirements single-subject
4. SCED analysis methods Tau-U NAP percentage of non-overlapping data effect size single case
5. Nielsen five users usability testing rule critique how many users needed formative evaluation
6. System Usability Scale SUS validation small sample UMUX-Lite UEQ-S comparison psychometric
7. change point detection evaluation metrics average run length detection delay false alarm rate benchmark
8. statistical significance versus engineering validation small sample size effect size confidence interval visual analysis recommendation
9. construct validity proxy metrics measurement validity software engineering behavioral research criterion validity
10. LLM text classification evaluation small labeled dataset inter-rater reliability Cohen's kappa Krippendorff's alpha annotation guideline
11. research ethics informed consent student research project behavioral data minimization small pilot study
12. multi-level evaluation framework software system algorithm behavior human-computer interaction outcome evaluation layers
13. recommender system offline evaluation online evaluation acceptance rate does not equal quality user compliance
14. evaluating digital health intervention without large-scale deployment simulation unit test formative evaluation framework MRC complex interventions
15. ablation study terminology component comparison machine learning versus rule-based system evaluation appropriate use
16. baseline selection empirical evaluation good practices what counts as a fair baseline comparison
17. predefined success criteria acceptance criteria versus post-hoc threshold cherry picking evaluation research
18. appropriate trust reliance on AI recommendation system calibration overtrust automation bias measurement scale
19. ORBIT model behavioral intervention development phases feasibility pilot efficacy stage model NIH
20. N-of-1 trial mobile health app personalization evaluation digital intervention single-user
21. mediation analysis causal chain evaluation multi-stage intervention pathway component-to-outcome
22. expert walkthrough cognitive walkthrough heuristic evaluation without users formative evaluation early stage software
23. Faulkner 2003 beyond five users assumption usability testing Spool Schroeder critique Nielsen
24. algorithm stress testing edge case testing synthetic scenario coverage software validation without production data

### İncelenen kaynak türleri

Kurumsal metodoloji standardı (What Works Clearinghouse / IES, ABD Eğitim Bakanlığı — SCD standartları), NIH resmi çerçeveleri (Stage Model, ORBIT), hakemli dergi makaleleri (*Behavior Research Methods*, *Perspectives on Behavior Science*, *Behavior Therapy*, *Behavior Modification*, *Journal of Counseling and Development*, ACM Transactions on Information Systems, ACM CSUR-benzeri konferans dokümanları), sistematik/kanonik HCI kaynağı (Paramythis, Weibelzahl & Masthoff — layered evaluation), IRB/üniversite etik kurul rehberleri (Stanford, UMassD, Berkeley, UNC, HHS/SACHRP), güncel arXiv çalışmaları (N-of-1 causal inference, appropriate reliance, LLM reliability framework — hepsi açıkça preprint/yeni olarak işaretlendi), pratisyen/HCI ders kaynakları (NN/g — Nielsen'in kendi güncel pozisyonuyla birlikte, eleştirel dengeyle kullanıldı).

### Elenen/zayıf bulunan kaynaklar ve neden

- **"Algorithm stress testing" araması (§23'ün son sorgusu):** sonuçların çoğu 2026 tarihli, düşük-kaliteli pazarlama/pratisyen blogları (dev.to, sqaexperts.com, bugpilot.io) — akademik kanıt olarak **kullanılmadı**, sadece genel yazılım mühendisliği pratiğinin (sentetik stres testi kavramının varlığı) arka plan bilgisi olarak referans verildi. MIT'in MetaEase aracı (eecs.mit.edu haber makalesi, hakemli makalenin kendisi değil) ve STAB (arXiv 2605.27981, hakemli değil henüz) **orta güvenilirlikte**, sadece kavramsal destek için kullanıldı.
- **Mediation analysis kaynakları (§16):** çok teknik, epidemiyoloji/biyoistatistik odaklı (arXiv 2606.02833, PMC6428612, vb.) — NotifyMe'ye **doğrudan uygulanabilirlik yok**, sadece "bu formal çerçeve var ama NotifyMe ölçeğinde kullanılamaz" sonucunu desteklemek için kullanıldı.
- **"Reliable decision support with LLMs" (Megahed ve ark., §17):** Taylor & Francis'te yeni bir dergide (2026), atıf sayısı/tanınırlığı bu oturumda kontrol edilmedi — orta güven, ama metodolojik çerçevesi (4-fazlı, çoklu Kappa) sağlam görünüyor.
- **Park ve ark. KAIST çalışması (Aşama 2B'den, bu fazda tekrar kullanılmadı)** — zaten düşük-orta güven olarak işaretliydi, bu fazda tekrar araştırılmadı.

### Önemli belirsizlikler

- Faulkner (2003) ve Spool & Schroeder (2001)'in tam metnine (sadece abstract/highlights değil) bu oturumda erişilmedi — aktarılan sayılar (%55-99, %35) Exa'nın highlight özetlerinden, birincil kaynağın tam metninden doğrulanmadı.
- WWC SCD standardının **hangi versiyonunun** (4.1, 5.0) güncel olduğu bu oturumda net karıştırılmadı — hem 4.1 hem 5.0 atıfları arama sonuçlarında görüldü, rapor genel ilkeleri (3-gösterim, min. veri noktası) aktarıyor ama versiyon-spesifik farklar (§ "Updated Guidance for Rating SCDs") derinlemesine incelenmedi.
- Lanovaz & Turgeon (2020)'un DOI'si makale başlığında *Perspectives on Behavior Science* olarak geçiyor ama arama sonucunda dergi adı net görünmedi (sadece DOI ve yazar/başlık) — **dergi adı bu oturumda tam doğrulanmadı.**
- Türkiye'ye özgü üniversite etik kurul gerekliliği konusunda **hiçbir Türkiye-spesifik kaynak aranmadı** (kullanıcının talimatına uygun olarak kesin hukuki iddia üretilmedi) — bu, §22 ve §32'de açık bir soru olarak bırakıldı, Mustafa'nın kendi kurumuna sorması gerekiyor.

---

**Durum:** Aşama 2D tamamlandı. Kod/repo/roadmap değişikliği yapılmadı, algoritma implement edilmedi, nihai evaluation paketi kararı verilmedi, commit/push yapılmadı. Bu, Tasarım 1 araştırma serisinin (Aşama 1, 2A, 2B, 2C, 2D) son büyük akademik fazıdır — beş rapor birlikte Faz 3 kararlarına (roadmap, mimari, evaluation planı) temel oluşturacak durumda.

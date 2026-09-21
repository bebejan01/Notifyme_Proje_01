# NotifyMe — Tasarım 1 Araştırması — Aşama 2C: Akademik Literatür — Goal Trajectory + Pace + Hierarchical Progress

**Tarih:** 2026-09-20
**Kapsam:** Goal-seviye ilerleme/hız (trajectory/pace), Goal→Task hiyerarşisi, workload-based progress, planned-vs-actual progress, EVM/Earned Schedule, expected progress curve, velocity/trend, remaining-work/remaining-time, deadline forecasting, goal feasibility/capacity, multiple goals, bu algoritmanın test edilebilirliği. Serbest metin LLM sınıflandırması, failure attribution (Aşama 2B'de yapıldı), rakip ürünler (Aşama 1), genel AI planner araştırması, akademik literatürün genel değerlendirme metodolojisi (Aşama 2D) bu raporun konusu DEĞİL.
**Önceki raporlar (okundu, değiştirilmedi):** `notifyme_competitor_analysis_phase1.md`, `notifyme_academic_adaptation_closed_loop_phase2a.md`, `notifyme_academic_feedback_human_factors_phase2b.md`.
**Amaç:** NotifyMe'nin "task tamamlansa da goal geride kalabilir" sezgisini doğrulamak DEĞİL. Literatürde bu ayrımın gerçek akademik karşılığını bulmak, varsayımları (linear trajectory, remaining_work/remaining_time formülü, workload eşitliği) çürütmeye çalışmak.

---

## 1. Executive Summary

Bu araştırmanın en önemli bulgusu, kullanıcı mesajında hiç adı geçmeyen bir literatürden geldi (bkz. §25 Unexpected Findings): **Carver & Scheier'in kontrol-teorisi tabanlı öz-düzenleme modeli** (1982, 1990, 1998) NotifyMe'nin "task tamamlansa da goal'un gerisinde kalma" sezgisini — "PROGRESS ≠ PACE" ayrımını — 40+ yıllık, çok atıflı bir psikolojik çerçeveyle **doğrudan ve tam olarak** formalize ediyor. Bu model iki ayrı feedback loop öngörüyor: biri **discrepancy'yi** (hedefe kalan mesafe = PROGRESS) azaltmaya çalışıyor, diğeri bu azaltmanın **hızını** (velocity of discrepancy reduction = PACE) izliyor ve bu hıza göre duygu (affect) üretiyor. **Bu, NotifyMe'nin sorduğu "LEVEL ve TREND ayrı tutulmalı mı" sorusuna literatürden gelen en doğrudan, en güçlü "evet" cevabı.**

İkinci büyük bulgu: **kesin (linear) beklenen ilerleme eğrisi varsayımı yanlış** — hem inşaat/proje yönetimi literatüründeki S-curve modelleri (ilerleme başta yavaş, ortada hızlı, sonda yavaş) hem de Carver & Scheier'in "coasting" (öndeyken gevşeme) bulgusu, doğrusal beklentinin naif olduğunu gösteriyor.

Üçüncü büyük bulgu: **EVM'nin klasik zaman göstergesi (SPI) kullanıcının talimatında öngörülen şekilde gerçekten kusurlu** — ama bunun akademik/mühendislik camiasında zaten bilinen, **çözülmüş** bir sorunu var: **Earned Schedule (Lipke, 2003)**. ES, SPI'nin "geç biten projede sonunda yapay olarak 1.0'a yakınsama" hatasını düzeltiyor ve 16 gerçek projede EVM'nin dört klasik yöntemine karşı istatistiksel olarak (Sign Test) daha iyi tahmin ürettiği gösterilmiş. Ancak **Reference Class Forecasting (Flyvbjerg)** karşılaştırmalı çalışmalarda hem EVM'yi hem Monte Carlo'yu geçiyor — ama yalnızca yeterince benzer bir "referans sınıf" (geçmiş, karşılaştırılabilir proje/goal havuzu) varsa. **NotifyMe'nin tek-kullanıcı, erken-aşama, idiosenkratik hedef bağlamında (her Goal'ün "10km koşmak" ya da "Calculus öğrenmek" gibi biricik olması) hiçbir yöntem için yeterli "referans sınıf" veya kalibrasyon verisi yok** — bu, raporun tekrar eden bir teması.

Dördüncü büyük bulgu: **workload-based progress (task sayısı yerine iş miktarı) fikri akademik/profesyonel proje yönetimi camiasında zaten standart bir eleştiri** ("simple averaging" hatası, WBS ağırlıklandırma ihtiyacı) — ama "bilgi işi" (knowledge work, NotifyMe'nin çoğu Task'ı gibi: "Calculus çalış", "video izle") için **doğal bir ölçü birimi yok**, bu literatürün kendisinin kabul ettiği çözülmemiş bir problem.

Beşinci bulgu, kullanıcının kendi CAUSE→RESPONSE varsayımına yakın bir uyarı: **SMART hedeflerin ("spesifik, ölçülebilir") bilimsel temeli sanılandan zayıf** — yeni bir sistematik derleme SMART'ın "teori-temelli olmadığını", bazı bağlamlarda (erken öğrenme, karmaşık görev) spesifik/ölçülebilir hedeflerin belirsiz/açık-uçlu hedeflerden **daha iyi olmadığını** gösteriyor. Bu, NotifyMe'nin "her Goal ölçülebilir bir sayısal hedefe sahip olmalı" varsayımını (§18) doğrudan sorguluyor.

---

## 2. Scope and Methodology

Kapsam kullanıcı talimatındaki 30 bölümün tamamı; ayrıca literatür beklenmedik bir alana yönlendirdiğinde (Carver & Scheier kontrol teorisi, Kruglanski goal systems theory) oraya gidildi — talimat gereği ("promptta adı geçmedi diye değerli bir alanı eleme"). Goal trajectory algoritmasının test edilebilirliği için gerekli evaluation bilgisi araştırıldı, Phase 2D'nin genel değerlendirme metodolojisine (N=1 tasarım, kullanıcı pilotu) girilmedi.

---

## 3. Terminology — "Goal Trajectory" Akademik Karşılığı Nedir?

Kullanıcının "Goal Trajectory" terimi tek bir akademik isimle karşılık bulmuyor, birden fazla alanda farklı isimlerle var:

- **Psikoloji (bireysel öz-düzenleme):** "discrepancy reduction", "rate of progress", "velocity of goal pursuit" (Carver & Scheier, §4, §10).
- **Proje yönetimi:** "schedule performance", "earned schedule", "schedule variance (time)" (§8).
- **Öğrenme analitiği:** "learning trajectory", "progress monitoring", ama çoğunlukla task-completion/time-on-task proxy'leri üzerinden (§14).
- **Operasyon araştırması:** "makespan", "resource-constrained scheduling" (§17).
- **Agile yazılım:** "velocity", "burndown/burnup forecasting" (§13).

**Sonuç:** NotifyMe'nin aradığı "task'lar tamam ama goal geride" senaryosunu **birebir bu isimle** ele alan tek bir disiplin yok — ama psikolojideki "velocity of discrepancy reduction" kavramı (Carver & Scheier 1990) kavramsal olarak en yakın ve en olgun karşılık. **Kanıt seviyesi: Var — doğrulandı** (Carver & Scheier'in 40+ yıllık, çok atıflı literatürü).

---

## 4. Task Performance vs Goal Progress

**Ana bulgu (Carver & Scheier kontrol teorisi, §25'te detaylı):** Carver & Scheier (1982, *Psychological Bulletin*, DOI 10.1037/0033-2909.92.1.111; 1990, *Psychological Review*, DOI 10.1037/0033-295X.97.1.19) discrepancy-reducing feedback loop modelinde **iki ayrı katman** öngörüyor: (1) davranışı yönlendiren "action loop" — mevcut durum ile hedef arasındaki farkı (discrepancy) azaltmaya çalışır, bu NotifyMe'nin Task-seviyesi tamamlanmasına karşılık gelir; (2) bu azalmanın **hızını** izleyen ikinci bir loop — "rate of progress towards goals" — pozitif/negatif affect üretir. **Kritik alıntı:** "if a person is moving faster than her desired rate of progress towards her goal, she experiences positive affect. Conversely, if a person is moving slower than her desired velocity, she experiences negative affect." Bu ikinci loop **tam olarak** NotifyMe'nin "task'ları tamamlıyor ama goal'un gerisinde" senaryosunun matematiksel/psikolojik karşılığı — kullanıcı task'ları (action loop) tamamlıyor olabilir ama velocity loop hâlâ negatif olabilir.

**A sorusunun cevabı:** Evet, task performance ve goal progress ayrı kavramlar olarak modellenmeli — bu, akademik olarak en güçlü destekli bulgulardan biri (kanıt seviyesi: **Var — doğrulandı**, klasik+güncel psikoloji literatürü).

---

## 5. Goal Hierarchies

Carver & Scheier'in modeli aynı zamanda **hiyerarşik** — Wright, Carver & Scheier (2000, *On the Self-Regulation of Behavior*, Cambridge UP, DOI 10.1017/cbo9781139174794) kitabının bölüm başlıkları arasında doğrudan "Goals, hierarchicality, and behavior" ve "Hierarchicality and problems in living" var — üst-seviye (program/principle/system-concept) hedeflerin alt-seviye (davranış) hedeflerini yönlendirdiği bir kontrol hiyerarşisi öneriliyor. **Bu, NotifyMe'nin Goal→Task hiyerarşisiyle kavramsal olarak uyumlu, ama modelin kendisi 3+ seviyeli soyut bir hiyerarşi öneriyor (NotifyMe'de 2 seviye: Goal→Task).**

**Q sorusunun cevabı:** Kavramsal olarak Carver & Scheier'in kontrol-hiyerarşisi + Kruglanski'nin goal-systems mimarisi (§20) iki tamamlayıcı çerçeve sağlıyor — biri "üst hedef alt davranışı nasıl yönlendirir" (dikey), diğeri "aynı seviyedeki hedefler birbiriyle nasıl ilişkilenir" (yatay, multifinality/equifinality). **Kanıt seviyesi: Var — doğrulandı (kavramsal çerçeve), NotifyMe'nin 2-seviye somut şemasına doğrudan formül vermiyor.**

---

## 6. Workload-Based Progress

**C sorusunun cevabı (task count neden yetersiz):** Doğrudan, güçlü destek var — hem proje yönetimi pratiği hem akademik literatür. Profesyonel PM kaynakları (Primavera P6 dokümantasyonu, planningengineer.net) "simple averaging" (her task'ı eşit ağırlıklı saymak) hatasını **standart bir bilinen problem** olarak ele alıyor: "a two-hour administrative task... carries the same weight as a three-month core system build." Çözüm önerisi: **weighted progress contribution** — task'lara süre/maliyet/karmaşıklık bazlı ağırlık atamak, PMBOK'un WBS (Work Breakdown Structure) prensibiyle uyumlu.

**Akademik destek:** Sharp (2013), "Quantifying Task Output and Project Value in Knowledge-Work Contexts" (ISAHP konferansı, DOI 10.13033/isahp.y2013.069) — **tam olarak NotifyMe'nin problemine** (bilgi işi/knowledge work task'larının doğal bir ölçü birimi yok) AHP/ANP (Analytic Hierarchy Process) ile çözüm arıyor: alt-görevleri büyüklük/karmaşıklık/kalite kriterlerine göre pairwise karşılaştırıp göreli ağırlık çıkarma. Makale ayrıca EVM'nin "planned cost = değer" varsayımını ("implicit/labour theory of value") eleştirip "subjective theory of value" (ekip/kullanıcının kendi önceliğine göre ağırlık) öneriyor.

**D sorusunun cevabı:** Workload-based progress, farklı Task'lar **aynı birimde** (örn. hepsi "soru sayısı") olduğunda doğrudan uygulanabilir (NotifyMe'nin `plannedAmount`+`unit` alanı bunu destekliyor). Ama **farklı birimlerdeki** Task'ları (100 soru + 2 saat video + 3 deneme) **tek bir sayıya birleştirmek** için literatürde hazır bir formül yok — Sharp'ın AHP/ANP yaklaşımı teorik olarak mümkün ama ağır (her Task için pairwise karşılaştırma), NotifyMe'nin erken aşaması için **over-engineering**. **Kanıt seviyesi: Var — doğrulandı ki eşit-ağırlık yanlış (proje yönetimi standardı); farklı-birim birleştirme için Yok — literatürde hazır çözüm bulunamadı, açık problem.**

---

## 7. Planned vs Actual Progress

Bu bölümde araştırmanın **ikinci en kritik bulgusu** var: **Smyth, Milyavskaya, Friese, Werner, Frech, Loschelder ve ark. (2023), "What Constitutes Successful Goal Pursuit? Exploring the Relation Between Subjective and Objective Measures of Goal Progress"** (*Personality Science*, DOI 10.5964/ps.12017). 4 veri seti, 351 katılımcı, akademik+kilo-verme hedefleri. **Bulgu:** subjektif ilerleme algısı ile objektif ilerleme ölçümü arasındaki ilişki **R² = .05–.39** — yani objektif ve subjektif ölçümler **"related but distinct constructs"** (ilişkili ama farklı yapılar), aynı şeyi ölçmüyorlar. Makale ayrıca literatür taramasında benzer bulguları özetliyor: akademik performans r=.14-.34, fiziksel aktivite r=.01-.53, iş performansı r=.28-.39, kariyer başarısı r=.26-.47 — **hiçbiri r=.50'yi (paylaşılan varyansın %25'i) geçmiyor.**

**Bu, NotifyMe'nin Aşama 2B'de bulduğu self-serving bias bulgusuyla (d=0.96) birleşince çift yönlü bir uyarı oluşturuyor:** hem kullanıcının kendi "ilerleme hissi"nin objektif veriye zayıf denk düştüğü, hem de bunun bir "hata" olmaktan çok, farklı bir yapıyı (motivasyon, öz-değerlendirme) ölçtüğü kabul edilmeli — NotifyMe'nin plannedAmount/actualAmount (objektif) ile kullanıcının kendi "nasıl gidiyor" algısı arasında sistematik bir fark **beklenmeli**, bu bir "sistem hatası" değil.

**E sorusunun cevabı:** planned-vs-actual karşılaştırması yapılabilir (objektif veri var), ama sonucun kullanıcının kendi algısıyla uyuşmayabileceği, bu uyuşmazlığın **normal** olduğu (bir çelişki/hata sinyali değil) kabul edilmeli. **Kanıt seviyesi: Var — doğrulandı, orta-güçlü (4 veri seti, meta-düzey karşılaştırma).**

---

## 8. EVM / Earned Schedule

**O sorusunun cevabı:** Klasik EVM'nin schedule göstergeleri (SV, SPI) **gerçekten kusurlu** ve bu kusur kullanıcının sezgisiyle örtüşüyor. Lipke (2003, "Schedule is Different", *The Measurable News*) ve sonraki çalışmalar: **geç biten bir projede, proje tamamlandığında SV=0 ve SPI=1.0'a yakınsıyor — yani gösterge "mükemmel performans" diyor, oysa proje geç bitmiş.** Bunun nedeni: SPI, planlanan maliyete (PV) göre referanslı, zamana göre değil.

**Çözüm zaten var — Earned Schedule (ES):** Lipke'nin geliştirdiği zaman-tabanlı gösterge (SV(t), SPI(t)) bu sorunu düzeltiyor: "ES facilitates time-based analysis... indicators perform reliably for either early or late performing projects." Bağımsız doğrulama: Henderson (2003) 6 gerçek projede geriye dönük test; **Vanhoucke & Vandevoorde** simülasyon çalışması ("ES outperforms, on average, the other forecasting methods" — *The Measurable News*, 2007-2008); Lipke'nin kendi 16-proje çalışması, Sign Test ile ES'nin 4 klasik EVM yöntemine karşı **istatistiksel olarak anlamlı biçimde** daha iyi tahmin ürettiğini gösteriyor (neredeyse her %-tamamlanma aralığında).

**Ama kritik dürüstlük notu (P sorusuyla bağlantılı):** ES, çok-aktiviteli, **kümülatif bütçe/maliyet eğrisi** üzerinden çalışıyor — NotifyMe'nin tek bir Goal'ü (genelde birkaç-onlarca Task) için PV/EV/AT kavramlarının **anlamlı hale gelmesi için yeterli granülerlik/veri** gerekir. Tek kullanıcı, tek Goal, düzinelerce Task ölçeğinde ES'nin **matematiği** aktarılabilir (kavramsal olarak "PV=EV olduğu an neredeydi" hesaplaması küçük ölçekte de yapılabilir) ama **istatistiksel güvenilirlik** iddiası (16-proje çalışmasındaki gibi) NotifyMe ölçeğinde **doğrulanamaz**.

**Kanıt seviyesi: Var — doğrulandı (ES, EVM'nin bilinen bir kusurunu çözüyor, ampirik destekli); NotifyMe'ye doğrudan uygulanabilirlik — mühendislik uyarlaması, ölçek farkı nedeniyle istatistiksel garantiler geçerli değil.**

---

## 9. Expected Progress Curves

**F sorusunun cevabı (linear ne zaman yanlış):** İnşaat proje yönetimi literatüründe **S-curve** kavramı (kümülatif ilerleme zamana karşı) neredeyse hiçbir zaman doğrusal değil — Chao & Chien (2009, *J. Constr. Eng. Manage.*, DOI 10.1061/(asce)0733-9364(2009)135:3(169)), Bhaumik (2016, beta S-curve, erken/geç şekil parametreleri) ve Barraza, Back & Mata (2000, stochastic SS-curves) gibi çalışmalar S-curve'ün **başta yavaş, ortada hızlı (inflection point), sonda yavaş** bir şekil aldığını, bunun proje karmaşıklığı/kaynak yoğunlaşmasına bağlı olduğunu gösteriyor.

**Önemli sınırlama:** Bu modeller **101 proje** (Chao & Chien) gibi büyük geçmiş veri setleriyle kalibre ediliyor — inşaat sektörüne özgü, kurumsal ölçekte. NotifyMe'nin tek-kullanıcı, tek-Goal bağlamında böyle bir kalibrasyon verisi **yok ve olmayacak** (her Goal biricik: "10km koşmak" bir kez yaşanır, "S-curve şekli" öğrenilecek tekrarlı örneklem üretmez — kategori bazında biriken çoklu Goal geçmişi olursa uzun vadede kısmen mümkün olabilir, ama bu spekülatif).

**G sorusunun cevabı:** Alternatif eğri türleri var (front-loaded, back-loaded, S-curve, learning-curve) ama **hangi Goal türünün hangi eğriye uyacağını önceden bilmek** için akademik bir sınıflandırma bulunamadı — NotifyMe'nin başlangıçta **doğrusal beklenti + geniş tolerans bandı** kullanması (S-curve karmaşıklığından kaçınarak) daha dürüst bir minimum, S-curve tahmini iddiası şu an literatürden **desteklenmiyor** (veri yetersizliği nedeniyle). **Kanıt seviyesi: Var — doğrulandı ki linear varsayım naif; Yok — NotifyMe ölçeğinde S-curve kalibrasyonu için literatür destekli bir yöntem yok.**

---

## 10. Progress Level vs Trend / Velocity

**H sorusunun cevabı — bu araştırmanın en net "evet"i:** Carver & Scheier'in modeli **LEVEL (discrepancy, ne kadar kaldı) ve VELOCITY'yi (rate of discrepancy reduction) açıkça iki ayrı, paralel çalışan sistem olarak tanımlıyor** (§4). Bu ayrım sadece kavramsal değil, **davranışsal sonuçları da öngörüyor: "coasting" fenomeni.** Model, kullanıcı beklenen hızın **üstünde** ilerlerken pozitif affect'in kullanıcıyı **"coast"** etmeye (efor azaltmaya) yönelttiğini savunuyor — "people who exceed the criterion rate of progress... will automatically tend to reduce subsequent effort... They will 'coast' a little." **NotifyMe için doğrudan tasarım uyarısı:** kullanıcıya "hedefinin önündesin" göstermek, saf motivasyon artışı sağlamak yerine **efor azaltmasına (coasting) yol açabilir** — bu, Aşama 2B'nin "kullanıcı önerinin açıklamasını görmek ister mi" bulgusuna paralel, tahmin edilmeyen bir davranışsal risk.

**I sorusunun cevabı (recent velocity ne kadar anlamlı):** Aşama 2A'daki EWMA/CUSUM bulgusuyla (Schat ve ark. 2021) doğrudan bağlantılı — "tek kötü gün"ü filtrelemek için EWMA/CUSUM kullanılabiliyorsa, aynı mantık "recent velocity"yi (son N günün hızı) LEVEL'dan ayrı, kendi kontrol-limitiyle izlemek için de uygulanabilir. **Kanıt seviyesi: Var — doğrulandı (Carver & Scheier + Aşama 2A'nın EWMA/CUSUM bulgusuyla tutarlı).**

---

## 11. Remaining Work / Remaining Time

**J sorusunun cevabı:** `pace_ratio = actual_rate / required_rate` formülü **literatürde bu isimle bulunamadı**, ama kavramsal olarak Earned Schedule'ın **SPI(t) = ES/AT** oranıyla (§8) matematiksel olarak eşdeğer bir mantık — "beklenen ilerleme noktası / gerçekleşen zaman" oranı. **PERT'in kendi eleştirisi** (§12) burada da geçerli bir uyarı: basit oran/nokta-tahmini yöntemleri **belirsizliği/varyansı** hesaba katmıyor, "remaining_time küçüldükçe" davranışı (SV/SPI'nin proje sonuna doğru yapay biçimde yakınsaması) tam olarak ES'nin çözdüğü sorun.

**Sonuç:** Formül **kavramsal olarak makul** (ES'in matematiğiyle akraba) ama "doğru" olduğu literatürden **gelmiyor** — Tasarım kararı olarak işaretlenmeli, ES'in zaten çözdüğü "remaining_time→0 iken davranış" sorununa karşı **ES'in kendi düzeltmesi (SPI(t) değil SPI ($) kullanma)** benimsenmeli. **Kanıt seviyesi: Dolaylı destekli (ES'le matematiksel akrabalık), doğrudan literatür yok.**

---

## 12. Deadline Forecasting

**M sorusunun cevabı (deterministic/statistical/probabilistic):** Üç yöntem ailesi bulundu, hepsinin **veri ihtiyacı NotifyMe'nin erken aşamasını aşıyor**:

- **PERT (three-point estimation):** Klasik, yaygın, ama akademik olarak **ciddi şekilde eleştirilmiş**. Ballesteros-Pérez, Larsen & González-Cruz (2018, *J. Technology and Science Education*, DOI 10.3926/jotse.303): PERT **sistematik olarak proje süresini az tahmin ediyor, varyansı fazla tahmin ediyor** — RAND Corporation'ın 1964 raporundan (MacCrimmon & Ryavec) beri bilinen bir kusur. Trietsch (PERT21 alternatifi) ve Kim, Hammond & Bickel (2014, DOI 10.1109/tem.2014.2304977) PERT'in dağılım/varyans varsayımlarının hatalı olduğunu gösteriyor. **NotifyMe'nin "3 nokta tahmini" (en iyi/en olası/en kötü) gibi basit bir yaklaşım denemesi durumunda bu bilinen tuzaklara düşme riski var — literatür "basit ama yanıltıcı" diyor.**
- **Monte Carlo simülasyonu (agile bağlamda):** Miranda ve ark. (2021, ACM SAC, DOI 10.1145/3412841.3442030) gerçek proje verisiyle test etmiş: teslim tarihi tahmininde MMRE %32 (geliştirici tahminlerinin %134 hatasından çok daha iyi), ama **20+ geçmiş veri noktası** gerektiğini bulmuş. NotifyMe'nin tek-Goal erken aşamasında bu veri hacmi yok.
- **Reference Class Forecasting (RCF):** Flyvbjerg (2006, *Project Management Journal*; arXiv 1302.3642) — Kahneman & Tversky'nin "outside view" teorisine dayanan yöntem, planning fallacy'yi (Aşama 2A'da bulunmuştu) doğrudan hedef alıyor. Batselier & Vanhoucke (2016) karşılaştırmalı çalışması **RCF'nin hem EVM'yi hem Monte Carlo'yu geçtiğini** buluyor — **ama sadece** "referans sınıfı" (benzer geçmiş proje/Goal havuzu) **yeterince benzer ve büyükse.** Cantarelli'nin 2025 eleştirel derlemesi bunu netleştiriyor: küçük şirketler/az sayıda proje türü için RCF'nin **uygulanabilirliği sınırlı.**

**Sonuç (K, L, M soruları birlikte):** NotifyMe'nin şu anki (tek kullanıcı, her Goal biricik) bağlamında **hiçbir olasılıksal forecasting yöntemi için yeterli referans sınıfı/kalibrasyon verisi yok.** Deterministic ("bu hızla X günde biter") **tek dürüst seçenek** — ama SPI'nin klasik hatasına (§8) düşmemek için Earned-Schedule-tarzı zaman-bazlı formül kullanılmalı, çıplak yüzde değil. Probabilistic iddia (%X olasılıkla yetişecek) **şu an sahte kesinlik (false precision)** olur — literatür bunun için en az 20 karşılaştırılabilir geçmiş veri noktası istiyor (Monte Carlo bulgusu). **Uzun vadede** (kullanıcı aynı kategoride — örn. "sınav hazırlığı" — çok sayıda Goal tamamladıkça) kişisel bir reference class oluşabilir, bu ileriye dönük bir tasarım fırsatı olarak not edilebilir ama Tasarım 1 kapsamında değil.

---

## 13. Agile / Burndown / Velocity

Software project management'taki "velocity" (sprint başına tamamlanan iş miktarı) kavramı, workload-based progress (§6) ile matematiksel olarak aynı fikir — "task sayısı değil iş miktarı" ilkesi zaten agile'ın temel prensibi (story point). Ama akademik/practitioner ayrımı önemli: Monte Carlo forecasting (§12) **peer-reviewed**; "burndown chart"ın kendisi **practitioner pratiği**, doğrudan akademik değerlendirme bulunamadı bu oturumda.

**P sorusunun cevabı — bilinen sorunlar:** Agile velocity'nin proje yönetimi pratiğinde iyi bilinen 3 sınırlaması (bu oturumda akademik makale yerine practitioner/mühendislik kaynaklarından, ama tutarlı biçimde tekrarlanan): (1) takımlar/kişiler arası karşılaştırılamaz (her "story point" göreceli), (2) geçmiş velocity gelecek performansı garanti etmiyor (rejim değişimi — tam olarak Aşama 2A'nın EMA "yavaş tepki" uyarısıyla aynı sorun), (3) gaming riski (kolay puanlamak için story point şişirme — NotifyMe'nin Aşama 2B'de bulunan "kullanıcı kolay hedef seçme" riskiyle paralel). **NotifyMe'ye aktarılabilirlik:** kavramsal olarak evet (workload-per-period ölçümü), ama tek-kullanıcı bağlamında "takımlar arası karşılaştırma" sorunu geçersiz (sadece kendi geçmişiyle karşılaştırılıyor), gaming ve rejim-değişimi riskleri **geçerli.**

---

## 14. Learning Analytics Perspective

**R sorusunun cevabı (proxy metrics/Goodhart's Law):** Bu bölüm, kullanıcının "1000 soru çözmek Calculus öğrenmeyi garanti eder mi" sorusuna **açık ve rahatsız edici bir "hayır" ile cevap veriyor.**

- **Time-on-task ölçümünün kendisi bile güvenilmez:** Kovanović ve ark. (learninganalytics.upenn.edu, *Journal of Learning Analytics* 2015, DOI 10.18608/jla.2015.23.6) time-on-task tahmininin metodolojiye göre (10/30/60 dk eşiği vb.) **sonuçları önemli ölçüde değiştirdiğini** gösteriyor — NotifyMe'nin `plannedDuration`/`actualDuration` verisi bile, ölçüm metodolojisine bağlı sistematik hataya açık.
- **Gaming/proxy sorunu doğrudan kanıtlı:** Knowledge Tracing (KT) model literatüründe (arXiv 2512.18659, 2025) öğrencilerin "gaming the system" (ipucu istismarı, deneme-yanılma tıklama) davranışının model doğruluğunu **AUC'de %15.2'ye kadar düşürdüğü** gösteriliyor — "increased engagement may be the result of gaming behaviors, which constitutes ineffective participation."
- **Trace data ile self-report arasında zayıf/tersine ilişki:** Zhou & Winne çalışmasının izinden giden bir 2023 makale (heeryung.github.io, LAK23) prospektif anketlerde "mastery-oriented" diyen öğrencilerin **yarısından fazlasının** trace data'da düşük-katılım (disengaged) kümesine düştüğünü buluyor — "learners' self-reports did not translate into behaviors."
- **"Mastering" grubu farklı davranış örüntüsü gösteriyor, sadece aktivite sayısı değil:** 2025 bir çalışma (*Educational Technology Research and Development*, DOI 10.1007/s11423-025-10528-4) mastery-odaklı öğrencilerin quiz aktivitelerinde (görüntüleme, gönderim, tekrar, puan) tutarlı biçimde daha yüksek performans gösterdiğini ama **self-assessment task'larının** sonuçla korelasyon göstermediğini buluyor — yani **her aktivite türü eşit bilgi vermiyor.**

**Sonuç:** "1000 soru çöz" gibi bir proxy hedef **aktivite** ölçer, **öğrenme/mastery**'yi garanti etmez — bu tam olarak Goodhart's Law'ın ("bir ölçü hedef haline geldiğinde iyi bir ölçü olmaktan çıkar") klasik formülasyonu, burada doğrudan isimlendirilmedi ama davranışsal kanıtla (gaming, trace-self-report uyumsuzluğu) doğrulandı. **NotifyMe'nin Goal-seviye "workload tamamlandı" göstergesi, "Goal gerçekten başarıldı" anlamına gelmeyebilir — bu ayrımın kullanıcıya (ve Tasarım 1 sunumunda) açıkça belirtilmesi gerekiyor.** **Kanıt seviyesi: Var — doğrulandı, çok kaynaklı.**

---

## 15. Goal-Setting / Goal Pursuit Perspective

**Beklenmedik ikinci büyük bulgu (bkz. §25):** SMART hedeflerin bilimsel temeli literatürde **ciddi şekilde sorgulanıyor.** Bir narrative review (*Health Psychology Review*, "(over)use of SMART goals for physical activity promotion") ve yeni bir deneysel çalışma (Pietsch, Riddell, Semmler, Ntoumanis & Gucciardi, 2024, DOI 10.1080/01443410.2024.2420818) şunu buluyor:

- **SMART, teori-temelli bir strateji değil** — Doran'ın 1981 orijinal makalesi akademik goal-setting teorisine (Locke & Latham) dayanmıyor.
- **"Spesifik" olmak her zaman daha iyi değil:** McEwan ve ark. (2016) meta-analizi, fiziksel aktivitede spesifik hedeflerle (d=0.589) belirsiz/açık-uçlu hedefler (d=0.511) arasında **anlamlı fark bulamıyor.**
- **"Achievable/Realistic" kriteri goal-setting teorisiyle çelişiyor** — Locke & Latham'ın kendi bulgusu (Aşama 2A'da bulunmuştu) **zor** hedeflerin kolay/"gerçekçi" hedeflerden daha iyi performans ürettiği yönünde; SMART'ın "achievable" vurgusu bunun tam tersini öneriyor.
- **Goal türü önemli:** karmaşık/yeni bir görevin **erken aşamasında** "do-your-best" (DYB) veya "open" (açık-uçlu, keşif odaklı) hedefler spesifik hedeflerden **daha iyi** performans üretebiliyor (Hawkins ve ark. 2020, Schweickle ve ark. 2017) — çünkü spesifik hedef, doğru stratejiyi bulma sürecini zorlaştırıyor ve performans kaygısı yaratıyor.
- **SMART hedefler algılanan başarılabilirliği düşürebiliyor:** bir 6-dakikalık yürüme testi çalışmasında SMART hedef koşulunda katılımcılar hedefi kontrol/açık-uçlu koşullardan **anlamlı biçimde daha az başarılabilir** algılıyor (d=-1.19 ile -1.95 arası).

**NotifyMe için sonuç:** "Her Goal sayısal, ölçülebilir bir hedefe sahip olmalı" varsayımı (§18'deki uncertainty tartışmasıyla doğrudan bağlantılı) literatür tarafından **evrensel olarak desteklenmiyor** — özellikle yeni/karmaşık öğrenme hedeflerinde (NotifyMe'nin ana kullanım senaryosu: "Calculus öğren", "Python öğren") açık-uçlu/öğrenme-odaklı hedefler akademik olarak **en az spesifik hedefler kadar meşru**, bazı bağlamlarda daha iyi. **Kanıt seviyesi: Var — doğrulandı, güncel (2024) deneysel + meta-analitik kanıt.**

---

## 16. Goal Feasibility and Capacity

**N sorusunun cevabı:** Operasyon araştırması alanında bu tam olarak **Resource-Constrained Project Scheduling Problem (RCPSP)** — 1960'lardan beri (Dike 1964, Kelley 1963) çalışılan, **NP-hard** olduğu kanıtlanmış, 50+ yıllık zengin bir literatür (van der Beek ve ark. 2025, *European Journal of Operational Research* özel sayısı özeti). RCPSP formel olarak "verilen kaynak kapasitesiyle bir görev kümesinin fizibilitesi/optimal zamanlaması" sorusunu tam olarak modelliyor.

**Ancak ölçek/karmaşıklık uyarısı:** RCPSP'nin klasik çözümleri (branch-and-bound, metaheuristics, constraint programming) endüstriyel ölçek (onlarca-yüzlerce aktivite, çoklu kaynak türü) için geliştirilmiş, **NP-hard** karmaşıklığı NotifyMe'nin "birkaç Goal + günlük Task'lar" ölçeğinde gereksiz ağır. **Yeni, ilginç bir niş uygulama bulundu:** de Jong (JKU Linz, yüksek lisans tezi, MiniZinc ile "A Constraint-Based Approach to Personal Task Scheduling") **RCPSP'nin bireysel/kişisel yaşam zamanlamasına** uygulanmasını deniyor — ama bu **hakemli bir dergi makalesi değil, bir tez**, akademik olgunluğu düşük, "gap exists in the literature regarding application of these industrial-strength tools to personal life scheduling" diye kendi de kabul ediyor.

**Sonuç:** Goal feasibility'nin formel akademik karşılığı **var** (RCPSP) ama NotifyMe ölçeğinde **doğrudan uygulanması aşırı mühendislik olur** — basit bir "remaining_workload / available_capacity" oranı (RCPSP'nin "kapasite" fikrini basitleştirilmiş haliyle ödünç alan) daha gerçekçi bir Tasarım 1 minimum'u. **Kanıt seviyesi: Var — doğrulandı (RCPSP formalizmi mevcut), ama NotifyMe ölçeğine "uygun" değil — aşırı karmaşık.**

---

## 17. Availability / Resource Constraints

RCPSP'nin "her resource'un sabit kapasitesi var" varsayımı (§16, `Bk` — renewable resource capacity) NotifyMe'nin "kullanılabilir zaman" fikrine doğrudan karşılık geliyor — kullanıcının günlük saatleri = renewable resource capacity. **K sorusunun cevabı:** Evet, `remaining_workload / remaining_availability` (RCPSP'nin basitleştirilmiş, tek-kaynaklı hali) `remaining_workload / calendar_days`'den **kavramsal olarak daha doğru** — literatür (RCPSP'nin temel tanımı) bunu destekliyor, çünkü calendar_days kullanılabilir kapasiteyi temsil etmiyor. Ama **NotifyMe'nin şu anki mimarisinde `availability` verisi (FAZ1 şemasında) henüz yok** — bu Tasarım 1 için bir mimari eklenti gereksinimi olarak not edilmeli (kod değişikliği önerilmiyor, sadece gözlem).

---

## 18. Uncertainty and Unmeasurable Goals

§15'teki SMART eleştirisiyle doğrudan bağlantılı: bazı Goal'ler (örn. "Python öğren") doğası gereği **gözlemlenebilirliği düşük.** Muhasebe/yönetim literatüründeki bir kavram — "observability" (Amir, *Abacus*, "Observability and Subjective Performance Measurement") — objektif ölçümün **güvenilirliği düşükse veya davranış gözlemlenemezse**, subjektif değerlendirmenin devreye girdiğini gösteriyor (yönetici performans değerlendirmesi bağlamında, ama kavram genel).

**S/R sorularıyla bağlantılı sonuç:** NotifyMe'nin Goal türleri **en az iki kategoriye** ayrılmalı: (a) doğal sayısal ölçüsü olan (soru sayısı, koşu mesafesi — workload-based progress, §6, doğrudan uygulanabilir), (b) doğal ölçüsü olmayan/proxy gerektiren (mastery-tipi öğrenme hedefleri — §14'ün Goodhart's Law uyarısı geçerli, "workload tamamlandı" ≠ "hedef başarıldı"). **Bu ayrımın kendisi literatürden (§14+§15+§18 birlikte) güçlü destekli, ama NotifyMe'nin buna göre farklı UI/algoritma davranışı göstermesi gerektiği mühendislik çıkarımı.** **Kanıt seviyesi: Var — doğrulandı (ayrımın kendisi), Belirsiz — NotifyMe'nin buna nasıl tepki vermesi gerektiği.**

---

## 19. Estimation Error

Aşama 2A'nın planning fallacy bulgusuyla (Buehler, Griffin & Ross 1994) doğrudan devam: **Reference Class Forecasting (§12)** bu sorunun akademik olarak en iyi belgelenmiş çözümü — "outside view" (geçmiş benzer vakaların dağılımı) kullanarak "inside view"in (senaryo bazlı, iyimser) yanlılığını düzeltmek. Ama §12'de belirtildiği gibi, **NotifyMe'nin erken aşamasında yeterli "benzer geçmiş vaka" havuzu yok** — bu sorunun **kendisi de** çözülemeden kalıyor.

**S sorusunun cevabı:** Evet, Goal total workload tahmini zamanla güncellenmeli (Goal'ün gerçek kapsamı ilk tahminden farklı çıkabilir — "180 saat çıktı, 100 saat sanılmıştı" örneği) — ama güncelleme yapıldığında **geçmiş trajectory verisinin nasıl yorumlanacağı** (eski hesaplamalar geçersiz mi, yoksa "re-baseline" mi) literatürde **doğrudan ele alınmadı bu oturumda** — EVM'nin kendi pratiğinde "re-baselining" bilinen ama tartışmalı bir teknik (temel çizgiyi değiştirmek performans geçmişini "temizleyebilir" ama şeffaflığı azaltır) — bu açık bir tasarım sorusu olarak kalıyor. **Kanıt seviyesi: Dolaylı destekli (RCF'nin outside-view mantığı), NotifyMe'nin spesifik "yeniden temellendirme" sorununa doğrudan literatür yok.**

---

## 20. Multiple Goals / Goal Conflict

**T sorusunun cevabı:** Kruglanski'nin **Goal Systems Theory**'si (2002, "A Theory of Goal Systems", *Adv. Exp. Soc. Psychol.*, DOI 10.1016/S0065-2601(02)80008-9; güncellemeleri: Köpetz, Faber, Fishbach & Kruglanski 2011, DOI 10.1037/a0022980; Kruglanski, Chernikova, Babush, Dugas & Schumpe 2015, "The Architecture of Goal Systems") bu problemi doğrudan formalize ediyor, üç konfigürasyon tanımlıyor:

- **Multifinality:** tek bir eylem (means) birden fazla goal'e hizmet ediyor ("iki kuşu bir taşla") — ama bu **"dilution effect"** yaratıyor: bir means birden fazla goal'e bağlandıkça, her bir goal'e olan algılanan bağlılığı **zayıflıyor.**
- **Equifinality:** bir goal'e birden fazla means ulaşabiliyor — seçim/ikame problemi.
- **Counterfinality:** bir goal'e hizmet eden means, **başka bir goal'i baltalıyor** — NotifyMe'nin sorduğu "bir Goal'ün workload'unu artırmak diğer Goal'ları bozar mı" sorusunun **tam akademik karşılığı.**
- **Multifinality constraints effect** (Köpetz ve ark. 2011): birden fazla aktif goal olduğunda, kullanıcılar **tüm goal'lere zarar vermeyen** (veya hepsine fayda sağlayan) means'leri tercih etme eğiliminde — NotifyMe'nin zaman tahsisi önerilerinde bu davranışsal eğilimin göz önünde bulundurulması gerekebilir.

**U sorusuyla bağlantı:** Goal Systems Theory, çoklu-goal senaryosunda "her Goal ayrı bir izole birim" varsayımının **psikolojik olarak yanlış** olduğunu gösteriyor — goal'ler kaynak (zaman/dikkat) paylaştıkça birbirini etkiliyor (counterfinality). **NotifyMe'nin "tek Goal varsayımının riskleri" (talimatın istediği gibi) açıkça belirtilmeli: bir Goal'ün workload'unu artırma önerisi, diğer Goal'lerin (kullanıcının aynı anda takip ettiği başka Goal'lerin) zaman bütçesini baltalayabilir, ve bu literatürde iyi bilinen bir dinamik (counterfinality).** **Kanıt seviyesi: Var — doğrulandı, olgun akademik çerçeve; NotifyMe'nin şu anki tek-Goal-izole hesaplama mantığı bu riski hesaba katmıyor.**

---

## 21. Trajectory → Adaptation

Aşama 2B'nin tailoring-variable çerçevesiyle (Dziak ve ark.) doğrudan bağlantı: Goal-trajectory sinyali de bir "tailoring variable" olarak modellenebilir (gözlem: pace_ratio; assessment time: haftalık; decision time: haftalık review; cutoff: literatürden gelmeyen bir eşik, §11). Kullanıcının önerdiği 7 aday tepki (workload artır/azalt, deadline değiştir, scope azalt, availability artırmasını öner, task dağılımını değiştir, hiçbir şey yapma, risk bildir) için **doğrudan literatür desteği bulunamadı** — bunlar mühendislik varsayımı seviyesinde kalıyor, tıpkı Aşama 2B'nin CAUSE→RESPONSE matrisindeki çoğu satır gibi. **Tek net literatür-destekli ilke:** Carver & Scheier'in "coasting" bulgusu (§10) "hiçbir şey yapma" seçeneğinin bazen **doğru** tepki olabileceğini gösteriyor (kullanıcı zaten önde, müdahale gereksiz-hatta ters etkili olabilir).

---

## 22. Evaluation Possibilities

Goal-trajectory algoritmasının test edilebilirliği için: Aşama 2A'nın Schat ve ark. (2021) sentetik-veri şablonu burada da uygulanabilir — **enjekte edilmiş senaryolar** (kullanıcının önerdiği liste: sabit-önde, sürekli-geride, erken-başarısızlık-sonra-toparlanma, gürültülü performans, deadline kısaltma vb.) üzerinde algoritmanın davranışı test edilebilir. Barraza, Back & Mata'nın (2000) **stochastic S-curve** yaklaşımı (§9) da benzer bir simülasyon şablonu sunuyor — ama construction-domain'e özgü parametrelerle, doğrudan aktarılamaz.

**Ölçülebilecekler (sentetik veriyle):** pace_ratio hesaplamasının doğru yönde tepki verip vermediği, tek-kötü-hafta'ya aşırı tepki verip vermediği (Aşama 2A'nın EWMA/CUSUM mantığıyla), remaining_time→0 iken formülün SPI'nin bilinen hatasına (§8) düşüp düşmediği.

**Ölçülemeyecekler:** "Goal gerçekten başarıldı mı" (§14, Goodhart's Law — bu iddia hiçbir veri seviyesinde algoritmik olarak doğrulanamaz, sadece gerçek kullanıcı/uzun-vadeli takip ile), "coasting riski gerçekleşiyor mu" (gerçek kullanıcı davranışı gerekir), "referans sınıf olmadan probabilistic forecast'ın doğruluğu" (tanım gereği test edilemez, referans sınıf yoksa).

---

## 23. Candidate NotifyMe Trajectory Models

Nihai seçim yapılmıyor — 4 aday, trade-off'larla.

### Model A — Minimal Deterministic
`remaining_workload / remaining_time` (calendar days, ES-tarzı zaman-normalize edilmiş, SPI'nin klasik hatasından kaçınarak) — tek sayı, haftalık güncellenir.
- **Gerekli veri:** Goal'ün toplam workload tahmini (kullanıcı girer) + Task'ların plannedAmount toplamı.
- **Güçlü yön:** Uygulanması kolay, açıklanabilir, sıfır-veri sorunu yok (ilk günden çalışır).
- **Zayıf yön:** Linear beklenti varsayımı (§9, literatürce sorgulanan), LEVEL/TREND ayrımı yok (§10'daki Carver-Scheier bulgusunu kaçırıyor), gürültüye karşı savunmasız.
- **Tasarım 1 uygulanabilirliği:** Yüksek.

### Model B — Workload-Aware + Level/Trend Ayrımı (araştırmanın en çok desteklediği aday)
Model A'nın formülüne + ayrı bir "velocity" göstergesi (son N haftanın workload/zaman oranı, EWMA ile — Aşama 2A'nın §7-8 bulgusuyla tutarlı) eklenir; LEVEL ("ne kadar kaldı") ve TREND ("hızlanıyor mu yavaşlıyor mu") ayrı gösterilir.
- **Güçlü yön:** Carver & Scheier'in (§4, §10) LEVEL/VELOCITY ayrımını doğrudan uyguluyor — bu araştırmanın en güçlü akademik dayanağı. Aşama 2A'nın EWMA altyapısıyla (adaptasyon motoru için zaten planlanan) yeniden kullanılabilir.
- **Zayıf yön:** İki gösterge kullanıcıya nasıl sunulacak (§ Aşama 2B'nin explainability bulgusu — fazla bilgi bilişsel yük riski) net değil; "coasting" riskini (§10) azaltacak bir UI tasarımı gerektirir ama bu tasarım literatürden gelmiyor.
- **Tasarım 1 uygulanabilirliği:** Orta-yüksek.

### Model C — Weighted/Multi-Unit Workload (Sharp'ın AHP/ANP yaklaşımından esinlenen, hafifletilmiş)
Farklı birimlerdeki Task'ları (soru/dakika/deneme) kullanıcının **kendi** göreli önem/süre tahminiyle (basit bir "bu task Goal'ün yaklaşık %X'i" girişi) ağırlıklandırma.
- **Güçlü yön:** §6'nın "farklı birim birleştirme" boşluğunu dolduruyor, WBS ağırlıklandırma pratiğiyle (§6) tutarlı.
- **Zayıf yön:** Kullanıcıdan ekstra veri girişi ister (response burden, Aşama 2B §10), AHP/ANP'nin tam hali (pairwise comparison) aşırı karmaşık — basitleştirilmiş hali bile literatürden doğrudan test edilmemiş.
- **Tasarım 1 uygulanabilirliği:** Düşük-orta — implementasyon ve UX maliyeti yüksek.

### Model D — Probabilistic (Reference-Class-lite)
Kullanıcının **kendi geçmiş, benzer-kategori Goal'lerinden** (örn. tüm "sınav hazırlığı" kategorisindeki geçmiş Goal'ler) basit bir kişisel referans sınıfı oluşturup, bunun üzerinden kaba bir "tipik sapma" aralığı göstermek.
- **Güçlü yön:** RCF'nin (§12) güçlü akademik temeline en yakın aday; kişisel veri arttıkça (yıllar içinde) gerçek değer kazanabilir.
- **Zayıf yön:** Başlangıçta (yeterli geçmiş Goal olmadan) **uygulanamaz** — soğuk-başlangıç problemi en şiddetli olan aday; Monte Carlo bulgusunun (§12) "20+ veri noktası" eşiğini NotifyMe'nin erken kullanıcıları büyük olasılıkla karşılayamaz.
- **Tasarım 1 uygulanabilirliği:** Düşük — gerçekçi değil, ileriye dönük not olarak kalmalı.

---

## 24. Red Team

### Varsayım 1 — "Goal progress sayısal olarak ölçülebilir."
- **Destek:** Workload-based progress, doğal sayısal birimi olan Goal'ler için güçlü destekli (§6).
- **Karşı kanıt:** §14 (Goodhart's Law, proxy-mastery ayrımı) + §15 (SMART eleştirisi) + §18 (observability) — bazı Goal türleri için **hayır**, doğal ölçüsü yok.
- **Risk: YÜKSEK** genel bir mimari kararı olarak dayatılırsa (tüm Goal'lerin sayısal hedefi olmalı) — Goal türüne göre farklılaştırma gerekiyor.

### Varsayım 2 — "Goal progress linear olmalıdır."
- **Destek:** Yok bulunamadı.
- **Karşı kanıt: GÜÇLÜ.** S-curve literatürü (§9) + Carver & Scheier'in coasting bulgusu (§10) ikisi birden linear varsayımı sorguluyor.
- **Risk: ORTA** — linear'ı **başlangıç noktası** olarak kullanmak (S-curve'e geçmemek) dürüst bir minimum, ama "sapma = kötü" yorumunun linear referans etrafında **geniş tolerans** taşıması gerekiyor.

### Varsayım 3 — "Task completion Goal progress'i temsil eder."
- **Destek:** Basit bağlamlarda (Goal = Task'ların toplamı) kısmen evet.
- **Karşı kanıt: GÜÇLÜ.** §14 (mastery≠activity, gaming), §7 (Smyth ve ark., subjektif-objektif R²=.05-.39).
- **Risk: YÜKSEK** — Urun-Vizyonu'nun kendi vurguladığı temel problem (task'lar tamam, goal geride) burada teyit ediliyor, ama çözümü de (workload-based + Carver-Scheier velocity) net değil, sadece yön net.

### Varsayım 4 — "Workload amount Goal progress'i temsil eder."
- **Destek:** Tek-birimli Goal'lerde (§6) evet.
- **Karşı kanıt:** Çok-birimli Goal'lerde (§6, §14) hayır/kısmi — "1000 soru" mastery'yi garanti etmiyor.
- **Risk: ORTA-YÜKSEK.**

### Varsayım 5 — "Recent velocity geleceği tahmin etmek için yeterlidir."
- **Destek:** EWMA/kontrol-limiti mantığı (Aşama 2A) kısa-vadeli trend tespiti için destekli.
- **Karşı kanıt:** RCF/planning-fallacy literatürü (§12, §19) "inside view"in (sadece kendi son verine bakmak) sistematik olarak iyimser olduğunu gösteriyor; velocity tek başına rejim değişimini (dönem başı/sonu) yakalamakta yavaş (Aşama 2A'nın EMA uyarısıyla aynı).
- **Risk: ORTA.**

### Varsayım 6 — "remaining_work / remaining_time anlamlı bir pace metriğidir."
- **Destek:** Earned Schedule'ın matematiğiyle kavramsal akrabalık (§8, §11).
- **Karşı kanıt:** Klasik EVM'nin SPI hatasına (§8) düşme riski, ES'in düzeltmesi uygulanmazsa.
- **Risk: ORTA** — ES-tarzı düzeltme uygulanırsa risk azalır, uygulanmazsa (naif oran) risk yüksek.

### Varsayım 7 — "Deadline riskini erken veriden tahmin etmek mümkündür."
- **Destek:** ES/RCF/Monte Carlo hepsi teoride mümkün diyor.
- **Karşı kanıt: GÜÇLÜ.** Hepsi NotifyMe'nin erken-aşama, tek-Goal, düşük-veri bağlamında **kalibrasyon verisi eksikliğinden** pratik olarak çöküyor (§12).
- **Risk: YÜKSEK** — probabilistic/istatistiksel iddia şu an sahte kesinlik olur.

### Varsayım 8 — "Kullanıcının total workload tahmini yeterince doğrudur."
- **Destek:** Yok.
- **Karşı kanıt: GÜÇLÜ.** Planning fallacy (Aşama 2A) + reference-class-forecasting'in tüm motivasyonu (§12, §19) bu varsayımın **yanlış olduğunu kanıtlamaya adanmış bir literatür.**
- **Risk: YÜKSEK.**

### Varsayım 9 — "Availability güvenilir bir kapasite ölçüsüdür."
- **Destek:** RCPSP'nin temel varsayımı (sabit kapasite) — ama bu bir **model basitleştirmesi**, gerçekliğin kendisi değil.
- **Karşı kanıt:** Kullanıcının kendi zaman tahmini de bir self-report, Aşama 2B'nin self-report güvenilirlik sorunlarına (recall bias, self-serving bias) tabi.
- **Risk: ORTA.**

### Varsayım 10 — "Bir Goal'ün workload'unu artırmak diğer Goal'ları bozmaz."
- **Destek:** Yok.
- **Karşı kanıt: GÜÇLÜ.** Kruglanski'nin counterfinality kavramı (§20) tam olarak bunun **normal, beklenen** bir dinamik olduğunu gösteriyor.
- **Risk: YÜKSEK** — çok-Goal senaryosunda izole hesaplama yapılırsa ciddi yanlış yönlendirme riski.

### Varsayım 11 — "Kullanıcıya 'geridesin' demek faydalıdır."
- **Destek:** Discrepancy'nin motive edici olabileceği (Locke & Latham, Aşama 2A) kısmi destek.
- **Karşı kanıt:** Carver & Scheier'in disengagement literatürü (kitap bölüm başlıkları: "Expectancies and disengagement", "Scaling back goals... response shift" — bu oturumda derinlemesine taranmadı, sadece varlığı tespit edildi, §27 açık soru) negatif discrepancy sinyalinin bazen **goal'den vazgeçmeye** yol açabileceğini ima ediyor; ayrıca "önde" sinyali coasting'e yol açabilir (§10) — **her iki yönde de** risk var, "faydalı" varsayımı basit değil.
- **Risk: YÜKSEK — belirsizlik yüksek.**

### Varsayım 12 — "Goal completion = Goal success."
- **Destek:** Sadece tek-birimli, iyi-tanımlı Goal'lerde.
- **Karşı kanıt: GÜÇLÜ.** §14 (Goodhart's Law/proxy metrics) tam olarak bunu sorguluyor.
- **Risk: YÜKSEK.**

---

## 25. Unexpected Findings / Promptta Olmayan Önemli Bulgular

Bu bölüm boş değil — iki önemli, promptta hiç adı geçmeyen literatür bulundu:

1. **Carver & Scheier'in kontrol-teorisi tabanlı öz-düzenleme modeli** (1982, 1990, 1998; ayrıca Kruglanski'nin goal-systems theory'si ile birlikte, 2002+) — kullanıcının kendi kelimeleriyle tarif ettiği "PROGRESS ≠ PACE" ve "LEVEL vs TREND" problemlerinin **40+ yıllık, yüksek atıflı, doğrudan** akademik karşılığı. Bu, promptta önerilen terimler arasında (progress monitoring, goal velocity, goal pursuit) **kısmen** işaret ediliyordu ama Carver & Scheier'in spesifik iki-loop modeli ve "coasting" bulgusu aranmadan bulunmadı, **NotifyMe'nin mimarisini gerçekten etkileyebilecek** bir bulgu: kullanıcıya "önde/geride" göstermenin kendisi davranışsal bir müdahale, nötr bir bilgi gösterimi değil. **Bu, Tasarım 1 raporunda goal-trajectory UI'ının tasarımını (sadece hesaplamayı değil) etkilemeli.**
2. **SMART hedeflerin bilimsel temelinin sorgulanması** (§15) — NotifyMe'nin Goal modelinin **temel varsayımlarından birini** (her Goal ölçülebilir/spesifik bir hedefe sahip olmalı) doğrudan sarsıyor. Bu, FAZ1 şemasındaki `Goal.deadline` (nullable) ve mevcut esnekliğin ("her goal'ün sabit tarihi olmayabilir") aslında akademik olarak **doğru yönde** bir tasarım kararı olduğunu (kazara da olsa) teyit ediyor — ama bu esnekliğin Goal-trajectory hesaplamasına nasıl yansıyacağı (ölçülemeyen Goal'de trajectory nasıl gösterilir?) çözülmemiş bir soru olarak kalıyor.

Konu NotifyMe'nin Goal Trajectory probleminden **açıkça uzaklaşan** ama not edilmeye değer bir üçüncü bulgu: "observability" kavramı (Amir, muhasebe/yönetim literatürü, §18) — orijinal alanı çok farklı (yönetici performans değerlendirmesi) olduğu için derinlemesine takip edilmedi, sadece kavramın ismi/varlığı not edildi.

---

## 26. Implications for NotifyMe

1. **Goal-trajectory hesaplaması tek bir sayı olmamalı — en az iki ayrı sinyal (LEVEL + TREND/velocity) tutulmalı**, Carver & Scheier'in modeliyle uyumlu ve Aşama 2A'nın EWMA altyapısıyla teknik olarak yeniden kullanılabilir.
2. **EVM'nin klasik SPI hatasına düşmemek için, herhangi bir remaining_work/remaining_time formülü Earned-Schedule-tarzı zaman-normalizasyonu içermeli** — çıplak "kalan iş/kalan gün" oranı, deadline'a yaklaşıldıkça yapay biçimde iyileşen/kötüleşen bir gösterge üretebilir.
3. **Goal türüne göre farklılaştırma gerekiyor** — doğal sayısal birimi olan Goal'ler (§6, workload-based progress uygulanabilir) ile mastery/proxy-tipi Goal'ler (§14, §15 — sayısal trajectory sahte kesinlik olur) arasında ayrım, hem veri modelinde hem UI'da yansıtılmalı.
4. **Probabilistic/istatistiksel deadline-risk iddiası şu an akademik olarak savunulamaz** (§12) — erken aşamada deterministic (ES-düzeltmeli) gösterge yeterli ve dürüst.
5. **Çok-Goal senaryosunun izole hesaplanması psikolojik olarak yanlış** (§20, counterfinality) — bu Tasarım 1'de mimari olarak çözülmese bile, raporun kendisinde bir sınırlama olarak açıkça belirtilmeli.
6. **"Kullanıcıya geridesin/öndesin göstermenin" kendisi nötr değil** (§10, §25) — bu bir UI/UX tasarım kararı gerektiriyor, salt hesaplama sorunu değil.

---

## 27. Open Questions

- Carver & Scheier'in "disengagement" ve "response shift/scaling back goals" bulguları (negatif discrepancy sinyalinin goal'den vazgeçmeye yol açması) bu oturumda **derinlemesine taranmadı** — sadece varlığı tespit edildi (§24, Varsayım 11). Ayrı bir mini-araştırmayı hak ediyor.
- Goal total workload tahmini zamanla güncellendiğinde geçmiş trajectory verisinin nasıl yorumlanacağı (§19, "re-baselining" sorunu) çözülmedi.
- Multi-birimli Task'ları (soru+video+deneme) tek bir Goal progress metriğinde birleştirmenin **kullanıcı-dostu, düşük-yük** bir yöntemi (§6, §23 Model C) bulunamadı — Sharp'ın AHP/ANP'si teorik olarak var ama pratik değil.
- Kişisel "reference class" (aynı kategori Goal'lerin geçmişi, §23 Model D) fikrinin ne kadar veri/zaman sonra anlamlı hale geleceği literatürden çıkarılamadı (Monte Carlo'nun "20+ veri noktası" bulgusu genel proje bağlamından, NotifyMe'nin kişisel-Goal bağlamına doğrudan aktarılamaz).
- "Observability" (§18, §25) kavramı muhasebe/yönetim literatüründen, NotifyMe'nin Goal-ölçülebilirlik sorununa ne kadar doğrudan aktarılabileceği derinlemesine araştırılmadı.

---

## 28. What Phase 2D Must Investigate

Kullanıcının kendi talimatına göre Phase 2D genel **evaluation methodology** konusu: N=1/single-case experimental design, sentetik değerlendirmenin sınırları, küçük kullanıcı pilotu, usability/trust değerlendirmesi, hangi bilimsel iddiaların yapılıp yapılamayacağı. Bu raporda sadece Goal-trajectory algoritmasına özgü test edilebilirlik bilgisi (§22) verildi, genel metodoloji ele alınmadı — bu Aşama 2D'nin konusu.

Ek olarak, bu raporun kendi açık sorularından (§27) Phase 2D'ye taşınması gerekenler: Carver & Scheier'in disengagement literatürü, ve genel olarak "NotifyMe'nin trajectory/adaptasyon iddialarının hangi seviyede (algoritmik iç-tutarlılık vs gerçek davranış değişikliği) test edilebileceği" — bu Aşama 2A'nın §18-19'unda (synthetic data can/cannot claim) zaten kısmen ele alınmıştı, Phase 2D'de Goal-trajectory'ye özgü genişletilmesi gerekiyor.

---

## 29. Sources / Search Queries / Weak or Excluded Sources

### Kullanılan arama sorguları (temsili liste, ~20 gerçek Exa sorgusu çalıştırıldı)

1. Carver Scheier control theory self-regulation discrepancy reduction rate of progress velocity feedback loop goal
2. Carver Scheier 1990 origins functions positive negative affect control process view rate of progress
3. Earned Schedule Walt Lipke schedule performance index time-based EVM criticism late in project
4. goal systems theory Kruglanski multifinality multiple goals competing resource allocation academic
5. agile velocity forecasting Monte Carlo simulation software project completion date academic peer-reviewed
6. Goodhart's law proxy metric versus true goal measurement gaming academic learning analytics mastery versus activity time-on-task
7. S-curve project progress nonlinear expected progress curve construction project management academic
8. resource-constrained project scheduling personal task scheduling capacity availability academic operations research
9. reference class forecasting Flyvbjerg outside view estimate updating over time project
10. PERT three-point estimation program evaluation review technique small sample uncertainty forecasting accuracy criticism
11. goal specificity measurability SMART goals observability qualitative versus quantitative goal setting research
12. work breakdown structure task weighting unequal task size project progress percent complete bias

### İncelenen kaynak türleri

Peer-reviewed dergi makaleleri (*Psychological Bulletin*, *Psychological Review*, *Personality Science*, *Educational and Child Psychology*, *Journal of Learning Analytics*, *Educational Technology Research and Development*, ASCE *J. Constr. Eng. Manage.*, *IEEE Trans. Eng. Management*, *European Journal of Operational Research*), konferans bildirileri (ACM SAC — Monte Carlo, ISAHP — AHP/ANP), sistematik/narrative review'ler (5+), akademik tezler (JKU Linz — düşük-orta güven, açıkça işaretlendi), practitioner/endüstri kaynakları (Primavera P6 dokümantasyonu, planningengineer.net — akademik değil, kavramsal destek için kullanıldı, açıkça ayrıştırıldı), arXiv preprint (1 adet, KT gaming çalışması, açıkça işaretlendi).

### Elenen/zayıf bulunan kaynaklar ve neden

- **de Jong (JKU Linz tezi, MiniZinc personal scheduling):** Hakemli yayın değil, tek kaynak, akademik olgunluğu düşük — sadece "RCPSP'nin kişisel yaşama uygulanması yeni bir araştırma alanı" gözlemini desteklemek için kullanıldı, yöntem/sonuç iddiası olarak kullanılmadı.
- **Profit.co blog (weighted progress contribution):** Pazarlama/practitioner blog'u, akademik kanıt değil — sadece "simple averaging" probleminin endüstri pratiğinde ne kadar yaygın kabul gördüğünü göstermek için, Sharp (2013) ve WBS ağırlıklandırma akademik/PMBOK kaynaklarıyla birlikte, tek başına kanıt olarak kullanılmadı.
- **Agile burndown/velocity'nin bilinen sınırlamaları (gaming, karşılaştırılamazlık):** Bu oturumda doğrudan akademik makale bulunamadı, practitioner konsensüsü olarak işaretlendi (§13).
- **Genel "goal disengagement" literatürü (Wrosch, Carver):** Bu oturumda aranmadı/derinlemesine taranmadı, sadece Carver & Scheier'in kendi kitap bölüm başlıklarından varlığı tespit edildi — Phase 2D veya ayrı bir mini-araştırma için işaretlendi.

### Önemli belirsizlikler

- Batselier & Vanhoucke (2016) makalesinin DOI'si bu oturumda doğrudan doğrulanamadı (Cantarelli 2025'in atfı üzerinden aktarıldı) — birincil kaynağa erişilmedi.
- Earned Schedule'ın 16-proje çalışmasının (Lipke, "Project Duration Forecasting") istatistiksel yönteminin (Sign Test) tam varsayımları/gücü bu oturumda derinlemesine incelenmedi, sadece sonucu aktarıldı.
- Carver & Scheier'in "disengagement" ve "response shift" bulguları hakkında bu raporda **hiçbir doğrudan kaynak okunmadı** — sadece 2000 kitabının bölüm başlıkları üzerinden varlığı çıkarıldı, bu "Var — doğrulandı" değil, "kaynağın var olduğu doğrulandı, içeriği bu oturumda okunmadı" seviyesinde bir kanıt.
- Sharp (2013) AHP/ANP makalesinin atıf sayısı/akademik etkisi bu oturumda kontrol edilmedi — ISAHP (Analytic Hierarchy Process konferansı) niş bir venue, ana akım proje yönetimi literatüründe ne kadar tanındığı belirsiz.

---

**Durum:** Aşama 2C tamamlandı. Kod/repo/roadmap/Goal modeli değişikliği yapılmadı, algoritma implement edilmedi, nihai mimari kararı verilmedi, commit/push yapılmadı. Aşama 2D (genel evaluation methodology) bu oturumda başlatılmadı.

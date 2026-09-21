# NotifyMe — Open-Gaps Cleanup C: Goal Trajectory Edge Cases — Re-Baselining + Mixed-Unit Workload + Goal Observability + Coasting/Disengagement

**Tarih:** 2026-09-21
**Kapsam:** SADECE dört alan — (1) re-baselining, (2) mixed-unit workload aggregation, (3) goal observability / goal-type distinction, (4) coasting / disengagement / trajectory feedback'in davranışsal etkileri. Bu, NotifyMe Tasarım 1 araştırma serisinin (Phase 1, 2A-2D, Open-Gaps Cleanup A-B) ardından gelen **son Open-Gaps Cleanup fazıdır** — bittikten sonra yeni araştırma fazı önerilmiyor.
**Önceki raporlar (okundu, başlangıç bilgisi kabul edildi, tekrar araştırılmadı):** `notifyme_competitor_analysis_phase1.md`, `notifyme_academic_adaptation_closed_loop_phase2a.md`, `notifyme_academic_feedback_human_factors_phase2b.md`, `notifyme_academic_goal_trajectory_phase2c.md` (**bu araştırmanın ana öncülü** — LEVEL/TREND ayrımı, Carver & Scheier kontrol teorisi, Earned Schedule, goal observability'nin ilk tespiti, multiple-goal/counterfinality, forecasting sınırları — tam okundu, tekrar araştırılmadı), `notifyme_academic_evaluation_phase2d.md` (Claim→Evidence mantığı, layered evaluation, synthetic can/cannot), `notifyme_open_gaps_data_fusion.md` (measured/self-reported terminolojisi, uncertainty-aware rule system, false-precision uyarısı), `notifyme_open_gaps_feedback_taxonomy.md` (taksonomi/feedback UX kararları, Authority Inversion).
**Amaç:** Phase 2C'den kalan dört kritik açığı, Phase 3 mimari kararından önce, Phase 3 kararını gerçekten etkileyecek kadar kanıtla kapatmak.

---

## 1. Executive Summary

Bu araştırmanın en doğrudan uygulanabilir bulgusu **re-baselining** alanında: ABD federal IT proje denetim literatürü (GAO-08-925) ve "Re-baseline Factor" yaklaşımı (Kesheh & Stratton, PM World Journal) NotifyMe'nin "ne zaman yeniden temellendirilmeli" sorusuna **ilkesel, kanıta dayalı bir cevap** veriyor: eşik-aşımı **tek bir gözlemde değil, ardışık 3 dönemde** gerçekleşmeli (Aşama 2A'nın EWMA/CUSUM "tek kötü gün" mantığıyla birebir tutarlı) ve rebaseline süreci **şeffaf, gerekçeli, geçmişi silmeyen** bir olay olarak belgelenmeli — GAO'nun 5 "best practice"i (neden, süreç, doğrulama, yönetim onayı, dokümantasyon) NotifyMe'nin tek-kullanıcı ölçeğine basitleştirilmiş halde uygulanabilir. **Geçmişi silme problemi** için tıp/sağlık politikası literatüründeki **segmented regression / interrupted time series (ITS)** yöntemi (Schober & Vetter 2021, *Anesthesia & Analgesia*) doğrudan aktarılabilir bir çözüm sunuyor: rebaseline noktasından önce ve sonra **iki ayrı segment** (level + trend) modellenir, hiçbir veri silinmez — bu, kullanıcının kendi önerdiği "segment trajectory before/after change" seçeneğini akademik olarak en güçlü destekli aday yapıyor.

İkinci büyük bulgu, **mixed-unit workload** alanında: OECD/JRC'nin *Handbook on Constructing Composite Indicators* (Nardo, Saisana, Saltelli ve ark., 2005/2008) — resmi, kanonik bir metodoloji standardı — kullanıcının sezgisini **doğrudan** doğruluyor: "eşit ağırlıklandırma, ağırlık yokluğu değildir, sadece örtük eşit ağırlıklandırmadır" ve **her ağırlıklandırma yöntemi bir değer yargısıdır**. Daha da kritik: Handbook, linear/geometric aggregation'ın **compensability** (bir boyuttaki eksikliğin diğerinde fazlalıkla telafi edilebilmesi) varsayımını zorunlu kıldığını, ama bu varsayımın **her zaman doğru olmadığını** gösteriyor — "final project %37 tamamlandı, video %70 izlendi, ortalama %53" gibi bir sayı, iki farklı işin gerçekten birbirinin yerine geçebileceğini **iddia eder**, bu iddia genellikle temelsizdir. Handbook'un resmi alternatifi — **non-compensatory multi-criteria approach (MCA)**, yani boyutları **ayrı ayrı** göstermek — kullanıcının "vector/multi-dimensional progress" fikrine doğrudan akademik meşruiyet kazandırıyor.

Üçüncü büyük bulgu, **goal observability** alanında: Bayesian Knowledge Tracing (BKT — Corbett & Anderson 1995, öğrenme analitiğinin kanonik latent-mastery modeli) mastery'yi biçimsel olarak **gözlemlenemeyen gizli değişken** (hidden Markov state), aktiviteyi ise **gözlemlenen emisyon** (doğru/yanlış cevap) olarak modelliyor — bu ayrım NotifyMe'nin "workload progress ≠ goal outcome" sezgisinin doğrudan matematiksel karşılığı. Ama kritik veri-gereksinimi bulgusu: pyBKT'nin kendi validasyon çalışması, güvenilir parametre tahmini için **en az ~50 öğrenci × öğrenci başına ~15 gözlem** gerektiğini gösteriyor — NotifyMe'nin tek-kullanıcı, tek-Goal bağlamında bu **hiçbir şekilde** karşılanamaz. Sonuç: NotifyMe mastery-tipi Goal'ler için **formal bir mastery skoru üretmemeli** — bunun yerine "workload progress ölçülüyor, mastery ölçülmüyor" ayrımını açıkça göstermeli.

Dördüncü ve en zengin bulgu, **coasting/disengagement** alanında — Phase 2C'nin "ayrı bir mini-araştırmayı hak ediyor" dediği açık soru burada kapatıldı: Coasting artık **sadece teori değil, deneysel olarak kanıtlanmış** bir fenomen (Thürmer, Scheier & Carver 2019, *Motivation Science* — 2 kontrollü deney; Fulford, Johnson, Llabre & Carver 2010, *Psychological Science* — 21 günlük gerçek-dünya experience-sampling çalışması, NotifyMe'nin kendi kullanım deseninde doğrulanmış). **En değerli/beklenmedik bulgu**, promptta hiç sorulmayan ama mimariyi doğrudan etkileyebilecek bir çalışma: Jostmann & Brummelman (2025, ön-kayıtlı replikasyon, N=395) coasting'in **feedback zamanlamasıyla önlenebileceğini** kanıtladı — olumlu geri bildirim, kullanıcı bir sonraki eylemine hazırlanırken (immediate değil, "preparatory phase"de) verilirse, coasting yerine performans **artışı** gözleniyor. Disengagement tarafında, Wrosch, Scheier, Miller, Schulz & Carver'ın (2003, *PSPB*) Goal Disengagement/Reengagement Scale'i ve Carver & Scheier'in kendi "response shift" makalesi (2000, *Social Science & Medicine*) **hedefi küçültmenin/bırakmanın kendisinin adaptif bir öz-düzenleme mekanizması** olduğunu, "başarısızlık" değil "yavaş-hareket eden bir recalibration" olduğunu gösteriyor — bu, NotifyMe'nin "Goal adjustment ≠ failure" ilkesine güçlü akademik temel sağlıyor.

Genel sonuç: Dört alanın hepsinde ortak bir tema tekrarlıyor — **NotifyMe'nin en dürüst mimari kararı, karmaşık bir formül bulmak değil, ne zaman formül kurmaktan kaçınıp yapısal dürüstlüğü (segmentasyon, ayrı-boyut gösterimi, ölçülemeyen'i ölçülemeyen olarak işaretleme, mesaj zamanlaması) tercih edeceğini bilmek.**

---

## 2. Scope + Stop Rule

Bu araştırma talimatın 0. ve 1. bölümlerindeki kesme kuralına uydu: yalnızca re-baselining, mixed-unit aggregation, goal observability, coasting/disengagement bulguları takip edildi. Phase 2C'de zaten kapsamlı biçimde araştırılan konular (LEVEL/TREND ayrımının kendisi, Earned Schedule'ın temel matematiği, S-curve, RCPSP/capacity, multiple-goal/counterfinality, PERT/Monte Carlo/RCF forecasting sınırları) **tekrar araştırılmadı**, sadece bu dört alanla kesiştiği noktalarda referans verildi. 9 hedefli Exa arama sorgusu çalıştırıldı (rebaselining/scope-change proje yönetimi, segmented regression/change-point analizi, composite indicator/ağırlıklandırma metodolojisi, achievement goal theory, Bayesian Knowledge Tracing/latent mastery, Wrosch goal disengagement, coasting deneysel literatür, response shift/scaling back, çok-metrikli dashboard/bilgi yükü), 7 önceki rapor okundu (2C tam, 2D/Cleanup A/Cleanup B kapsamlı, 1/2A/2B kısa). Bu üç kararı doğrudan değiştirmeyen bulgular (achievement goal theory'nin motivasyonel — mastery-vs-performance-orientation — boyutu, dashboard tasarımının pratik/blog-düzeyi kaynakları) §24'e (Future Work) kaydedildi, derinleştirilmedi.

---

## 3. Re-Baselining

**Ne zaman rebaseline yapılmalı — ilkesel cevap:** ABD federal hükümetinin GAO-08-925 raporu (2008, resmi denetim standardı, 250 federal IT programı üzerinde ampirik analiz) rebaselining'in **en sık nedeninin** ("%55'i") kapsam/gereksinim değişikliği olduğunu, ikinci en sık nedenin ("%44'ü") finansman değişikliği olduğunu gösteriyor — NotifyMe'nin senaryosu (kullanıcı toplam workload tahminini 3000'den 4500'e çıkarıyor) bu iki kategoriden birinciyle birebir örtüşüyor, yani **bilinen, sık karşılaşılan, patolojik olmayan bir olay**. GAO'nun 5 "best practice"i: (1) rebaseline gerekçesini açıkça belirt, (2) yeni baseline'ın nasıl kurulacağını tanımla, (3) yeni baseline'ı doğrula, (4) yönetim/kullanıcı onayı iste, (5) süreci belgele. NotifyMe ölçeğinde bu, ağır bir onay süreci değil, basit bir **"neden değişti, ne değişti, eskisi ne oldu"** kaydı olarak uygulanabilir.

**Nicel tetikleyici — Kesheh & Stratton'ın Re-baseline Factor'u (RBF):** PM World Journal'da yayımlanan bu yaklaşım (pratisyen/mühendislik kaynağı, akademik hakemli değil — açıkça işaretleniyor), EVM'nin CPI/SPI göstergelerinin **tek bir dönemde eşik aşması** yerine, **ardışık 3 dönem boyunca eşik aşımı + kötüleşen yön** koşulunu rebaseline tetikleyicisi olarak öneriyor (RBF formülü: breach sayısı / control-account sayısı > 0.5, 3 ardışık dönem). **Bu, Aşama 2A'nın EWMA/CUSUM bulgusuyla (Schat ve ark. 2021 — "tek kötü gün" ile "gerçek örüntü" arasındaki fark) yapısal olarak aynı ilke** — tek bir sapma değil, **kalıcılık** rebaseline'ı tetiklemeli. Bu, Mustafa'nın §6'daki "exact numeric threshold arama" uyarısını ihlal etmiyor: eşiğin kendisi (RBF'nin 0.5'i) mühendislik parametresi olarak kalıyor, ama **"ardışık kalıcılık, tek gözlem değil"** ilkesi literatürden gelen bir tasarım kısıtı.

**Kanıt seviyesi:** Var — doğrulandı (GAO: kurumsal/denetim standardı, güçlü; RBF: pratisyen kaynağı, kavramsal olarak Aşama 2A'nın EWMA mantığıyla tutarlı, sayısal eşiği doğrudan aktarılabilir değil).

---

## 4. Baseline Versioning / Historical Preservation

**En kritik bulgu bu bölümde.** Sağlık politikası/epidemiyoloji literatüründeki **segmented regression (interrupted time series analysis, ITS)** — Schober & Vetter (2021, *Anesthesia & Analgesia*, PMC7870037; ayrıca Bernal/Wagner parametrizasyon karşılaştırması, *BMC Medical Research Methodology* 2025) — tam olarak NotifyMe'nin "geçmişi silmeden değişimi nasıl gösteririm" problemini çözüyor: bilinen bir "kesinti noktası" (rebaseline anı) etrafında **iki ayrı regresyon çizgisi** (öncesi/sonrası) fit edilir, her segment kendi **level** (o dönemin başlangıç seviyesi) ve **slope/trend** (o dönemin hızı) parametrelerine sahip olur. Bu yöntemin iki önemli katkısı var: (1) hiçbir veri silinmiyor veya "sıfırlanmıyor" — tüm zaman serisi tek bir modelde tutuluyor; (2) basit "öncesi-sonrası ortalama karşılaştırması"nın **yanıltıcı** olabileceğini gösteriyor (eğer öncesinde zaten bir trend varsa, bu trend kesintiden sonra da devam ediyorsa, "değişim" yanlışlıkla kesintiye atfedilir — regression-to-the-mean, Aşama 2D'nin SCED bölümündeki confound listesiyle aynı aile).

**NotifyMe'ye doğrudan haritalama:** Kullanıcının kendi önerdiği "C) Segment trajectory before/after change" seçeneği, bu literatürün **doğrudan, formalize edilmiş karşılığı**. Uygulama: rebaseline anında (1) eski segment'in LEVEL/TREND değerleri **donmuş kayıt** olarak saklanır (silinmez), (2) yeni segment sıfırdan değil, kendi başlangıç noktasından (yeni totalWorkload, mevcut tarih) başlayan **bağımsız** bir LEVEL/TREND hesaplaması başlatır, (3) kullanıcıya gösterilen "genel trajectory" bu iki segmentin **birleşik, ama ayrıştırılabilir** görünümüdür. Bu, "A) Full reset" (geçmişi tamamen kaybeder) ve "D) Preserve history but recalculate expected trajectory" (geçmiş veriyi yeni beklentiyle yeniden yorumlayıp epistemik olarak yanıltıcı bir "olsaydı" senaryosu üretir) seçeneklerinin ikisinden de daha savunulabilir.

**Kanıt seviyesi:** Var — doğrulandı, güçlü (peer-reviewed metodoloji, farklı disiplinden ama yapısal olarak doğrudan aktarılabilir — NotifyMe formal ITS istatistiksel çıkarımı yapmıyor, sadece "segment ayır, level+trend'i ayrı hesapla" mimari ilkesini ödünç alıyor).

---

## 5. Scope Change vs Performance Deviation

GAO-08-925'in kendi verisi bu ayrımı doğrudan destekliyor: rebaseline'ların **%55'i** kapsam/gereksinim değişikliği, geri kalanı finansman veya **"orijinal baseline'ın gerçekçi olmaması"** (yani başlangıç tahmin hatası) — hiçbiri "kullanıcı kötü performans gösterdi" kategorisinde değil. Bu, Phase 2A'nın planning fallacy bulgusuyla (Buehler, Griffin & Ross 1994) ve Phase 2C'nin "kullanıcının total workload tahmini yeterince doğru değildir" varsayımının **güçlü karşı-kanıtla reddedildiği** (Aşama 2C §24, Varsayım 8) sonucuyla birebir tutarlı: **başlangıç tahmininin sonradan yanlış çıkması normal ve beklenen bir olay**, kullanıcının "başarısızlığı" değil.

**Mimari ayrım önerisi:** Scope change (`totalWorkload`, `deadline`, `successCriterion` gibi Goal'ün **tanımının** değişmesi) ile performance deviation (aynı tanım altında, gerçekleşen ilerlemenin beklenenden sapması) **yapısal olarak farklı olaylar** olarak ele alınmalı — biri rebaseline (§3-4) tetikler, diğeri LEVEL/TREND hesaplamasının kendi (Phase 2A'nın EWMA/CUSUM'lu) normal işleyişidir. Bu ayrımın pratik testi: "kullanıcı Goal'ün *tanımını* mı değiştirdi (workload, deadline, kriter) yoksa aynı tanım altında *gerçekleşen davranışı* mı beklenenden farklı" — ilki her zaman rebaseline'a (§3), ikincisi her zaman normal trajectory güncellemesine gider, ikisi karıştırılmamalı.

**Kanıt seviyesi:** Var — doğrulandı (GAO verisi + Aşama 2A/2C'nin planning-fallacy bulgusuyla yakınsama).

---

## 6. Mixed-Unit Workload

**Terminoloji/çerçeve düzeltmesi:** OECD/JRC Handbook'un kendi dili kullanılırsa, NotifyMe'nin "3000 soru + 20 saat video + 3 proje" problemi klasik bir **composite indicator construction** problemi — bu literatür 20+ yıllık, kanonik, çok disiplinli (ekonomi, sürdürülebilirlik endeksleri, insani gelişme endeksi gibi endeks inşası pratiğinden geliyor) ve **doğrudan uygulanabilir bir metodoloji seti** sunuyor (Adım 6: "Weighting and aggregation").

**Compensability sorunu — en kritik bulgu:** Handbook, linear/geometric aggregation'ın (yani "her Task'a bir ağırlık ver, topla") **compensability** varsayımı taşıdığını gösteriyor: bir boyuttaki düşük skor, başka bir boyuttaki yüksek skorla **telafi edilebilir** anlamına gelir. NotifyMe bağlamında: "final project %20 tamam ama video %90 izlendi, ortalama %55" demek, **"video izlemenin final projeyi telafi edebileceğini"** iddia eder — bu iddia genellikle temelsiz (Python öğrenmede final projeyi bitirmemiş olmak, çok video izlemiş olmakla "dengelenemeyabilir"). Handbook'un resmi çözümü: eğer boyutlar **eşit derecede meşru ve birbirini telafi etmiyorsa**, **non-compensatory multi-criteria approach (MCA)** kullanılmalı — bu, ordinal/ayrı bilgiyi koruyan, tek sayıya indirgemeyen bir yaklaşım.

**Eşit ağırlıklandırma "ağırlıksızlık" değildir:** Handbook'un çok net bir uyarısı: "equal weighting does not mean 'no weights', but implicitly implies the weights are equal." Yani NotifyMe basitçe "hepsini eşit ağırlıklandır" derse bile bu **bir değer yargısı vermiş olur**, nötr bir varsayılan değil — bu, kullanıcı-tanımlı ağırlıkların (§10) da, eşit ağırlığın da, ikisinin de keyfi olduğunu, "en az keyfi" seçeneğin **ağırlıklandırmadan kaçınmak** (boyutları ayrı göstermek) olduğunu gösteriyor.

**Kanıt seviyesi:** Var — doğrulandı, güçlü (OECD/JRC'nin resmi metodoloji standardı, 20+ yıllık kullanım, birden fazla ağırlıklandırma/aggregation yönteminin sistematik karşılaştırması).

---

## 7. Aggregation / Weighting

Handbook'un weighting yöntemleri tablosu (istatistiksel: PCA/factor analysis, DEA, UCM; katılımcı: budget allocation, **AHP**, conjoint analysis) NotifyMe için **hiçbiri uygun değil** — hepsi ya çok sayıda veri noktası (PCA/DEA/UCM — korelasyon yapısı gerektiriyor, NotifyMe'de tek kullanıcı/az Task var) ya da çok sayıda "uzman"/katılımcı (budget allocation, conjoint) gerektiriyor. **AHP** (Aşama 2C'nin Sharp 2013 bulgusuyla zaten işaretlenmiş "over-engineering" riski) burada da doğrulanıyor: Handbook'un kendi notu — AHP "sadece düşük sayıda indikatör için uygulanabilir" (pairwise comparison sayısı karesel büyüyor) ve **NotifyMe'nin tek kullanıcısı** "uzman paneli" rolünü tek başına oynamak zorunda kalır, bu da AHP'nin asıl gücünü (çoklu-değerlendirici konsensüsü) devre dışı bırakır.

**Kullanıcı-tanımlı ağırlıklar (§10, seçenek C) için özel uyarı:** Handbook, ağırlıkların "essentially value judgements" olduğunu, kaynağı ne olursa olsun (istatistiksel, uzman, kullanıcı) **hiçbirinin "objektif"** olmadığını vurguluyor. NotifyMe'nin kullanıcıdan "final proje Goal'ün yaklaşık %X'i" gibi bir tahmin istemesi (Aşama 2C'nin Model C'si) teknik olarak mümkün ama **iki katmanlı hata riski** taşıyor: hem kullanıcının kendi task-ağırlık tahmini (planning-fallacy'ye benzer bir öznel yargı) hem de bu ağırlıkların zaman içinde geçerliliğini koruyup korumadığı (bir görev başta "küçük" görünüp sonra "büyük" çıkabilir) — bu ikinci kat belirsizlik literatürde **doğrudan ele alınmadı**, açık soru olarak kalıyor (§24).

**Kanıt seviyesi:** Var — doğrulandı ki mevcut ağırlıklandırma yöntemlerinin hiçbiri NotifyMe ölçeğine doğrudan uymuyor; Belirsiz — kullanıcı-tanımlı ağırlıkların zamanla-geçerlilik sorunu.

---

## 8. Multi-Dimensional Progress

Handbook'un **non-compensatory MCA**'sı ve kullanıcının "vector/multi-dimensional progress" fikri **aynı çözümün** iki farklı ismi. Ek destek, muhasebe/yönetim literatüründen: Iselin, Mia & Sands (2009, *Int. J. Accounting, Auditing and Performance Evaluation*) — Balanced Scorecard tipi **multi-perspective performans raporlama sistemleri**nin (dört ayrı, birleştirilmemiş boyut: finansal, müşteri, süreç, öğrenme) organizasyonel performansla **pozitif** ilişkili olduğunu, buna karşılık "information/data/redundant cue overload"un (çok fazla ayrı metrik) performansla **zayıf negatif** ilişkili olduğunu gösteriyor — yani ayrı boyutlar göstermek **kendi başına** aşırı yük yaratmıyor, ama boyut sayısı arttıkça (BSC örneğinde 4'ün ötesi) risk artıyor. Hioki, Suematsu & Miya (2020, *Pacific Accounting Review*) benzer biçimde, çoklu metrik altında "information overload"un yalnızca **yüksek Need-for-Cognition** yöneticilerde bile finansal/müşteri metriklerini etkili kullanamama riskine yol açtığını gösteriyor — düşük-NFC'de zaten müşteri-perspektifi metrikleri kullanılmıyor.

**NotifyMe için sonuç:** Mixed-unit Goal'lerde **2-4 ayrı boyut** (Balanced Scorecard'ın kendi pratik sınırı) göstermek, tek bir yapay-birleştirilmiş yüzdeden **daha dürüst ve muhtemelen aynı derecede kullanılabilir** — ama sınırsız boyut sayısı önerilmiyor. Bu, §6-7'nin "tek sayıya indirgeme = false precision" bulgusunu tamamlıyor: **"no aggregation, show dimensions separately"** (Mustafa'nın kendi listesindeki F seçeneği) hem OECD/JRC metodolojisiyle hem muhasebe/BSC literatürüyle **iki bağımsız kaynaktan** destekleniyor.

**Kanıt seviyesi:** Var — doğrulandı, orta-güçlü (OECD/JRC doğrudan; BSC/muhasebe literatürü NotifyMe'ye örgütsel bağlamdan aktarılıyor, birebir değil).

---

## 9. Goal Observability

**En biçimsel/matematiksel destek bu bölümde bulundu.** Bayesian Knowledge Tracing (BKT — Corbett & Anderson 1995; güncel derleme: arXiv 2105.15106, "A Survey of Knowledge Tracing") öğrenme analitiğinde **latent mastery** ile **gözlemlenen performansı** biçimsel olarak ayıran kanonik model: bir Hidden Markov Model'de, **gözlemlenemeyen düğümler** (öğrencinin gerçekten skill'i "bilip bilmediği", ikili: mastered/not-mastered) ile **gözlemlenen düğümler** (o skill'e ait bir sorunun doğru/yanlış cevaplanması) arasında **emisyon olasılıkları** (guess: bilmeden doğru yanıtlama olasılığı; slip: bilerek yanlış yanıtlama olasılığı) tanımlanıyor. Bu, kullanıcının kendi "workload tamamlandı ≠ Goal başarıldı" sezgisinin **doğrudan matematiksel karşılığı**: gözlemlenen aktivite (doğru cevap sayısı) mastery'nin **kesin göstergesi değil, gürültülü bir emisyonu**.

**Kritik veri-gereksinimi bulgusu (uygulanabilirlik sınırı):** pyBKT'nin kendi validasyon çalışması (arXiv 2105.00385) somut bir eşik veriyor: güvenilir parametre yakınsaması için **~50 öğrenci**, kabul edilebilir mastery-tahmin doğruluğu için **öğrenci başına ~15 gözlem/fırsat** gerekiyor (worst-case mastery-estimation-accuracy, sequence length ~15'te "asymptote" ediyor). Individualized BKT çalışmaları (Yudelson, Koedinger & Gordon) ayrıca öğrenci-özgü **öğrenme hızı** parametresinin (kaç deneme sonra öğrenir) **öğrenci-özgü başlangıç-mastery**'den daha belirleyici olduğunu, ama bunun da **cross-student** (birden fazla öğrenciden) fit edilmesi gerektiğini gösteriyor.

**NotifyMe'ye doğrudan uygulama:** NotifyMe'nin tek-kullanıcı, tek-Goal bağlamı bu veri gereksinimini **hiçbir şekilde** karşılamıyor — bir formal BKT-tarzı "mastery olasılığı" hesaplamak, Cleanup A'nın "false precision" uyarısının (§18, sayısal confidence gösterme riski) doğrudan bir tekrarı olur. **Sonuç:** NotifyMe mastery-tipi Goal'ler için gizli bir "mastery skoru" **üretmemeli** — sadece **gözlemlenen workload/aktivite verisini** göstermeli, "bu aktivite mastery'yi garanti eder" iması yapmamalı. Achievement Goal Theory literatürü (Elliot & McGregor 2001, 2×2 mastery/performance modeli) burada **yalnızca dolaylı** destek sağlıyor — bu literatür kullanıcının *neden* bir Goal'i takip ettiğini (motivasyonel yönelim) ele alıyor, "Goal'ün gerçek durumu ne kadar gözlemlenebilir" sorusunu değil; bu ayrım araştırma notunda açıkça belirtilmeli, iki farklı soru karıştırılmamalı.

**Kanıt seviyesi:** Var — doğrulandı, güçlü (BKT'nin latent/observed ayrımı biçimsel olarak doğru, veri-gereksinimi somut sayılarla ölçülmüş); NotifyMe'ye tam BKT uygulaması **önerilmiyor** — önkoşul karşılanmıyor, sadece kavramsal ayrım (latent vs observed) ödünç alınıyor.

---

## 10. Workload Progress vs Goal Achievement

§9'un doğrudan sonucu: NotifyMe'nin veri modelinde/UI'ında **iki ayrı kavram** açıkça ayrılmalı — **workload progress** (gözlemlenen: tamamlanan soru/saat/proje sayısı, güvenilir, doğrudan ölçülen) ve **goal outcome/mastery** (gizli: gerçekten öğrenildi mi, bilinmiyor, sadece **proxy** görülebiliyor). Bu ayrım Phase 2C'nin Goodhart's Law bulgusuyla (§14, o rapor) ve Phase 2D'nin construct-validity bulgusuyla (§19, "task completion rate ≠ productivity") aynı ailede, ama burada **mimari bir öneri** olarak somutlaşıyor: NotifyMe **iki farklı gösterge** taşımalı, tek bir "Goal progress %" değil.

**Pratik minimum:** doğal-birimli (natural-unit) Goal'lerde bu ayrım gereksiz (workload = outcome, "3000 soru çöz" gibi Goal'lerde tamamlanma zaten anlamlı bir gösterge). Mastery-tipi Goal'lerde ("Python öğren") sistem **açıkça** "workload: %80 tamamlandı" + "mastery: ölçülmedi/bilinmiyor" gibi iki ayrı, birbirine karıştırılmayan alan göstermeli — Cleanup A'nın kategorik-etiket tercihi (sayısal % yerine) burada da geçerli.

**Kanıt seviyesi:** Var — doğrulandı (§9'un doğal uzantısı, üç bağımsız kaynaktan — Aşama 2C, 2D, bu faz — yakınsıyor).

---

## 11. Goal Types / Measurement Strategies

Kullanıcının önerdiği üç-tipli sistem (OUTPUT_GOAL / PROJECT_GOAL / MASTERY_GOAL) **kavramsal olarak** §6 (natural-unit vs mixed-unit) ve §9 (observable vs latent) bulgularıyla tutarlı, ama literatür **hangi mimari biçimin** (ayrı Goal "type" alanı mı, yoksa tek Goal modeli + opsiyonel "measurement strategy" mi) daha temiz olduğuna dair **doğrudan bir kanıt sunmuyor** — bu, mühendislik tercihi olarak kalıyor. Tek dolaylı ipucu: composite-indicator literatüründeki (§6-8) "hangi aggregation yönteminin kullanılacağı, verinin doğasına göre önceden belirlenmeli" ilkesi, Goal'ün **başlangıçta** (oluşturulduğunda) hangi ölçüm stratejisine (natural-amount / milestone-weighted / proxy-only) sahip olacağının **açıkça seçilmesi** gerektiğini destekliyor — bu seçim sonradan (Goal ilerledikçe) örtük biçimde değişmemeli, çünkü bu §3-5'teki "scope change ≠ performance deviation" ayrımını bulanıklaştırır.

**Schema büyütme riski değerlendirmesi:** Üç ayrı Goal type'ı (her biri farklı progress-hesaplama mantığı) ile tek model + strateji-flag arasındaki fark, öncelikle **kod karmaşıklığı** sorunu — literatür bu spesifik mühendislik trade-off'una girmiyor. Notumuz: **measurement strategy** (bir enum/flag: `natural_amount` | `weighted_milestones` | `proxy_unmeasured`) muhtemelen "Goal type" (ayrı sınıf hiyerarşisi) yerine daha az şema büyütmesi gerektirir, ama bu **doğrulanmış bir literatür sonucu değil, mühendislik değerlendirmesi**.

**Kanıt seviyesi:** Var — doğrulandı (ayrımın kendisi, §6+§9'dan miras); Yok — hangi mimari biçim daha iyi, literatür bu soruyu cevaplamıyor.

---

## 12. Proxy / Goodhart Risk

Phase 2C'nin Goodhart's Law bulgusu (§14, o rapor) burada **mixed-unit ve mastery bağlamına genişletiliyor**: eğer NotifyMe kullanıcıya "video %70, final proje %20, ortalama %55" gibi tek bir birleşik sayı gösterirse ve bu sayı örtük olarak "hedef" haline gelirse, kullanıcı **daha kolay boyutu şişirerek** (çok video izleyip final projeyi ertelemek) genel skoru yükseltebilir — bu, composite-indicator literatüründeki "double counting"/"gaming" riskiyle (Handbook §6, korelasyonlu indikatörlerin ağırlık şişirmesi) ve Aşama 2C'nin agile-velocity "gaming" bulgusuyla (story-point şişirme) aynı aile. **Non-compensatory gösterim (§8) bu riski azaltır**: eğer boyutlar ayrı gösteriliyorsa, "final projeyi ihmal ediyorsun" sinyali video-izleme skoruyla **gizlenemez**.

**Dil önerisi (Aşama 2C'nin kendi önerisiyle tutarlı):** "Goal başarı olasılığı" yerine "workload trajectory" gibi daha dürüst bir terim kullanılmalı — bu faz, bu öneriyi **mixed-unit ve mastery Goal'lerde daha da güçlü bir gereklilik** olarak teyit ediyor, çünkü bu Goal türlerinde "başarı" kelimesinin epistemik zemini (§9-10) natural-unit Goal'lerden daha zayıf.

**Kanıt seviyesi:** Var — doğrulandı (Aşama 2C + composite-indicator literatürünün yakınsaması).

---

## 13. Coasting

**Bu araştırmanın en zengin, en doğrudan aktarılabilir literatürü.** Phase 2C'nin teorik (Carver & Scheier 1990) coasting bulgusu burada **deneysel olarak doğrulandı ve nüanslandı**:

- **Thürmer, Scheier & Carver (2019, *Motivation Science*, DOI 10.1037/mot0000157)** — 2 kontrollü deney, katılımcılara iki hedef (doğruluk + hız) veriliyor, yarı yolda rastgele geri bildirim veriliyor (bir hedefte hedefin üstünde/altında). **Bulgu:** hedefin üstünde olduğu bildirilen katılımcılar o hedefte **daha az** çaba gösteriyor (coasting) VE eş zamanlı olarak **diğer** hedefe kayıyor (shifting) — bu ikisi birlikte gerçekleşiyor, sadece "gevşeme" değil, "kaynak yeniden-tahsisi". Deney 2, bu etkinin **affect** (olumlu duygu) üzerinden nedensel olarak işlediğini gösteriyor — Carver & Scheier'in orijinal teorik mekanizmasını doğrudan doğruluyor.
- **Fulford, Johnson, Llabre & Carver (2010, *Psychological Science*, DOI 10.1177/0956797610373372)** — **NotifyMe'nin kendi kullanım desenine en yakın kanıt**: 21 gün boyunca günde 3 kez, kendi-seçtikleri 3 hedef hakkında experience-sampling (bipolar bozukluk grubu + kontrol grubu). **Bulgu:** beklenenin altında ilerleme → sonraki çabada **artış**; beklenenin üstünde ilerleme → sonraki çabada **azalış** — "coasting response was particularly robust." Bu, laboratuvar deneyinin (Thürmer ve ark.) gerçek-dünya, kullanıcı-tanımlı, günlük-ölçekli hedeflerde de **tekrarlandığını** gösteriyor — NotifyMe'nin senaryosuna (kullanıcı kendi Goal'ini tanımlıyor, günlük/haftalık ilerleme takip ediliyor) neredeyse birebir yapısal benzerlik.
- **Cheema & Bagchi ("Resting on Laurels", *J. Consumer Research*, DOI 10.1086/598802) — beklenmedik nüans:** Discrete Progress Markers (DPM, yani "ilerleme göstergeleri") **progress certainty**'ye (ilerlemenin ne kadar belirsiz/belirgin olduğuna) bağlı olarak **ters yönlerde** çalışıyor: ilerleme belirsizken DPM performansı **artırıyor** (uncertainty azaltıyor), ilerleme zaten belirginken DPM performansı **düşürüyor** ("complacency" yaratıyor). **NotifyMe'ye doğrudan sonuç:** progress göstergesi eklemek **evrensel olarak iyi değil** — Goal'ün doğası zaten net/belirginse (örn. basit sayısal Goal, kolayca izlenen) ekstra bir "işte %70'tesin" göstergesi coasting riskini **artırabilir**; belirsiz/karmaşık Goal'lerde (mastery-tipi) aynı gösterge faydalı olabilir.

**En değerli/beklenmedik bulgu — Jostmann & Brummelman (2025, ön-kayıtlı, N=395, 3 deney):** Coasting'i **önleme** yöntemi bulundu. Olumlu geri bildirim **hemen** (immediate) verilirse performans düşüyor (coasting) — ama kullanıcı bir sonraki performansına **hazırlanmaya başladıktan sonra** (preparatory phase, "delayed" feedback) verilirse, performans düşmüyor, **artıyor** (encouragement'a dönüşüyor). **NotifyMe için somut tasarım ipucu:** "hedefinin önündesin" mesajını, kullanıcı bir sonraki oturuma/task'a **başlamak üzereyken** (ör. yeni bir Task'a tıkladığında, günlük plan açıldığında) göstermek, hemen geri bildirim anında göstermekten **daha güvenli** olabilir — bu, ampirik olarak test edilmemiş bir NotifyMe-özgü çıkarım ama üç bağımsız, güçlü kaynaktan (Thürmer, Fulford, Jostmann) türetiliyor.

**Kanıt seviyesi:** Var — doğrulandı, çok güçlü (deneysel + naturalistik + ön-kayıtlı replikasyon, üç bağımsız araştırma grubu, Carver & Scheier'in orijinal teorisiyle tam tutarlı).

---

## 14. Behind Feedback / Disengagement

**Wrosch, Scheier, Miller, Schulz & Carver (2003, *Personality and Social Psychology Bulletin*, DOI 10.1177/0146167203256921)** — Goal Disengagement/Reengagement Scale'in temel makalesi, 3 çalışma (N=115 üniversite öğrencisi; N=120 genç+yaşlı yetişkin; N=45 kanser hastası çocuk ebeveyni). **Bulgu:** **goal disengagement kapasitesi** (ulaşılamaz bir hedeften vazgeçebilme) **düşük psikolojik sıkıntı** ile ilişkili; **goal reengagement kapasitesi** (yeni, ulaşılabilir hedeflere geçebilme) **yüksek öznel iyi-oluş** ile ilişkili — ikisi **bağımsız süreçler**, biri diğerini garanti etmiyor. Barlow, Wrosch & McGrath'in (2019) meta-analitik derlemesi bu bulguyu çok sayıda örneklemde doğruluyor.

**"Geridesin" bilgisinin ne zaman disengagement'a yol açabileceği:** Wrosch ve ark.'ın teorik modeli (goal adjustment capacities makalesi, PMC4145404) şunu öneriyor: sürekli/tekrarlayan başarısızlık sinyali, eğer kullanıcı **alternatif, anlamlı bir hedefe** yönlendirilmiyorsa, salt "disengagement" (vazgeçme) değil **hiçbir şeye** (ne eski hedefe ne yeni birine) bağlanmama riskini artırabilir — bu, teorik model düzeyinde, NotifyMe'ye özgü ampirik test **yapılmadı**, ama Wrosch'un kendi bulgusuyla (reengagement'ın ayrı ve gerekli bir süreç olduğu) tutarlı bir çıkarım.

**Kanıt seviyesi:** Var — doğrulandı, güçlü (birden fazla bağımsız örneklem + meta-analiz); NotifyMe'nin spesifik "geridesin" mesajının disengagement'ı tetikleyip tetiklemediği **doğrudan test edilmedi**, teorik model düzeyinde çıkarım.

---

## 15. Adaptive Goal Adjustment

**Phase 2C'nin açık bıraktığı soru burada kapatıldı.** Carver & Scheier'in kendi "response shift" makalesi (2000, *Social Science & Medicine*, DOI 10.1016/S0277-9536(99)00412-8) — Sprangers & Schwartz'ın (1999) sağlık-ilişkili yaşam kalitesi literatüründeki "response shift" fenomenini kendi kontrol-teorisi çerçevesiyle açıklıyor. **Ana mekanizma:** İnsan öz-düzenleme sistemi iki hızda çalışan geri besleme döngüsüne sahip — hızlı döngü davranışı (task'ları) yönetir, **yavaş döngü** ise referans değerin (hedefin) kendisini kademeli olarak **yeniden kalibre eder**. Uzun süreli olumsuz sapma (deteriorating performance) durumunda bu yavaş döngü hedefi **küçültür** ("scaling back goals") — bu, Carver & Scheier'in kendi ifadesiyle **"giving up in a small way, so as not to give up in a large way"** — hedefi küçültmek, alanı tamamen terk etmemek için bir **koruyucu** mekanizma.

**NotifyMe için doğrudan sonuç:** Kullanıcının deadline uzatması, workload azaltması, scope küçültmesi **normal, adaptif bir öz-düzenleme süreci** olarak modellenmeli, sistem tarafından "başarısızlık" veya "pes etme" olarak **etiketlenmemeli**. Bu, §5'teki (scope change ≠ performance deviation) mimari ayrımı **psikolojik olarak da** güçlendiriyor: kullanıcı bir Goal'i küçültüyorsa, bu genellikle rasyonel bir yeniden-kalibrasyon, sistem hatası göstergesi değil.

**Kanıt seviyesi:** Var — doğrulandı, güçlü (Carver & Scheier'in kendi teorisinin doğal uzantısı, response-shift literatürüyle çapraz doğrulanmış).

---

## 16. Trajectory Messaging

§13-15'in birleşik sonucu: LEVEL/TREND **internal** sinyal, kullanıcı-facing mesaj **farklı bir katman** olmalı. §13'ün Jostmann & Brummelman bulgusu **zamanlama**yı (ne zaman gösterilir), Cheema & Bagchi'nin bulgusu **ne zaman hiç gösterilmemesi gerektiğini** (progress zaten belirginken ekstra gösterge complacency riski), §15'in Carver & Scheier bulgusu **çerçevelemeyi** (evaluative "geridesin" yerine descriptive "son 7 gündeki hızın..." veya action-oriented "bu hız devam ederse...") etkiliyor. Kullanıcının önerdiği üç framing türü (descriptive / evaluative / action-oriented) arasında literatür **doğrudan bir karşılaştırma** sunmuyor (bu, copywriting/mesaj-tasarımı araştırmasına girer, talimatın kendi sınırı) — ama üç bulgu birlikte şu ilkeyi destekliyor: **evaluative ("geridesin/öndesin") çerçeveleme en yüksek coasting/disengagement riskini taşıyan tür**, çünkü doğrudan bir sosyal/kişisel değerlendirme imasıdır; descriptive/action-oriented çerçevelemeler bu riski **teorik olarak** azaltır (ama bu spesifik karşılaştırma NotifyMe'de test edilmedi).

**Kanıt seviyesi:** Dolaylı destekli (üç bağımsız bulgunun birleşik çıkarımı), doğrudan bir "hangi framing daha iyi" deneyi bulunamadı.

---

## 17. Multiple Goals / Capacity

Bu konu Phase 2C'de (Kruglanski'nin Goal Systems Theory, counterfinality) kapsamlı işlendi, burada **tekrar araştırılmadı**. Talimatın sorduğu tek yeni soru: "Bir Goal gerideyse workload artır demek diğer Goal'ları bozabilir mi" — Phase 2C'nin counterfinality bulgusu bu soruyu **zaten evet** olarak cevaplıyor. Bu fazın tek katkısı: coasting/disengagement bulguları (§13-15) ile birleştirildiğinde, "Goal-level trajectory + user-level capacity" birlikte düşünülmesi gerekliliği **daha da güçleniyor** — çünkü bir Goal'de "öndesin" (coasting riski) ile aynı anda başka bir Goal'de "geridesin" (disengagement riski) mesajları **eş zamanlı** verilirse, Fishbach & Dhar'ın (2005, Cheema & Bagchi'nin atıfladığı) "goal shifting" bulgusuyla tutarlı olarak kullanıcı kaynağını öndeki Goal'den geridekine **otomatik olarak** kaydırabilir — bu aslında **istenen** bir davranış olabilir (self-regulating), ama sistemin bunu bilinçli tasarlaması ile tesadüfen olması arasında fark var. Bu Phase 3'te zorunlu bir mimari kısıt olarak işaretlenmeli, ama kod/algoritma önerilmiyor.

**Kanıt seviyesi:** Var — doğrulandı (Aşama 2C'den miras + bu fazın coasting bulgusuyla birleşik çıkarım).

---

## 18. Candidate Trajectory Models

Aşama 2C'nin 4 modeli (A: Minimal Deterministic, B: Workload-Aware+Level/Trend, C: Weighted/Multi-Unit, D: Probabilistic) **tekrar üretilmiyor** — bu fazın bulguları bu modellere **ek katmanlar** olarak ekleniyor, yeni bir model seti değil:

- **Model A/B'ye eklenen katman — Re-baselining (§3-5):** Her iki model de, Goal'ün totalWorkload/deadline'ı değiştiğinde **segment ayırma** (§4) mekanizmasına ihtiyaç duyuyor. Bu, Model A/B'nin "Tasarım 1 uygulanabilirliği" değerlendirmesini **değiştirmiyor** (segment ayırma nispeten basit bir veri-modeli eklentisi), ama önceden not edilmemiş bir gereksinim ekliyor.
- **Model C'ye (Weighted/Multi-Unit) eklenen uyarı (§6-8):** Aşama 2C zaten Model C'yi "düşük-orta uygulanabilirlik, yüksek UX maliyeti" olarak işaretlemişti — bu fazın OECD/JRC bulgusu bunu **güçlendiriyor**: kullanıcı-tanımlı ağırlıklar (Model C'nin temel mekanizması) "essentially value judgements", objektif değil. **Yeni aday olarak önerilen: Model C' — Non-Aggregated Multi-Dimensional**, yani Model C'nin ağırlıklandırma adımını **tamamen atlayıp** boyutları ayrı göstermek (§8). Bu, Model C'den **daha düşük implementasyon karmaşıklığı** (ağırlık toplama/normalize etme mantığı yok) ve **daha yüksek bilimsel savunulabilirlik** (false-precision riski yok) taşıyor — Tasarım 1 için Model C'den daha uygulanabilir bir aday.
- **Model A/B'ye eklenen "mastery katmanı" (§9-12):** Mastery-tipi Goal'lerde (natural-unit olmayan), hangi model seçilirse seçilsin, **workload progress** (gözlemlenen) ile **mastery/outcome** (gizli, ölçülmeyen) ayrı gösterilmeli — bu, mevcut modellere eklenen bir **UI/veri-modeli kuralı**, ayrı bir "5. model" değil.
- **Tüm modellere eklenen "messaging katmanı" (§13-16):** LEVEL/TREND'in kullanıcıya **nasıl ve ne zaman** gösterileceği (evaluative değil descriptive/action-oriented; immediate değil preparatory-phase'de; progress zaten belirginse hiç gösterilmeyebilir) — bu da ayrı bir model değil, tüm modellerin **UI tasarım kısıtı**.

**Sonuç:** Aşama 2C'nin Model B'si (Workload-Aware + Level/Trend) hâlâ **en dengeli aday** (o raporun kendi değerlendirmesiyle tutarlı), ama bu faz onu üç somut ek gereksinimle (segment-ayırma, mastery-ayrımı, messaging-zamanlaması) **zenginleştiriyor**. Model C yerine **Model C'** (non-aggregated) mixed-unit Goal'ler için önerilir.

---

## 19. Candidate Re-Baselining Models

Kullanıcının önerdiği 4 seçenek (Reset / Versioned Baseline / Segmented History / Recalculation) §3-5 bulgularıyla değerlendirilir:

- **A) Full Reset:** Geçmişi tamamen kaybeder — literatür (GAO, ITS) tarafından **desteklenmiyor**, hiçbir kaynak bunu önermiyor. Açıklanabilirliği yüksek ama epistemik olarak dürüst değil (Aşama 2A'nın §19-20'sindeki "sistemin kendi geçmişini gizlemesi" eleştirisine benzer risk).
- **B) Versioned Baseline (basit kayıt):** Her rebaseline anında eski parametreleri (totalWorkload, deadline vb.) bir "sürüm" olarak saklamak — GAO'nun "orijinal baseline + güncel baseline" pratiğiyle (federal IT programları) doğrudan tutarlı, uygulaması nispeten basit.
- **C) Segmented History (ITS-tarzı, §4'te önerilen):** Her segment kendi LEVEL/TREND'ini taşır, hiçbir veri silinmez veya yeniden yorumlanmaz — **en güçlü literatür desteğine sahip** (Schober & Vetter, segmented regression), B ile **birlikte** kullanılabilir (B: parametre geçmişi, C: performans geçmişi segmentasyonu).
- **D) Recalculation (geçmişi yeni beklentiyle yeniden yorumlama):** Literatür tarafından **örtük olarak reddediliyor** — segmented-regression'ın temel motivasyonu tam olarak bunun (basit öncesi-sonrası karşılaştırmanın) yanıltıcı olabileceğini göstermek (Schober & Vetter'in "flawed" uyarısı, trend zaten var olduğunda spurious etki üretme riski).

**Sonuç:** **B + C birlikte** (versioned parameters + segmented performance history) en savunulabilir, tek başına D önerilmiyor, A açıkça reddediliyor. Nihai seçim Phase 3'te.

---

## 20. Candidate Mixed-Unit Models

Kullanıcının önerdiği 6 seçenek §6-8 bulgularıyla değerlendirilir:

| Seçenek | Varsayımlar | False-precision riski | UX yükü | Uygulama maliyeti |
|---|---|---|---|---|
| A) Single weighted % | Tüm boyutlar ortak birime indirgenebilir, telafi edilebilir | **Yüksek** (Handbook: compensability varsayımı genellikle yanlış) | Düşük (kullanıcıya tek sayı) | Düşük |
| B) Duration-based ortak denominator | "Süre" tüm iş türleri için adil bir ortak ölçü | Orta (süre de bir proxy, gerçek "iş miktarı" değil — Aşama 2C §14'ün time-on-task eleştirisiyle aynı risk) | Düşük | Orta |
| C) User-defined weights | Kullanıcı kendi ağırlığını doğru tahmin edebilir | **Yüksek** (Handbook: ağırlıklar her zaman value judgement, kullanıcı da "objektif" değil) | Yüksek (ekstra veri girişi) | Orta-yüksek |
| D) Milestone-based | Milestone'lar eşit önemde veya önem sırası biliniyor | Orta | Orta | Orta |
| E) Multi-dimensional/vector (**Model C'**, §18) | Boyutlar gerçekten farklı, birleştirilmemeli | **Düşük** (Handbook'un resmi önerisi) | Orta (birden fazla gösterge okunmalı, ama §8'in BSC bulgusu 2-4 boyutta bunun sorun olmadığını gösteriyor) | Düşük-orta |
| F) No aggregation (E ile aynı, isim farkı) | — | — | — | — |

**Sonuç:** **E (multi-dimensional/vector)** hem en düşük false-precision riski hem OECD/JRC'nin resmi tavsiyesiyle en tutarlı seçenek — Tasarım 1 için en savunulabilir aday. A (single weighted %) en düşük uygulama maliyetine sahip ama epistemik olarak en zayıf — eğer kullanılırsa, **"bu bir yaklaşıklık, kesin bir birleştirme değil"** şeklinde açıkça etiketlenmeli.

---

## 21. Evaluation

Phase 2D'nin Claim→Evidence çerçevesi burada doğrudan uygulanıyor.

**Sentetik senaryolarla test edilebilecek property'ler:**
- **History preservation:** rebaseline sonrası eski segment verisinin (LEVEL/TREND) hâlâ erişilebilir/doğru olduğunu doğrulamak — deterministic unit test.
- **No false performance penalty after scope change:** totalWorkload arttığında (kullanıcı hatası değil, scope genişlemesi), yeni segmentin LEVEL hesaplamasının eski segmentin "kötü performans" olarak yanlış yorumlanmadığını doğrulamak — sentetik senaryo (§27 listesindeki senaryo 4-7).
- **LEVEL/TREND continuity:** segment geçişinde TREND hesaplamasının (EWMA benzeri) aniden sıfırlanmadığını, kademeli geçiş yaptığını doğrulamak.
- **Bounded response, no invalid aggregation:** mixed-unit Goal'lerde, eğer Model A (single %) seçilirse, birimler arası **geçersiz toplamaların** (örn. "20 saat + 10 soru" direkt toplama) test kapsamında **engellenmiş** olduğunu doğrulamak — deterministic unit test.
- **Capacity constraint respect (§17):** birden fazla Goal aynı anda "workload artır" önerisi üretirse, toplam önerinin kullanıcının availability'sini aşmadığını doğrulamak.

**Sentetik değerlendirme neyi KANITLAYAMAZ (Aşama 2D §6'nın burada tekrarı):** kullanıcının gerçekten coasting yaşayıp yaşamadığı, "geridesin" mesajının gerçek dünyada disengagement'a yol açıp açmadığı, segment-ayırmanın kullanıcı tarafından **anlaşılır** bulunup bulunmadığı (bu, Aşama 2D'nin usability-pilot kategorisine giriyor, sentetik test değil), multi-dimensional gösterimin tek-sayıdan gerçekten daha az "gaming"e yol açtığı (bu davranışsal bir iddia, sentetik veriyle test edilemez).

**Kanıt seviyesi:** Var — doğrulandı (Aşama 2D çerçevesinin doğrudan uzantısı).

---

## 22. Red Team

| # | Varsayım | Destekleyici kanıt | Karşı kanıt | Belirsizlik | Risk | NotifyMe implikasyonu |
|---|---|---|---|---|---|---|
| 1 | Her Goal sayısal olarak ölçülebilir | Natural-unit Goal'lerde doğru | §9: BKT'nin latent/observed ayrımı, mastery Goal'lerde doğrudan ölçüm yok | Düşük | **YÜKSEK** | Goal type/measurement strategy ayrımı gerekli |
| 2 | Her Goal tek bir progress % ile temsil edilmelidir | Basit Goal'lerde makul | §6-8: OECD/JRC Handbook, compensability varsayımının çoğu zaman yanlış olduğunu gösteriyor | Düşük | **YÜKSEK** | Mixed-unit Goal'lerde vector/non-aggregated gösterim tercih edilmeli |
| 3 | Task completion Goal progress demektir | Tek-birimli Goal'lerde kısmen doğru | §9-12: BKT + Goodhart's Law (Aşama 2C) | Düşük | **YÜKSEK** | Workload≠outcome ayrımı zorunlu |
| 4 | Workload completion Goal success demektir | — | §12: proxy gaming riski | Düşük | **YÜKSEK** | "Başarı" dili yerine "workload trajectory" dili |
| 5 | Farklı unit'ler ağırlıklarla kolayca toplanabilir | Sezgisel makul | §6-7: Handbook, weight seçiminin her zaman değer yargısı olduğu | Düşük | **YÜKSEK** | Sabit/kullanıcı-tanımlı ağırlık yerine non-aggregated gösterim |
| 6 | Estimated duration doğal ve tarafsız ortak unit'tir | Süre evrensel bir ölçü gibi görünüyor | §20: süre de bir proxy (time-on-task eleştirisi, Aşama 2C §14) | Orta | **ORTA** | Duration-based aggregation da false-precision riski taşır |
| 7 | User-defined weights gerçeği temsil eder | Kullanıcı kendi işini bilir | §7: Handbike + kullanıcının kendi planning-fallacy'si (Aşama 2A) | Orta | **YÜKSEK** | Kullanıcı ağırlıkları da keyfi olabilir, "objektif" değil |
| 8 | Re-baseline yapmak geçmiş performansı silmelidir | Basit/sezgisel (temiz sayfa) | §4: ITS/segmented-regression literatürü, geçmişin korunabileceğini gösteriyor | Düşük | **YÜKSEK** | Full-reset yerine segmented history |
| 9 | Re-baseline geçmiş veriyi yeniden hesaplamalıdır | "Doğru" görünüyor | §4: Schober & Vetter, basit before-after karşılaştırmanın yanıltıcı (spurious trend) olabileceğini gösteriyor | Orta | **ORTA-YÜKSEK** | Recalculation yerine segmentasyon |
| 10 | Scope change performans başarısızlığıdır | — | §5: GAO verisi, rebaseline'ların çoğunun kapsam/finansman kaynaklı olduğunu, "kötü performans" değil | Düşük | **YÜKSEK** | Scope change ile performance deviation açıkça ayrılmalı |
| 11 | Deadline değişikliği sadece basit bir tarih güncellemesidir | — | §3-4: deadline değişikliği de rebaseline tetikleyicisi, segment-ayırma gerektirebilir | Orta | **ORTA** | Deadline değişikliğinin de trajectory'ye etkisi değerlendirilmeli |
| 12 | "Ahead" feedback her zaman motive edicidir | Genel sezgi (olumlu geri bildirim iyidir) | §13: Thürmer/Fulford/Cheema — coasting deneysel olarak kanıtlı, robust etki | Düşük | **YÜKSEK** | "Öndesin" mesajı dikkatli zamanlanmalı/çerçevelenmeli |
| 13 | "Behind" feedback her zaman motive edicidir | Discrepancy motive edebilir (Locke & Latham) | §14: Wrosch — sürekli olumsuz sinyal disengagement'a da yol açabilir | Orta | **YÜKSEK** | "Geridesin" mesajı da risk taşır, tek yönlü olumlu varsayılamaz |
| 14 | Kullanıcı Goal'den vazgeçerse sistem başarısız olmuştur | Ürün-başarı sezgisi | §15: Carver & Scheier'in response-shift teorisi, scaling-back'in adaptif olduğunu gösteriyor | Düşük | **YÜKSEK** | Goal adjustment/disengagement UI'da "başarısızlık" olarak kodlanmamalı |
| 15 | Goal disengagement her zaman kötüdür | — | §14: Wrosch, disengagement kapasitesinin düşük psikolojik sıkıntıyla ilişkili olduğunu gösteriyor | Düşük | **YÜKSEK** | Disengagement kabul edilebilir bir çıktı olmalı |
| 16 | Daha fazla progress metriği daha doğru trajectory verir | Sezgisel (daha fazla veri = daha iyi) | §8: BSC/muhasebe literatürü, information overload riskini gösteriyor (özellikle >4 boyut) | Orta | **ORTA** | Boyut sayısı 2-4 ile sınırlı tutulmalı |
| 17 | Progress göstergesi göstermek her zaman faydalıdır | Şeffaflık ilkesi genel olarak iyi | §13: Cheema & Bagchi — DPM, progress zaten belirginken performansı düşürüyor | Orta | **ORTA** | Gösterge her zaman gösterilmemeli, belirsizlik düzeyine göre koşullu olmalı |

---

## 23. Phase 3 Decision Table

**A. Re-baselining gerekli mi?** Evet — GAO'nun verisi (federal IT programlarının ~%48'i rebaseline ediliyor, en sık neden kapsam değişikliği) NotifyMe'nin senaryosunun **yaygın, normal** bir olay olduğunu gösteriyor.

**B. Hangi değişiklikler baseline version oluşturmalı?** totalWorkload, deadline, successCriterion değişikliği (Goal'ün **tanımının** değişmesi) — §5.

**C. Eski history korunmalı mı?** Evet, kesinlikle — §4, segmented-regression literatürü full-reset'i açıkça desteklemiyor.

**D. Scope change ile performance deviation nasıl ayrılmalı?** "Goal tanımı değişti mi (workload/deadline/kriter) yoksa aynı tanım altında gerçekleşen mi beklenenden sapıyor" testi — §5.

**E. Mixed-unit Goal tek yüzdeye indirgenmeli mi?** Hayır, tercihen değil — §6-8, OECD/JRC + BSC literatürü non-aggregated gösterimi destekliyor.

**F. Duration ortak denominator olarak kullanılmalı mı?** Kısmen destekli ama false-precision riski taşıyor (süre de bir proxy) — §20, orta risk.

**G. User-defined weights kullanılmalı mı?** Kullanılırsa açıkça "kullanıcı tahmini, kesin değil" etiketlenmeli — §7.

**H. Multi-dimensional progress gerekli/yararlı mı?** Evet, en savunulabilir mixed-unit çözümü — §8, §20.

**I. Natural-unit Goal ile mastery Goal ayrılmalı mı?** Evet — §9-11, BKT'nin latent/observed ayrımı doğrudan destekliyor.

**J. Goal type mı, measurement strategy mi daha temiz?** Literatür bu spesifik mimari soruyu cevaplamıyor — mühendislik kararı, measurement-strategy (flag) muhtemelen daha az şema büyütmesi (dolaylı çıkarım) — §11.

**K. Workload progress ile Goal success ayrılmalı mı?** Evet, kesinlikle — §10, üç bağımsız kaynaktan (2C, 2D, bu faz) yakınsama.

**L. Proxy metrics kullanıcıya nasıl sunulmalı?** "Workload trajectory" dili, "başarı/mastery" dili değil — §12.

**M. LEVEL/TREND hangi Goal türlerinde anlamlı?** Natural-unit ve (dikkatle) milestone-based Goal'lerde güçlü; mastery Goal'lerde sadece workload boyutunda, outcome boyutunda değil — §9-11.

**N. Ahead feedback coasting riski taşıyor mu?** Evet, deneysel olarak kanıtlı, robust bir etki — §13.

**O. Behind feedback disengagement riski taşıyor mu?** Evet, teorik olarak destekli (Wrosch), NotifyMe'ye özgü ampirik test yok — §14.

**P. Goal adjustment/disengagement failure sayılmalı mı?** Hayır — Carver & Scheier'in response-shift teorisi ve Wrosch'un well-being bulgusu, adaptif bir süreç olduğunu gösteriyor — §14-15.

**Q. Trajectory feedback intervention olarak değerlendirilmeli mi?** Evet — hem coasting/disengagement literatürü hem "reactivity of self-monitoring" (behaviorist psikoloji, §16'da referans) trajectory göstermenin nötr bilgi değil, davranışsal bir müdahale olduğunu gösteriyor.

**R. Goal-level trajectory user-level capacity ile birlikte düşünülmeli mi?** Evet — Aşama 2C'den miras + bu fazın coasting/shifting bulgusuyla (Fishbach & Dhar) güçlenen bir kısıt — §17.

**S. Tasarım 1 için en gerçekçi trajectory aday modelleri hangileri?** Model B (Workload-Aware + Level/Trend, Aşama 2C) + bu fazın 3 eklentisi (segment-ayırma, mastery-ayrımı, messaging-zamanlaması); mixed-unit için Model C' (non-aggregated); re-baselining için Versioned+Segmented (B+C) kombinasyonu — §18-20.

**T. Hangi konular future work olarak bırakılmalı?** Kullanıcı-tanımlı ağırlıkların zamanla-geçerlilik sorunu (§7); "hangi framing türü — descriptive/evaluative/action-oriented — en güvenli" sorusunun doğrudan deneysel testi (§16); Goal type vs measurement-strategy mimari kararının kod-seviyesi karşılaştırması (§11); achievement-goal-theory'nin (mastery/performance orientation) NotifyMe'nin kullanıcı-motivasyon modeline entegrasyonu (§24).

---

## 24. Future Work / Limitations

Bu araştırma sırasında ortaya çıkan ama dört ana kararı **doğrudan değiştirmeyen** sorular, STOP RULE gereği derinleştirilmedi:

- **Achievement Goal Theory'nin motivasyonel boyutu** (mastery-approach vs performance-approach goal orientation, Elliot & McGregor 2×2 modeli) — bu literatür "kullanıcı Goal'i neden takip ediyor" sorusuna cevap veriyor, "Goal'ün durumu ne kadar gözlemlenebilir" sorusuna değil. NotifyMe'nin kullanıcı-motivasyon modeline dahil edilip edilmeyeceği ayrı bir soru, bu fazda araştırılmadı.
- **Kullanıcı-tanımlı ağırlıkların zamanla-geçerlilik sorunu** (§7) — bir task'ın "göreli önemi" Goal ilerledikçe değişebilir mi, değişirse nasıl güncellenmeli — literatürde doğrudan ele alınmadı.
- **Dashboard/çoklu-metrik tasarımının HCI-spesifik derinliği** (§8'de kısmen değinildi, pratisyen/blog kaynakları düşük kaliteli bulundu, akademik muhasebe kaynakları (Iselin, Hioki) örgütsel bağlamdan NotifyMe'nin kişisel bağlamına dolaylı aktarılıyor) — kişisel productivity dashboard'larına özgü bir HCI literatürü taraması yapılmadı.
- **Framing türlerinin (descriptive/evaluative/action-oriented) doğrudan karşılaştırmalı deneysel testi** (§16) — literatürde bulunamadı, muhtemelen mevcut değil veya bu oturumda erişilemedi.
- **Milestone-weighted Goal'lerde ağırlığın "task count" veya "estimated effort"tan türetilmesinin göreli güvenilirliği** — §10'daki seçenekler karşılaştırıldı ama hiçbiri için doğrudan ampirik kanıt bulunamadı, hepsi mühendislik varsayımı seviyesinde kaldı.

Bu sorular Phase 3 kararını **bloklamıyor**, ama gelecekte (kullanıcı verisi biriktikçe veya Phase 3 sonrası) yeniden ziyaret edilebilir.

---

## 25. Sources

### Kullanılan arama sorguları (9 gerçek Exa sorgusu)

1. rebaselining project schedule baseline change management scope change academic
2. change point segmented regression preserve historical baseline versioning time series analysis
3. composite indicator construction weighting aggregation methodology pitfalls OECD handbook
4. achievement goal theory mastery goals performance goals latent construct measurement education
5. Bayesian knowledge tracing latent skill mastery estimation observable performance proxy
6. Wrosch capacity to disengage from unattainable goals reengagement well-being
7. coasting effect goal progress feedback ahead of schedule reduced effort empirical study
8. self-monitoring reactivity personal informatics quantified self measurement changes behavior
9. response shift scaling back goals Carver Scheier expectancy disengagement self-regulation
10. multiple performance metrics dashboard single score criticism information overload decision making

### Ana kaynaklar (güçlü/doğrudan kullanılan)

- **GAO-08-925** (2008), *Information Technology: Agencies Need to Establish Comprehensive Policies to Address Changes to Projects' Cost, Schedule, and Performance Goals* — ABD Government Accountability Office, resmi denetim raporu, 250 IT programı ampirik anket. Güven: Yüksek (kurumsal standart).
- **Kesheh & Stratton** (2014), "Taking the Guesswork Out of Rebaselining", PM World Journal — pratisyen kaynağı, açıkça öyle işaretlendi, akademik hakemli değil.
- **Schober & Vetter** (2021), "Segmented Regression in an Interrupted Time Series Study Design", *Anesthesia & Analgesia*, PMC7870037. Güven: Yüksek (peer-reviewed, metodoloji makalesi).
- **[Yazar bilgisi eksik]** (2025), "Interpretation of coefficients in segmented regression for interrupted time series analyses", *BMC Medical Research Methodology*, DOI 10.1186/s12874-025-02556-8. Güven: Yüksek.
- **Nardo, Saisana, Saltelli, Tarantola, Hoffmann, Giovannini** (2005/2008), *Handbook on Constructing Composite Indicators: Methodology and User Guide*, OECD/JRC. Güven: Yüksek (kurumsal metodoloji standardı, OECD+European Commission JRC ortak yayını).
- **Corbett & Anderson** (1995), Bayesian Knowledge Tracing'in orijinal makalesi (bu oturumda doğrudan erişilmedi, güncel derlemeler — arXiv 2105.15106, Wikipedia BKT maddesi, pyBKT arXiv 2105.00385 — üzerinden aktarıldı). Orijinal DOI bu oturumda doğrulanamadı.
- **Yudelson, Koedinger & Gordon**, "Individualized Bayesian Knowledge Tracing Models" — CMU teknik raporu, hakemli konferans/dergi bilgisi bu oturumda netleştirilemedi.
- **Wrosch, Scheier, Miller, Schulz & Carver** (2003), "Adaptive Self-Regulation of Unattainable Goals: Goal Disengagement, Goal Reengagement, and Subjective Well-Being", *Personality and Social Psychology Bulletin*, DOI 10.1177/0146167203256921. Güven: Yüksek (3 çalışma, çok atıflı).
- **Barlow, Wrosch & McGrath** (2019), "Goal adjustment capacities and quality of life: A meta-analytic review", *Journal of Personality*, DOI 10.1111/jopy.12492. Güven: Yüksek (meta-analiz).
- **Thürmer, Scheier & Carver** (2019), "On the mechanics of goal striving: Experimental evidence of coasting and shifting", *Motivation Science*, DOI 10.1037/mot0000157. Güven: Yüksek (2 kontrollü deney).
- **Fulford, Johnson, Llabre & Carver** (2010), "Pushing and Coasting in Dynamic Goal Pursuit", *Psychological Science*, DOI 10.1177/0956797610373372. Güven: Yüksek (21 gün ESM, gerçek-dünya).
- **Jostmann & Brummelman** (2025), coasting'i geciktirilmiş geri bildirimle önleme — 3 deney, N=395, ön-kayıtlı replikasyon içeriyor. Dergi/DOI bilgisi PDF üzerinden alındı, tam bibliyografik doğrulama bu oturumda yapılmadı (yazar web sitesinden erişildi — eddiebrummelman.com).
- **Cheema & Bagchi**, "Resting on Laurels: The Effects of Discrete Progress Markers as Subgoals on Task Performance and Preferences", *Journal of Consumer Research*, DOI 10.1086/598802 (Duke.edu üzerinden erişildi, tam yazar/yıl bilgisi PDF'te net değildi). Güven: Orta-yüksek.
- **Carver & Scheier** (2000), "Scaling back goals and recalibration of the affect system are processes in normal adaptive self-regulation: understanding 'response shift' phenomena", *Social Science & Medicine*, DOI 10.1016/S0277-9536(99)00412-8. Güven: Yüksek (Carver & Scheier'in kendi teorik uzantısı).
- **Cooper, Heron & Heward** (2007), reactivity kavramının kaynağı (davranış analizi ders kitabı) — "Know Thyself: A Theory of the Self for Personal Informatics" makalesi üzerinden dolaylı atıfla kullanıldı, birincil kaynağa bu oturumda erişilmedi.
- **Iselin, Mia & Sands** (2009), "Multi-perspective performance reporting and organisational performance", *Int. J. Accounting, Auditing and Performance Evaluation*, DOI 10.1504/ijaape.2010.030477. Güven: Orta (peer-reviewed ama örgütsel bağlamdan NotifyMe'ye dolaylı aktarım).
- **Hioki, Suematsu & Miya** (2020), "The interaction effect of quantity and characteristics of accounting measures on performance evaluation", *Pacific Accounting Review*, DOI 10.1108/par-04-2018-0034. Güven: Orta (deneysel, N=54, örgütsel bağlam).

### Elenen/zayıf bulunan kaynaklar

- Dashboard tasarımı üzerine bulunan blog/pratisyen kaynakları (routiine.io, ioannisphilippides.com, s-lib.com "EIU" makalesi — bu sonuncusu akademik görünümlü ama düşük tanınırlıklı bir dergide, 2026 tarihli) — akademik kanıt olarak **kullanılmadı**, sadece §8/§24'te "pratik uzlaşı var ama akademik derinlik zayıf" notuyla anıldı.
- Achievement Goal Theory'nin bulunan makaleleri (PALS, AGQ-R ölçek çalışmaları) — konuyla ilgili ama bu fazın asıl sorusuna (observability) dolaylı, §9'da açıkça "yalnızca dolaylı destek" olarak işaretlendi, §24'e taşındı.

### Önemli belirsizlikler

- Corbett & Anderson'ın (1995) BKT orijinal makalesinin tam bibliyografik bilgisi (dergi, DOI) bu oturumda doğrulanamadı — güncel derlemeler ve pyBKT üzerinden aktarıldı.
- Jostmann & Brummelman (2025) ve Cheema & Bagchi makalelerinin tam dergi/cilt/sayı bilgisi PDF içeriğinden çıkarılamadı, sadece DOI/başlık düzeyinde doğrulandı.
- Kesheh & Stratton'ın (RBF) önerdiği "0.5 eşik, 3 ardışık dönem" parametreleri **inşaat/raylı sistem projelerinden** (yazarların kendi ifadesiyle) türetilmiş — NotifyMe ölçeğine doğrudan aktarılabilir değil, sadece **"ardışık kalıcılık" ilkesi** ödünç alınabilir, sayısal değerler değil.

---

**Durum:** Open-Gaps Cleanup C tamamlandı. **Open-Gaps Cleanup programı bu raporla bitmiştir** — yeni bir cleanup fazı önerilmiyor. Kod/repo/roadmap/Goal modeli değişikliği yapılmadı, algoritma implement edilmedi, nihai mimari kararı verilmedi, commit/push yapılmadı. Phase 3 (mimari tasarım/karar) için Mustafa'nın önünde artık 8 araştırma raporu var: Phase 1, 2A, 2B, 2C, 2D, Open-Gaps Cleanup A, B, C.

# NotifyMe — Tasarım 1 Araştırması — Aşama 2B: Akademik Literatür — User Feedback + Failure Attribution + Human Factors

**Tarih:** 2026-09-20
**Kapsam:** Yalnızca yapılandırılmış/serbest-metin kullanıcı geri bildirimi, başarısızlık atıfı (failure attribution), self-report güvenilirliği, feedback timing, habituation, explainability, kullanıcı kontrolü ve feedback→adaptasyon eşleştirmesi. Goal trajectory/pace, akademik literatürün genel taraması dışındaki konular ve Faz 1 (ticari rakipler) bu raporun konusu DEĞİL.
**Amaç:** NotifyMe'nin ad-hoc feedback kategorilerini doğrulamak DEĞİL. Varsayımlar yanlışsa açıkça söylemek, daha iyi bir model varsa bulmak.
**Önceki raporlar (okundu, değiştirilmedi):** `notifyme_competitor_analysis_phase1.md`, `notifyme_academic_adaptation_closed_loop_phase2a.md`.

---

## 1. Executive Summary

NotifyMe'nin "outcome yetmez, cause de lazım" sezgisi akademik olarak **güçlü destekli**: Weiner'in attribution theory'si (1985, *Psychological Review*, DOI 10.1037/0033-295X.92.4.548) tam olarak bunu söylüyor — locus/stability/controllability üç boyutu farklı psikolojik sonuçlar (beklenti değişimi, duygu, motivasyon) doğuruyor, "başarısız oldum" tek başına bilgi vermiyor. JITAI literatüründeki **tailoring variable** kavramı (Nahum-Shani ve ark. 2016, DOI 10.1007/s12160-016-9830-8; Dziak ve ark., Oxford *Annals of Behavioral Medicine* 2026, DOI mevcut) NotifyMe'nin "cause → hangi adaptasyon" sorusuna **doğrudan uygulanabilir, hazır bir akademik çerçeve** sağlıyor — bu Aşama 2A'da bulunamayan boşluğu büyük ölçüde dolduruyor.

Ama iki temel varsayım ciddi şekilde sarsılıyor: (1) **Kullanıcının kendi başarısızlık nedenini doğru bildiği varsayımı zayıf** — self-serving bias meta-analizi (Mezulis ve ark. 2004, DOI 10.1037/0033-2909.130.5.711) d=0.96 gibi çok büyük bir etki bulmuş: insanlar sistematik olarak başarıyı içsel, başarısızlığı dışsal nedenlere atfediyor. "Zamanım yetmedi" kullanıcının içtenlikle inandığı ama **sistematik olarak yanlı** bir açıklama olabilir. (2) **Kullanıcı kontrolü/onay akışı serbestçe iyi değil** — psikolojik reactance literatürü (Li & Shi 2025 meta-analiz, DOI 10.1093/hcr/hqaf016) özellikle **tekrarlayan davranışlarda** özgürlük-tehdit eden dilin reaktans arttırdığını gösteriyor; NotifyMe'nin haftalık tekrar eden önerileri tam bu risk kategorisinde.

Free-text geri bildirimin "daha fazla bilgi" sağladığı iddiası da **koşullu doğru**: EMA/deneyim örneklemesi literatürü (Stone, Schneider & Smyth 2022, DOI 10.1146/annurev-clinpsy-080921-083128) momentary self-report'un retrospektiften daha güvenilir olduğunu ama recall bias'ın kısa gecikmede bile (aynı gün içinde) ortaya çıktığını gösteriyor — NotifyMe'nin "gün sonu" veya "haftalık" geri bildirim toplama tasarımı bu riski taşıyor.

## 2. Research Scope

Bu aşama şu 7 araştırma sorusunu ve LLM alt-sorusunu kapsıyor: (1) failure attribution/neden sınıflandırması, (2) self-report güvenilirliği, (3) feedback timing, (4) habituation/intervention fatigue, (5) explainability/trust, (6) user control/autonomy, (7) feedback→adaptation mapping, ve sınırlı olarak LLM sınıflandırma uygulanabilirliği. Goal trajectory, Phase 1 rakip analizi ve genel LLM/agent/RAG araştırması kapsam dışı.

## 3. Search Methodology

Exa web search ile ~20 gerçek arama sorgusu çalıştırıldı (attribution theory, self-regulated learning/procrastination, EMA/self-report reliability, JITAI habituation/fatigue, explainable recommendations/trust, algorithm aversion/appreciation, tailoring variables, LLM few-shot classification, survey response-category sayısı, self-serving bias, psikolojik reactance). Öncelik: survey/meta-analiz/review makaleleri, sonra bireysel temel çalışmalar. Kaynaklar ağırlıklı olarak APA PsycNet, Oxford Academic, ScienceDirect, PMC/PubMed, SAGE, ACM, arXiv (preprint olarak işaretlendi). Çoğu kaynağa Exa'nın "highlights" özetleri üzerinden erişildi — tam metin PDF'e erişilen birkaç istisna dışında (ör. Nahum-Shani 2016 JITAI PDF, tailoring variables Oxford makalesi).

## 4. Relevant Research Fields

Attribution Theory · Self-Regulated Learning/Metacognition/Procrastination · Ecological Momentary Assessment/Experience Sampling · JITAI/Adaptive Interventions (tailoring variables) · Intervention Fatigue/Habituation · Explainable Recommender Systems · Algorithm Aversion/Appreciation · Psychological Reactance/Self-Determination Theory · Survey/Questionnaire Design · LLM Text Classification/Annotation.

## 5. Attribution Theory

**Temel kaynak:** Weiner, B. (1985). "An attributional theory of achievement motivation and emotion." *Psychological Review*, 92(4), 548–573. DOI: 10.1037/0033-295X.92.4.548 (Aşama 2A'da da bulundu, burada derinleştirildi). Üç causal dimension: **locus** (içsel/dışsal), **stability** (kalıcı/geçici), **controllability** (kontrol edilebilir/edilemez). Bu üçü sırasıyla beklenti değişimi, öz-saygıyla ilgili duygular (gurur/utanç/suçluluk) ve kişilerarası yargıları (yardım, kızgınlık) etkiliyor — **outcome değil, atıfın kendisi** motivasyonu ve gelecek davranışı belirliyor.

**Eğitim alanına uygulama (attributional retraining):** Hamm, Perry, Clifton, Chipperfield & Boese (2014), *Basic and Applied Social Psychology* — DOI 10.1080/01973533.2014.890623; Perry ve ark.'nın 15+ yıllık attributional retraining (AR) programı. Lazowski & Hulleman (2016) meta-analizi: AR etkisi orta boy (d=0.54), 1-2 harf notu performans kazancına denk geliyor. **Bulgu:** kontrol edilemez atıfları azaltmak (AR ile) algılanan kontrolü ve olumlu duyguyu artırıyor, bu da performansı **dolaylı olarak** (aracı değişkenler üzerinden) etkiliyor — Hamm ve ark. 2017/2021 çalışması bu nedensel zinciri path-analysis ile doğruluyor.

**Procrastination bağlantısı:** Steel (2007) meta-analizi — "The nature of procrastination", *Psychological Bulletin*, 133(1), 65-94, DOI 10.1037/0033-2909.133.1.65 — 691 korelasyon, en güçlü yordayıcılar task aversiveness, self-efficacy, impulsiveness, conscientiousness. Ayrıca bir 2023 çalışma (*Frontiers in Psychology*, DOI mevcut, https://doi.org/10.3389/fpsyg.2023.1167660) causal attribution + self-efficacy'nin akademik erteleme üzerindeki aracı rolünü doğruluyor — içsel atıf (effort) düşük erteleme ile ilişkili.

**NotifyMe için sonuç:** Weiner'ın üç boyutu (locus/stability/controllability) doğrudan uygulanabilir bir **sınıflandırma iskeleti** sunuyor, ama bu üç boyut kullanıcıya doğrudan "locus/stability/controllability" olarak sorulmaz — bunlar **arka planda** kategori tasarımını değerlendirmek için kullanılan bir analiz çerçevesi olmalı (bkz. §7).

## 6. Outcome vs Cause

Literatür bu ayrımı **doğrudan** destekliyor ama farklı bir terminolojiyle: Weiner'ın modeli zaten "outcome" (başarı/başarısızlık) ile "causal ascription" (neden) arasında net bir kavramsal ayrım yapıyor — outcome duyguyu (genel olumlu/olumsuz) belirlerken, atıf **öz-saygıya bağlı** spesifik duyguları (gurur/utanç/suçluluk) ve **gelecek beklentisini** belirliyor (Weiner 1985, yukarıdaki kaynak; ayrıca güncel bir replikasyon: Tracy & Ibasco, *Emotion Review* güncel, ResearchGate kaydı). JITAI/tailoring variable literatürü de aynı ayrımı **operasyonel** düzeyde yapıyor: "response status" (outcome — responder/nonresponder) ile "tailoring variable" (hangi bilginin adaptasyon kararını yönlendireceği) ayrı kavramlar (Dziak ve ark., Oxford *Annals of Behavioral Medicine*, "Constructing evidence-based tailoring variables for adaptive interventions").

**A sorusunun cevabı (bkz. §17 A-R):** Evet, outcome ve cause ayrı tutulmalı — literatür bunun tek bir "nasıl geçti" sorusuna indirgenemeyeceğini gösteriyor. **Kanıt seviyesi: Var — doğrulandı** (Weiner'ın 40+ yıllık teorik/ampirik temeli + JITAI'nin operasyonel ayrımı).

## 7. Candidate Failure Taxonomies

Mevcut ad-hoc 9 kategori ("Planladığım gibi geçti / ... / Diğer") eleştiriyle değerlendirildiğinde:

- **"Kısmen tamamladım"** bir OUTCOME'dur, CAUSE değil — Task modelindeki `status` (partiallyCompleted) alanı zaten bunu tutuyor, feedback kategorisinde tekrarı **redundant** ve kavramsal karışıklık yaratıyor (§6'daki ayrımı ihlal ediyor).
- **"Zamanım yetmedi"** bir CAUSE ama Weiner'ın taksonomisinde **belirsiz konumlu**: hem içsel-kontrol edilebilir ("planlamayı iyi yapmadım") hem dışsal-kontrol edilemez ("beklenmedik iş çıktı") anlamına gelebilir — tek bir kategori altında iki farklı adaptasyon-anlamı gizleniyor.
- **"Planlama/tahmin hatası"** aslında ayrı bir kategori değil, "zamanım yetmedi"nin **spesifik bir alt-nedeni** olabilir (estimation error, bkz. Buehler, Griffin & Ross 1994 planning fallacy, Aşama 2A'da bulundu) — kategori listesinde granülerlik tutarsız.

**Önerilen akademik-temelli taksonomi mimarisi (nihai liste değil, iskelet):** Weiner'ın 2 boyutuna (locus, controllability — stability tek-seferlik bir görev feedback'i için daha az kritik, haftalık trend analizinde daha anlamlı) dayalı 2x2 çerçeve önerilebilir:

| | İçsel (locus=internal) | Dışsal (locus=external) |
|---|---|---|
| **Kontrol edilebilir** | Odaklanamadım / Ertelediğim | Görev tanımını kötü yaptım |
| **Kontrol edilemez** | Beklenmedik enerji/sağlık düşüşü | Beklenmedik dış müdahale |

Bu, mevcut ad-hoc listeden **daha az kategori, daha net teorik temel** ama kullanıcıya "locus/controllability" jargonuyla sorulmaz — arkaplanda her seçeneğin bu 2x2'ye eşlendiği bir kullanıcı-dostu metin listesi olur. "Görev beklediğimden zordu" ayrı bir üçüncü eksen (task difficulty attribution — ability/task ayrımı, Weiner'ın orijinal 4-hücre modelinde "task difficulty" ayrı bir hücre) gerektirir; bu 2x2'ye tam oturmuyor, taksonominin en az 3 boyutlu olması gerekebilir — **bu bir açık tasarım sorusu, çözülmedi.**

**Kategori sayısı — HCI/survey design kanıtı:** Sistematik derleme (DeCastellarnau 2017, *Quality & Quantity*, DOI 10.1007/s11135-017-0533-4) ve scoping review (2024, *Sage Open*, DOI 10.1177/21582440241230363) net bir "optimal sayı" vermiyor — bulgular çelişkili, ama **çoğunluk 4-7 arası** öneriyor, 7'nin üzerinde ayırt edilebilirlik düşüyor ve "response style" (rastgele/dikkatsiz yanıtlama) artıyor. Pokropek ve ark. (güncel, tomek.zozlak.org yayını) 2.800+ katılımcılı deneyde daha fazla kategori = daha uzun yanıt süresi ama **algılanan yük/ilgi/motivasyon değişmiyor** bulmuş — yani "çok kategori kullanıcıyı yorar" varsayımı **kısmen abartılı** olabilir, ama bu bulgu genel survey bağlamında, NotifyMe'nin **her görev sonrası tekrar eden** mikro-etkileşim bağlamına doğrudan genellenemez (bkz. §10 response burden, farklı bir literatür — task-level, survey-level değil).

**Kanıt seviyesi:** Mevcut 9 kategorinin outcome/cause karışımı içermesi **Var — doğrulandı** (kavramsal analiz, Weiner'ın ayrımına dayanarak). Optimal kategori sayısı **Belirsiz** — literatür çelişkili.

## 8. Self-Report Reliability

Bu, Aşama 2B'nin en kritik ve en güçlü kanıtlı bulgusu.

**Recall bias, kısa gecikmede bile var:** Stone, Schneider & Smyth (2022), *Annual Review of Clinical Psychology*, DOI 10.1146/annurev-clinpsy-080921-083128 — EMA'nın 9 metodolojik sorununu değerlendiren otoriter review. Peak-and-end heuristic (Redelmeier & Kahneman 1996 — kolonoskopi ağrısı çalışması, klasik) tek bir günün içinde bile geçerli: insanlar deneyimin **zirve** ve **son** anını hatırlıyor, süre boyunca ortalamayı değil.

**Negativity/extremity bias:** Ellison ve ark. (2020), *Personality and Individual Differences*, DOI 10.1016/j.paid.2020.110071 — retrospektif hatırlama ile EMA ortalamaları arasında **anlamlı fark** bulundu; katılımcılar stresi olduğundan daha yüksek hatırlıyor (extremity/negativity bias). Zielke & Stewart (2011, tez, Indiana University-Purdue) sistematik review: EMA, retrospektif ölçümden 9 bulgunun 5'inde (56%) daha güçlü prediktif validiteye sahip — ama %22'sinde retrospektif daha iyi, sonuç türüne (biyolojik vs davranışsal/subjektif) bağlı.

**Objektif davranışla korelasyon zayıf/değişken:** Behavior-analytic sistematik review (PMC9163273) mobil EMA (mEMA) ile objektif ölçümler (accelerometer vb.) arasındaki uyum oranının **%1.8 ile %100 arasında** değiştiğini, birleştirici bir değişken bulunamadığını gösteriyor — yani self-report'un objektif veriyle ne kadar örtüştüğü **davranışa ve kişiye göre büyük ölçüde değişken**, genellenebilir bir güvenilirlik katsayısı yok.

**Self-serving bias — NotifyMe'nin en büyük riski:** Mezulis, Abramson, Hyde & Hankin (2004), *Psychological Bulletin*, 130(5), 711, DOI 10.1037/0033-2909.130.5.711 — 266 çalışma, 503 etki büyüklüğü meta-analizi. Ortalama **d=0.96** (büyük etki): insanlar başarıyı içsel/kalıcı/global, başarısızlığı dışsal/geçici/spesifik nedenlere atfetme eğiliminde — bu **neredeyse evrensel** (neredeyse tüm örneklemlerde mevcut), kültüre göre değişse de (ABD d=1.05, Asya örneklemleri d=0.30) her zaman pozitif yönde. Campbell & Sedikides (1999) meta-analizi (*Review of General Psychology*, DOI 10.1037/1089-2680.3.1.23) bu bias'ın **self-threat** (öz-saygıya tehdit) arttıkça büyüdüğünü gösteriyor — yani kullanıcı NotifyMe'de tekrar tekrar başarısızlık gördükçe, self-serving bias'ın **güçlenmesi** beklenir, azalması değil.

**Sonuç (G sorusu):** Self-report **kör biçimde güvenilir kabul edilemez**. "Zamanım yetmedi" dediğinde bu, kullanıcının içtenlikle inandığı ama sistematik olarak dışsallaştırılmış bir açıklama olabilir (d=0.96 çok büyük bir etki — bu marjinal bir uyarı değil, literatürün en sağlam bulgularından biri). **Kanıt seviyesi: Var — doğrulandı, güçlü.**

## 9. Subjective + Objective Data

NotifyMe'nin planned/actual (objektif) + kategorik/serbest-metin (subjektif) veriyi birleştirme fikri için doğrudan "multimodal self-tracking" veya "self-report + behavioral data fusion" başlığında adanmış bir metodolojik literatür **derinlemesine bulunamadı** bu oturumda (zaman kısıtı — bu bir açık soru olarak işaretleniyor, §21). Ancak dolaylı destek güçlü: yukarıdaki §8'deki EMA-objektif korelasyon bulguları (PMC9163273, %1.8-%100 uyum aralığı) zaten **çelişkili veri** senaryosunun norm olduğunu, istisna olmadığını gösteriyor — yani NotifyMe'nin "plannedDuration=60, actualDuration=25 ama kullanıcı 'zamanım yetmedi' diyor" örneği **beklenmedik bir edge-case değil, EMA literatüründe standart karşılaşılan bir durum.**

**Çelişkili veride sistem ne yapmalı (I sorusu):** Doğrudan bir "ground truth" iddiası literatürde bulunamadı (kullanıcıyı "yalancı" saymak hiçbir kaynakta önerilmiyor). En yakın destek: JITAI'nin "tailoring variable reliability" ilkesi (Nahum-Shani 2016 JITAI PDF, §Tailoring Variables) — "when tailoring variables are measured unreliably, decision rule performs little better than random; when invalid, may recommend counterproductive option" — bu, **çelişkili sinyali görmezden gelmek yerine confidence/güvenilirlik olarak modellemenin** (bkz. §12) neden gerekli olduğuna dolaylı destek veriyor, ama "kullanıcıya açıklama sor" veya "confidence düşür" arasında hangisinin daha iyi olduğuna dair doğrudan ampirik kanıt bulunamadı. **Kanıt seviyesi: mühendislik varsayımı + dolaylı JITAI destekli, doğrudan literatür yok.**

## 10. Feedback Timing and Response Burden

EMA literatürü (§8'deki kaynaklar) momentary/anlık geri bildirimin retrospektiften genellikle daha az yanlı olduğunu gösteriyor — ama bu, "her görev sonrası sor" ile "gün sonu/hafta sonu sor" arasındaki NotifyMe-spesifik trade-off'a **doğrudan** cevap vermiyor; EMA çalışmaları tipik olarak günde 3-8 rastgele bildirim kullanıyor (klinik bağlamda), NotifyMe'nin her-görev-sonrası modeli daha yüksek frekanslı olabilir.

**Response burden kavramı:** JITAI intervention fatigue literatüründe (§11) "burden" resmi olarak tanımlanmış — "perceived amount of effort required to participate in the intervention" (Sekhon ve ark., Nahum-Shani 2025 review'da alıntılanmış, DOI 10.1146/annurev-psych-121024-044244). Bu literatür **resource efficiency** ilkesini vurguluyor: gereksiz müdahale/soru sıklığı burden+fatigue+habituation'ı artırıp genel etkinliği düşürüyor — bu, "her task sonrası feedback" tasarımına karşı dolaylı ama net bir uyarı.

**E sorusunun cevabı:** Evet, her task sonrası feedback istemek muhtemelen kötü fikir — hem survey design literatürü (kısa/az soru → daha az yorgunluk) hem JITAI resource-efficiency ilkesi bunu destekliyor. **F sorusu:** Feedback muhtemelen **sapma olduğunda zorunlu, planlandığı gibi gittiğinde opsiyonel/tek-tık** olmalı — bu JITAI'nin "provide nothing" seçeneğine (gereksiz müdahaleden kaçınma) kavramsal olarak paralel, ama NotifyMe'ye özgü bu eşiğin nasıl belirleneceği literatürden gelmiyor, tasarım kararı. **Kanıt seviyesi: dolaylı destekli (JITAI resource-efficiency ilkesi), NotifyMe'nin spesifik frekans sorusuna doğrudan literatür yok.**

## 11. Habituation / Intervention Fatigue

Aşama 2A'daki HeartSteps bulgusunu derinleştiriyor. İki temel kaynak:

**Park ve ark. (2023)**, KAIST — "Understanding Disengagement in Just-in-Time Mobile Health Interventions" (ic.kaist.ac.kr, muhtemelen CHI/CSCW tarzı konferans, tam bibliyografik bilgi bu oturumda doğrulanamadı — **preprint/PDF olarak erişildi, dergi/konferans adı teyit edilmedi**). Nitel+nicel: disengagement döngüsü 4 faktörle tetikleniyor — (1) **boredom/habituation** ("aynı ses, aynı mesaj... numb oldum"), (2) inopportune alarm (yanlış zamanda kesinti), (3) **distrust for JIT feedback mechanism**, (4) düşük ödül nedeniyle motivasyon kaybı. Yüksek boredom-proneness + düşük self-control olan kullanıcılar en hızlı disengage oluyor.

**Nahum-Shani & Murphy (2025)**, *Annual Review of Psychology*, DOI 10.1146/annurev-psych-121024-044244 (Aşama 2A'da bulundu, burada derinleştirildi) — "burden", "mental fatigue", "habituation" resmi olarak tanımlanıyor; **çözüm önerisi: içerik/format/zamanlama çeşitlendirme** ("bank" of content, aynı mesajı tekrar sunmak yerine), ve **"provide nothing" seçeneği** decision rule'a dahil edilmeli. **pJITAI (personalized JITAI)** kavramı — stokastik (deterministik değil) karar kuralları, sistemin "prompt gönder / gönderme" kararını olasılıksal öğrenmesi — NotifyMe'nin ölçeğinde (tek kullanıcı, erken veri) **aşırı karmaşık**, ama "aynı öneriyi asla art arda aynı biçimde verme" ilkesi basit bir tasarım kuralı olarak alınabilir.

**J sorusu — sistem ne zaman SUSMALI:** Literatür net: sürekli aynı tip/format öneri = disengagement riski. **Suppress/cooldown/variation** JITAI'nin resmi "provide nothing" ve içerik-çeşitlendirme ilkeleriyle **doğrudan eşleşiyor**. **Kanıt seviyesi: Var — doğrulandı (JITAI resmi çerçevesi), ama Park ve ark.'nın tam yayın bilgisi doğrulanamadı — düşük-orta güven o kaynak için.**

## 12. Explainability and Trust

**Sistematik review (Jafari & Vassileva, 2026), ACM (muhtemelen TORS/TIST), DOI 10.1145/3820245** — "What Makes an Explanation Good" — PRISMA metodolojili, son 10 yıl. 7 açıklama hedefi tanımlıyor (Tintarev & Masthoff taksonomisi): effectiveness, efficiency, **transparency**, persuasiveness, **trust**, satisfaction, scrutability.

**Wardatzky ve ark. (2025)**, *ACM Trans. Recommender Systems*, DOI 10.1145/3716394 — 124 makalelik sistematik derleme: açıklama etkisinin **kullanıcı özelliklerine göre büyük ölçüde değiştiğini**, meta-analiz yapılamayacak kadar heterojen/tutarsız bulgular olduğunu gösteriyor — yani "açıklama = daha fazla güven" **evrensel bir yasa değil**, koşullu.

**Siepmann & Chatti (2023)**, arXiv preprint, DOI 10.48550/arxiv.2304.08094 — "Trust and Transparency in RS" review: şeffaflık-güven ilişkisi **karışık sonuçlu** — Cramer ve ark. şeffaflığın güveni artırmadığını, Kunkel ve ark. açıklama **kalitesinin** (miktarının değil) güveni artırdığını buluyor. **Controllability + explanation birlikte** (ayrı özellikler olarak) algılanan güveni artırıyor (Tsai ve ark., bu review'da alıntılanmış).

**NotifyMe'nin A/B örneği (kısa "90 dakika öneriyorum" vs uzun gerekçeli açıklama):** Literatür **B'nin otomatik olarak daha iyi olduğunu doğrulamıyor** — açıklama kalitesi (Kunkel ve ark.) önemli olabilir ama açıklama **miktarı** ile güven arasında net bir doz-cevap ilişkisi yok; bazı çalışmalar (Beyond Persuasion, Jafari 2025, DOI 10.1145/3705328.3748758) fazla bilginin **bilişsel yük** yarattığını, karar hızını düşürebileceğini gösteriyor. **L sorusunun cevabı:** "Ne kadar bilgi gösterilmeli" sorusuna literatür tek bir cevap vermiyor — **kullanıcı özelliklerine (need for cognition, uzmanlık) göre uyarlanabilir açıklama** en güçlü öneri, ama bu NotifyMe'nin tek-kullanıcı erken aşaması için over-engineering olabilir. **Kanıt seviyesi: Var — doğrulandı ki ilişki KOŞULLU, "daha fazla açıklama = daha iyi" iddiası Yok — açıkça reddedildi (literatür tarafından).**

## 13. User Control / Autonomy

**Algorithm aversion vs appreciation — çözülmemiş bir çelişki, entegre edilmiş çerçeve var:** Burton, Stein & Jensen (2019) sistematik review (*J. Behavioral Decision Making*, DOI 10.1002/bdm.2155); Logg, Minson & Moore (2019) "algorithm appreciation" (*OBHDP*, DOI 10.1016/j.obhdp.2018.12.005) — insanlar bazen algoritmayı insana tercih ediyor (appreciation), bazen insanı algoritmaya (aversion). Yeni bir entegratif çerçeve (MISQ, "An Integrative Perspective on Algorithm Aversion") bu çelişkiyi **algoritmanın "katman"ına** (hesaplama prosedürü olarak mı, yoksa somut bir ürüne gömülü olarak mı değerlendirildiğine) bağlıyor — NotifyMe'nin "AI öneriyor" çerçevesi bu iki katmanı karıştırırsa tutarsız kullanıcı tepkileri alabilir.

**Psikolojik reactance — NotifyMe'nin en somut riski:** Li & Shi (2025) meta-analiz, *Human Communication Research*, DOI 10.1093/hcr/hqaf016 — 28 makale, 146 etki büyüklüğü: yüksek "freedom-threatening language" (özgürlük tehdit eden dil, ör. emir kipi) reaktansı artırıyor (r=.20), ve bu etki **"behavior repetitiveness" (davranışın tekrarlanma sıklığı) tarafından güçlendiriliyor** — yani **tekrar eden** öneriler (NotifyMe'nin haftalık iş yükü önerileri tam bu kategoride) özellikle reaktans riski taşıyor. Bu doğrudan Motion'ın "surrender problem" şikayetine (Faz 1 raporu, temporal.day kaynağı) **teorik bir açıklama** sağlıyor.

**Görlitz & Rosenthal-von der Pütten (2026)**, *Computers in Human Behavior: AI and Humans*, DOI 10.1016/j.chbah.2026.100290 — "Technology paternalism and the reactance deficit": AI sistemlerinin opaklığı, kullanıcının otonomi kısıtlamasını **fark etmemesine** yol açabiliyor — "covert restriction" (örtük kısıtlama) başlangıçta düşük reaktans yaratıyor ama sonradan (mekanizma açıklandığında) güven kaybı riski taşıyor. **NotifyMe için sonuç: şeffaf öneri + açık onay/red/değiştir akışı, örtük/otomatik değişiklikten reaktans açısından daha güvenli — bu NotifyMe'nin zaten benimsediği tasarım ilkesini literatür destekliyor, ama tekrar eden önerilerde bile dilin ("öneriyorum" vs "değiştiriyorum") reaktansı etkileyebileceği unutulmamalı.**

**M sorusu:** Kullanıcı kontrolü önemli çünkü (a) reaktansı azaltıyor (özellikle tekrar eden müdahalelerde), (b) self-determination theory'ye göre (Deci & Ryan 1987, algorithm aversion/self-serving bias kaynaklarında da geçiyor) otonomi temel bir psikolojik ihtiyaç. **Kanıt seviyesi: Var — doğrulandı (meta-analiz düzeyinde).**

## 14. Feedback → Adaptation Mapping

Bu, Aşama 2A'nın bulamadığı boşluğu dolduran **en önemli bulgu**: JITAI'nin **tailoring variable** çerçevesi (§7'de tanıtıldı) tam olarak "hangi bilgi hangi adaptasyon kararını bilgilendirmeli" sorusunu formalize ediyor.

**Dziak ve ark., Oxford *Annals of Behavioral Medicine*, "Constructing evidence-based tailoring variables for adaptive interventions"** (2026, DOI mevcut yukarıda) — tailoring variable 4 bileşenle tanımlanıyor: (1) **Observed Variable** (ne ölçülecek), (2) **Assessment Time** (ne zaman ölçülecek), (3) **Decision Time** (ne zaman karar için kullanılacak), (4) **Cutoff** (hangi eşik karar değiştirir). Bu, NotifyMe'nin "60→90dk önerisi" tasarımına **doğrudan uygulanabilir bir şablon**: `actualDuration/plannedDuration` oranı = observed variable; haftalık = assessment/decision time; %20 sapma (Gegmara'nın kullandığı) = cutoff — ama makale özellikle vurguluyor: **bu sorular "causal ve prescriptive, sadece predictive değil"** — yani cutoff'un "doğru" değeri ampirik/deneysel olarak belirlenmeli, sezgiyle değil (bu, Aşama 2A'daki "neden 90, neden 70 değil" sorusunun **hâlâ çözülmediğini** teyit ediyor — literatür bu soruyu "sistematik olarak test edilmesi gereken bir tasarım kararı" olarak çerçeveliyor, hazır bir formül vermiyor).

**Nahum-Shani ve ark. (2016) JITAI framework** (Aşama 2A'da bulundu) tailoring variable seçiminin **proximal outcome'a göre** yapılması gerektiğini vurguluyor — "hangi koşullar altında kişi bir müdahale seçeneğinden fayda görür (diğerine göre)". Bu, NotifyMe'nin CAUSE→RESPONSE eşleştirme matrisi için doğrudan metodolojik destek: her cause kategorisinin ayrı bir "proximal outcome" (ör. TIME SHORTAGE → süre yeterliliği; TASK DIFFICULTY → görev tamamlanabilirlik algısı) hedeflemesi gerektiğini öneriyor.

**Önerilen CAUSE → RESPONSE matrisi (nihai değil, taslak):**

| Cause kategorisi | Olası sistem yanıtı | Destek düzeyi |
|---|---|---|
| TIME SHORTAGE (zamanım yetmedi) | Süre artırma önerisi | **Dolaylı destekli** — JITAI tailoring variable mantığıyla tutarlı, ama "zamanım yetmedi"nin locus/controllability'si belirsiz olduğu için (§7) hangi yanıtın doğru olduğu literatürden net çıkmıyor |
| TASK DIFFICULTY (görev zordu) | Görevi bölme / tahmini güncelleme | **Dolaylı destekli** — Weiner'ın "task difficulty" ayrı bir causal kategori olması (ability'den farklı) bu ayrımı destekliyor, ama spesifik "böl" yanıtı mühendislik varsayımı |
| EXTERNAL INTERRUPTION (beklenmedik iş) | Kullanılabilir zaman güncelleme, süre artırma DEĞİL | **Mühendislik varsayımı, literatür destekli mantık** — dışsal/kontrol edilemez nedenler workload artırımını "cezalandırmamalı" mantığı Weiner'ın controllability boyutuyla tutarlı ama doğrudan test edilmiş değil |
| FOCUS PROBLEM (odaklanamadım) | Workload artırma **ETMEMEK** | **Destek bulunamadı, güçlü mühendislik sezgisi** — odaklanma sorununun süre/miktar artırılarak çözülmeyeceği mantıklı ama bunu doğrudan test eden bir NotifyMe-benzeri çalışma bulunamadı |
| ESTIMATION ERROR (planlama hatası) | Gelecek tahminleri güncelleme (mevcut görev değil) | **Dolaylı destekli** — planning fallacy literatürü (Aşama 2A, Buehler ve ark. 1994) doğrudan bu kategoriye karşılık geliyor |

**N sorusunun cevabı:** Bilimsel olarak **kısmen savunulabilir** — genel çerçeve (tailoring variable metodolojisi) güçlü akademik temelli, ama spesifik eşleştirmeler (hangi cause → hangi response) büyük ölçüde **mühendislik varsayımı + Weiner'ın genel mantığından türetilmiş dolaylı destek**, doğrudan test edilmiş bir emsal yok.

## 15. Free Text Feedback

Doğrudan "free-text feedback value-add" başlığında adanmış bir literatür bu oturumda derinlemesine taranmadı (zaman kısıtı, §21). Dolaylı kanıt: Sunsama'nın (Faz 1) serbest-metin journal'ının "skip" seçeneğiyle atlanabilir olması, ve Zielke & Stewart'ın (§8) EMA compliance sorunlarına işaret etmesi, serbest metnin **response burden'ı artırıp compliance'ı düşürme riski** taşıdığını gösteriyor. **O sorusu (free-text gerçekten değer katıyor mu):** **Belirsiz** — bu oturumda doğrudan kanıtlanamadı, Aşama 2C veya ayrı bir mini-araştırma gerektirebilir.

## 16. LLM Classification — Is It Necessary?

**Küçük/orta veri setinde fine-tuned küçük model, zero-shot LLM'den daha iyi:** Genişçe atıfta bulunulan bir çalışma (arXiv 2406.08660, "Fine-Tuned 'Small' LLMs (Still) Significantly Outperform Zero-Shot Generative AI Models in Text Classification") — fine-tune edilmiş BERT-tarzı modeller, ChatGPT/Claude zero-shot'tan **tutarlı biçimde üstün**, özellikle "non-standard" (genele-özel) sınıflandırma görevlerinde (NotifyMe'nin failure-attribution kategorileri tam bu türden). Performans **200-500 etiketli örnekte doyuma ulaşıyor** — 200'ün altında model potansiyelinin altında kalıyor.

**Ama NotifyMe'nin erken aşamasında (tek kullanıcı, çok az veri) bu doygunluk noktasına ulaşmak gerçekçi değil** — bu durumda zero/few-shot LLM daha pragmatik bir başlangıç noktası olabilir, ama "Reliable decision support with LLMs" makalesi (DOI 10.1080/2573234X.2026.2652281) LLM'lerin **intra-rater tutarlılığının** (aynı modelin aynı girdiyi tekrar tekrar aynı sınıflandırması) bile %88-98 arasında değiştiğini, **inter-rater** (farklı modeller arası) tutarlılığın daha da düştüğünü gösteriyor — "LLM = güvenilir tek doğru cevap" varsayımı yanlış.

**Ground truth/inter-rater agreement gerekli mi (Q sorusu):** Evet — birden fazla kaynak (Gilardi ve ark. metodolojisini genişleten arXiv 2307.02179; GPT-4 annotator çalışması PMC11326574) en az **100-250 elle etiketlenmiş örnek** ve **Cohen's Kappa/Fleiss' Kappa/Krippendorff's Alpha** ile insan-insan VE insan-LLM uyumunun ölçülmesini öneriyor. Sıcaklık (temperature) parametresinin düşürülmesi (0.2 civarı) tutarlılığı belirgin artırıyor, doğruluğu düşürmüyor.

**P sorusu (LLM gerekli mi):** NotifyMe'nin erken aşamasında (az veri, sabit/küçük kategori seti) **basit anahtar-kelime/kural-tabanlı sınıflandırıcı** muhtemelen yeterli ve daha açıklanabilir bir başlangıç noktası — literatür LLM'in **büyük** avantajının, kategori seti büyüdüğünde veya nüanslı/uzun serbest metinde ortaya çıktığını gösteriyor; NotifyMe'nin küçük, sabit kategori setinde (structured feedback zaten var) LLM'in katma değeri **sınırlı olabilir**, sadece opsiyonel serbest-metin alanını sınıflandırmak için (RAG/agent değil, basit sınıflandırma) gerekçelendirilebilir. **Kanıt seviyesi: Var — doğrulandı (fine-tune > zero-shot bulgusu), ama NotifyMe'nin spesifik ölçeğine uygulanabilirlik mühendislik çıkarımı.**

## 17. Evaluation of Feedback Classification

Accuracy/F1 tek başına yetersiz — imbalanced kategori dağılımında (NotifyMe'de "planladığım gibi geçti" muhtemelen en sık kategori olacak) **macro-F1** tercih edilmeli (arXiv 2406.08660'ın vurguladığı gibi, "naive majority class prediction" yüksek ama anlamsız accuracy veriyor). Inter-rater agreement (Kappa/Krippendorff's Alpha) hem insan etiketleyiciler hem LLM-insan karşılaştırması için standart.

### A–R Sorularının Toplu Cevabı

- **A.** Evet, outcome ve cause ayrı tutulmalı (§6, Var-doğrulandı).
- **B.** Weiner'ın locus/stability/controllability + JITAI'nin tailoring-variable çerçevesi (§5, §14).
- **C.** Doğrudan kullanılamaz (kullanıcıya "locus" diye sorulmaz) ama **arka plan analiz iskeleti** olarak kullanılabilir (§7).
- **D.** Literatür net sayı vermiyor, 4-7 arası genel eğilim ama NotifyMe'nin mikro-etkileşim bağlamına doğrudan genellenmez (§7, Belirsiz).
- **E.** Muhtemelen evet, kötü fikir — JITAI resource-efficiency ilkesi ve response burden literatürü destekliyor (§10).
- **F.** Muhtemelen sapma olduğunda zorunlu, normalde opsiyonel — kavramsal destek var, spesifik eşik yok (§10).
- **G.** Zayıf — self-serving bias d=0.96, EMA-objektif uyumu %1.8-100 aralığında değişken (§8, Var-doğrulandı, güçlü).
- **H.** Doğrudan metodoloji bulunamadı; JITAI tailoring-variable-reliability ilkesi dolaylı destek (§9).
- **I.** Doğrudan kanıt yok — mühendislik kararı, "kullanıcıyı yalancı sayma" hiçbir kaynakta önerilmiyor (§9).
- **J.** Muhtemelen değerli ama NotifyMe ölçeğinde (az veri) karmaşıklığı gerekçelendirmek zor; JITAI'de "reliability" kavramı zaten örtük confidence taşıyor (§9, Belirsiz).
- **K.** Habituation/tekrar riskini azaltmak için (§11, Var-doğrulandı — JITAI resmi ilkesi, format/zamanlama çeşitlendirme + "provide nothing").
- **L.** Kısa vs uzun açıklama arasında net doz-cevap yok, fazla bilgi bilişsel yük riski taşıyor (§12, Belirsiz/koşullu).
- **M.** Reaktansı azaltıyor, özellikle tekrar eden müdahalelerde kritik (§13, Var-doğrulandı, meta-analiz).
- **N.** Genel çerçeve güçlü, spesifik eşleştirmeler büyük ölçüde mühendislik varsayımı (§14).
- **O.** Belirsiz, bu oturumda derinlemesine taranmadı (§15).
- **P.** Erken aşamada muhtemelen gerekli değil, kural-tabanlı/basit sınıflandırıcı yeterli olabilir (§16).
- **Q.** Evet — 100-250 örnek, Kappa/Krippendorff's Alpha, düşük temperature (§16).
- **R.** Bkz. §18, Model B (Balanced) minimum-ama-savunulabilir aday olarak önerilir.

## 18. Candidate NotifyMe Feedback Models

Nihai seçim yapılmıyor — üç aday, trade-off'larla.

### Model A — Minimal
Tek soru: outcome (mevcut `status` alanından türetilir, ayrı sormaya gerek yok) + **tek** opsiyonel "neden" seçici (3-4 geniş kategori: İçsel/Dışsal × basitleştirilmiş) + opsiyonel serbest metin.
- **Avantaj:** En düşük response burden, en yüksek compliance ihtimali (§10, §11 fatigue riskini minimize eder).
- **Dezavantaj:** Weiner'ın 3 boyutunu (özellikle controllability) kaybeder, CAUSE→RESPONSE eşleştirmesi (§14) kaba kalır.
- **Veri kalitesi:** Düşük granülerlik ama muhtemelen daha yüksek doldurma oranı.
- **Tasarım 1 uygulanabilirliği:** Yüksek — az UI, az DB alanı.

### Model B — Balanced (araştırmanın en çok desteklediği aday)
Outcome (mevcut status) ayrı; CAUSE için önerilen 2x2 (veya 2x3, task-difficulty eklenirse — §7'deki açık soru) taksonomi, **sadece sapma olduğunda zorunlu** (§10'daki JITAI resource-efficiency ilkesi), planlandığı gibi gittiğinde tek-tıkla atlanabilir; serbest metin her zaman opsiyonel.
- **Avantaj:** Weiner'ın locus/controllability ayrımını korur, JITAI'nin "provide nothing"/resource-efficiency ilkesiyle uyumlu, CAUSE→RESPONSE eşleştirmesi (§14 tablosu) doğrudan bu modelle çalışır.
- **Dezavantaj:** Kategori tasarımı hâlâ açık (kaç boyut, kaç kategori — §7'de çözülmedi), implementasyonu Model A'dan daha karmaşık.
- **Adaptasyon motoruna katkı:** Yüksek — §14'teki matrisi doğrudan besler.
- **Tasarım 1 uygulanabilirliği:** Orta — kategori tasarımı ayrı bir tasarım kararı gerektirir.

### Model C — Research-heavy
Weiner'ın tam 3 boyutunu (locus, stability, controllability) + confidence/uncertainty alanı (§9) + her feedback için ayrı "bu neden ne kadar dışsaldı" gibi Likert-tipi alt-sorular; LLM ile serbest metin sınıflandırma + ground truth/inter-rater agreement pipeline (§16-17).
- **Avantaj:** En akademik olarak savunulabilir, en zengin veri.
- **Dezavantaj:** Response burden çok yüksek (§10, §11 — habituation/disengagement riski büyük), tek-kullanıcı erken veri bağlamında over-engineering riski (§16'daki "200-500 örnek doygunluk" bulgusu NotifyMe'nin bu veri hacmine kısa vadede ulaşamayacağını gösteriyor).
- **Tasarım 1 uygulanabilirliği:** Düşük — kapsam bir dönem için gerçekçi değil (Aşama 1 red-team itiraz 6 ile aynı risk).

## 19. Most Relevant Studies

En yüksek etki/en doğrudan uygulanabilir 10 kaynak (özet, tam liste yukarıdaki bölümlerde):

1. Weiner (1985) — *Psychological Review*, DOI 10.1037/0033-295X.92.4.548 — attribution theory temeli.
2. Mezulis ve ark. (2004) — *Psychological Bulletin*, DOI 10.1037/0033-2909.130.5.711 — self-serving bias meta-analizi, d=0.96.
3. Steel (2007) — *Psychological Bulletin*, DOI 10.1037/0033-2909.133.1.65 — procrastination meta-analizi.
4. Stone, Schneider & Smyth (2022) — DOI 10.1146/annurev-clinpsy-080921-083128 — EMA metodolojik review.
5. Nahum-Shani ve ark. (2016) — DOI 10.1007/s12160-016-9830-8 — JITAI framework, tailoring variables.
6. Dziak ve ark. (Oxford, *Annals of Behavioral Medicine*, 2026) — tailoring variable inşa metodolojisi, DOI mevcut metinde.
7. Nahum-Shani & Murphy (2025) — DOI 10.1146/annurev-psych-121024-044244 — JITAI güncel review, intervention fatigue/habituation.
8. Li & Shi (2025) — DOI 10.1093/hcr/hqaf016 — psikolojik reactance meta-analizi.
9. Jafari & Vassileva (2026) — DOI 10.1145/3820245 — explainable recommendation sistematik review.
10. arXiv 2406.08660 — fine-tuned küçük LLM vs zero-shot metin sınıflandırma karşılaştırması.

## 20. Red Team

### Varsayım 1 — "Kullanıcı her görev sonrası feedback vermek ister."
- **Destekleyen kanıt:** Yok bulunamadı.
- **Karşı kanıt:** JITAI intervention fatigue/habituation literatürü (§11), response burden/survey fatigue literatürü (§10) — tersini gösteriyor: sık, tekrar eden istek disengagement riski taşıyor.
- **Belirsizlik:** NotifyMe'ye özgü (kullanıcı motivasyonu, görev sıklığı) ampirik test edilmedi.
- **NotifyMe için risk: YÜKSEK.** Model A/B'nin "sadece sapmada zorunlu" ilkesi bu riski azaltmak için gerekli.

### Varsayım 2 — "Kullanıcı başarısızlığının nedenini doğru bilir."
- **Destekleyen kanıt:** Zayıf — EMA momentary self-report'un retrospektiften daha iyi olduğu bulgusu (§8) kısmi destek verir ama bu "neden"e değil "ne oldu"ya dair.
- **Karşı kanıt: GÜÇLÜ.** Self-serving bias meta-analizi (d=0.96, Mezulis ve ark. 2004) — bu araştırmanın en sağlam karşı-kanıtı.
- **Belirsizlik:** Yok, literatür net.
- **NotifyMe için risk: ÇOK YÜKSEK.** Bu varsayım üzerine kurulu bir CAUSE→RESPONSE motoru, sistematik olarak yanlı girdi alacak — objektif veriyle çapraz doğrulama (§9) olmadan tehlikeli.

### Varsayım 3 — "Structured categories gerçek hayatı yeterince temsil eder."
- **Destekleyen kanıt:** Weiner'ın 3-boyutlu modeli sınırlı sayıda kategoriyle güçlü açıklayıcılık sağlıyor (§5) — kısmi destek.
- **Karşı kanıt:** Mevcut ad-hoc 9 kategorinin outcome/cause karışımı içermesi (§7) — kategori tasarımının kendisi henüz teorik temelli değil.
- **Belirsizlik:** Kaç boyut/kategori yeterli, çözülmedi (§7).
- **NotifyMe için risk: ORTA.** Yeniden tasarım (Model B'deki 2x2/2x3) riski azaltabilir ama garantili değil.

### Varsayım 4 — "Free text daha fazla bilgi sağlar."
- **Destekleyen kanıt:** Doğrudan bulunamadı bu oturumda (§15).
- **Karşı kanıt:** Sunsama'nın "skip" seçeneğinin varlığı (Faz 1) + genel response-burden literatürü — serbest metin doldurma oranı düşük olabilir.
- **Belirsizlik: YÜKSEK** — ayrı araştırma gerektirir.
- **NotifyMe için risk: ORTA**, ama düşük maliyetli (opsiyonel alan) olduğu için düşük öncelikli risk.

### Varsayım 5 — "Daha fazla veri daha iyi adaptasyon demektir."
- **Destekleyen kanıt:** LLM fine-tuning literatürü (§16) — evet, 200-500 örneğe kadar performans artıyor.
- **Karşı kanıt:** Response burden arttıkça compliance düşüyor (§10-11) — "daha fazla veri isteme" davranışının kendisi veri kalitesini/miktarını düşürebilir, kendi kendini yenen bir döngü riski.
- **Belirsizlik:** NotifyMe'nin spesifik denge noktası bilinmiyor.
- **NotifyMe için risk: ORTA.** Naif "daha çok soru = daha çok veri" mantığı yanlış olabilir.

### Varsayım 6 — "Kullanıcı önerinin açıklamasını görmek ister."
- **Destekleyen kanıt:** Bazı çalışmalar açıklama kalitesinin güveni artırdığını gösteriyor (Kunkel ve ark., §12).
- **Karşı kanıt:** İlişki koşullu/heterojen (Wardatzky ve ark. 2025, meta-analiz yapılamayacak kadar tutarsız), fazla açıklama bilişsel yük yaratabilir (§12).
- **Belirsizlik: YÜKSEK.**
- **NotifyMe için risk: DÜŞÜK-ORTA** — açıklama göstermenin maliyeti düşük, ama "uzun gerekçeli açıklama otomatik olarak daha iyi" varsayımıyla tasarlamak yanlış yönlendirebilir.

### Varsayım 7 — "Kullanıcı sistem önerisini kabul/reddet/değiştir seçeneklerini kullanır."
- **Destekleyen kanıt:** Self-determination theory + reactance literatürü (§13) kontrolün **önemli olduğunu** gösteriyor — ama bu, kullanıcının seçenekleri **fiilen kullanacağı** anlamına gelmiyor, sadece kullanmadığında bile varlığının reaktansı azalttığı anlamına geliyor.
- **Karşı kanıt:** Doğrudan "kullanım oranı" verisi bulunamadı.
- **Belirsizlik: YÜKSEK.**
- **NotifyMe için risk: DÜŞÜK** — seçeneklerin varlığı, aktif kullanım oranından bağımsız olarak faydalı (reaktans azaltma), o yüzden bu varsayımın kısmen yanlış olması bile tasarımı geçersiz kılmaz.

### Varsayım 8 — "Failure reason gelecekteki doğru intervention'ı belirlemek için yeterlidir."
- **Destekleyen kanıt:** JITAI tailoring-variable çerçevesi (§14) bunun **prensipte** mümkün olduğunu gösteriyor.
- **Karşı kanıt:** Dziak ve ark.'nın kendi vurgusu — "bu sorular causal ve prescriptive, cutoff'lar ampirik olarak belirlenmeli" — yani failure reason **tek başına** yeterli değil, sistematik test/kalibrasyon gerekiyor.
- **Belirsizlik: YÜKSEK.**
- **NotifyMe için risk: YÜKSEK** — §14'teki CAUSE→RESPONSE matrisinin çoğu hücresi "mühendislik varsayımı" seviyesinde, "literatür destekli" değil.

## 21. Implications for NotifyMe

En önemli 3 çıkarım: (1) Outcome/cause ayrımı ve Weiner'ın locus/controllability boyutları kategori tasarımına dahil edilmeli — mevcut 9 kategori bu ayrımı yapmıyor. (2) Self-serving bias (d=0.96) nedeniyle **self-report'u objektif veriyle (planned/actual) çapraz okumadan** adaptasyon kararına doğrudan girdi yapmak riskli — en azından "kullanıcı raporu ile objektif veri arasında büyük sapma" durumları ayrı işaretlenmeli (nasıl işleneceği açık soru, §9). (3) Feedback sıklığı ve öneri tekrarı, habituation/reactance riskleri nedeniyle **minimize edilmeli** — "sadece sapmada sor", "aynı öneriyi tekrar aynı biçimde sunma" ilkeleri JITAI'den doğrudan alınabilir.

## 22. Open Questions

- Kaç boyutlu (2x2 mi 2x3 mü) ve kaç kategorili CAUSE taksonomisi NotifyMe için doğru — çözülmedi (§7).
- Self-report ile objektif veri çeliştiğinde sistemin tam davranışı (confidence düşür mü, açıklama iste mi, sessizce sakla mı) — doğrudan literatür yok (§9).
- Free-text feedback'in gerçek katma değeri — bu oturumda derinlemesine taranmadı (§15, §21).
- Park ve ark. (2023) KAIST çalışmasının tam yayın yeri (dergi/konferans) doğrulanamadı — düşük-orta güven kaynağı.
- Subjective+objective data fusion / multimodal self-tracking literatürü ayrı, adanmış bir taramayı hak ediyor.

## 23. What Phase 2C Must Investigate

Kullanıcının kendi talimatına göre: Goal trajectory / pace, kalan iş-kalan zaman formülü, Earned Value Management, Goal→Task hierarchical progress, deadline pace algoritmaları — bunların hiçbiri bu raporda araştırılmadı, Aşama 2C'nin konusu.

---

## Ek: Kullanılan arama sorguları

1. Weiner attribution theory locus stability controllability achievement motivation causal attribution
2. self-regulated learning attribution retraining procrastination causal attribution academic failure meta-analysis
3. ecological momentary assessment self-report reliability recall bias retrospective vs momentary assessment review
4. notification fatigue intervention fatigue habituation just-in-time adaptive intervention engagement decline over time
5. explainable recommendation system user trust algorithm aversion algorithm appreciation meta-analysis
6. tailoring variables adaptive intervention design just-in-time adaptive intervention decision rules what variable to tailor to
7. LLM zero-shot few-shot text classification small dataset evaluation inter-rater agreement ground truth annotation
8. number of response categories survey design response burden closed-ended vs open-ended question cognitive load
9. self-serving bias attribution success failure meta-analysis psychological reactance perceived autonomy control system recommendations

## Ek: İncelenen kaynak türleri

Peer-reviewed dergi makaleleri (*Psychological Review*, *Psychological Bulletin*, *Annual Review of Clinical Psychology*, *Annual Review of Psychology*, *Annals of Behavioral Medicine*, *Human Communication Research*, *Computers in Human Behavior: AI and Humans*, *Personality and Individual Differences*, *ACM TORS*), sistematik review/meta-analizler (7+), 2 arXiv preprint (açıkça işaretlendi), 1 tez (Zielke & Stewart, Indiana University-Purdue), 1 konferans/workshop kaynağı (KAIST, tam bibliyografi doğrulanamadı).

## Ek: Erişilemeyen/zayıf kaynaklar

Park ve ark. (2023) KAIST çalışmasının dergi/konferans adı doğrulanamadı (sadece PDF barındırma sitesi). "Reliable decision support with LLMs" makalesinin yayın yeri (Taylor & Francis, yeni bir dergi olabilir) düşük-orta tanınırlık. GoalFlow/Archion/Serena'ya (Faz 1) bu raporda tekrar atıf yapılmadı, kapsam dışı.

## Ek: Önemli belirsizlikler

§9 (subjective+objective data fusion), §15 (free-text değeri), §7 (nihai kategori sayısı/boyutu) bu oturumda tam çözülemedi — Aşama 2C sonrası ayrı bir mini-araştırma gerektirebilir.

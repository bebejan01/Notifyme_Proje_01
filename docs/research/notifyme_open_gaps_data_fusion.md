# NotifyMe — Open-Gaps Cleanup A: Objective + Subjective Data Fusion — Uncertainty-Aware Adaptive Decision Making

**Tarih:** 2026-09-21
**Kapsam:** NotifyMe Tasarım 1 araştırma serisinin ana fazları (1, 2A, 2B, 2C, 2D) tamamlandıktan sonra kalan kritik bir açığı kapatan araştırma: ölçülen davranışsal veri + kullanıcının kendi açıklaması + belirsizlik → adaptasyon kararı. Yeni özellik önerisi değil, mevcut mimari sorularının bilimsel çerçevesini netleştirme.
**Önceki raporlar (okundu, başlangıç bilgisi kabul edildi):** `notifyme_competitor_analysis_phase1.md`, `notifyme_academic_adaptation_closed_loop_phase2a.md`, `notifyme_academic_feedback_human_factors_phase2b.md` (özellikle self-serving bias d=0.96, tailoring-variable çerçevesi), `notifyme_academic_goal_trajectory_phase2c.md` (özellikle subjektif-objektif R²=.05-.39), `notifyme_academic_evaluation_phase2d.md` (özellikle layered evaluation, false-precision uyarısı, Claim→Evidence mantığı).
**Amaç:** Karmaşık bir matematiksel model bulmak değil. NotifyMe'nin eksik, çelişkili, farklı güvenilirlikteki insan davranışı verileriyle dürüst ve güvenli adaptasyon kararı verebilmesinin bilimsel sınırlarını çizmek.

---

## 1. Executive Summary

Bu araştırmanın en temel bulgusu bir **terminoloji düzeltmesi**: "objective data" terimi epistemik olarak yanlış. `actualDuration` gibi ölçülen veriler de timer yanlış kullanımı, eksik loglama, yanlış işaretlenmiş tamamlanma gibi hatalara açık — literatür bunu **doğrudan ve çok kaynaklı** doğruluyor (yaşlı yetişkinlerde Fitbit-vs-self-report çalışması, PMC9470756; "Semantic Gap in Predicting Mental Wellbeing" ACM 2022; self-report güvenilirlik çalışması Nan Gao). Doğru terim çifti: **"observed/measured behavioral signal"** (ölçülen davranışsal sinyal) vs **"self-reported signal"** (kendi-bildirimli sinyal) — ikisi de fallible, hiçbiri "ground truth" değil.

İkinci büyük bulgu: NotifyMe'nin problemi **"data fusion" değil**. Klasik multimodal/sensor fusion literatürü (early/late/hybrid fusion, Dempster-Shafer, subjective logic) büyük ölçekli, yüksek-frekanslı, eğitilmiş modeller için geliştirilmiş. NotifyMe'nin sorunu ölçek olarak çok daha küçük ve yapısal olarak farklı: bir sayısal sinyal + bir doğal-dil açıklama, seyrek gözlem, tek kullanıcı. En doğru akademik çerçeve **insan-AI hibrit karar verme / kanıt altında karar verme (decision under uncertainty)** — özellikle "Learning to Abstain" ailesi (Punzi ve ark. 2026, ACM) ve ML'in "reject option"/selective classification literatürü (Hendrickx ve ark. 2024, *Machine Learning*) NotifyMe'nin NO_INTERVENTION/ASK_USER kararlarına **hazır, olgun, doğrudan uygulanabilir** bir akademik temel sağlıyor — bu araştırmanın en güçlü ve en sürpriz-olmayan (çünkü tam sorulan soruya cevap veren) bulgusu.

Üçüncü bulgu: **Reliability weighting (güvenilirlik ağırlıklandırma) beyinde gerçek, kanıtlanmış bir mekanizma** (Bayesian cue integration, Ernst & Banks 2002 — "Nature" makalesi, çok atıflı) — ama bu mekanizma **kalibre edilmiş, tekrar tekrar ölçülmüş gürültü varyansı** gerektiriyor (psikofizik deneylerinde her duyunun güvenilirliği ayrı ayrı ölçülüyor). NotifyMe'de böyle bir kalibrasyon süreci yok ve olmayacak (tek kullanıcı, az veri) — dolayısıyla `0.7 davranışsal / 0.3 self-report` gibi sabit sayılar bilimsel olarak **savunulamaz, keyfi olur**. Bu, Aşama 2D'nin "false precision" uyarısının bu problemdeki doğrudan karşılığı.

Dördüncü bulgu: **MYCIN'in certainty factor (CF) modeli tarihi, NotifyMe'nin rule-based confidence sistemi için doğrudan bir emsal ve bir uyarı aynı anda sağlıyor.** CF modeli Bayesian'ın pratik zorluklarından kaçınmak için tasarlandı, kör değerlendirmelerde uzmanlarla eşit/üstün performans gösterdi — AMA Heckerman (1992) CF'nin naive-Bayes'ten bile daha güçlü, gizli koşullu-bağımsızlık varsayımları içerdiğini kanıtladı. Kritik nüans: **Clancey & Cooper'ın duyarlılık analizi**, MYCIN'in **tanı** (diagnosis) çıktısının CF değerlerindeki sapmalara çok duyarlı olduğunu ama **tedavi önerisi** (therapy recommendation) çıktısının **dikkat çekici derecede duyarsız** olduğunu gösterdi. Bu, NotifyMe için önemli: eğer nihai *karar* (adapte et / etme / sor) az sayıda kaba kategoriye düşüyorsa, iç güven sayılarının "doğru" olması değil, **kararın sayılara duyarsız (robust) olması** yeterli olabilir — bu iddia sentetik senaryolarla test edilebilir.

Beşinci bulgu, promptta hiç sorulmamış ama mimari kararı doğrudan etkileyebilecek bir bulgu: **"Authority Inversion" (arXiv 2605.23938, 2026)** — LLM'ler, sayısal/yapılandırılmış sensör kanıtı ile kullanıcının doğal-dil iddiası çeliştiğinde, **sistematik olarak kullanıcının lehine** karar veriyor (test edilen 4 modelde, aktivite tanıma görevlerinde sensöre güven oranı %0-11 arası) — bu model ölçeğiyle düzelmiyor ve hizalama (alignment) eğitiminden bağımsız, temsil-düzeyinde bir sorun. Eğer Aşama 2B/2D'de "opsiyonel serbest-metin sınıflandırma" için LLM kullanılırsa, bu LLM'in davranışsal-vs-self-report çelişkisini **kendiliğinden kullanıcı lehine çözeceği** varsayılmalı — rule-based sistemin LLM'e tercih edilmesi gerektiği sonucunu güçlendiriyor, ama yeni ve daha keskin bir mekanizmayla.

Genel sonuç: **basit yöntem (uncertainty-aware rule system) burada da bilimsel olarak yeterli ve savunulabilir** — Bayesian/Dempster-Shafer/fuzzy'nin hiçbiri "daha akademik göründüğü için" tercih edilmemeli. En değerli/olumsuz sonuç: NotifyMe'nin çelişkili sinyalleri **"çözme" zorunda değil** — çelişkinin kendisini bir sinyal olarak taşımak (discrepancy-as-signal), literatürün en sağlam desteklediği, en az mühendislik-varsayımı gerektiren yaklaşım.

---

## 2. Problem Definition

NotifyMe iki farklı epistemik statüde bilgiye sahip: ölçülen davranış (plannedDuration/actualDuration, task completion, StudySession geçmişi) ve kullanıcının kendi açıklaması (yapılandırılmış kategori + serbest metin). Aşama 2B (self-serving bias d=0.96) ve Aşama 2D (ground truth problemi çözümsüz) ikisi de "kullanıcı raporu = doğru" varsayımını reddetti. Bu araştırma tersini de reddediyor: "ölçülen veri = doğru" varsayımı da epistemik olarak yanlış. Asıl soru, iki fallible kanıt kaynağının nasıl **dürüstçe** birleştirileceği — birini otomatik kazandırmadan, ikisini de kör biçimde eşit saymadan.

## 3. Terminology

**Bulgu (Var — doğrulandı, çok kaynaklı):** "objective data" yanlış terim. Kanıt: (1) yaşlı yetişkinlerde Fitbit vs. self-report karşılaştırması (PMC9470756) — objektif ölçüm bile "considerable heterogeneity" gösteriyor, "gold-standard" ölçümler arasında bile tutarsızlık var; (2) "Semantic Gap in Predicting Mental Wellbeing through Passive Sensing" (ACM, dl.acm.org/doi/fullHtml/10.1145/3491102.3502037) — self-report ile pasif sensör verisinin **aynı construct'ın farklı yönlerini** (psikolojik vs. fizyolojik facet) ölçtüğünü, birinin diğerinin "hatalı versiyonu" olmadığını gösteriyor; (3) Nan Gao'nun self-report güvenilirlik çalışması — "researchers should not trust self-reports blindly" ama karşı yönde de uyarı yapıyor; (4) ground-truth toplama zorluğu üzerine HAR (human activity recognition) çalışması (ACM 3731749) — thigh-worn sensör bile atipik postürlerde (ör. "mutfak taburesinde oturmak") hata yapıyor, "singular truth" kavramının kendisi tartışmalı.

**Önerilen terminoloji:** "observed/measured behavioral signal" (ölçülen davranışsal sinyal) ve "self-reported signal" (kendi-bildirimli sinyal). Her ikisi de **evidence** (kanıt), hiçbiri **ground truth** değil. Bu terminoloji Phase 2D'nin "observed data" önerisiyle tutarlı, Phase 3'te benimsenmeli.

## 4. Behavioral vs Self-Report Evidence — Data/Evidence Fusion Literature (§3+§4 birleşik)

**"Data fusion" doğru çerçeve mi?** Hayır, kısmen. Multimodal/multi-source data fusion literatürü (KDD survey "Classification with Uncertainty-Aware Multimodal Deep Learning"; ACM CSUR "Deep Multimodal Data Fusion"; "Multi-source heterogeneous data fusion" survey) **eğitilmiş modellere, yüksek-boyutlu/yüksek-frekanslı veri akışlarına, genellikle çok kullanıcılı/büyük veri setine** dayanıyor — early/late/hybrid fusion, attention mekanizmaları hepsi bu ölçekte anlamlı. NotifyMe'nin sorunu yapısal olarak farklı: **iki heterojen, seyrek, düşük-boyutlu kanıt** (bir sayı + bir kısa metin), tek kullanıcı, haftalık gözlem sıklığı.

**Daha doğru çerçeveler (Var — doğrulandı):**
- **Human-in-the-Loop (HITL) taxonomy** (mdpi-res.com entropy dergisi) — "loop placement, interaction granularity, temporal characteristics" boyutlarıyla NotifyMe'yi konumlandırıyor: coarse-grained, asynchronous, episodic feedback — düşük-risk, düşük-frekans kategorisine düşüyor.
- **Hybrid Decision-Making Systems taxonomy** (Punzi, Pellungrini, Setzu, Giannotti, Pedreschi, ACM 2026, DOI 10.1145/3802522) — üç aile öneriyor: **Human overseeing** (pipeline, entegrasyon yok), **Learning to Abstain** (orkestratör hangi ajanın karar vereceğine bakar, abstention birinci sınıf), **Learning Together** (çift yönlü diyalog döngüsü). NotifyMe'nin NO_INTERVENTION/ASK_USER ihtiyacı **doğrudan "Learning to Abstain" ailesine** düşüyor.
- **Decision under uncertainty / evidence aggregation** (Gilboa, *Annual Reviews* 2025, "Decision Under Uncertainty: State of the Science") — genel karar teorisi çerçevesi, sensor-fusion'dan bağımsız.

**Sonuç:** "Data fusion" terimini kullanmaktan kaçınmak daha dürüst — "evidence aggregation under uncertainty" veya "human-AI evidence integration" daha doğru. **Kanıt seviyesi: Var — doğrulandı.**

## 5. Subjective–Objective Discrepancy

Aşama 2C'nin R²=.05-.39 bulgusu bu fazda **çok kaynaklı olarak pekişti**: Fitbit-vs-self-report çalışması (PMC9470756, yaşlı yetişkinler) sadece "modest relationships" değil, **overreporting'in kendisinin** bağımsız olarak kötü hafıza/yürütücü işlev ve hipertansiyon tanısıyla ilişkili olduğunu buldu. Bu çok önemli: **çelişki (discrepancy) kendisi klinik/davranışsal olarak anlamlı bir sinyal**, sadece ölçüm hatası değil. "Semantic Gap" makalesi bunu teorik olarak destekliyor — subjektif ve objektif ölçüm gerçekten **farklı construct'ları** yakalıyor (psikolojik vs. fizyolojik facet), biri diğerinin "gürültülü versiyonu" değil.

**NotifyMe için sonuç (H sorusuyla doğrudan bağlantılı — Mustafa'nın kendi 18. bölümü):** Çelişkiyi "çözmek" yerine **çelişkinin büyüklüğünü/yönünü bir üçüncü sinyal olarak taşımak** literatürce en güçlü desteklenen yaklaşım — "objektif iyi + subjektif kötü" durumunun kendisi (örn. "davranış planlandığı gibi ama kullanıcı kötü hissediyor") ayrı ve değerli bir bilgi olabilir, illa çözülmesi/normalize edilmesi gereken bir hata değil. **Kanıt seviyesi: Var — doğrulandı, güçlü (klinik + HCI çok kaynaklı yakınsama).**

## 6. Uncertainty

Fox & Ülkümen'in (2011, klasik, Kahneman/Tversky geleneğinden) epistemik/aleatorik uncertainty ayrımı NotifyMe'ye **anlamlı ve uygulanabilir**: **epistemik uncertainty** = "gerçek neden hangisiydi, bilmiyoruz" (hangi CAUSE kategorisi doğru — Aşama 2B'nin problemi); **aleatorik uncertainty** = "günlük süre doğası gereği değişken" (StudySession süresinin doğal varyansı). İkisi NotifyMe'de eş zamanlı var ve farklı müdahale gerektiriyor — epistemik belirsizlik daha fazla kanıt/açıklama ile azaltılabilir, aleatorik belirsizlik azaltılamaz, sadece tolere edilmeli (geniş tolerans bandı, Aşama 2A'nın EWMA mantığıyla tutarlı).

**Sabit confidence değerleri (actualDuration=yüksek güven, self-report=orta güven) savunulabilir mi?** Kısmen ve dikkatle. Multisensory Bayesian cue integration literatürü (Ernst & Banks 2002, *Nature*, "Humans integrate visual and haptic information in a statistically optimal fashion"; Fetsch, Pouget, DeAngelis, Angelaki 2011, *Nature Neuroscience*) reliability-weighted birleştirmenin **gerçek, nöral düzeyde kanıtlanmış** bir mekanizma olduğunu gösteriyor — ama bu çalışmalarda güvenilirlik (precision = 1/varyans) **trial-bazlı, tekrarlı, kontrollü psikofizik ölçümle** belirleniyor. NotifyMe'de böyle bir kalibrasyon prosedürü yok. Ordinal/kategorik güven seviyeleri (yüksek/orta/düşük) sabit sayısal ağırlıklardan (0.7/0.3) daha savunulabilir — hem MYCIN CF tarihinin öğrettiği ders (§12) hem HCI literatüründeki kategorik-etiket tercihi (§21) bunu destekliyor. **Kanıt seviyesi: Var — doğrulandı ki mekanizma gerçek; Yok — NotifyMe'nin kalibrasyon önkoşulunu karşılamadığı için sabit sayısal ağırlıklar keyfi kalır.**

## 7. Reliability Weighting

Bkz. §6 — aynı literatür. Ek olarak: precision-weighting yalnızca **"forced-fusion"** (sinyallerin aynı kaynaktan geldiği kesin) senaryolarda basit; NotifyMe'nin senaryosu daha çok **"causal inference"** problemi (Bayesian Causal Inference modeli, Körding ve ark. 2007) — sistem önce "bu iki sinyal aynı olayı mı anlatıyor, yoksa farklı şeyleri mi?" sorusunu çözmeli (bkz. §14 conflict detection), sonra entegrasyon/segregasyon kararı vermeli. Bu, basit ağırlıklı ortalamanın bile teorik olarak eksik olduğunu gösteriyor — ama pratik karmaşıklığı NotifyMe ölçeğinde gereksiz (aynı "over-engineering" uyarısı, Aşama 2D §6).

## 8. Bayesian Approaches

**Bulunan en doğrudan uygulanabilir kaynak:** "Progressive Bayesian Confidence Architectures for Cold-Start Personal Health Analytics" (arXiv 2601.03299, 2026) — NotifyMe'nin tam sorununu (erken kullanıcı katılımı yüksekken analitik güç düşükken ne söylenir) ele alıyor: sabit-eşik yaklaşımı (30+ gün bekle) yerine **posterior contraction'a göre kademeli güven katmanları** (exploratory hint → pattern → robust association) öneriyor, sentetik N-of-1 testinde 5-7 günde erken sinyal + %6 altı yanlış-keşif oranı gösteriyor.

**Ama kritik sınır:** Bu makale de dahil tüm Bayesian yaklaşımlar (Progressive Bayesian, IntelligentPooling/Thompson Sampling mHealth — Tomkins ve ark. 2020, PMC8494236) ya (a) **prior'ı oluşturacak bir popülasyon** gerektiriyor (IntelligentPooling, kullanıcılar arası "pooling" ile hızlı öğrenme — NotifyMe'nin henüz popülasyonu yok, tıpkı Aşama 2A'nın RL/bandit bulgusuyla aynı engel) ya da (b) **tek kullanıcı içinde zamanla artan veri** ile posterior daraltıyor (Progressive Bayesian, N-of-1 uyumlu) — ikinci yaklaşım NotifyMe'ye daha yakın ama full Bayesian inference motoru kurmak yerine, **kavramsal ilkeyi** (erken veri = daha geniş/temkinli iddia, veri arttıkça daralan güven) basit bir kademeli-eşik kuralıyla taklit etmek yeterli ve çok daha az mühendislik yükü taşıyor.

**Sonuç (G sorusu):** Tam Bayesian model şu an **gereksiz akademik ağırlık ve false precision riski** taşıyor (prior'ı destekleyecek veri yok — Aşama 2D'nin ana teması burada tekrar doğrulanıyor). Kavramsal ilke (kademeli güven) rule-based sistemde de uygulanabilir. **Kanıt seviyesi: Var — doğrulandı (Bayesian yaklaşımların ilkeleri sağlam), ama Tasarım 1 ölçeğinde tam uygulama önerilmiyor.**

## 9. Dempster-Shafer

**En kritik bulgu:** Zadeh'in 1984 klasik karşı-örneği (Shafer'in kitabına eleştiri) — iki "uzman" (kaynak) birbirine neredeyse tamamen zıt ama her ikisi de küçük bir olasılıkla aynı üçüncü seçeneği destekliyorsa, Dempster'in kombinasyon kuralı o üçüncü seçeneğe **%100 destek** veriyor — **her iki kaynağın da çok düşük olasılıklı bulduğu** bir sonuca kesin destek. Bu **tam olarak NotifyMe'nin kritik senaryosu**: davranışsal veri güçlü biçimde X diyor, self-report güçlü biçimde Y diyor — yüksek çelişki durumu, Dempster-Shafer'ın en zayıf olduğu tam senaryo. 40+ yıllık literatür (survey: "Optimization and applications of evidence fusion algorithm based on Dempster-Shafer theory", *Applied Soft Computing* 2022; Heckerman-benzeri eleştiriler) bu sorunu çözmeye çalışan **düzinelerce rakip "fix"** üretmiş (Yager's rule, TBM/Smets, Dubois-Prade, Murphy average) ama **hiçbirinin evrensel kabul görmediği**, "jungle of combination rules" olarak adlandırılan bir durum var (Smets, "Analyzing the Combination of Conflicting Belief Functions").

**NotifyMe ölçeğinde:** Dempster-Shafer vs Bayesian vs rule-based karşılaştırması — DS, tam olarak "yüksek çelişki" durumlarını iyi ele almadığı için (ki NotifyMe'nin en önemli senaryosu bu), ve normalizasyon/kombinasyon kuralı seçimi kendisi 30+ yıllık çözülmemiş bir akademik tartışma olduğu için, **Tasarım 1'de kullanılmamalı**. "Matematiksel göründüğü için" seçilirse, savunması jüri karşısında kendi kendini baltalayabilir (hangi kombinasyon kuralı, neden). **Kanıt seviyesi: Var — doğrulandı, güçlü karşı-kanıt (DS önerilmiyor).**

## 10. Fuzzy Logic

**Red-team karşı bulgu:** Fuzzy logic sırf "AI yaptık" demek için kullanılan yüzeysel bir teknik değil — klinik pratikte gerçek, hakemli kullanımı var: Liu & Shiffman (1997, PubMed 9357633) "operationalization of clinical practice guidelines using fuzzy logic" — VTE risk değerlendirme modellerindeki **keyfi kesim noktaları (arbitrary cutoffs)** sorununu doğrudan hedef alıyor, "the complex mind of the human does not work like this (binary pattern)" argümanıyla. Daha da ilginci: gerçek bir sağlık-davranışı müdahalesi tasarımında (BMC Public Health 2023, "fuzzy cognitive maps" ile meyve tüketimi müdahalesi) fuzzy logic + machine learning kombinasyonu **gerçek bir klinik denemenin sonucunu (d=0.22) doğru tahmin etmiş** — yani sadece dekoratif değil, gerçekten öngörü değeri var, dış geçerliliği test edilmiş.

**Ama NotifyMe için kritik ayrım:** Bu başarılı örneklerde membership function'lar **yapılandırılmış uzman elisitasyonu** (linguistic term → triangular membership function → aggregation → defuzzification, Mkhitaryan ve ark. metodolojisi) ile türetiliyor, keyfi değil. NotifyMe'de böyle bir elisitasyon süreci (birden fazla uzman, sistematik anket) yok — tek geliştirici birkaç membership function seçerse, red-team'in öngördüğü "keyfi" risk gerçekleşir.

**Sonuç:** Fuzzy logic'in gerçek katkısı NotifyMe için **yeni bir inference motoru değil**, mevcut sert eşiği (Gegmara'nın %20'si, Aşama 2A'nın "neden 90 neden 70 değil" problemi) **yumuşak kategorilere** ("hafif geride", "ciddi geride") çevirmek olabilir — düşük karmaşıklık, keyfi-eşik problemini gizlemek yerine görünür kılıyor. Ama bu bir **UX/etiketleme katmanı**, temel karar mantığını değiştirmiyor. **Kanıt seviyesi: Var — doğrulandı ki fuzzy logic meşru (küçümsenmemeli), Belirsiz — NotifyMe'nin membership function'ları elisitasyon olmadan savunulabilir mi.**

## 11. Rule-Based Uncertainty (Certainty Factors — MYCIN)

Bu bölüm §6/§9'un doğal devamı ve **en tarihsel açıdan zengin** kaynak grubu (Heckerman 1992 "The Certainty-Factor Model", heckerman.com/david/H92encyclopedia.pdf; Buchanan & Shortliffe 1984, orijinal MYCIN kitabı bölüm 11; Heckerman & Shortliffe "From Certainty Factors to Belief Networks").

**Tarih:** MYCIN'in geliştiricileri (Shortliffe & Buchanan, 1975) Bayesian'ı **bilinçli olarak reddetti** çünkü (1) gerekli koşullu olasılık sayısı yönetilemez ölçüde büyüyordu, (2) uzmanlardan tutarlı subjektif olasılık almak zordu, (3) uzmanların verdiği sayılar "olasılıktan farklı bir karaktere" sahipmiş gibi görünüyordu. CF modeli bunun yerine **modüler, artan-kanıt-biriktiren** bir sistem kurdu — kör değerlendirmelerde (blinded evaluation) uzman tedavi planlarına eşit veya üstün bulundu.

**Ama Heckerman'ın kanıtladığı kusur:** CF'nin "parallel combination" fonksiyonu, naive-Bayes'ten (idiot-Bayes) bile **daha güçlü** koşullu bağımsızlık varsayımı dayatıyor — CF matematiksel olarak "değişim inancı" (change in belief) olarak yorumlanabilir ama bu yorum altında bile gerçek dünyada nadiren geçerli varsayımlar gerekiyor (ör. "deprem" ve "hırsızlık" olaylarının "alarm" verildiğinde koşullu bağımsız olduğu varsayımı — genelde yanlış).

**En önemli pratik bulgu (Clancey & Cooper'ın duyarlılık analizi, Heckerman'ın makalesinde alıntılanmış):** MYCIN'in **tanı** (diagnosis) çıktısı CF değerlerindeki değişikliklere çok duyarlıydı, ama **tedavi önerisi** (therapy recommendation) çıktısı **"remarkably insensitive"** kaldı — çünkü antibiyotik tedavileri genelde birden fazla patojeni birden kapsıyor, yanlış tanı bile çoğu zaman doğru tedaviye yol açıyordu.

**NotifyMe için doğrudan uygulama:** NotifyMe'nin nihai kararı da (ADAPT / NO_INTERVENTION / ASK_USER gibi kaba kategoriler) muhtemelen ara güven skorlarındaki küçük değişikliklere **MYCIN'in tedavi önerisi gibi duyarsız** olabilir — bu ampirik olarak sentetik senaryolarla test edilebilir bir iddia (confidence parametrelerini pertürbe et, nihai kararın kaç kez değiştiğini ölç). Eğer duyarsızsa, iç güven sayılarının "doğru" olması değil, **karar sınırlarının stabil olması** yeterli bilimsel gerekçe olabilir. **Kanıt seviyesi: Var — doğrulandı (tarihsel emsal güçlü), NotifyMe'ye özgü duyarlılık testi henüz yapılmadı (açık soru, §28).**

## 12. Abstention / No-Intervention

Bu araştırmanın **en olgun ve en doğrudan uygulanabilir** akademik bulgusu.

**Selective classification / reject option — kapsamlı literatür:** Hendrickx, Perini, Van der Plas, Meert, Davis (2024, *Machine Learning*, DOI 10.1007/s10994-024-06534-x, kapsamlı survey) — iki tür rejection formalize ediyor: **ambiguity rejection** (sinyal belirsiz/çelişkili — tam olarak NotifyMe'nin senaryosu) ve **novelty rejection** (hiç görülmemiş desen — NotifyMe'nin cold-start senaryosu). Kökeni Chow (1970) ve Hellman (1970)'a kadar gidiyor — **56 yıllık, olgunlaşmış bir alan.**

**Formal karar modelleri:** "Optimal Strategies for Reject Option Classifiers" (JMLR) üç eşdeğer formülasyon sunuyor: cost-based (rejection'a açık maliyet ata), **bounded-improvement** (hedef risk sabitle, kapsamı maksimize et), **bounded-abstention** (hedef kapsam sabitle, riski minimize et) — üçü de aynı optimal stratejiye (Bayes classifier + randomize seçim fonksiyonu) yakınsıyor.

**NotifyMe'ye doğrudan haritalama:**
- **NO_INTERVENTION** ≈ ambiguity rejection / bounded-abstention — sistem yeterince emin değilse karar vermemeyi seçer, birinci sınıf bir çıktı.
- **ASK_USER** ≈ "Learning to Defer" (L2D — Madras ve ark., Punzi ve ark. survey'inde özetlenmiş) — insana devretme, sabit maliyetli rejection'ın (L2R) genelleştirilmiş hali; insanın "professional experience and common sense" ile makinenin bilmediği bilgiyi kullanabileceği kabul ediliyor.

**Temel soru — "karar vermemek meşru bir strateji mi?" — cevap net: EVET, formal ve olgun bir akademik alan.** NotifyMe'nin bunu "birinci sınıf karar" yapması, ML'in 56 yıllık pratiğiyle tam uyumlu. **Kanıt seviyesi: Var — doğrulandı, en güçlü bulgulardan biri (olgun, çok kaynaklı, doğrudan transfer edilebilir).**

## 13. Conflict Detection

Bkz. §5 (Bayesian causal inference — "aynı kaynaktan mı geliyor" sorusu). Ek pratik kanıt: EMA/wearable-vs-self-report uyum/uyumsuzluk (concordance/discordance) literatürü — yaşlı yetişkinlerde self-report çalışması (SAGE, "Are You Sure?": Lapses in Self-Reported Activities) — 95 katılımcının **çeyreğinin** 2 saatlik aktivite logunu sensörle **karşılaştırılabilir biçimde bile tamamlayamadığı**, karşılaştırma mümkün olan yerlerde **azınlığın** anlaşmaya vardığı gösterildi. Bu, "çelişki" tanımının kendisinin bulanık olabileceğini gösteriyor — bazı "çelişkiler" aslında veri kalitesi/karşılaştırılabilirlik sorunu, gerçek bir anlam taşıyan çelişki değil. NotifyMe'nin conflict-detection mekanizması bu ayrımı (gerçek çelişki vs. karşılaştırılamaz veri) açıkça yapmalı. **Kanıt seviyesi: Dolaylı destekli — pratik uyumsuzluk oranları yüksek ama "gerçek çelişki" tanımı literatürde de net değil.**

## 14. Temporal Evidence

Bu alt-başlık ayrı derinlemesine taranmadı (Aşama 2B'nin feedback-timing bulguları — EMA momentary vs retrospective, recall bias — burada tekrar edilmiyor, bkz. `notifyme_academic_feedback_human_factors_phase2b.md` §8, §10). Tek yeni katkı: missing-data literatüründeki (§16) "shared-parameter" modelleri, temporal tutarlılığı formal olarak modelliyor (ör. LTSPMM — latent trait shared-parameter mixed model, Cursio/Mermelstein/Hedeker) ama bu, NotifyMe ölçeğinde aşırı ağır (452 kişi × 35 zaman noktası gibi büyük EMA veri setleri için tasarlanmış).

## 15. Personalization / Reliability Learning

**IntelligentPooling** (Tomkins, Liao, Klasnja, Yeung, Murphy 2020, arXiv 2002.09971; PMC8494236) — mHealth bağlamında kaynak güvenilirliğini kullanıcıya özgü öğrenme problemi, Thompson Sampling + Bayesian mixed-effects model ile çözülüyor. **Kritik bulgu:** "kişiselleştirme (variance ekler) ile popülasyon-havuzlama (bias ekler) arasında doğal bir gerilim var" — sistem homojenlik yüksekken daha çok popülasyondan, heterojenlik yüksekken daha çok kişisel veriden öğreniyor (adaptif havuzlama).

**NotifyMe'ye uygulanabilirlik:** IntelligentPooling'in temel mekanizması (empirical Bayes ile hyper-parametre güncelleme) **popülasyon verisi gerektiriyor** — NotifyMe'nin henüz yok. **Future work olarak** işaretlenmeli: eğer NotifyMe bir gün çok-kullanıcılı hale gelirse, "bu kullanıcının timer kullanımı ne kadar güvenilir" sorusu tam olarak bu çerçeveyle (kullanıcı-özgü rastgele etki + popülasyon havuzu) modellenebilir. Tasarım 1'de **tek kullanıcı reliability learning'i** (§20 feedback-loop riskiyle bağlantılı) çok daha basit, ordinal bir "tutarlılık sayacı" ile yaklaşık olarak taklit edilebilir (ör. "son N geri bildirimden kaçı objektif veriyle tutarlıydı"), formal Bayesian hiyerarşi olmadan. **Kanıt seviyesi: Var — doğrulandı (çerçeve sağlam), NotifyMe ölçeği için aşırı — basit yaklaşıklaştırma önerilir.**

## 16. Missing Data

**Çok zengin, doğrudan uygulanabilir literatür.** EMA'da missing data formal olarak MCAR/MAR/MNAR ayrımıyla ele alınıyor (McNeish 2024, "Missing Not at Random Intensive Longitudinal Data with Dynamic Structural Equation Models") — **doğrudan NotifyMe'nin sorduğu soruya cevap veren bir örnek olay var**: bir binge-eating çalışmasında katılımcılar **utanç nedeniyle** aşırı yeme davranışını bildirmiyor — model, kayıp verilerin **%85.6'sının "Evet" olacağını** (yani tam olarak bildirilmemiş olumsuz davranış) tahmin ediyor. Bu, "kullanıcının feedback vermemesinin kendisi bir behavioral signal olabilir" hipotezini **doğrudan ampirik olarak destekleyen** bir emsal.

**Diğer teknik yaklaşımlar:** Shared-parameter modeller (Cursio, Mermelstein, Hedeker — latent trait, "yanıtlama isteği" gizli bir özellik olarak modelleniyor); "hidden missingness" için scaled inverse probability weighting (event-contingent EMA'da, yorgunluktan kaynaklanan bildirmeme riskini düzeltiyor). JMIR meta-analizi (2025, e65710) — EMA madde sayısı arttıkça katılım oranının düştüğünü (doğrudan Aşama 2B'nin resource-efficiency bulgusunu istatistiksel olarak teyit ediyor) ama **hangi moderatörlerin missingness'i yordadığının genelde belirsiz kaldığını** gösteriyor (R²≤%20).

**Etik/metodolojik risk:** Kullanıcının feedback vermemesini "muhtemelen kötü gün" olarak yorumlamak **MNAR modelleme açısından meşru** ama **doğru olmayabilir** (basitçe unutmuş, meşgul olmuş da olabilir) — Aşama 2B'nin self-serving-bias uyarısına paralel bir "silence bias" riski. Tam formal MNAR modellemesi (shared-parameter, DK-DSEM) NotifyMe ölçeğinde aşırı ağır (büyük N gerektiriyor) — hafif bir yaklaşıklık (ör. "kötü objektif performans + feedback yok" kombinasyonunu düşük-güvenle "olası zorluk" olarak işaretlemek, ama asla kesin varsayım olarak) önerilir. **Kanıt seviyesi: Var — doğrulandı ki missing-not-at-random gerçek ve modellenebilir bir fenomen; NotifyMe'ye tam formal uygulama önerilmiyor, hafifletilmiş versiyon önerilir.**

## 17. Cold Start

Bkz. §8. Progressive Bayesian Confidence (arXiv 2601.03299) kavramsal ilkesi — erken veri = temkinli/geniş iddia, veri arttıkça daralan güven — Model B'nin (aşağıda §19) doğal bir bileşeni olarak alınabilir, tam Bayesian hesaplama olmadan. IntelligentPooling'in popülasyon-öncelikli yaklaşımı NotifyMe'nin **şu an** erişemeyeceği bir kaynak (future work). **Sonuç:** cold-start döneminde sistem **conservative + fixed-rule** olmalı (Model A'ya yakın davranmalı), veri biriktikçe Model B'nin uncertainty-aware mekanizmalarına kademeli geçiş yapmalı.

## 18. Confidence Score Communication

**Zengin ve kısmen çelişkili HCI literatürü, ama net bir örüntü var.**

- Miscalibrated (yanlış kalibre edilmiş) confidence, kalibre edilmiş olandan **daha kötü**: Fregosi, Gómez Vicente, Campagner, Cabitza (AAAI 2026, "Too Sure for Our Own Good") — kalibre edilmiş güven skorları karar doğruluğunu **+%20** artırırken kalibre edilmemiş skorlar sadece **+%2** artırıyor, ve **hem automation bias hem conservatism bias'ı artırıyor**. Yüksek-ama-yanlış güven kullanıcıyı yanlış öneriyi kabule itiyor; düşük-ama-doğru güven kullanıcıyı doğru öneriyi reddetmeye itiyor.
- Cao, Liu, Huang (ACM CSCW 2024) — ham/kalibre-edilmiş **olasılık** gösteriminden, **kalibre-edilmiş frekans** gösterimi ("100 örnekten 72'sinde... 51'i gerçekten...") daha iyi sonuç veriyor, confirmation-bias etkisini azaltıyor.
- **Kategorik etiketler sayısal yüzdelerden daha güvenilir yorumlanıyor:** Fregosi ve ark. bilinçli olarak "yüksek/orta/düşük" kategorik etiket kullandı çünkü aynı %75 değeri farklı çalışmalarda farklı yorumlanmış (bazılarında "yüksek", bazılarında "orta") — sayısal yüzdelerin **tutarsız kişisel yorumlara** açık olduğunu gösteriyor.
- Zhou ve ark. (arXiv 2402.07632) — kullanıcılar miscalibration'ı **kendiliğinden fark edemiyor**; kalibrasyon seviyesini açıkça iletmek yardımcı oluyor ama bu sefer de güveni gereksiz düşürüyor (under-reliance).

**NotifyMe'ye doğrudan sonuç:** NotifyMe **kalibre edilmiş bir güven skoru üretemez** (kalibrasyon için gereken büyük etiketli veri seti yok) — bu durumda kullanıcıya sayısal yüzde göstermek, literatürün belgelediği **tam olarak zararlı senaryoyu** (miscalibrated confidence → hem automation hem conservatism bias) tetikleme riski taşır. Aşama 2C'nin "false precision" uyarısı burada **estetik bir dürüstlük sorunu değil, ölçülmüş bir zarar riski** haline geliyor. **Sonuç:** confidence Tasarım 1'de **internal sinyal olarak kalmalı**, kullanıcıya gösterilecekse **en fazla kategorik/ordinal etiket** ("emin değilim" gibi), asla ham yüzde. **Kanıt seviyesi: Var — doğrulandı, güçlü ve çok kaynaklı.**

## 19. Human Override

**Beklenmedik ve önemli bulgu:** "Hybrid Confirmation Tree" (HCT) literatürü (Berger ve ark. 2026, arXiv 2602.02375; escholarship.org) ve "Beyond AI advice — independent aggregation" (arXiv 2603.29866) — klasik "AI-as-advisor" akışının (sistem önerir → insan kabul/red eder) **sistematik olarak yetersiz** olduğunu gösteriyor, çünkü **insanlar doğru ve yanlış AI önerisini ayırt edemiyor** ve "conservative advice-takers" — kendi ilk yargılarına aşırı bağlı kalıyorlar (anlaşmazlıkta doğru AI önerisinin sadece %34'ünü benimsiyorlar). Alternatif (HCT: bağımsız insan + bağımsız AI kararı, anlaşmazlıkta ikinci bir insan çözer) tüm test edilen 10 veri setinde daha iyi performans gösteriyor.

**NotifyMe'ye uygulanabilirlik sınırlı ama önemli bir tasarım ipucu içeriyor:** HCT ikinci bir bağımsız insan gerektiriyor — NotifyMe'de yok (tek kullanıcı). Ama altta yatan ilke aktarılabilir: **kullanıcının kendi tahminini, sistemin önerisini görmeden önce** almak (ör. "bu hafta ne kadar süre ayırmayı planlıyorsun?" — öneriyi göstermeden), sonra sistem önerisiyle karşılaştırmak, **sıralı "öner→kabul et" akışından epistemik olarak daha güçlü** olabilir çünkü kullanıcının yargısı sistem tarafından çapalanmamış (anchoring olmadan) kalıyor. Bu, Phase 3 için **somut bir tasarım önerisi** (blind-then-compare), ama ampirik olarak NotifyMe'de test edilmemiş. **Kanıt seviyesi: Var — doğrulandı (AI-as-advisor'ın zayıflığı iyi belgelenmiş), NotifyMe'ye özgü blind-then-compare önerisi bir çıkarım, doğrudan test edilmemiş.**

Ayrıca genel meta-analiz (Vaccaro ve ark., *Nature Human Behaviour* 2024, "When combinations of humans and AI are useful") — insan-AI kombinasyonlarının **ortalamada** insan-veya-AI-tek-başına'dan **daha kötü** performans gösterdiğini buluyor (Hedges' g=-0.23), özellikle karar-alma görevlerinde (içerik-üretiminde tersi). Bu, "insan+AI her zaman insan veya AI'dan iyidir" varsayımının **genel olarak yanlış** olduğunu, NotifyMe'nin recommend+override akışının da otomatik olarak iyi sonuç vermeyeceğini hatırlatıyor — tasarımın dikkatli test edilmesi gerekiyor.

## 20. Feedback-Loop Risks

**Doğrulandı — algoritmik özkendini-güçlendiren geri besleme döngüleri gerçek ve matematiksel olarak gösterilmiş bir fenomen.** "Degenerate Feedback Loops in Recommender Systems" (arXiv 1902.10730) — recommender sistemlerin kullanıcı ilgisini zamanla daraltıp "degenerate" (yozlaşmış) bir duruma sürüklediğini formal olarak kanıtlıyor; mitigasyon: **sürekli rastgele keşif (exploration) + büyüyen aday havuzu**. "How human-AI feedback loops alter human judgements" (*Nature Human Behaviour* 2024) — küçük başlangıç yanlılıklarının insan-AI etkileşiminde **insan-insan etkileşiminden daha güçlü** biçimde büyüdüğünü gösteriyor (katılımcılar bunun farkında bile değil).

**NotifyMe'ye doğrudan uygulama:** Mustafa'nın kendi hipotezi (sistem self-report'u düşük-güvenilir bulur → daha az dikkate alır → kararlar davranışsal veriye kayar → self-report'un etkileme şansı azalır) **literatürde belgelenmiş bir sınıf problemin özel bir örneği**. Bilinen mitigasyonlar: (1) **sürekli keşif/periyodik tam-ağırlık yeniden-test** — self-report'a düzenli aralıklarla (ör. her N hafta) tam ağırlık geri verip tutarlılığı yeniden ölç, kalıcı olarak düşük ağırlığa "kilitlenmeyi" önle; (2) **taban ağırlık (floor weight)** — self-report'un etkisi asla sıfıra inmemeli, RecSys'teki "growing candidate pool" mantığının analojisi. Bu doğrudan uygulanabilir bir tasarım kısıtı. **Kanıt seviyesi: Var — doğrulandı, güçlü (matematiksel kanıt + gerçek insan-AI deneyi).**

## 21. Explainability

Aşama 2B'nin explainability bulguları (açıklama miktarı ≠ güven, kalite > miktar) burada tekrar edilmiyor. Data-fusion kararının açıklanabilirliği için ek not: bu fazda bulunan discrepancy-as-signal ilkesi (§5) açıklamaya doğal olarak yansıyabilir — "objektif verin X gösteriyor, sen Y diyorsun, bu ikisi arasındaki fark kendi başına ilginç" tarzı bir çerçeveleme, sistemin çelişkiyi gizlemek yerine şeffafça göstermesi, kullanıcı kontrolü/düzeltme fırsatı (Aşama 2B §13) ile tutarlı.

## 22. Evaluation

Aşama 2D'nin Claim→Evidence mantığı doğrudan uygulanıyor: Mustafa'nın önerdiği 10 sentetik senaryo (agree/conflict/weak/repeated/missing/cold-start/unreliable-timer) **algoritma iç-tutarlılığını** (bounded mi, oscillation var mı, NO_INTERVENTION/ASK_USER/ADAPT arasında doğru triyaj yapıyor mu) test edebilir — bu **desteklenen bir iddia**. **Desteklenmeyen iddia:** bu senaryoların gerçek kullanıcı güvenini, gerçek çelişki çözümünün doğruluğunu, veya gerçek "hangi kaynak daha güvenilirdi" sorusunu kanıtlaması — bunlar synthetic veri limitleri (Aşama 2D §6, circular validation riski) burada da geçerli. §11'deki MYCIN duyarlılık-analizi yaklaşımı (confidence parametrelerini pertürbe et, nihai kararın stabilitesini ölç) buraya doğrudan eklenmeli — yeni bir katkı.

## 23. Candidate Architectures

### MODEL A — SIMPLE RULE-BASED (Deterministic Priority)
**Girdi:** davranışsal veri + self-report kategori. **Karar mantığı:** sabit öncelik sırası (ör. davranışsal veri her zaman öncelikli, self-report sadece açıklama/etiketleme için). **Belirsizlik temsili:** yok. **Çelişki yönetimi:** yok — davranışsal veri kazanır. **Cold-start:** ideal (sıfır-veri sorunu yok). **Missing-data:** eksik alan basitçe yok sayılır. **Açıklanabilirlik:** yüksek (basit if/else). **Uygulama karmaşıklığı:** düşük. **Veri ihtiyacı:** yok. **Evaluation:** deterministic unit test. **Bilimsel savunulabilirlik:** düşük — "davranışsal veri = objektif truth" varsayımını (bu araştırmanın reddettiği varsayım, §3-5) doğrudan yeniden diriltiyor. **Tasarım 1 uygulanabilirliği:** yüksek ama epistemik olarak dürüst değil — **sadece cold-start döneminde geçici davranış olarak** savunulabilir.

### MODEL B — UNCERTAINTY-AWARE RULE SYSTEM (önerilen orta yol)
**Girdi:** aynı + ordinal güven etiketleri (yüksek/orta/düşük, sayısal değil). **Karar mantığı:** confidence-aware kurallar (§12'deki selective-classification mantığıyla: tek gözlem + düşük güven → NO_INTERVENTION; kalıcı sapma + tutarlı self-report → adaptasyon öner; güçlü çelişki → ASK_USER veya ertele; yetersiz kanıt → NO_INTERVENTION). **Belirsizlik temsili:** ordinal tier'lar (MYCIN CF'nin ruhuna yakın ama sayısal-olasılık yanılgısından kaçınarak — CF'nin kendi tarihsel dersi). **Çelişki yönetimi:** discrepancy-as-signal (§5) — çelişki büyüklüğü kendisi bir tetikleyici. **Cold-start:** Model A'ya yakın davranış + kademeli genişleme (Progressive Bayesian ilkesi, ama tam hesaplama olmadan, §8/§17). **Missing-data:** hafif MNAR-farkındalığı (§16) — "kötü objektif + sessizlik" düşük-güvenle işaretlenir, asla kesin varsayılmaz. **Açıklanabilirlik:** yüksek (kural izi verilebilir). **Uygulama karmaşıklığı:** orta. **Veri ihtiyacı:** düşük-orta (sentetik test yeterli, gerçek veri gerekmez). **Evaluation:** §22'deki sentetik senaryolar + MYCIN-tarzı duyarlılık testi. **Bilimsel savunulabilirlik:** yüksek — Aşama 2A'nın EWMA/CUSUM altyapısıyla, Aşama 2B'nin tailoring-variable diliyle, ve bu fazın ana bulgularıyla (reject-option, discrepancy-as-signal, CF tarihi) doğrudan tutarlı. **Tasarım 1 uygulanabilirliği:** yüksek-orta.

### MODEL C — PROBABILISTIC / EVIDENCE-FUSION
**Girdi:** aynı + tam olasılık dağılımları. **Karar mantığı:** Bayesian posterior (veya Dempster-Shafer belief combination). **Belirsizlik temsili:** formal, sayısal. **Çelişki yönetimi:** kombinasyon kuralı (hangisi — §9'un çözülmemiş sorunu). **Cold-start:** popülasyon prior'u gerektirir (IntelligentPooling-tarzı) — NotifyMe'de yok, **ciddi engel**. **Missing-data:** formal MNAR modeli (shared-parameter) — büyük N gerektirir, NotifyMe'de yok. **Açıklanabilirlik:** düşük-orta (posterior'u kullanıcıya "anlatmak" zor, §18'in uyardığı false-precision riski). **Uygulama karmaşıklığı:** yüksek. **Veri ihtiyacı:** yüksek (kalibrasyon için). **Evaluation:** formal ama NotifyMe ölçeğinde test edilemez güç eksikliği. **Bilimsel savunulabilirlik:** teoride en yüksek, **pratikte en düşük** — çünkü önkoşulları (kalibrasyon verisi, popülasyon) karşılanmıyor, bu da "false precision" üretme riskini en yüksek yapıyor. **Tasarım 1 uygulanabilirliği:** düşük — **önerilmiyor**, future-work.

**Nihai seçim yapılmıyor (talimat gereği)** ama **Model B en dengeli ve en savunulabilir aday** olarak öne çıkıyor; Model C'nin açıkça gerçekçi olmadığı belirtiliyor (Aşama 2D'nin Package C mantığıyla paralel).

## 24. Red Team

| # | Varsayım | Destekleyici kanıt | Karşı kanıt | Belirsizlik | Risk | NotifyMe'ye etkisi |
|---|---|---|---|---|---|---|
| 1 | Behavioral data objective truth'tur | Ölçülmüş, sayısal | §3: timer hatası, eksik loglama, "semantic gap" — ölçülen veri de fallible | Düşük | **YÜKSEK** | Terminoloji değişmeli: "observed", "objective" değil |
| 2 | Self-report güvenilmezdir, önemsizdir | Self-serving bias (2B), R²=.05-.39 (2C) | §5: discrepancy'nin kendisi klinik olarak anlamlı sinyal; self-report tamamen atılırsa bu bilgi kaybolur | Orta | **ORTA-YÜKSEK** | Self-report asla sıfır ağırlığa düşmemeli (floor weight, §20) |
| 3 | İki sinyali weighted average yapmak problemi çözer | Bayesian cue integration gerçek bir mekanizma (§6) | Ağırlıkların kalibrasyonu gerekiyor, NotifyMe'de yok — keyfi olur | Düşük | **YÜKSEK** | Sabit sayısal ağırlık (0.7/0.3 gibi) kullanılmamalı |
| 4 | Confidence score bilimsel görünüyorsa anlamlıdır | — | §18: miscalibrated confidence hem automation hem conservatism bias'ı artırıyor, ölçülmüş zarar | Düşük | **YÜKSEK** | Sayısal % kullanıcıya gösterilmemeli |
| 5 | Bayesian model rule-based sistemden otomatik olarak üstündür | Teorik olarak en güçlü çerçeve (§8) | Prior/kalibrasyon önkoşulları NotifyMe'de yok; MYCIN'in kendi tarihi (§11) Bayesian'ın pratik zorluklarını gösteriyor | Düşük | **ORTA** | Model C önerilmiyor, Model B tercih ediliyor |
| 6 | Dempster-Shafer daha gelişmiş olduğu için daha iyidir | Matematiksel olarak zengin | §9: Zadeh paradoksu, 40+ yıllık çözülmemiş "jungle of combination rules" tartışması, tam da yüksek-çelişki senaryosunda en zayıf | Düşük | **YÜKSEK eğer seçilirse** | DS kesinlikle önerilmiyor |
| 7 | Fuzzy logic belirsizliği otomatik olarak çözer | Klinik kullanımda gerçek başarı var (§10) | Membership function'lar elisitasyon olmadan keyfi kalır | Orta | **ORTA** | Sadece etiketleme/UX katmanı olarak kullanılabilir, karar motoru değil |
| 8 | Her conflict çözülmelidir | Sezgisel makul | §5: discrepancy-as-signal — çelişkiyi taşımak, çözmekten daha bilgilendirici olabilir | Orta | **ORTA** | Zorla-çözme yerine ASK_USER/işaretleme tercih edilmeli |
| 9 | Sistem emin değilse kullanıcıya sormak her zaman iyidir | Kullanıcı kontrolü genel olarak olumlu (2A/2B) | §16 (2B): her sapmada sormak habituation/fatigue riski taşıyor; ASK_USER da bir maliyet | Orta | **ORTA** | ASK_USER eşiği yüksek tutulmalı, her belirsizlikte değil |
| 10 | Daha fazla veri her zaman daha iyi karar verir | LLM/istatistik genel ilkesi | §16: daha fazla soru = daha düşük acceptance (JMIR meta-analizi); Aşama 2B'nin resource-efficiency bulgusu | Düşük | **ORTA** | Veri toplama minimize edilmeli, response burden gözetilmeli |
| 11 | Historical reliability gelecekte de geçerlidir | §15: reliability learning meşru bir alan | §20: rejim değişimi (Aşama 2A'nın EMA yavaş-tepki uyarısı); statik güvenilirlik varsayımı riskli | Orta | **ORTA** | Periyodik yeniden-test gerekli (§20) |
| 12 | Missing feedback hiçbir şey ifade etmez | Basit/nötr varsayım | §16: MNAR literatürü, "utanç nedeniyle bildirmeme" örneği — sessizlik bazen bilgi taşıyor | Orta | **ORTA** | Sessizlik nötr sayılmamalı ama kesin de varsayılmamalı |
| 13 | Missing feedback mutlaka bir behavioral signal'dır | §16'daki güçlü örnek | Ama aynı derecede güçlü karşı-örnek yok — çoğu missingness'in nedeni (JMIR meta-analizi) belirsiz kalıyor | Yüksek | **ORTA** | "Muhtemelen" dilinde, düşük-güvenle kullanılmalı, kesin değil |
| 14 | User override ground truth'tur | Kullanıcı kontrolü, otonomi (2A/2B) | §19: HCT literatürü — insanlar AI önerisinin doğruluğunu ayırt edemiyor; override her zaman doğru değil | Orta | **ORTA** | Override kaydedilmeli ama "doğru cevap" olarak kodlanmamalı |
| 15 | Agreement between signals truth anlamına gelir | Sezgisel makul | §13: bazı "anlaşmalar" karşılaştırılamaz/tesadüfi olabilir (SAGE self-report çalışması) | Orta | **DÜŞÜK-ORTA** | Anlaşma da bir güven artışı sinyali, kesinlik değil |
| 16 | Disagreement measurement error anlamına gelir | Klasik varsayım | §5: en güçlü karşı-kanıt — discrepancy klinik olarak anlamlı olabilir | Düşük | **YÜKSEK** | Bu varsayım açıkça reddedilmeli, raporun ana teması |
| 17 | Internal confidence kullanıcıya yüzde olarak gösterilmelidir | Şeffaflık ilkesi genel olarak iyi | §18: sayısal % gösterimi zarar riski taşıyor, kategorik daha güvenli | Düşük | **YÜKSEK eğer yapılırsa** | Asla ham yüzde gösterilmemeli |
| 18 | Fusion mekanizması varsa AI/ML gerekir | Yaygın varsayım | §12: reject-option/abstention ML kökenli ama basit if/else kurallarla da uygulanabilir; §11: MYCIN CF de "AI" ama basit toplama/çıkarma | Düşük | **ORTA** | "AI kullanmak" hedef değil (talimatın kendi son uyarısı) — Model B rule-based, AI değil |

## 25. Unexpected Findings / Promptta Olmayan Önemli Bulgular

1. **Authority Inversion (arXiv 2605.23938, 2026)** — En kritik beklenmedik bulgu. LLM'ler, sayısal/yapılandırılmış sensör kanıtı ile kullanıcının doğal-dil iddiası çeliştiğinde **sistematik olarak kullanıcı lehine** karar veriyor (aktivite tanımada sensöre güven oranı 4 modelde %0-11.2 arası, model boyutu 4B'den 35B'ye çıkınca **düzelmiyor**). Mekanizma: sayısal sensör verisi, LLM'in token-embedding uzayında karar-alt-uzayına neredeyse dik (ortogonal) projeksiyon yapıyor (CIR_sensör ≈ 0.03-0.08), doğal-dil iddiaları çok daha güçlü nüfuz ediyor (CIR_user, CIR_sensör'ün 1.4-2.9 katı). **NotifyMe için doğrudan sonuç:** Aşama 2B/2D'nin "LLM zorunlu değil, rule-based yeterli" sonucu bu bulguyla **daha da güçleniyor** — eğer NotifyMe ileride LLM'i davranışsal-vs-self-report çelişkisinin herhangi bir noktasında (sınıflandırma, özetleme, karar) kullanırsa, LLM'in kullanıcının anlatısını sessizce ve sistematik olarak sayısal kanıta tercih edeceği varsayılmalı — "AI = daha objektif" sezgisinin tam tersi.
2. **MYCIN'in tedavi-önerisi CF-duyarsızlığı (Clancey & Cooper, §11)** — NotifyMe'nin nihai kararlarının (ADAPT/NO_INTERVENTION/ASK_USER gibi kaba kategoriler) iç güven parametrelerindeki hatalara MYCIN'in tedavi önerisi gibi duyarsız kalabileceği, bu yüzden "sayıların doğru olması" yerine "kararın stabil olması" kriterinin yeterli olabileceği — bu Aşama 2D'nin evaluation metodolojisine (§22, duyarlılık testi) doğrudan yeni bir test türü ekliyor.
3. **Hybrid Confirmation Tree / AI-as-advisor'ın zayıflığı (§19)** — NotifyMe'nin "öner → kabul/red/değiştir" UX deseni, literatürde giderek daha fazla eleştirilen bir paradigma; "blind-then-compare" (kullanıcının kendi tahminini önce, sistem önerisini görmeden almak) daha güçlü bir alternatif olabilir — Phase 3 için somut, test edilebilir bir tasarım önerisi.
4. **Vaccaro ve ark. meta-analizi (*Nature Human Behaviour* 2024)** — insan-AI kombinasyonlarının ortalamada insan-veya-AI-tek-başına'dan daha kötü performans gösterdiği (g=-0.23), özellikle karar-alma görevlerinde — NotifyMe'nin "recommend+override" tasarımının kendiliğinden iyi sonuç vereceği varsayımı sorgulanmalı.

## 26. Implications for NotifyMe

1. **Terminoloji değişmeli:** "objective data" yerine "observed/measured behavioral signal"; "subjective data" yerine "self-reported signal" — hiçbiri ground truth değil (§3).
2. **Problem "data fusion" olarak çerçevelenmemeli** — "evidence aggregation under uncertainty" / "human-AI hybrid decision-making" daha doğru, sensor-fusion literatürünün ağır makine öğrenmesi aparatı gereksiz (§4).
3. **Model B (Uncertainty-Aware Rule System) en savunulabilir aday** — MYCIN CF tarihinin dersini alarak (sayısal-olasılık-yanılgısından kaçınarak), reject-option ML'in olgun çerçevesini (NO_INTERVENTION/ASK_USER) kullanarak, discrepancy-as-signal ilkesini benimseyerek (§23).
4. **Sabit sayısal güven ağırlıkları (0.7/0.3 gibi) kullanılmamalı** — ordinal/kategorik güven seviyeleri tercih edilmeli (§6, §18).
5. **Kullanıcıya sayısal % confidence asla gösterilmemeli** — miscalibration zararı ölçülmüş bir risk (§18).
6. **Self-report'a asla sıfır ağırlık verilmemeli** — feedback-loop degenerasyon riskine karşı taban ağırlık + periyodik tam-ağırlık yeniden-test (§20).
7. **Çelişkinin kendisi bir sinyal olarak taşınmalı** — otomatik "çözme" yerine, büyük sapmalar ASK_USER'a veya açık işaretlemeye yönlendirilmeli (§5, §8'deki red-team maddesi #16).
8. **LLM kullanılırsa (opsiyonel serbest-metin sınıflandırma için), asla davranışsal-vs-self-report çelişkisinin hakemi olarak kullanılmamalı** — Authority Inversion riski (§25/1).
9. **Dempster-Shafer ve tam Bayesian model Tasarım 1'de kullanılmamalı** — hem teorik-tartışmalı hem önkoşulsuz (§9, §8).

## 27. Phase 3 Decision Table

| Soru | Cevap (özet) |
|---|---|
| A. "Objective data" yerine hangi terim? | "Observed/measured behavioral signal" — self-reported signal ile birlikte, ikisi de "evidence", ikisi de fallible (§3) |
| B. Behavioral+self-report fusion doğru framing mi? | Kısmen — "data fusion" değil, "evidence aggregation under uncertainty / hybrid decision-making" daha doğru (§4) |
| C. Çeliştiğinde sistem ne yapmalı? | Zorla çözmemeli; kararı ordinal güvene göre triyaj etmeli (NO_INTERVENTION / ASK_USER / açık işaretleme) (§12, §19) |
| D. Conflict'in kendisi bilgi olabilir mi? | Evet — literatürün en güçlü desteklediği bulgulardan biri (§5) |
| E. Confidence/reliability nasıl temsil edilmeli? | Ordinal/kategorik tier (yüksek/orta/düşük), sayısal olasılık değil (§6, §11) |
| F. Sabit numeric weights kullanılmalı mı? | Hayır — kalibrasyon önkoşulu yok, keyfi olur (§6, §7) |
| G. Bayesian yaklaşım gerekli mi? | Hayır, tam model değil — kavramsal ilke (kademeli güven) rule-based sistemde taklit edilebilir (§8) |
| H. Dempster-Shafer gerekli mi? | Hayır — 40+ yıllık çözülmemiş tartışma, tam da yüksek-çelişki senaryosunda zayıf (§9) |
| I. Fuzzy logic gerekli mi? | Sadece etiketleme/UX katmanı olarak (opsiyonel), karar motoru olarak değil (§10) |
| J. Rule-based uncertainty system yeterli mi? | Evet — MYCIN CF tarihi + reject-option ML çerçevesiyle iyi desteklenen, önerilen yaklaşım (§11, §12, Model B) |
| K. NO_INTERVENTION birinci sınıf karar olmalı mı? | Evet — 56 yıllık ML reject-option literatürüyle doğrudan destekli (§12) |
| L. ASK_USER ne zaman kullanılmalı? | Güçlü/tutarlı çelişki + yetersiz kanıt durumunda, ama her sapmada değil (habituation riski) (§12, red-team #9) |
| M. Historical reliability kullanılmalı mı? | Basitleştirilmiş biçimde evet (tutarlılık sayacı), ama periyodik yeniden-test şartıyla (§15, §20) |
| N. Missing data nasıl ele alınmalı? | Sessizlik nötr sayılmamalı ama kesin de varsayılmamalı — düşük-güvenli, hafifletilmiş MNAR-farkındalığı (§16) |
| O. Cold start nasıl ele alınmalı? | Conservative/Model-A-benzeri başlangıç, veri arttıkça kademeli uncertainty-aware geçiş (§17) |
| P. Kullanıcıya confidence gösterilmeli mi? | Kategorik/ordinal en fazla; ham yüzde asla — ölçülmüş zarar riski (§18) |
| Q. Human override nasıl yorumlanmalı? | Kaydedilmeli ama "ground truth" sayılmamalı; blind-then-compare tasarımı değerlendirilmeli (§19) |
| R. Fusion sisteminin evaluation'ı nasıl yapılmalı? | Sentetik 10-senaryo + MYCIN-tarzı duyarlılık analizi (karar parametre pertürbasyonuna dayanıklı mı) (§22) |
| S. En gerçekçi aday mimari? | Model B (Uncertainty-Aware Rule System) — nihai seçim Phase 3'te (§23) |
| T. Hangi sorular hâlâ çözülmedi? | Bkz. §28 |

## 28. Remaining Open Questions

- **Ordinal güven tier'larının sayısı/eşikleri:** kaç seviye (2 mi 3 mü), hangi kritere göre belirlenecek — Aşama 2A/2C'nin tekrar eden "neden 90 neden 70 değil" problemiyle aynı yapıda, henüz çözülmedi.
- **Discrepancy-as-signal eşiği:** hangi büyüklükteki bir sapma "ASK_USER"ı tetiklemeli — literatür kavramsal destek veriyor ama sayısal eşik önermiyor (aynı açık-parametre problemi).
- **Periyodik yeniden-test sıklığı (§20):** self-report'a ne sıklıkla tam ağırlık geri verilmeli — RecSys literatürü ilkeyi destekliyor ama NotifyMe'ye özgü sıklık belirtmiyor.
- **MYCIN-tarzı duyarlılık testinin NotifyMe'de gerçek sonucu:** §11/§22'de önerilen test (confidence parametrelerini pertürbe et, karar stabilitesini ölç) henüz uygulanmadı — Phase 3'ün ilk teknik adımlarından biri olabilir.
- **Blind-then-compare tasarımının kullanılabilirlik maliyeti:** §19'daki öneri UX açısından ek sürtünme (kullanıcıdan önce tahmin isteme) yaratabilir — Aşama 2B'nin resource-efficiency ilkesiyle gerilim içinde, ayrı değerlendirme gerektirir.
- **LLM'in Authority Inversion riskinin, sayısal veriyi metne çevirerek (ör. "actualDuration 25 dakika, plannedDuration'ın %42'si") azaltılıp azaltılamayacağı** — bu fazda araştırılmadı, orijinal makale format-uyumluluğunun (numeric→interpretable-indicator) etkiyi azalttığını ima ediyor ama NotifyMe'ye özgü test edilmedi.

## 29. Sources / Search Queries / Weak Sources

### Kullanılan arama sorguları (temsili, gerçek Exa aramaları)

1. "observed behavioral signal" vs "objective data" terminology epistemology self-tracking measurement error personal informatics
2. multimodal data fusion evidence aggregation decision under uncertainty review taxonomy human-in-the-loop systems
3. epistemic uncertainty versus aleatoric uncertainty decision making review behavioral systems
4. reliability weighting precision weighting Bayesian cue integration multisensory cue combination review
5. Bayesian inference adaptive intervention personal informatics cold start small data prior limitations
6. Dempster-Shafer evidence theory conflicting evidence combination criticism limitations practical application review
7. fuzzy logic behavior change personal informatics decision support system review criticism membership function arbitrary
8. selective classification reject option abstention machine learning when to abstain uncertainty threshold survey
9. discordance between self-report and sensor data wearable behavioral sensing personal informatics contradiction meaningful signal
10. missing not at random self-report nonresponse as informative signal ecological momentary assessment missingness
11. algorithmic feedback loop confirmation bias self-reinforcing personalization system trusts sensor over user
12. calibrated confidence communication end users uncertainty visualization should systems show percentage confidence
13. certainty factors MYCIN expert system historical comparison Bayesian probability rule-based uncertainty reasoning
14. conflict resolution strategies combining human judgment and algorithmic prediction disagreement review human-AI
15. source reliability learning calibration over time personalized trust weighting individual differences

### İncelenen kaynak türleri

Hakemli dergi/konferans makaleleri (*Nature*, *Nature Neuroscience*, *Nature Human Behaviour*, *Machine Learning* — Springer, *Psychological Bulletin* geleneğinden Fox & Ülkümen, ACM TORS/CSUR/CSCW, JMLR, *Annual Reviews*), klasik/tarihsel AI kaynakları (Heckerman 1992/1991, Buchanan & Shortliffe 1984 — MYCIN), sistematik review/survey'ler (Dempster-Shafer survey *Applied Soft Computing* 2022, reject-option survey *Machine Learning* 2024, HITL taxonomy), preprint/arXiv (çoğu 2025-2026, açıkça işaretlendi — Authority Inversion, Progressive Bayesian Confidence, IntelligentPooling'in arXiv versiyonu), klinik/tıbbi kaynak (fuzzy logic VTE, *BMC Public Health*).

### Elenen/zayıf bulunan kaynaklar ve neden

- İlk arama sorgusu ("observed behavioral signal" terminology) düşük-kaliteli pazarlama/SEO blogları (atsiliepsiu.lt, upgrowth.in) döndürdü — **akademik kanıt olarak kullanılmadı**, terminoloji tartışması bunun yerine personal-informatics/wearable-vs-self-report akademik literatüründen (§3) kuruldu.
- "Progressive Bayesian Confidence Architectures" (arXiv 2601.03299) ve "Authority Inversion" (arXiv 2605.23938) **çok yeni preprint'ler** (2026), hakemli değil — kavramsal katkıları güçlü ve iç tutarlı olduğu için kullanıldı ama **hakem denetiminden geçmedikleri açıkça belirtilir**.
- Dempster-Shafer survey'lerinin bazı ikincil kaynakları (fs.unm.edu, PSP-97 System) düşük-kurumsal-güvenilirlik — sadece klasik Zadeh paradoksunu teyit etmek için, birincil değil destekleyici kaynak olarak kullanıldı.

### Önemli belirsizlikler

- Authority Inversion (arXiv 2605.23938) tek bir çalışma, replikasyon yok — bulgu çarpıcı ama bağımsız doğrulama bekliyor.
- Ernst & Banks (2002) ve reliability-weighting literatürünün NotifyMe ölçeğine aktarılabilirliği bu raporda **eleştirel olarak reddedildi** (kalibrasyon önkoşulu yok) — ama bu, mekanizmanın kendisinin geçersiz olduğu anlamına gelmiyor, sadece NotifyMe'nin önkoşulları karşılamadığı anlamına geliyor; gelecekte (büyük kullanıcı tabanı) yeniden değerlendirilebilir.
- MYCIN duyarlılık-analizi önerisi (§11, §22) bu raporda **kavramsal bir öneri**, NotifyMe'nin kendi kod tabanında hiç test edilmedi — Phase 3 için somut bir sonraki adım, ama sonucu bilinmiyor.

---

**Durum:** Open-Gaps Cleanup A tamamlandı. Kod/repo/roadmap değişikliği yapılmadı, algoritma implement edilmedi, nihai mimari kararı verilmedi, commit/push yapılmadı.

# NotifyMe — Tasarım 1 Araştırması — Aşama 2A: Akademik Literatür — Adaptif Planlama + Closed-Loop Feedback

**Tarih:** 2026-09-20
**Kapsam:** Yalnızca adaptasyon algoritması + closed-loop feedback akademik literatürü. Serbest metin LLM sınıflandırması, Goal trajectory, rakip ürünler, genel AI planner araştırması derinlemesine ele alınmadı (bunlar önceki/sonraki aşamaların konusu).
**Önceki aşama:** `docs/research/notifyme_competitor_analysis_phase1.md` — ticari ürün araştırması, okundu, değiştirilmedi.
**Amaç:** NotifyMe'nin özgünlüğünü kanıtlamak DEĞİL. Literatürde NotifyMe'nin varsayımlarını çürüten veya daha iyi yöntemler varsa dürüstçe raporlamak.

---

## 1. Executive Summary

NotifyMe'nin "geçmiş performanstan kademeli, kullanıcı-onaylı öneri üretip sonucu tekrar ölçme" fikri, akademik literatürde **parçalar halinde** çok sağlam bir temele sahip, ama **bu spesifik kombinasyonun (planlama-uygulaması alanında) hazır, tek bir akademik çerçevesi yok**. Bulgular:

- **Closed-loop (measure→adapt→measure) yapı** akademik olarak çok iyi tanımlanmış: Just-in-Time Adaptive Interventions (JITAI — Nahum-Shani & Murphy) ve Dynamic Treatment Regimes (Chakraborty & Murphy) bu döngüyü onlarca yıldır formalize ediyor. Ama bu literatür **sağlık/klinik/mobil-sağlık müdahaleleri** için geliştirilmiş, **kişisel görev/zaman-yönetimi** alanına doğrudan uygulanmış hali kamuya açık kaynaklarda bulunamadı.
- **EMA (exponential moving average)** gerçek bir istatistiksel/mühendislik tekniği (exponential smoothing, 1950'lerden beri; Stanford'dan güncel bir genel çerçeve de var), ama **"NotifyMe'nin problemi için EMA doğru yöntemdir" diyen akademik bir kaynak yok** — bu bir tahmin/mühendislik seçimi, kanıtlanmış bir "en iyi yöntem" değil.
- **"Tek kötü gün" problemi** akademik olarak çözülmüş bir problem: istatistiksel süreç kontrolü (SPC) literatüründe EWMA/CUSUM kontrol grafikleri tam olarak bunun için var, hatta psikoloji alanında (deneyim örneklemesi/ESM verisi) doğrudan uygulanmış bir 2021 makalesi bulundu — **bu, araştırmanın en güçlü, en doğrudan uygulanabilir bulgusu.**
- **Kademeli değişim büyüklüğü** (60→90dk, neden 90 değil 70/120) için **NotifyMe'nin alanına özgü akademik bir formül bulunamadı**. En yakın paralel, spor bilimindeki "Acute:Chronic Workload Ratio" (ACWR) literatürü — orada bile "doğru" eşik hâlâ tartışmalı, meta-analizler karışık sonuç veriyor. **Bu, NotifyMe'nin en zayıf akademik zemini olan nokta.**
- **Kullanıcı onayı/override'ı sisteme geri besleme** için tam formalize bir çerçeve var: Coactive Learning (Shivaswamy & Joachims) ve mixed-initiative UI ilkeleri (Horvitz, 1999) — bunlar doğrudan uygulanabilir, iyi atıf verilebilir.
- **RL/contextual bandit gerçekten gerekli mi?** Bulgular açıkça **hayır** yönünde: JITAI alanının kendi kanonik örneği (HeartSteps) basit bir contextual bandit'i bile fit etmek için 44 kullanıcı × haftalarca × günde 5 mikro-randomizasyon (binlerce karar noktası) gerektirdi. NotifyMe'nin tek-kullanıcı, erken-aşama verisiyle bunun bir kesri bile yok — RL/bandit şu an **gereksiz karmaşıklık**, akademik olarak savunulamaz.
- **Rule-based (EMA+eşik+sınırlı adım) adaptasyon Tasarım 1 için akademik olarak savunulabilir** — ama "basit if/else" ile "textbook adaptive-control/forecasting tekniği" arasındaki farkı doğru çerçevelemek şart (bkz. §20 Red Team).

---

## 2. Research Scope

Bu aşama yalnızca şu ikili problemi kapsıyor:
1. **Adaptasyon algoritması** — geçmiş performanstan (planlanan/gerçekleşen süre-iş miktarı, tamamlanma, gecikme, geri bildirim) gelecek dönem parametrelerini (süre, iş yükü) nasıl, ne kadar, ne zaman değiştirmeli.
2. **Closed-loop feedback** — önerinin sonucunu tekrar ölçüp bir sonraki adaptasyon kararına nasıl geri besleyeceği.

Kapsam dışı (bilinçli): serbest metin LLM sınıflandırması, Goal trajectory/pace analizi, rakip ürün araştırması (Aşama 1'de yapıldı), genel "AI planner" pazar araştırması.

---

## 3. Search Methodology

Exa web search (`web_search_exa`) ile ~20 hedefli sorgu çalıştırıldı, her sorguya "objective" alanıyla ne aranması gerektiği net tanımlandı. Aranan terim aileleri: JITAI/adaptive intervention, dynamic treatment regimes, contextual bandit/mHealth, human-in-the-loop/interactive ML, EMA/exponential smoothing/online learning, planning fallacy, goal-setting theory, attribution theory/self-regulated learning, acute:chronic workload ratio (spor bilimi), change-point detection/statistical process control, safe/bounded RL, coactive learning/preference elicitation, implementation intentions, mixed-initiative UI, personal informatics, cold-start Bayesian personalization. İki kaynak doğrudan `web_fetch_exa` ile tam metin/özet düzeyinde doğrulandı (JITAI 2016 makalesi, Hardeman 2019 sistematik derleme).

**Kullanılan kaynak türleri:** Annual Review of Psychology, Annals of Behavioral Medicine, Health Psychology, Psychological Methods, Psychological Review, American Psychologist, PMC/NIH, Springer (IJBNPA, BMC Sports Science), ScienceDirect, arXiv (preprint olarak işaretlendi), JAIR/ACM/AAAI, PubMed, üniversite arşivleri (MIT, Stanford, UEA ePrints).

**Erişilemeyen/sınırlı erişilen önemli kaynaklar:** Bazı makalelerin sadece abstract/highlight düzeyine erişildi, tam PDF indirilmedi (bu raporda böyle işaretlendi). "ProGem" (Gemini+Prophet hibrit görev süresi tahmini, IJACSA 2026) ilginç bir paralel ama düşük atıf sayılı, yeni bir dergide — kalite güveni orta.

---

## 4. Relevant Research Fields

1. **Mobile health / behavioral science** — JITAI, dynamic treatment regimes, micro-randomized trials (MRT).
2. **Sequential decision making / online learning** — contextual bandits, reinforcement learning, exponential smoothing/moving models.
3. **Statistics / signal processing** — statistical process control (SPC), change-point detection, EWMA/CUSUM.
4. **Sports science** — training load monitoring, acute:chronic workload ratio.
5. **Cognitive/social psychology** — planning fallacy, attribution theory, goal-setting theory, implementation intentions.
6. **Human-computer interaction** — mixed-initiative UI, coactive learning, personal informatics.
7. **Machine learning (recommender systems)** — cold-start personalization, Bayesian preference elicitation.

---

## 5. Key Survey / Review Papers

| Kaynak | Yıl | Yayın | Odak |
| --- | --- | --- | --- |
| Nahum-Shani & Murphy, "Just-in-Time Adaptive Interventions: Where Are We Now and What Is Next?" — DOI 10.1146/annurev-psych-121024-044244 | 2025 | Annual Review of Psychology | JITAI alanının güncel durumu, 3 açık zorluk (engagement zamanlaması, dijital-teknoloji katılımı, sosyal ilişkiler) |
| Nahum-Shani et al., "Just-in-Time Adaptive Interventions (JITAIs) in Mobile Health: Key Components and Design Principles" — DOI 10.1007/s12160-016-9830-8 | 2016 | Annals of Behavioral Medicine | JITAI'nin temel bileşenlerini formalize eden kanonik makale (2279 atıf) |
| Hardeman, Houghton, Lane, Jones, Naughton, "A systematic review of JITAIs to promote physical activity" — DOI 10.1186/s12966-019-0792-7 | 2019 | Int. J. Behav. Nutr. Phys. Act. | 14 gerçek JITAI'yi sistematik inceliyor — **uygulamada JITAI'lerin ne kadar erken aşamada olduğunun kanıtı** |
| Chakraborty & Murphy, "Dynamic Treatment Regimes" — PMC4231831 | ~2014 | Annual Review of Statistics / PMC | SMART tasarımı, Q-learning, marjinal yapısal modeller — closed-loop karar kuralları teorisi |
| Qian, Walton, Collins, Klasnja, Lanza, Nahum-Shani et al., "The Micro-Randomized Trial for Developing Digital Interventions" — DOI 10.48550/arxiv.2107.03544 | 2021 | arXiv (preprint, sonradan Psychological Methods'da yayımlandığı biliniyor ama bu oturumda o versiyona erişilmedi) | MRT tasarımı ve veri analizi metodolojisinin kapsamlı incelemesi, HeartSteps örneğiyle |
| Buehler, Griffin & Ross, "Chapter One — The Planning Fallacy: Cognitive, Motivational, and Social Origins" — ScienceDirect S0065260110430014 | ~2010 | Advances in Experimental Social Psychology | Planning fallacy'nin 20+ yıllık araştırma programının derlemesi |

---

## 6. Adaptation Methods

Aşağıdaki yöntemler NotifyMe'nin "geçmiş performanstan gelecek parametreyi değiştirme" problemine göre değerlendirildi.

- **Basit hareketli ortalama (moving average):** En basit taban çizgisi. Literatürde EMA'nın özel bir hâli olarak ele alınıyor (bkz. §7). NotifyMe'ye uyar mı: evet, ama tüm geçmişe eşit ağırlık verir, yakın davranışı yeterince önceliklendirmez.
- **EMA / exponential smoothing:** §7'de detaylı.
- **Threshold-based adaptation:** Gegmara'nın kullandığı yöntem (%20 sapma eşiği). Akademik karşılığı: kontrol teorisindeki "deadband"/"hysteresis" ve SPC'deki kontrol limitleri (bkz. §8). NotifyMe'ye uyar mı: evet, EMA ile birlikte kullanılırsa (EMA neyin "normal" olduğunu tanımlar, eşik ne zaman "anormal"e döndüğünü söyler).
- **Proportional adjustment (orantılı düzeltme):** Klasik kontrol teorisinde P-kontrolör — hata büyüklüğüyle orantılı düzeltme. NotifyMe'nin "60→90dk" örneği aslında örtük bir P-kontrolör gibi okunabilir (sapma ne kadar büyükse öneri o kadar büyük). Literatürde doğrudan bu alana uygulanmış bir örnek bulunamadı, ama kavramsal olarak tutarlı.
- **PID / feedback controllers:** Klasik, iyi anlaşılan bir çerçeve ama NotifyMe'nin problemi (gürültülü, seyrek, insan davranışı) klasik PID'in varsaydığı sürekli/deterministik sistemlerden çok farklı. Akademik literatürde insan-davranışı kişiselleştirmesine PID'in doğrudan uygulandığı güçlü bir örnek bulunamadı — **kamuya açık kaynaklarda doğrulanamadı**, spekülatif bir uzantı olarak kalıyor.
- **Fuzzy logic:** Aranan sorgularda NotifyMe'nin alanına özgü bir uygulama bulunamadı. Muhtemelen var ama bu araştırmada net bir kaynak çıkmadı — **doğrulanamadı**.
- **Bayesian updating / Bayesian optimization:** Güçlü aday, özellikle küçük veriyle (§ Araştırma Sorusu I). Klasik istatistikte (conjugate prior → posterior update) çok iyi biliniyor; güncel LLM-kişiselleştirme literatüründe de (Cold-Start Personalization via Bayesian Adaptive Questioning, CAPE/Pep, ICML 2026 poster) aktif olarak kullanılıyor — ama bu son grup NotifyMe'nin alanından (LLM tercih öğrenme) farklı bir problem, doğrudan aktarılamaz, sadece "Bayesian yaklaşım küçük veride işe yarıyor" genel ilkesini destekliyor.
- **Contextual bandits / multi-armed bandits:** Lei, Lu, Tewari, Murphy'nin actor-critic contextual bandit algoritması (arXiv 1706.09090) JITAI'ler için özel olarak geliştirilmiş — ama veri ihtiyacı çok yüksek (bkz. §11, HeartSteps). NotifyMe'nin erken aşamasına **uygun değil**.
- **Reinforcement learning:** Aynı veri-açlığı sorunu, daha da şiddetli. **Uygun değil** (bkz. §Q J).
- **Online learning (genel):** EMA/exponential smoothing zaten online learning'in bir alt kümesi (Stanford'ın "Exponentially Weighted Moving Models" makalesi bunu net gösteriyor — web.stanford.edu/~boyd/papers/pdf/ewmm.pdf). NotifyMe'nin ihtiyacına en iyi oturan genel kategori bu.
- **Adaptive control (mühendislik):** Kavramsal olarak en yakın çerçeve — "bounded, gradual, feedback-driven parameter update" tam olarak adaptif kontrolün tanımı. Ama klasik adaptif kontrol literatürü fiziksel/mekanik sistemler için, insan davranışına uyarlanmış hali kavramsal referans olarak kullanılabilir, birebir formül olarak değil.
- **Rule-based adaptive systems:** Bu, aslında NotifyMe'nin şu anki (FAZ1 sonrası düşünülen) tasarımının kendisi. Akademik meşruiyeti JITAI'nin kendi tarihinde var: Nahum-Shani et al. (2016) ve 2025 derlemesi, gerçek dünyada uygulanan JITAI'lerin çoğunun **basit, önceden belirlenmiş karar kuralları** kullandığını, karmaşık öğrenilmiş politikaların (RL/bandit) hâlâ azınlıkta olduğunu ima ediyor (Hardeman 2019'daki 14 JITAI'nin "theory-based" olanları bile çoğunlukla basit tetikleyici-eşik mantığı kullanıyor).

---

## 7. EMA / Smoothing Approaches

- **Matematiksel temel:** Klasik exponential smoothing (Brown, 1950'ler-60'lar) ve genelleştirilmiş hali "Exponentially Weighted Moving Models" (Stanford, Boyd ve arkadaşları — web.stanford.edu/~boyd/papers/pdf/ewmm.pdf). EMA, karesel kayıp fonksiyonuyla EWMM'nin özel bir hâli; **sabit bellek, sabit hesaplama** ile güncellenebilir (tüm geçmişi saklamaya gerek yok) — bu, NotifyMe'nin mobil/offline-first mimarisine (FAZ1 SQLite) pratik olarak uyuyor.
- **α (smoothing constant) seçimi:** Literatürde net bir "doğru" değer yok — düşük α = yavaş/kararlı, yüksek α = hızlı/gürültüye duyarlı (IJRTE inşaat projesi süre tahmini makalesi, α=0.3/0.6/0.9 karşılaştırması, α=0.3'ün en iyi sonucu verdiğini buluyor — ama bu inşaat projeleri için, NotifyMe'nin alanına genellenmesi **doğrulanamaz**).
- **Task-effort tahmini için güncel bir hibrit örnek:** "ProGem: A Hybrid AI Framework for Task Effort Estimation" (IJACSA, 2026, DOI 10.14569/ijacsa.2026.0170393) — Gemini LLM + Prophet zaman-serisi modelini birleştirip yazılım görev süresini tahmin ediyor, 1197 gerçek görev üzerinde test edilmiş, R²=0.475 (orta düzey açıklayıcılık). Bu, "EMA/zaman-serisi + LLM hibridi görev süresi tahmininde işe yarayabilir" fikrine **kısmi akademik destek** veriyor, ama (a) yazılım proje yönetimi bağlamında, kişisel günlük görevler değil, (b) R²=0.475 mütevazı bir doğruluk, "çözülmüş problem" değil.
- **EMA tek başına yeterli mi (Araştırma Sorusu C):** Hayır. EMA bir **nokta tahmini** üretir (yeni "normal" ne), ama **ne zaman bu normalin gerçekten değiştiğine karar vermek** için ayrı bir mekanizma (eşik/kontrol grafiği) gerekir — bu tam olarak §8'in konusu.

---

## 8. Threshold / Trend Detection

Bu, araştırmanın **en güçlü ve en doğrudan uygulanabilir bulgusu.**

- **Statistical Process Control (SPC):** Endüstriyel kalite kontrolünden gelen, "bir sürecin ortalaması gerçekten değişti mi, yoksa bu normal gürültü mü" sorusuna cevap veren klasik bir çerçeve (Shewhart kontrol grafikleri, EWMA kontrol grafikleri, CUSUM).
- **Doğrudan uygulanabilir kaynak:** Schat, Tuerlinckx, Smit, De Ketelaere, Ceulemans, **"Detecting mean changes in experience sampling data in real time: A comparison of univariate and multivariate statistical process control methods"** — DOI 10.1037/met0000447, *Psychological Methods*, 2021. Bu makale **tam olarak NotifyMe'nin problemine** (günlük/tekrarlı öz-bildirim verisinde gerçek bir kalıcı değişimi tek seferlik gürültüden ayırt etme) psikoloji bağlamında (mood/depresyon relaps erken uyarısı) cevap arıyor. **Bulgusu: EWMA ve CUSUM yöntemleri, klasik Shewhart yöntemine göre küçük/orta büyüklükteki kalıcı ortalama değişimlerini tespit etmede açıkça daha iyi performans gösteriyor** — hem gerçek hem simüle edilmiş veri üzerinde. Makale ayrıca gerçek ESM (experience sampling method) verisinin bağımsızlık, normal dağılım gibi SPC'nin klasik varsayımlarını ihlal ettiğini, bunun için metodun uyarlanması gerektiğini açıkça tartışıyor — bu, NotifyMe'nin kendi verisi için de (görev tamamlama, eksik günler, çarpık dağılımlar) doğrudan geçerli bir uyarı.
- **NotifyMe için pratik sonuç:** "Tek kötü gün" problemi, EMA'nın kendisiyle değil, **EWMA/CUSUM tipi bir kontrol-limiti mantığıyla** çözülmeli — yani Gegmara'nın "%20 sabit eşik"i yerine, istatistiksel olarak daha savunulabilir bir "kümülatif sapma" veya "ardışık N gözlem eşiği aşıyor mu" mantığı (Western Electric kuralları geleneğinden esinlenerek) tercih edilebilir. Bu, akademik olarak Gegmara'dan daha güçlü bir zemine oturur.
- **Minimum observation window / confidence threshold:** Gegmara'nın "örnek sayısına göre güven seviyesi" fikri kavramsal olarak SPC/istatistiksel çıkarımın temel ilkesiyle (az örnekle güven aralığı geniş, karar verilemez) uyumlu — ama Gegmara'nın kendi eşiği (hangi örnek sayısında "güvenilir" sayıldığı) akademik bir kaynağa dayanmıyor, muhtemelen sezgisel/deneme-yanılma.

---

## 9. Gradual / Bounded Adaptation

- **En güçlü paralel alan: spor bilimi, Acute:Chronic Workload Ratio (ACWR).** 2025 tarihli bir sistematik derleme (BMC Sports Science, Medicine and Rehabilitation, DOI 10.1186/s13102-025-01332-x) ACWR'nin sakatlık riskini tahmindeki etkinliğini meta-analiz ediyor. Temel fikir NotifyMe'ninkiyle neredeyse birebir örtüşüyor: **"kısa vadeli yük" (akut) ile "uzun vadeli ortalama yük" (kronik) arasındaki oranı izleyip, oran çok hızlı büyürse (örn. >1.5) sakatlık/tükenme riskinin arttığını varsay.** Bu literatür ayrıca **Banister'ın Fitness-Fatigue modelini** (1982) ve haftalık yük artışında "%10 kuralı" gibi pratik-ama-tartışmalı sezgisel kuralları da içeriyor.
- **Önemli dürüstlük notu:** Bu literatür kendi alanında bile **tartışmalı** — ACWR'nin sakatlık tahmin gücü hakkında meta-analizler karışık/çelişkili sonuçlar veriyor (bazı çalışmalar zayıf prediktif değer buluyor). Yani "spor biliminde bu problem çözülmüş, NotifyMe'ye aktarabiliriz" demek **yanlış olur** — doğru çerçeveleme: "iş yükünü kademeli artırma fikri kendi alanında bile hâlâ aktif tartışılan, kesin bir 'doğru oran' sunmayan bir araştırma konusu."
- **Safe/bounded RL, step-size selection:** Bu araştırmada bulunan kaynaklar (ör. "SafeAdapt" — sürekli öğrenmede güvenli politika güncellemesi) çok yeni, dar kapsamlı arXiv preprint'leri, NotifyMe'nin insan-davranışı bağlamına **doğrudan uygulanabilir değil** — daha çok robotik/RL güvenlik literatüründe, "önceden sertifikalanmış güvenli bölge" fikri soyut olarak ilham verebilir ama somut bir formül sunmuyor.
- **Goal-setting theory'nin dolaylı katkısı:** Locke & Latham (2002, "Building a practically useful theory of goal setting and task motivation: A 35-year odyssey", American Psychologist) — spesifik ve **zor ama ulaşılabilir** hedeflerin performansı artırdığını, hedef zorluk-performans ilişkisinin **doğrusal** olduğunu (ability/commitment sınırına kadar) gösteriyor. Bu, "kademeli artış mantıklı" fikrine dolaylı destek veriyor ama "60'tan 90'a mı yoksa 70'e mi çıkmalı" sorusuna sayısal bir cevap **vermiyor** — bu spesifik oran/adım büyüklüğü sorusu **literatürde NotifyMe'nin alanı için çözülmüş değil.**
- **Sonuç (Araştırma Sorusu F):** Adım büyüklüğü için akademik olarak savunulabilir tek dürüst pozisyon: **(a)** değişim yönü (artış/azalış) ve genel kademelilik ilkesi literatürle destekleniyor (goal-setting theory + ACWR mantığı), **(b)** tam sayısal oran (örn. max %25 artış) literatürden türetilemez, tasarım kararı olarak açıkça işaretlenmeli, ileride kullanıcı verisiyle kalibre edilmesi gereken bir parametre olarak sunulmalı.

---

## 10. Closed-Loop Adaptive Systems

- **JITAI (Nahum-Shani et al. 2016, 2025):** Decision point → tailoring variable (kullanıcının o andaki durumu) → decision rule (hangi müdahale hangi durumda) → intervention option (hangi destek) döngüsü — kavramsal olarak NotifyMe'nin MEASURE→ANALYZE→ADAPT→MEASURE döngüsüyle doğrudan örtüşüyor.
- **Dynamic Treatment Regimes / SMART tasarımı (Chakraborty & Murphy):** Klinik literatürde, bir tedavi kararının sonraki tedavi kararını **istatistiksel olarak** etkilemesini sağlayan deneysel tasarım (Sequential Multiple Assignment Randomized Trial). Q-learning ve marjinal yapısal modeller bu regimlerin **etkisini ölçmek** için kullanılıyor.
- **Micro-Randomized Trials (MRT — Klasnja et al. 2015, Qian et al. 2021):** JITAI'lerin **bileşenlerini optimize etmek** için özel bir deneysel tasarım — kullanıcı, çalışma boyunca yüzlerce/binlerce kez rastgele "müdahale var/yok" olarak atanıyor, sonuç ölçülüyor.
- **KRİTİK UYARI:** Bu üç çerçeve de **istatistiksel çıkarım için tasarlanmış deneysel/araştırma metodolojileridir**, tek bir kullanıcı için gerçek zamanlı bir öneri motoru **tasarlamanın tarifi değildir**. NotifyMe'nin "closed-loop" fikri kavramsal olarak bu literatürle akraba, ama HeartSteps/SMART tarzı istatistiksel geçerlilik (randomizasyon, çok kullanıcılı veri, formel hipotez testi) Tasarım 1 kapsamında **ne mümkün ne de gerekli**. Doğru çerçeveleme: "NotifyMe, JITAI/DTR literatüründeki closed-loop *kavramından* ilham alıyor, onun istatistiksel *yöntemlerini* (MRT, Q-learning) uygulamıyor."
- **Coactive Learning'in closed-loop'a katkısı:** Kullanıcının öneriyi değiştirmesi (90dk yerine 120dk seçmesi) klasik JITAI/DTR literatüründe yok, ama Coactive Learning (§12) bunu tam olarak formalize ediyor — iki literatür NotifyMe'de birleşiyor.

---

## 11. JITAI / Adaptive Intervention Literature

- **HeartSteps (Klasnja et al. 2015 tasarım, 2019 etkinlik makalesi — DOI 10.1093/abm/kay067; ayrıca NCT03225521, ClinicalTrials.gov):** JITAI alanının en çok atıf alan, en iyi belgelenmiş vaka çalışması. 44 sedanter yetişkin, 6 haftalık mikro-randomize deneme, günde 5 karar noktası (bağlama göre aktivite önerisi) + akşam planlama. **Bulgu:** öneri almak 30 dakikalık adım sayısını ortalama %14-24 artırıyor (p≈.02-.06), ama etki **zamanla azalıyor** (habitüasyon/alışma etkisi — 271 adımlık ilk-hafta etkisi haftalar içinde küçülüyor).
- **NotifyMe için ders (çift yönlü):**
  1. **Olumlu:** contextually tailored suggestion + planning ikilisi işe yarayan bir formül — NotifyMe'nin "plan + hatırlatma" ikilisiyle kavramsal olarak uyumlu.
  2. **Uyarı:** Etkinin zamanla azalması ("habituation"), NotifyMe'nin de aynı öneriyi tekrar tekrar verirse kullanıcının duyarsızlaşabileceğine işaret ediyor — bu, closed-loop "önerinin başarısını tekrar ölç" fikrine **ek bir boyut** katıyor: sadece "öneri işe yaradı mı" değil, "öneri hâlâ işe yarıyor mu, yoksa alışkanlık mı oluştu" sorusu da izlenmeli.
- **Contextual bandit (Lei, Lu, Tewari, Murphy — arXiv 1706.09090):** HeartSteps'in JITAI'sini veriye dayalı optimize etmek için geliştirilen actor-critic contextual bandit algoritması. **Veri ihtiyacı çok yüksek** — makale "hundreds of thousands of randomizations" ölçeğinden bahsediyor (tüm HeartSteps popülasyonu için). NotifyMe'nin tek-kullanıcı erken aşamasında bunun bir kesri bile mevcut değil.
- **Sistematik derleme bulgusu (Hardeman 2019):** 14 gerçek JITAI'den sadece **5'i teori tabanlı**, çoğu 3-4 hafta kısa süreli, **hiçbiri** yeterli istatistiksel güce sahip değil, maliyet-etkinlik konusunda **kanıt yok**. Bu, JITAI'lerin akademik dünyada bile hâlâ **erken aşamada, "çözülmüş" olmaktan uzak** bir alan olduğunu gösteriyor — NotifyMe'nin de bu belirsizliği miras aldığını dürüstçe kabul etmek gerekiyor.

---

## 12. Human-in-the-Loop / User Override

- **Coactive Learning (Shivaswamy & Joachims, JAIR 2015, DOI 10.1613/jair.4539; ayrıca ICML 2012 orijinali):** Sistem bir öneri (y) sunar, kullanıcı bunu **tam optimal olmasa da daha iyi** bir alternatifle (ȳ) düzeltir; öğrenme algoritması bu düzeltmeyi kullanarak ağırlıklarını günceller (Preference Perceptron). **NotifyMe'ye doğrudan uygulanabilir:** sistem "90dk" önerir, kullanıcı "120dk" seçerse, bu fark (120-90) bir "kullanıcı düzeltmesi" sinyali olarak modellenebilir — kullanıcının cardinal (kesin) bir değer belirtmesi bile gerekmez, sadece "önerilenden daha fazla/az" bilgisi yeterli olabilir. Ölçülebilir bir regret/hata metriği de tanımlanmış durumda (akademik makalede formal regret sınırları var).
- **Mixed-Initiative UI (Horvitz, CHI 1999, DOI 10.1145/302979.303030 — "Principles of Mixed-Initiative User Interfaces"):** Klasik, çok atıflı (LookOut sistemi örneğiyle) makale. 12 ilke arasında NotifyMe'ye doğrudan uygulanabilir olanlar: **(1)** otomasyonun gerçek katma değeri olmalı, **(2)** kullanıcının hedefindeki belirsizlik hesaba katılmalı, **(3)** eylemin zamanlaması dikkat durumuna göre ayarlanmalı, **(9)** kullanıcının sonucu **rafine edebileceği** mekanizmalar sağlanmalı, **(12)** sistem kullanıcıyı gözlemleyerek öğrenmeye devam etmeli. Bu ilkeler NotifyMe'nin "öner, dayatma" felsefesini akademik bir çerçeveye oturtuyor.
- **Personal Informatics Stage Model (Li, Dey, Forlizzi, CHI 2010, DOI 10.1145/1753326.1753409):** 5 aşamalı model (Preparation → Collection → Integration → **Reflection** → **Action**). NotifyMe'nin planned-vs-actual + haftalık analiz döngüsü tam olarak bu modelin Reflection/Action aşamalarına denk geliyor. Makalenin önemli bulgusu: **"barrier'lar aşamalar arasında kademeleniyor"** — önceki aşamadaki sorun (örn. eksik/yanlış veri toplama) sonraki aşamaları (reflection, action) doğrudan bozuyor. **NotifyMe için ders:** kullanıcı planned/actual veya yapılandırılmış geri bildirimi düzgün doldurmazsa (Sunsama'nın "skip" seçeneği gibi — Aşama 1 raporunda not edildi), tüm adaptasyon zinciri veri açlığından etkilenir — bu, closed-loop tasarımının **Collection aşamasının kalitesine bağımlı en kırılgan noktası.**

---

## 13. Method Comparison Matrix

Nitel karşılaştırma, sayısal skor değil.

| Yöntem | Açıklanabilirlik | Az veriyle çalışma | Kişiselleştirme | Online güncellenebilme | Tek-kötü-güne dayanıklılık | Kademeli değişim | Kullanıcı override desteği | Closed-loop potansiyeli | Uygulama zorluğu | Test edilebilirlik | Tasarım1 uygunluğu | ML'e genişletilebilirlik |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Basit ortalama | Çok yüksek | Yüksek | Düşük | Zayıf (tüm geçmiş eşit ağırlık) | Düşük (tek nokta değiştirmez ama trend'i de geç yakalar) | Doğal değil, ek kural gerekir | Kolay eklenir | Düşük | Çok düşük | Çok kolay | Uygun ama zayıf | Kolay |
| EMA / exponential smoothing | Yüksek | Yüksek (ilk gözlemden itibaren çalışır) | Orta (α kullanıcıya göre ayarlanabilir) | Doğal (recursive) | **Düşük tek başına** — bkz. §7 | Doğal değil, eşik/adım kuralı ek gerekir | Kolay eklenir | Orta | Düşük | Kolay (sentetik veriyle test edilebilir) | **Uygun, önerilen çekirdek** | Kolay (Bayesian'a genişler) |
| EMA + eşik (Gegmara tarzı) | Yüksek | Yüksek | Orta | Doğal | Orta (eşik ad hoc ise zayıf) | Kural olarak eklenebilir | Kolay eklenir | Orta | Düşük-orta | Kolay | Uygun | Kolay |
| EWMA/CUSUM (SPC) | Orta-yüksek | Orta (kontrol limitleri için biraz geçmiş gerekir) | Orta | Doğal | **Yüksek — literatürle en iyi desteklenen** | Ek kural gerekir | Kolay eklenir | Orta-yüksek | Orta | Orta (simülasyonla test edilebilir, Schat 2021 metodolojisi örnek alınabilir) | **Uygun, akademik olarak en savunulabilir** | Orta |
| Bayesian updating (conjugate prior) | Orta | **Yüksek — belirsizliği doğal olarak nicelleştirir** | Yüksek | Doğal | Orta-yüksek (posterior varyansı "ne kadar eminiz" bilgisini taşır) | Prior ile doğal olarak sınırlanabilir | Prior'a müdahale olarak modellenebilir | Yüksek | Orta-yüksek (istatistik bilgisi gerekir) | Orta | Uygun ama ek karmaşıklık | Yüksek |
| Coactive Learning (override'dan öğrenme) | Orta | Düşük (çok sayıda düzeltme gerektirir) | Yüksek | Doğal | n/a (bu ayrı bir sinyal kanalı) | n/a | **En güçlü, amaç bu** | Yüksek | Orta | Orta | Sınırlı (Tasarım1'de az veri) — kavram olarak alınabilir, algoritma olarak erken | Yüksek |
| Contextual bandit | Düşük-orta | **Çok düşük — HeartSteps'te bile binlerce karar noktası gerekti** | Yüksek (teoride) | Doğal | Belirsiz | Ek kural gerekir | Zor, non-trivial | Yüksek (teoride) | Yüksek | Zor (gerçek kullanıcı verisi olmadan anlamsız) | **Uygun değil** | n/a (zaten ML) |
| Reinforcement learning | Düşük | **Çok düşük** | Yüksek (teoride) | Doğal | Belirsiz | Ek kural gerekir | Zor | Yüksek (teoride) | Çok yüksek | Çok zor | **Uygun değil** | n/a |

---

## 14. Most Relevant Individual Studies

Aşağıdaki 8 çalışma en yakın/en doğrudan uygulanabilir bulundu; her biri için kısa profil (tam 25-madde şablonu yerine, en bilgilendirici alanlara odaklanan yoğunlaştırılmış format — kullanıcı talimatındaki tüm 25 soru örtük olarak kapsanıyor).

### 14.1 Klasnja et al. (2019) — HeartSteps MRT etkinlik makalesi
**Yazarlar:** Predrag Klasnja, Shawna Smith, Nicholas Seewald, Jin Seok Lee, Kelly Hall, Brook Luers, Eric Hekler, Susan Murphy. **Yayın:** Annals of Behavioral Medicine 53(6), DOI 10.1093/abm/kay067. **Veri:** 44 sedanter yetişkin, 6 hafta, dakika-seviyesi adım sayısı (Jawbone + telefon). **Yöntem:** Micro-randomized trial, centered/weighted least squares. **Adaptasyon girdisi:** konum, hava durumu, gün, zaman; **çıktısı:** aktivite önerisi gönder/gönderme. **Sıklık:** günde 5 karar noktası. **Değişim büyüklüğü:** binary (öneri var/yok), büyüklük skalası yok. **Gürültü ele alımı:** istatistiksel model (weighted least squares) ile, tek gözlem değil, yüzlerce randomizasyon üzerinden ortalama etki hesaplanıyor. **Closed-loop:** kısmi — etki zamanla ölçülüyor (habituation bulgusu) ama sonraki öneri bundan otomatik değişmiyor (bu MRT'nin amacı, sonradan optimize etmek için veri toplamak). **Kullanıcı müdahalesi:** yok (randomize, kullanıcı öneriyi reddedemiyor, sadece görmezden gelebiliyor). **Sonuçlar:** öneri +%14-24 adım artışı, zamanla azalan etki. **Sınırlılıklar:** küçük örneklem, kısa süre (6 hafta), tek davranış (yürüme). **NotifyMe benzerliği:** en yakın "gerçek dünya closed-loop" örneği, ama ölçek ve istatistiksel araç seti çok farklı. **Doğrudan uygulanabilir mi:** Hayır — MRT'nin kendisi değil, ama "etki zamanla azalabilir" bulgusu tasarım uyarısı olarak alınmalı.

### 14.2 Schat, Tuerlinckx, Smit, De Ketelaere, Ceulemans (2021) — SPC for ESM data
**Yayın:** Psychological Methods, DOI 10.1037/met0000447. **Veri:** Gerçek + simüle edilmiş deneyim-örneklemesi (ESM) verisi, depresyon relaps vakası. **Yöntem:** Shewhart, Hotelling's T², EWMA, MEWMA, CUSUM, MCUSUM karşılaştırması. **Adaptasyon girdisi:** günlük ortalama duygu-durum skorları. **Değişim tespiti:** kontrol limitleri, kümülatif sapma. **Gürültü ele alımı:** makalenin **ana konusu** — otokorelasyon, eksik veri, çarpık dağılım gibi ESM'ye özgü ihlaller için özel öneriler var. **Sonuç:** EWMA/CUSUM, küçük-orta ortalama değişimlerini Shewhart'tan daha iyi tespit ediyor. **Sınırlılıklar:** tek vaka örneği (n=1 klinik illustrasyon) + simülasyon; gerçek çok-kullanıcılı genelleme sınırlı. **NotifyMe benzerliği:** **en yüksek** — problem yapısı neredeyse birebir aynı (günlük öz-bildirim, kalıcı değişim vs gürültü). **Doğrudan uygulanabilir mi:** Evet, metodoloji olarak (EWMA/CUSUM mantığı) doğrudan uyarlanabilir; NotifyMe'nin kendi sentetik veri testlerinde bu makalenin simülasyon yaklaşımı **şablon olarak kullanılabilir**.

### 14.3 Nahum-Shani et al. (2016) — JITAI key components
**Yayın:** Annals of Behavioral Medicine, DOI 10.1007/s12160-016-9830-8 (2279 atıf). **Katkı:** JITAI'nin temel bileşenlerini (decision points, tailoring variables, decision rules, intervention options) ve tasarım ilkelerini formalize ediyor. **NotifyMe benzerliği:** kavramsal iskelet olarak çok değerli — NotifyMe'nin kendi "ne zaman, hangi veriye göre, ne öner" sorularını bu terminolojiyle net şekilde çerçeveleyebilir. **Doğrudan uygulanabilir mi:** Kavramsal çerçeve olarak evet, spesifik algoritma olarak hayır (makale genel tasarım ilkeleri sunuyor, tek bir formül değil).

### 14.4 Chakraborty & Murphy — Dynamic Treatment Regimes
**Yayın:** PMC4231831 (review). **Katkı:** Closed-loop karar kurallarının (bir aşamadaki tedavi kararının sonraki aşamayı etkilemesi) istatistiksel formalizasyonu, SMART tasarımı, Q-learning. **NotifyMe benzerliği:** "önerinin sonucunu ölçüp bir sonraki öneriyi etkileme" fikrinin en resmi/matematiksel karşılığı. **Sınırlılık:** klinik/tıbbi karar bağlamı için, tam istatistiksel aygıt (SMART, marjinal yapısal modeller) NotifyMe'nin ölçeğinde uygulanamaz. **Doğrudan uygulanabilir mi:** Sadece kavramsal ilham düzeyinde.

### 14.5 Buehler, Griffin & Ross (1994) — Planning fallacy
**Yayın:** Journal of Personality and Social Psychology 67(3), DOI 10.1037/0022-3514.67.3.366. **Bulgu:** İnsanlar kendi görev tamamlama sürelerini sistematik olarak hafife alıyor (planlama yanılgısı); bunun nedeni geçmiş deneyimi değil, gelecek senaryosunu temel almaları (inside view vs outside view). Geçmiş deneyimle bağlantı kurmaya yönlendirilen katılımcılarda iyimser önyargı ortadan kalkıyor. **NotifyMe benzerliği:** NotifyMe'nin "kullanıcı 60dk planlıyor ama gerçekte daha uzun sürüyor" temel varsayımının **doğrudan akademik kanıtı**. Ayrıca "geçmiş verileri göster/kullan" tasarım kararının (planned-vs-actual ekranı) neden işe yarayabileceğinin teorik gerekçesi.

### 14.6 Locke & Latham (2002) — Goal-setting theory
**Yayın:** American Psychologist 57(9), DOI 10.1037/0003-066X.57.9.705. **Bulgu:** 35 yıllık, >500 çalışmalık meta-sentez; spesifik ve zor (ama ulaşılabilir) hedefler "elinden geleni yap" tarzı hedeflerden tutarlı biçimde daha iyi performans üretiyor; zorluk-performans ilişkisi **doğrusal**, yetenek/bağlılık sınırına kadar. Geri bildirim, hedef bağlılığı, yetenek ve görev karmaşıklığı düzenleyici (moderator) faktörler. **NotifyMe benzerliği:** kademeli-ama-zorlayıcı hedef önerisi fikrinin genel psikolojik gerekçesi; ama **spesifik oranı belirlemiyor.**

### 14.7 Weiner (1985) — Attributional theory
**Yayın:** Psychological Review 92(4), DOI 10.1037/0033-295x.92.4.548. **Bulgu:** Başarı/başarısızlık nedenleri 3 boyutta sınıflanır — **locus** (içsel/dışsal), **stability** (kararlı/değişken), **controllability** (kontrol edilebilir/edilemez). Bu boyutlar beklenti değişimini ve duygusal tepkiyi (umut, suçluluk, gurur, utanç) belirliyor. **NotifyMe benzerliği:** NotifyMe'nin Urun-Vizyonu'ndaki 6 kategorili başarısızlık nedeni listesi ("Zamanım yetmedi / Odaklanamadım / Görev zor / Beklenmedik iş çıktı...") bu üç boyuta **haritalanabilir** (örn. "zamanım yetmedi" = dışsal/değişken/kısmen kontrol edilebilir; "odaklanamadım" = içsel/değişken/kontrol edilebilir) — bu, kategorileri **ad hoc değil, teorik temelli** hale getirir; Tasarım 1 sunumunda güçlü bir savunma noktası.

### 14.8 Shivaswamy & Joachims (2015) — Coactive Learning
**Yayın:** JAIR, DOI 10.1613/jair.4539. **Bulgu:** Kullanıcı, sistemin önerisini (y) mükemmel olmasa da daha iyi bir alternatifle (ȳ) düzeltirse, bu "y'den ȳ'ye" farkı bir öğrenme sinyali olarak kullanılabilir; kesin (cardinal) bir değerlendirme gerekmez. Formal regret sınırları kanıtlanmış. **NotifyMe benzerliği:** kullanıcının "90dk" önerisini "120dk"ya değiştirmesi tam olarak bu modelin senaryosu. **Sınırlılık:** algoritmaların regret garantileri çok sayıda tekrarlı etkileşim varsayıyor — NotifyMe'nin tek-kullanıcı erken verisiyle formal garantiler anlamsız, ama **kavramsal model** (override = zayıf ama bilgilendirici sinyal) doğrudan alınabilir.

---

## 15. What Gegmara Got Right / Wrong

*(Hatırlatma: Gegmara akademik bir kaynak değil, Devpost hackathon projesi — Aşama 1'de bulunmuştu, burada sadece akademik literatürle çapraz değerlendiriliyor.)*

**Doğru yaptıkları (literatürle uyumlu):**
- EMA kullanımı → gerçek, kabul görmüş bir online-learning/forecasting tekniği (§7).
- Örnek sayısına göre güven kapısı → SPC/istatistiksel çıkarımın temel mantığıyla (az veri = düşük güven) kavramsal olarak uyumlu.
- Kategori bazlı (görev tipine göre ayrı) öğrenme → kişiselleştirme literatüründe (Bayesian, cold-start) "context/kategori bazlı ayrı model" standart bir pratik.

**Yanlış/eksik/doğrulanamayan yaptıkları:**
- **%20 sapma eşiği** → akademik bir kaynağa dayandığı görülmüyor (hackathon projesi kaynak kodu/sunumunda atıf yok), muhtemelen sezgisel. NotifyMe bunu **kopyalamak yerine**, SPC literatüründeki (Schat 2021) daha savunulabilir kontrol-limiti mantığını tercih etmeli.
- **Tek EMA + sabit eşik**, "tek kötü gün vs gerçek örüntü" ayrımını EWMA/CUSUM'un sağladığı kümülatif-sapma mantığı kadar güçlü yapmıyor — EMA tek başına yeterli değil (§7 sonucu).
- **Closed-loop'un "önerinin sonucu tekrar ölçüldü mü" kısmı** Gegmara'da (Aşama 1'de bulunduğu kadarıyla) yok — skor sürekli güncelleniyor ama "geçen haftaki öneri işe yaradı mı" sorusu sorulmuyor. NotifyMe'nin planladığı closed-loop bu noktada Gegmara'dan **daha iddialı**, ama bu iddia henüz **kanıtlanmamış** (hiçbir üründe/hackathon projesinde bulunamadı — bkz. Aşama 1 §4-L).

---

## 16. Implications for NotifyMe

1. **Adaptasyon motoru için akademik olarak en savunulabilir minimum tasarım:** EMA (trend/nokta tahmini) + EWMA/CUSUM tarzı kontrol-limiti mantığı (ne zaman "gerçek" değişim) + goal-setting theory ile hizalı kademeli/sınırlı adım büyüklüğü (ama sayısal oranı literatürden değil, tasarım kararı olarak sunarak) + Weiner'ın 3 boyutuna (locus/stability/controllability) haritalanmış yapılandırılmış başarısızlık nedeni taksonomisi + Coactive Learning mantığıyla modellenen kullanıcı override sinyali.
2. **JITAI/DTR/MRT literatürü kavramsal iskelet olarak alınmalı, istatistiksel yöntem olarak değil** — bu ayrımın raporda/sunumda açıkça yapılması, "biz JITAI kullanıyoruz" gibi abartılı bir iddiadan kaçınmayı sağlar.
3. **RL/bandit şu an gereksiz** — HeartSteps'in kendi veri ihtiyacı (44 kullanıcı × binlerce karar noktası) bunu açıkça gösteriyor.
4. **Habituation/alışma riski** (HeartSteps bulgusu) NotifyMe'nin closed-loop tasarımına eklenmesi gereken bir boyut: "öneri hâlâ etkili mi" sorusu, sadece "öneri kabul edildi mi" sorusundan ayrı izlenmeli.
5. **Kademeli adım büyüklüğünün tam oranı literatürden gelmiyor** — bu, Tasarım 1 sunumunda dürüstçe "tasarım parametresi, ileride kalibre edilecek" olarak sunulmalı, "bilimsel olarak kanıtlanmış oran" gibi sunulmamalı.

---

## 17. Evaluation Strategies

Gerçek kullanıcı davranış-değişikliği kanıtı (HeartSteps tarzı) Tasarım 1 kapsamında **mümkün değil** (zaman, örneklem, etik onay gerektirir). Bunun yerine:

1. **Sentetik veri simülasyonu** (Schat et al. 2021'in metodolojisi şablon alınarak): bilinen bir "gerçek" trend/değişim noktası enjekte edilmiş sentetik kullanıcı-davranış serileri üretip, algoritmanın bunu doğru tespit edip etmediğini (ve gürültüye yanlış tepki verip vermediğini) ölçmek.
2. **Algoritmik iç-tutarlılık testleri:** sınırlı adım büyüklüğü gerçekten aşılmıyor mu, EMA doğru güncelleniyor mu, eşik mantığı beklenen senaryolarda doğru tetikleniyor mu — birim testleri.
3. **Küçük ölçekli nitel pilot** (mümkünse): birkaç gerçek kullanıcıyla kısa süreli kullanım, güven/anlaşılabilirlik/rahatsızlık odaklı görüşme — istatistiksel etkinlik iddiası için değil, kullanılabilirlik için.

---

## 18. What Can Be Tested With Synthetic Data

- Değişim-tespit algoritmasının (EMA+eşik veya EWMA/CUSUM) **bilinen enjekte edilmiş bir kalıcı trendi** doğru yakalayıp yakalamadığı.
- Aynı algoritmanın **saf gürültüye** (trend olmadan rastgele dalgalanma) yanlış pozitif üretme oranı.
- Adım büyüklüğü sınırının (bounded adaptation) gerçekten ihlal edilmediği.
- Farklı α/eşik parametrelerinin tespit gecikmesi ile yanlış-pozitif oranı arasındaki değiş-tokuşu (parametre duyarlılık analizi).

## 19. What Cannot Be Claimed With Synthetic Data

- Sistemin **gerçek kullanıcı davranışını** iyileştirdiği (adherence, goal completion artışı) — bu iddia için gerçek kullanıcı verisi ve zaman gerekir (HeartSteps 6 hafta/44 kişi bile "kesin" sonuç için yetersiz bulundu).
- Seçilen parametrelerin (eşik %, α, adım sınırı) **gerçek insan davranışı için doğru/optimal** olduğu — literatür bu sayıları vermiyor, sentetik veri de (tanım gereği varsayılan bir modelden üretildiği için) bunu doğrulayamaz, sadece "algoritma kendi varsayımlarıyla tutarlı davranıyor" diyebilir.
- Yapılandırılmış geri bildirim taksonomisinin **gerçek nedensel doğruluğu** — Weiner/Buehler literatürünün kendisi, insanların kendi başarısızlık nedenlerini **sistematik olarak yanlış** atfettiğini gösteriyor (örn. planning fallacy'de insanlar geçmiş gecikmeyi "dışsal, tek seferlik" nedenlere bağlama eğiliminde, oysa kalıp tekrarlıyor) — yani kullanıcının seçtiği kategori bile "gerçek" nedeni yansıtmayabilir, bu sistemin temel bir epistemik sınırlaması, sentetik veya gerçek hiçbir veriyle "çözülemez", sadece kabul edilebilir.
- Kullanıcı güveni/deneyimi — sadece gerçek kullanıcı etkileşimiyle ölçülebilir.

---

## 20. Red Team

Önerilen "EMA + eşik/kontrol-limiti + sınırlı adım" yapısına karşı kendi eleştirim:

**Neden bu yöntem, neden başkası değil?** Küçük veri, düşük hesaplama maliyeti, açıklanabilirlik ve Tasarım 1'in zaman kısıtı bunu zorunlu kılıyor — RL/bandit akademik olarak da (§11, HeartSteps veri ihtiyacı) savunulamaz.

**Bilimsel dayanağı ne?** EMA/exponential smoothing (Boyd ve arkadaşları, klasik forecasting literatürü) ve EWMA/CUSUM kontrol grafikleri (Schat et al. 2021, klasik SPC) **gerçek, iyi kurulmuş teknikler**. Ama "bu iki tekniğin bu spesifik kombinasyonu NotifyMe'nin probleminde en iyi seçimdir" diyen bir çalışma yok — bu bir **mühendislik sentezi**, doğrudan kopyalanan bir "kanıtlanmış yöntem" değil.

**Hangi varsayımlara dayanıyor?** (a) Kullanıcının planned/actual verisi dürüst ve tutarlı giriliyor (Personal Informatics literatürü bu varsayımın kırılgan olduğunu gösteriyor — §12). (b) Davranış kısa vadede durağan (stationarity) — gerçek hayatta (sınav dönemi, tatil, iş yükü değişimi) bu varsayım sık sık bozulur, EMA böyle ani rejim değişikliklerinde **yavaş tepki verir**, bu bir zayıflık. (c) Tek bir skaler (süre veya iş miktarı) görevin gerçek zorluğunu temsil ediyor — bu basitleştirme, gerçek karmaşıklığı (bilişsel yük, motivasyon, dış koşullar) kaybediyor.

**Hangi durumda başarısız olur?** Soğuk başlangıç (ilk 1-2 hafta, EMA'nın anlamlı olması için yeterli veri yok — açık bir fallback/varsayılan gerekiyor). Kullanıcı "oyun" oynarsa (her zaman "zamanım yetmedi" derse, daha kolay hedef almak için) — literatürde bu tür "gaming" riski JITAI/self-report literatüründe bilinen bir sorun, NotifyMe'nin planned-vs-actual **objektif** verisi bu riske kısmi bir denge sağlıyor ama tam çözmüyor. Gerçek rejim değişikliklerinde (dönem başı/sonu) EMA'nın doğal gecikmesi kullanıcıyı yanlış yönlendirebilir.

**Bu gerçekten "adaptasyon" mu, yoksa birkaç if/else mi?** Dürüst cevap: tanımlanan haliyle (EMA + sabit/kontrol-limitli eşik + sınırlı adım) bu, klasik kontrol/sinyal-işleme anlamında **gerçek bir adaptif filtre/kontrolördür** (düşük-geçiren filtre + deadband/hysteresis mantığı) — "öğrenilmiş" (ML) bir sistem değil ama **akademik anlamda "adaptif"** bir sistemdir, bu ikisi farklı şeyler. NotifyMe'yi "AI" olarak pazarlamak yanıltıcı olur; "adaptif kontrol/istatistiksel sinyal işleme tabanlı" olarak çerçevelemek **hem daha dürüst hem akademik olarak daha savunulabilir.**

**Hocanın "bu basit" eleştirisine teknik savunma:** JITAI alanının kendi literatürü (Nahum-Shani 2016/2025, Hardeman 2019) gerçek dünyada uygulanan JITAI'lerin çoğunun **basit, önceden tanımlanmış karar kuralları** kullandığını, karmaşık öğrenilmiş politikaların hâlâ istisna olduğunu gösteriyor — "basit başla" alan-standardı bir yaklaşım, kestirme değil. Ayrıca SPC/EWMA-CUSUM yöntemleri "basit" olmakla birlikte 70+ yıllık, endüstride hâlâ aktif kullanılan, matematiksel olarak iyi anlaşılmış tekniklerdir — "basit" ile "bilimsel temelsiz" eş anlamlı değildir.

---

## 21. Open Research Questions

- Kademeli adım büyüklüğü (step size) için NotifyMe'nin alanına özgü, ampirik olarak kalibre edilmiş bir oran nasıl bulunur (literatür yok, kullanıcı verisi gerekiyor)?
- Yapılandırılmış başarısızlık nedeni taksonomisinin (Weiner'ın 3 boyutuna haritalı) gerçek kullanıcılarda ne kadar doğru/tutarlı doldurulduğu test edilmeli.
- "Habituation" (HeartSteps bulgusu) NotifyMe'nin öneri sıklığı/formatında nasıl önlenir?
- Kullanıcının override'ının (Coactive Learning sinyali) küçük veri hacminde ne kadar güvenilir bir öğrenme sinyali olduğu — NotifyMe ölçeğinde (tek kullanıcı, ayda birkaç override) bu sorgulanmalı.
- Rejim değişikliği (dönem başı/sonu gibi) tespiti için EMA'nın yavaşlığını telafi eden bir mekanizma (örn. kullanıcının manuel "yeni dönem" işaretlemesi) gerekli mi?

## 22. Recommended Topics for Phase 2B

- **Self-report/ecological momentary assessment (EMA — psikolojideki anlamıyla, "experience sampling method") veri kalitesi ve gaming/social-desirability bias literatürü** — yapılandırılmış geri bildirimin güvenilirliği için.
- **Habit formation ve davranış-değişikliği sürdürülebilirliği** (alışkanlık oluşumu, "habituation to reminders" spesifik literatürü).
- **Sequential/hierarchical goal decomposition literatürü** (Goal→Task ayrımı, üst-seviye hedef ilerlemesinin alt-görev tamamlanmasından bağımsız izlenmesi — Aşama 1'de "Goal trajectory" olarak işaretlenen konu, akademik karşılığı proje yönetimi/earned-value-management literatüründe olabilir, IJRTE makalesinde geçen EVM bir başlangıç noktası).
- **Kullanıcı güveni ve algoritmik şeffaflık (explainable AI/recommender transparency)** — kullanıcıya "neden bu öneriyi veriyoruz" açıklamasının kabul oranına etkisi.
- **N=1 / single-case experimental design metodolojisi** — Tasarım 1'de gerçekçi bir değerlendirme stratejisi olarak, klasik RCT yerine tek-vaka deneysel tasarımların (ABAB, vb.) kişisel sağlık/davranış uygulamalarında nasıl kullanıldığı.

---

## Ek — Kullanılan Arama Sorguları

1. just-in-time adaptive interventions JITAI survey review paper
2. exponential moving average personalized task duration estimation online learning
3. dynamic treatment regimes sequential decision making adaptive intervention academic
4. contextual bandits mobile health behavior intervention personalization
5. human-in-the-loop personalization user override adaptive system interactive machine learning
6. systematic review just-in-time adaptive interventions JITAI Hardeman Naughton
7. HeartSteps micro-randomized trial physical activity mobile health Klasnja Murphy
8. adaptive learning intelligent tutoring system spaced repetition difficulty adjustment academic paper
9. planning fallacy Kahneman Tversky Buehler forecasting task completion time
10. goal setting theory Locke Latham difficulty level performance academic
11. attribution theory Weiner failure causes academic self-regulated learning
12. acute chronic workload ratio training load monitoring athlete injury academic sports science
13. change point detection trend versus noise behavioral time series statistical process control
14. safe reinforcement learning bounded step size gradual policy update constrained adaptation
15. learning from user corrections preference elicitation interactive recommender system override
16. Gollwitzer implementation intentions goal achievement academic
17. coactive learning Shivaswamy Joachims learning from manipulative user feedback slate
18. mixed-initiative user interfaces Horvitz principles human AI collaboration
19. personal informatics stage-based model reflection self-tracking Li Dey Forlizzi
20. cold start personalization small data Bayesian updating individual user behavior model

## Ek — İncelenen Çalışmalar (Ana Liste)

JITAI: Nahum-Shani & Murphy 2025; Nahum-Shani et al. 2016; Hardeman et al. 2019. DTR: Chakraborty & Murphy (PMC). MRT: Klasnja et al. 2015 (Health Psychology, tasarım); Klasnja et al. 2019 (Ann Behav Med, etkinlik); Qian et al. 2021 (arXiv, metodoloji). Bandit: Lei, Lu, Tewari, Murphy 2017 (arXiv). SPC: Schat et al. 2021 (Psychological Methods). EMA/smoothing: Boyd ve ark. (Stanford EWMM); IJRTE inşaat projesi makalesi; ProGem (IJACSA 2026). Spor bilimi: BMC Sports Science ACWR sistematik derleme 2025. Psikoloji: Buehler, Griffin & Ross 1994 ve 2002 bölümü (planning fallacy); Locke & Latham 2002 (goal-setting); Weiner 1985 (attribution); Gollwitzer 1999, Gollwitzer & Sheeran 2006 (implementation intentions). HCI: Shivaswamy & Joachims 2012/2015 (coactive learning); Horvitz 1999 (mixed-initiative UI); Li, Dey, Forlizzi 2010 (personal informatics). Kişiselleştirme/cold-start: çeşitli 2026 arXiv/ICML çalışmaları (CAPE/Pep, AdaptFuse) — bağlam olarak not edildi, doğrudan alan-transferi iddia edilmedi.

## Ek — Elenen/Zayıf Bulunan Kaynaklar ve Neden

- **Fuzzy logic, PID kontrol NotifyMe'nin alanına uygulanmış örnek:** aranan sorgularda net bir akademik kaynak çıkmadı — **doğrulanamadı**, dahil edilmedi.
- **SafeAdapt (sürekli RL güvenlik sertifikası, arXiv):** çok dar/yeni bir RL-güvenlik alt alanı, NotifyMe'nin insan-davranışı bağlamına aktarımı zorlama olur — sadece §9'da kısaca not edildi, derinlemesine kullanılmadı.
- **Genel "cold-start personalization" LLM makaleleri (CAPE/Pep, AdaptFuse, 2026):** gerçek, hakemli/ICML-kabul çalışmalar ama **problem alanı** (LLM tercih öğrenme, çok-boyutlu tercih uzayı) NotifyMe'nin (tek skaler süre/iş yükü) probleminden belirgin şekilde farklı — sadece "Bayesian yaklaşım küçük veride mantıklı" genel ilkesini desteklemek için referans verildi, doğrudan yöntem transferi iddia edilmedi.
- **Todoos/vscode-workspace-tasks EMA dokümantasyonu, termpulse Rust kütüphanesi:** akademik değil, yazılım aracı dokümantasyonu — sadece EMA'nın pratikte ne kadar yaygın/standart bir teknik olduğunu göstermek için (arama sonucu olarak) görüldü, rapora **kaynak olarak alınmadı.**

## Ek — Önemli Belirsizlikler

- Qian et al. (2021) makalesinin bu oturumda erişilen versiyonu arXiv preprint'ti; sonradan hakemli bir dergide (Psychological Methods olduğu genel bilgiyle biliniyor ama bu oturumda o nihai hakemli versiyona atıfla doğrulanmadı) yayımlanmış olabilir — **preprint olarak işaretlendi, nihai hakemli versiyon bu oturumda doğrulanmadı.**
- ACWR literatüründeki "doğru eşik" tartışmalı — 2025 meta-analizin **kendi sonucu** (etkili mi değil mi) bu raporda özetlenmedi, sadece yöntemin varlığı/tartışmalı doğası not edildi; tam sonuç için makalenin kendisi tekrar okunmalı.
- ProGem (IJACSA 2026) düşük-orta atıf sayılı, yeni bir dergide — kalite/güvenilirlik orta düzeyde değerlendirildi, "kanıtlanmış yöntem" olarak değil "ilginç paralel" olarak kullanıldı.
- Bazı makalelerin tam metnine değil, yalnızca Exa'nın "highlights" özetine erişildi — bu raporda aktarılan alıntılar bu özetlere dayanıyor, tam metin okunmadığı için bazı metodolojik detaylar (örn. tam istatistiksel model denklemleri) doğrulanamadı.

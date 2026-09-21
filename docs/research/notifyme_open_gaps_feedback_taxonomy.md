# NotifyMe — Open-Gaps Cleanup B: Failure Attribution Taxonomy + Feedback UX + Free-Text Value

**Tarih:** 2026-09-21
**Kapsam:** SADECE üç karar alanı — (1) kullanıcıdan hangi deviation/failure reason kategorileri istenmeli, (2) feedback hangi durumda/ne zaman sorulmalı, (3) optional free-text ve LLM gerçekten değer sağlıyor mu. Bu üç kararı doğrudan değiştirmeyen yeni sorular takip edilmedi, §20'ye (Future Work) kaydedildi (talimatın STOP RULE'ü, bkz. §2).
**Önceki raporlar (okundu, başlangıç bilgisi kabul edildi):** `notifyme_competitor_analysis_phase1.md`, `notifyme_academic_adaptation_closed_loop_phase2a.md`, `notifyme_academic_feedback_human_factors_phase2b.md` (özellikle Weiner attribution, self-serving bias d=0.96, outcome≠cause, tailoring-variable eşleştirmesi, EMA/JITAI timing, LLM sınıflandırma bulguları), `notifyme_academic_goal_trajectory_phase2c.md`, `notifyme_academic_evaluation_phase2d.md` (Claim→Evidence mantığı), `notifyme_open_gaps_data_fusion.md` (ölçülen sinyal vs self-reported sinyal terminolojisi, NO_INTERVENTION/ASK_USER, discrepancy-as-signal, Authority Inversion).
**Amaç:** NotifyMe'nin ad-hoc 9 kategorisini doğrulamak değil. Bu üç kararı Tasarım 1'de savunulabilir kılacak minimum kanıtı toplamak.

---

## 1. Executive Summary

Bu araştırmanın en önemli çerçeve-düzeltmesi: **"iyi bir taxonomy nasıl kurulur" sorusunun kendi altın-standardı var ve NotifyMe ona açıkça ulaşamaz.** Michie ve ark.'ın Behaviour Change Technique Taxonomy'si (BCTTv1, *Annals of Behavioral Medicine* 2013, DOI 10.1007/s12160-013-9486-6) — davranış-değişikliği literatüründe kanonik bir taxonomy inşa metodolojisi — 400 katılımcı, çok turlu Delphi paneli, açık-sıralama (open-sort) + hiyerarşik kümeleme, aylar süren inter-rater güvenilirlik testi gerektirdi. NotifyMe'nin failure-reason taksonomisi bu titizliğin hiçbirine ulaşamayacak (tek geliştirici, tek dönem) — bu, taksonominin **kaçınılmaz olarak "mühendislik hipotezi"** kalacağını, "ampirik olarak doğrulanmış taksonomi" değil, dürüstçe kabul edilmesi gereken bir sınır olduğunu gösteriyor. Bu, Aşama 2D'nin "false precision" temasının taksonomi tasarımındaki karşılığı.

İkinci büyük bulgu, promptun "actionability" sorusuna doğrudan teorik bir temel sağlıyor: **kategori sayısını "her kararı değiştiren ayrım kadar kaba tut" ilkesinin kendi bir karar-teorisi kanıtı var** — "The optimality of coarse categories in decision-making and information storage" (arXiv 1606.07529, karar teorisi) resmi olarak, karar-alma maliyetini minimize eden kriter yapısının **sadece kararı değiştiren ayrımları** kodladığını kanıtlıyor (ikili/binary kriterler verimlilik açısından optimal). Bu, "motivasyon düşüklüğü" ve "odaklanamadım" aynı adaptasyona gidiyorsa birleştirilmeli sezgisine **doğrudan matematiksel destek** veriyor — ama karşı-uyarı da güçlü: psikometri literatürü (Tsai, Wind & Estrada 2024, DOI 10.1080/15366367.2023.2288791; Nissen & Van Dusen, PERC) kategorileri **ampirik kanıt olmadan** birleştirmeye karşı uyarıyor — kategoriler gerçekten aynı şekilde kullanılıyor mu (seçilme oranı + davranışla korelasyon), yoksa sezgisel varsayım mı, bu ayrım net olmalı.

Üçüncü bulgu, feedback-zamanlaması sorusuna Aşama 2B'nin bulamadığı **hesaplamalı/formal** bir cevap ekliyor: JITA-EMA (Schneider, Junghaenel, Smyth, Wen & Stone, *Behavior Research Methods* 2023, DOI 10.3758/s13428-023-02083-8) ve "Ask Less, Learn More" (Li, Ponnada, Wang, Dunton & Intille, *ACM* 2024, DOI 10.1145/3699735) — her ikisi de "confidence yeterli olduğunda sormayı durdur" ilkesini formalize eden, gerçek algoritmalarla test edilmiş (ilkinde %40-54 soru azaltımı, doğruluk kaybı olmadan) çerçeveler. Bunun tam karşı-tarafı da bulundu: JMIR mHealth 2026 (e68735) tekrarlanan ölçümlerin zamanla **careless responding/straight-lining** ürettiğini gösteren bir viewpoint makalesi — "aynı nedeni üst üste soruyorsan kaliteyi düşürüyorsun" hipotezine doğrudan destek.

Dördüncü bulgu, free-text'in değerini **nicelleştiren** ilk doğrudan kanıt: Luebker (2020, DOI 10.12758/mda.2020.09) 22.306 kişilik gerçek bir deneyde, gömülü bir opsiyonel açık-metin kutusunun **her bir anlamlı yanıtına karşılık** ortalama 3.7 ek item-missing ve 0.1 ek break-off maliyeti olduğunu ölçmüş. Bu, "opsiyonel free-text bedavadır" varsayımını **doğrudan ve sayısal olarak** çürütüyor. Ama aynı zamanda Reja ve ark. (web survey deneyi) açık-metnin, önceden kodlanmış 10 kategoriye ek **8 yeni kategori** ortaya çıkardığını (yanıtların %63'ü bu yeni kategorileri kullandı) gösteriyor — free-text'in "taksonominin kaçırdığını yakalama" değeri de somut ve ölçülmüş.

Beşinci bulgu (LLM): Bu faz yeni bir LLM-evaluation araştırması açmadı (talimat gereği, Aşama 2B/2D zaten kapsamlı) — ama Cleanup A'nın Authority Inversion bulgusu (§25/1, arXiv 2605.23938) burada **doğrudan pekişiyor**: eğer LLM optional free-text'i sınıflandırırsa ve bu sınıflandırma davranışsal veriyle çelişirse, LLM'in kullanıcı lehine yanlı karar vereceği bilinen bir risk. Bu, LLM'in rolünün **çok dar** tutulması gerektiği sonucunu (Aşama 2B'nin zaten söylediği) güçlendiriyor: sadece serbest-metni yapılandırılmış bir öneri-etiketine eşleştiren, hakemlik yapmayan bir bileşen.

Genel sonuç: Önerilen taksonomi çekirdeği **küçük (4-6 kategori), outcome'dan ayrılmış, Weiner'ın locus/controllability mantığına dayalı ama kullanıcıya jargonla sorulmayan** bir yapı (Model B, §17); feedback **sadece anlamlı sapmada, kademeli olarak bastırılan** bir tetikleyiciyle sorulmalı; free-text **var olmalı ama opsiyonel ve düşük-maliyetli konumlandırılmalı** (ayrı sayfa/adım, gömülü değil — Luebker'in bulgusu); LLM **sadece bu opsiyonel metni yapılandırılmış etikete eşleştiren dar bir bileşen** olarak, hakem değil.

---

## 2. Scope and Stop Rule

Bu araştırma talimatın 0. ve 21. bölümlerindeki kesme kuralına uydu: yalnızca (1) taksonomi, (2) feedback trigger/timing, (3) free-text/LLM kararlarını etkileyen bulgular takip edildi. Araştırma sırasında ortaya çıkan ama bu üç kararı doğrudan değiştirmeyen sorular (§20'de listelendi) derinlemesine araştırılmadı. 7 hedefli Exa arama sorgusu çalıştırıldı (taksonomi tasarım metodolojisi, EMA soru-baskılama/adaptif uzunluk, açık-uçlu vs kapalı-uçlu değer karşılaştırması, "don't know" seçeneği literatürü, EMA'da bilgi-riski/mahremiyet, karar-teorisinde kategori birleştirme, serbest-metinden taksonomi keşfi), 6 önceki rapor okundu (2B ve Cleanup A tam, 2D ve 2C kısmi — kullanıcı talimatı gereği).

---

## 3. Attribution Theory Relevance

Weiner'ın locus/stability/controllability çerçevesi (2B §5) burada **tekrar araştırılmadı** — sadece taksonomi tasarımına uygulanışı derinleştirildi. 2B'nin kendi önerdiği 2x2 (içsel/dışsal × kontrol-edilebilir/edilemez) iskeleti burada **taksonomi tasarım kriterleriyle** (§4-5) çapraz kontrol edildi ve genel olarak tutarlı bulundu, ama "görev beklediğimden zordu" (task difficulty) için 2B'nin kendi işaretlediği "3. boyut gerekebilir, çözülmedi" açık sorusu bu faz kapsamında da **çözülmedi** — bu üç karardan hiçbirini bloklamıyor (Model B §17 bunu 3 boyutlu bir varyant olarak taşıyabilir), §20'ye taşındı.

---

## 4. Candidate Cause Taxonomies

**Taksonomi inşa metodolojisinin kendi altın standardı — ve NotifyMe'nin ona ulaşamayacağı.** BCT Taxonomy v1 (Michie ve ark., *Annals of Behavioral Medicine* 2013, DOI 10.1007/s12160-013-9486-6; ayrıca Cane, Richardson, Johnston, Ladha & Michie 2014, DOI 10.1111/bjhp.12102) 93 ayrık kategoriyi 400 uzmanla (14 ülkeden), Delphi paneli + açık-sıralama görevi + hiyerarşik küme analizi + iki turlu inter-rater güvenilirlik testiyle (adjusted kappa ≥0.60, 26 kategoride) inşa etti — aylar sürdü. **Bu, "iyi bir taksonomi" için gerçek maliyeti gösteriyor.** NotifyMe'nin 4-9 kategorilik failure-reason listesi bu sürece asla girmeyecek — bu bir eksiklik değil, **kapsam gerçeği**: taksonomi Tasarım 1'de "literatürden ilham alan, iç-tutarlı bir mühendislik hipotezi" olarak konumlandırılmalı, "ampirik doğrulanmış" olarak sunulmamalı.

2B'nin önerdiği 2x2 iskelet (İçsel×Dışsal × Kontrol-edilebilir/edilemez → 4 kullanıcı-dostu metin kategorisi) bu fazda **en savunulabilir çekirdek** olarak doğrulandı, üç ek not ile: (1) "Diğer" ve "Emin değilim" ayrı, zorunlu iki uç-kategori olarak eklenmeli (§10); (2) task-difficulty 5. bir kategori olarak (2x2'nin dışında, Weiner'ın orijinal modelindeki ayrı hücre) eklenmesi mantıklı, önceki fazın açık bıraktığı sorunun pratik çözümü — tam teorik temiz bir 3 boyutlu model yerine, 2x2 + 1 ek "görev zordu" seçeneği; (3) **kategori sayısı 4-6 arası tutulmalı** (2B §7'nin DeCastellarnau/Pokropek bulgusu — 4-7 arası genel eğilim — burada NotifyMe'nin mikro-etkileşim bağlamına, düşük-uç tercih edilerek uygulanıyor).

**Kanıt seviyesi:** Var — doğrulandı ki NotifyMe'nin taksonomi süreci akademik-rigor standardına ulaşamaz (kapsam gerçeği, itiraz edilemez); 2B'nin 2x2+task-difficulty önerisi bu fazda güçlendi, nihai kategori sayısı hâlâ mühendislik kararı.

---

## 5. Actionability Analysis

**En önemli yeni bulgu bu bölümde.** "The optimality of coarse categories in decision-making and information storage" (karar teorisi, arXiv 1606.07529) resmi bir teorem kanıtlıyor: karar-alma maliyetini minimize eden kriter yapıları, **sadece gerçek kararı ayırt eden** kategorilere sahip olmalı — daha ince ayrım, karar değişmiyorsa maliyeti artırıyor, faydası yok. Bu, promptun kendi sorduğu "motivasyon düşüklüğü ve odaklanamadım aynı müdahaleye gidiyorsa ayrı kategori gerekli mi" sorusuna **teorik olarak net bir "hayır"** veriyor — İKİ kategori aynı adaptasyon-yanıtına gidiyorsa birleştirilmeli, sadece "psikolojik olarak farklı" olmaları yetmiyor.

**Ama uygulamada dikkatli olunmalı — psikometri karşı-kanıtı:** Tsai, Wind & Estrada (2024, *Journal of Applied Measurement*, DOI 10.1080/15366367.2023.2288791) ve Nissen & Van Dusen (PERC, CLASS ölçeği vaka analizi) kategori birleştirmenin **ampirik kanıt olmadan** yapılmaması gerektiğini gösteriyor — "sezgisel olarak aynı görünüyor" yeterli değil, iki test önerilir: (1) her kategori gerçekten seçiliyor mu (seçilme oranı), (2) kategoriler davranışla/sonuçla farklı şekilde mi ilişkileniyor (point-biserial korelasyon benzeri). NotifyMe'nin erken aşamasında bu ampirik test yapılamaz (veri yok) — dolayısıyla **başlangıç birleştirmesi mühendislik varsayımına dayanmalı, ama açıkça böyle etiketlenmeli**, ve veri biriktikçe (kategori seçilme oranları) gözden geçirilmeye açık tutulmalı.

**2B'nin CAUSE→RESPONSE matrisi (§14, o rapor) burada doğrulandı ve netleşti:** TIME_SHORTAGE→süre artırma, TASK_HARDER→bölme/tahmin güncelleme, UNEXPECTED_EVENT→availability güncelleme (workload artırımı değil), FOCUS_PROBLEM→workload artırma **etmeme**, ESTIMATION_ERROR→gelecek tahmini güncelleme — bunların **her biri farklı bir eyleme** karşılık geliyor, yani coarse-category teoreminin gerektirdiği "her ayrım bir karar farkı yaratıyor" kriterini **karşılıyor**. Bu, 2B'nin mühendislik-varsayımı seviyesindeki eşleştirmesine bu fazda **teorik bir gerekçe** ekliyor (matematiksel kanıt, ampirik doğrulama değil).

**Kanıt seviyesi:** Var — doğrulandı (karar-teorisi ilkesi + kısmi psikometrik karşı-uyarı), NotifyMe'ye özgü ampirik doğrulama yapılmadı, açık kalıyor.

---

## 6. Outcome vs Cause

2B'nin bu ayrımı (§6, o rapor) **tekrar araştırılmadı** — talimat gereği. Bu fazın tek katkısı: outcome'un sistemden türetilebildiği durumda (task `status` alanı zaten var) kullanıcıya tekrar sormanın **redundant** olduğu ilkesi (2B §7) burada **UX akışına** somutlaştırıldı — "Planın %55'i gerçekleşti" gibi bir sistem-ifadesi + doğrudan "Neden?" mikro-sorusu, iki-adımlı bir akış yerine **tek adımda** (outcome zaten görünürken, sadece sapma varsa cause sorulur) sunulmalı. Bu, §7'deki "meaningful deviation" tetikleyicisiyle birleşiyor.

---

## 7. Feedback Trigger

Cleanup A'daki NO_INTERVENTION/ASK_USER çerçevesi (reject-option/selective-classification, Chow 1970'ten beri olgun literatür) burada **feedback isteme kararına** doğrudan uygulanıyor: aynı mantık — "yeterince emin değilsen/sinyal zayıfsa hiç sorma" — CAUSE sorusu sormaya da genellenebilir. Sayısal bir eşik ("neden %20") **bu fazda da üretilmedi**, talimatın kendi uyarısı gereği (Cleanup A'nın "keyfi eşik" sorunuyla aynı döngüye girilmedi). Bunun yerine önerilen ordinal/yapısal tetikleyiciler (Aşama 2A'nın EWMA/CUSUM temelli sapma-tespiti ile uyumlu): **small deviation → sorma; meaningful/persistent deviation → sor; repeated identical deviation → §9'daki bastırma mantığına geç.** Eşiğin kendisi (ne kadar sapma "meaningful") açık bırakılmalı, literatür-türetilmiş/mühendislik-parametresi/ampirik-kalibrasyon-parametresi olarak etiketlenmeli — kesin sayı üretilmedi (talimatın açık isteği).

**Kanıt seviyesi:** Var — doğrulandı (reject-option mantığının genellenebilirliği, kavramsal), NotifyMe'ye özgü sayısal eşik hâlâ açık (bilinçli olarak).

---

## 8. Timing and Burden

**Bu fazın en olgun, en doğrudan uygulanabilir bulgu grubu — 2B'nin bulamadığı formal bir cevap.**

**JITA-EMA** (Schneider, Junghaenel, Smyth, Wen & Stone, *Behavior Research Methods* 2023, DOI 10.3758/s13428-023-02083-8) — "stopping rule" kavramını formalize ediyor: sabit sayıda soru sormak yerine, **sınıflandırma kararı yeterli güvenle verilene kadar** soru sor, sonra dur (Computerized Adaptive Testing/CAT tabanlı). Gerçek verilerle test edilmiş: sabit-uzunluk anketle karşılaştırıldığında sınıflandırma doğruluğu korunurken soru sayısı %40-54 azaltılabiliyor. **NotifyMe'ye doğrudan uygulama:** CAUSE sorusu için tam bir CAT motoru aşırı mühendislik olur (tek soru zaten kısa), ama **ilke** — "sistem zaten yeterince emin olduğunda soru sorma" — §7'deki NO_INTERVENTION mantığıyla birebir örtüşüyor, formal bir emsal sağlıyor.

**"Ask Less, Learn More"** (Li, Ponnada, Wang, Dunton & Intille, *ACM IMWUT* 2024, DOI 10.1145/3699735) — soru-cevap bilgi-kazancını (information gain) modelleyip düşük-bilgi-kazançlı soruları atlıyor; gerçek EMA veri setlerinde rastgele-atlamaya göre %15-52 daha az imputation hatası. **NotifyMe'ye kavramsal aktarım:** eğer sistem son N gün boyunca kullanıcının hep aynı CAUSE'u verdiğini biliyorsa, o soru artık düşük-bilgi-kazançlı — bu doğrudan §9'daki habituation-bastırma mantığının **formal karşılığı**.

**Karşı-uyarı — tekrarlanan ölçümün kendi bozulma riski:** JMIR mHealth and uHealth 2026 (e68735, "Intensive, Repeated Self-Report Measures: Should We Be Concerned About Changes in Data Quality Over Time?") — aynı/benzer soruların tekrar tekrar sorulmasının zamanla **careless responding, straight-lining (hep aynı cevap), pratik-etkisiyle yanıt süresi kısalması, item-anlamının kayması** ürettiğine dair çok-kaynaklı kanıt derliyor. **NotifyMe için sonuç:** hem "her sapmada sor" (2B'nin zaten reddettiği) hem "aynı kategoriyi durmadan tekrar sor" riskli — ikisi de careless-responding üretebilir, §9'daki bastırma mekanizması sadece "kullanıcı yorulmasın" değil, **veri kalitesini korumak için de gerekli**.

**Kanıt seviyesi:** Var — doğrulandı, güçlü ve çok kaynaklı (formal algoritmik emsal + karşı-uyarı ampirik olarak da destekli).

---

## 9. Repeated Feedback / Habituation

§8'deki JITA-EMA/Ask-Less-Learn-More ilkeleri burada somutlaşıyor: **düşük-yüklü confirmation** ("Son günlerde genellikle zaman yetersizliği belirttin, bugün de aynı mı?") tasarımı, hem 2B'nin JITAI-tabanlı içerik-çeşitlendirme ilkesiyle (§11, o rapor) hem bu fazın bilgi-kazancı mantığıyla tutarlı — **tam sormaktan** (tekrar careless-responding riski) **hiç sormamaya** (bilgi kaybı) göre daha düşük maliyetli bir orta yol. Talimatın sorduğu "hiç sormamak mı daha doğru" sorusuna kesin cevap yok — bu bir tasarım tercihi, ama literatür (JMIR 2026) "hiç sormama"nın en azından **veri-kalitesi açısından** zararsız olduğunu, "sürekli sorma"nın zararlı olduğunu gösteriyor — yani varsayılan risk dengesi düşük-yüklü confirmation veya susma lehine.

**Kanıt seviyesi:** Var — doğrulandı (ilke transferi net), spesifik "kaç tekrardan sonra bastır" sayısı literatürden gelmiyor, mühendislik parametresi.

---

## 10. Other / Unsure

**Beklenmedik ve önemli bir karşı-bulgu — Cleanup A'nın uncertainty-lehine duruşuna nüans ekliyor.** Genel siyasi-tutum anketi literatüründe (Krosnick ve ark. 2002; Elkjær & Wlezien 2024, DOI 10.1017/psrm.2024.42; Kuha, Butt, Katsikatsou & Skinner 2017, DOI 10.1080/01621459.2017.1323640) "Don't Know" (DK) seçeneğinin veri kalitesini **otomatik olarak iyileştirmediği**, bazen sadece **satisficing'i** (düşük-çaba kısayolu) teşvik ettiği gösteriliyor — Krosnick'in klasik bulgusu: DK seçeneği sunulduğunda over-time tutarlılık ve tahmin geçerliliği **artmıyor**. Ama Elkjær & Wlezien (2024) bunu kısmen düzeltiyor: DK seçeneğinin etkisi **bilgi seviyesine bağlı** — düşük-bilgili yanıtlayıcılarda (NotifyMe bağlamında: kullanıcı gerçekten nedeni bilmiyorsa) DK'nin rastgele-yanıt yanlılığını azalttığı, yüksek-bilgili yanıtlayıcılarda ise satisficing riskinin baskın olduğu gösteriliyor.

**NotifyMe'ye uygulanabilirlik sınırlı ama önemli bir uyarı taşıyor:** bu literatür genel tutum/bilgi sorularına dayanıyor, NotifyMe'nin "bu görev neden başarısız oldu" sorusu **davranışsal/episodik bir hatırlama sorusu**, tutum sorusu değil — doğrudan genellenmiyor. Ama ilke aktarılabilir: "UNSURE" seçeneğinin **her zaman veri kalitesini iyileştireceği varsayımı sorgulanmalı**, kör biçimde "belirsizlik dürüstlüğü artırır" denemez. Census Bureau 2025 çalışma raporu (rsm2025-05) ayrıca **"tahmin et" talimatının** ("eğer emin değilsen en iyi tahminini ver") bazı bağlamlarda "I'm not sure" checkbox'ından **daha az missing data** ürettiğini gösteriyor — NotifyMe'de "tahmin etmeye teşvik" + "gerçekten bilmiyorsan Diğer/Belirsiz'i seç" ikisinin birlikte sunulması (checkbox'ı zorunlu değil, en son sırada opsiyonel) bir orta yol olabilir.

**"OTHER" için ayrı kanıt:** Schwarz & Hippler'in klasik bulgusu (1991 bölümü; Bradburn 1983) — "Diğer" kategorisi **nadiren kullanılıyor** (genellikle <5%) — bu onu değersiz yapmıyor (kapsam-tamlığı garantisi sağlıyor, Reja ve ark.'ın açık-metin bulgusuyla tutarlı: kaçırılan kategoriler varsa yakalanmalı), ama "Diğer oranı yüksekse taksonomi kötü" sezgisinin **eşiği** literatürden gelmiyor — mühendislik yorumu.

**D/E sorularının cevabı:** OTHER — evet gerekli (düşük maliyetli, kapsam-tamlığı sağlıyor, Reja ve ark. destekliyor). UNSURE — **koşullu evet**, ama "her zaman veri kalitesini iyileştirir" varsayımıyla değil; NotifyMe'nin episodik/davranışsal soru tipi genel tutum-DK literatüründen farklı olduğu için literatür buraya tam güvenle genellenmiyor — dahil edilmesi öneriliyor (kullanıcıyı sahte bir kategoriye zorlamamak daha büyük risk) ama "DK oranı = veri kalitesi göstergesi" gibi bir yorum yapılmamalı.

**Kanıt seviyesi:** Var — doğrulandı ki DK-etkisi kör-iyi değil koşullu (siyasi-tutum literatüründen); NotifyMe'nin davranışsal-episodik bağlamına doğrudan transfer **dolaylı**, sınırlı güven.

---

## 11. Single vs Multiple Causes

Bu alt-başlık için adanmış, NotifyMe-benzeri bir literatür bu oturumda derinlemesine bulunamadı (kapsam/zaman kısıtı, STOP RULE gereği yeni bir dal açılmadı) — dolaylı kanıt: §4'teki BCT Taxonomy metodolojisi ve genel survey-design pratiği, "birden fazla neden aynı anda geçerli olabilir" durumunda **multi-select'in kavramsal olarak daha doğru** olduğunu ima ediyor (bir görevin başarısızlığı gerçekten çok-nedenli olabilir — promptun kendi örneği: "görev zordu + beklenmedik kesinti"), ama cognitive-load maliyeti (Schwarz & Hippler, response-alternatives literatürü, §12) doğrulanmış. **Minimum savunulabilir yaklaşım:** single-choice + "birden fazlaysa Diğer'e yaz" (free-text'e devret) — bu, multi-select'in UI karmaşıklığından kaçınırken çok-nedenli durumları tamamen kaybetmiyor, free-text'in §12'deki "taksonominin kaçırdığını yakalama" rolüyle tutarlı bir iş bölümü.

**Kanıt seviyesi:** Belirsiz — doğrudan literatür bulunamadı, mühendislik önerisi (free-text'e devretme) dolaylı olarak §12 ile tutarlı.

---

## 12. Free-Text Value

**Bu fazın en somut, en sert sorgulanan ve en net cevaplanan bölümü.**

**Değer — evet, ölçülmüş ve gerçek:** Reja, Manfreda, Hlebec & Vehovar (RIS 2001 web-survey deneyi) — açık-uçlu soru, 10 önceden-kodlanmış kapalı kategoriye ek **8 yeni kategori** ortaya çıkardı; açık-uçlu yanıtlayıcıların **%63'ü** bu ek kategorileri kullandı. Bu, "taksonomi kaçınılmaz olarak eksik olacak" (§4'ün sonucu) gerçeğiyle birleştiğinde, free-text'in **taksonominin kaçırdığını telafi etme** rolünün somut ve ölçülmüş olduğunu gösteriyor. Schwarz & Hippler (1991) klasik bulgusu da tutarlı: kapalı-format listelenmemiş bir görüş **neredeyse hiç** raporlanmıyor (respondents "question constraint" varsayımına uyuyor) — yani kapalı-kategori-only tasarım, taksonominin kendi kör noktalarını asla göremez.

**Maliyet — evet, ölçülmüş ve göz ardı edilemez:** Luebker (2020, DOI 10.12758/mda.2020.09) — 22.306 kişilik gerçek deney, gömülü (embedded) tasarımda **her anlamlı açık-metin yanıtına karşılık ortalama 3.7 ek item-missing + 0.1 ek break-off**; sayfa-ayırma (paging) tasarımında bu maliyet çok daha düşük (kapalı soruya etkisi yok, sadece 0.2 break-off/anlamlı-yanıt). **Doğrudan tasarım sonucu:** free-text kutusu **kapalı sorunun aynı ekranına gömülmemeli**, ayrı bir opsiyonel adım/ekran olarak sunulmalı — bu, maliyeti önemli ölçüde düşürüyor (Luebker'in kendi sonucu). Neuert, Meitinger & Behr (2021, DOI 10.1177/00491241211031271) ayrıca açık-uçlu probun **daha fazla tema çeşitliliği ve daha yüksek nonresponse** ürettiğini doğruluyor — evrensel bir bulgu, tek bir çalışmaya özgü değil.

**Sentez — O sorusunun (2B'de "belirsiz" bırakılmıştı) cevabı:** **Free-text NotifyMe V1 için gerekli, ama sadece opsiyonel + ayrı-adım (gömülü değil) konumlandırılırsa maliyeti düşük tutulabilir.** Free-text olmadan taksonominin kaçırdığı ~%15-20'lik (Reja'nın oranına yakın bir tahmin, NotifyMe'ye genellenmemiş) yeni-kategori bilgisi kaybolur — bu, "Diğer" oranının izlenmesi ve §14'teki dinamik-taksonomi olasılığıyla birlikte düşünülmeli. Fowler/Couper'ın (MDA dergisi, "Methodological Uses of Responses to Open Questions") sistematik listesi ayrıca free-text'in **7 farklı meşru kullanımını** (kategori-listesi doğrulama, soru-işlevi test etme, hata kontrolü — 2B'nin kendi hatasını bulduğu gibi — vb.) sıralıyor; NotifyMe için en alakalı ikisi: kategori-listesi genişletme (§14) ve "kod-kontrolü" (kapalı kategori doğru mu işaretlendi, tutarlılık kontrolü).

**Kanıt seviyesi:** Var — doğrulandı, çok kaynaklı ve nicel (hem değer hem maliyet ölçülmüş, tasarım önerisi doğrudan literatürden çıkıyor).

---

## 13. LLM Value

Bu bölüm yeni bir LLM-evaluation araştırması açmadı (STOP RULE, 2B/2D zaten kapsamlı) — sadece §12'nin free-text kararıyla birleştirilerek dar bir soru cevaplandı: **eğer free-text var ve opsiyonelse, onu kim/ne işler?**

2B'nin bulgusu (küçük/sabit kategori setinde basit anahtar-kelime/kural-tabanlı sınıflandırıcı muhtemelen yeterli, LLM'in avantajı büyük/nüanslı kategori setinde ortaya çıkıyor) burada **değişmedi**. Cleanup A'nın Authority Inversion bulgusu (arXiv 2605.23938 — LLM'ler sayısal kanıta karşı kullanıcının doğal-dil iddiasını sistematik tercih ediyor) ile birleştirildiğinde, **LLM'in olası tek meşru rolü netleşiyor: sadece kullanıcının yazdığı serbest-metni önceden tanımlı yapılandırılmış kategorilerden birine (veya "yeni tema" işaretine) eşlemek — davranışsal veriyle serbest-metin arasındaki herhangi bir çelişkiyi çözme yetkisi OLMADAN.** Bu, LLM'i "dar bir metin-sınıflandırma aracı" olarak konumlandırıyor, "hakem" veya "karar verici" değil — Cleanup A'nın Model B'siyle (rule-based + ordinal confidence) tam tutarlı.

**A) No free-text/no LLM — B) opsiyonel free-text, sadece sakla — C) +kural/anahtar-kelime işleme — D) +LLM sınıflandırma karşılaştırması (talimatın §13'ü):** 2B'nin kendi verisiyle (200-500 örnek doygunluk noktası, NotifyMe'nin erken aşamada bu hacme ulaşamayacağı) B veya C en savunulabilir başlangıç noktaları — D (LLM) yalnızca free-text hacmi arttığında (kategori keşfi/§14 ile birlikte) gerekçelendirilebilir, **Tasarım 1'in ilk sürümünde değil**. Bu, promptun kendi uyarısıyla ("LLM'i sırf hocaya 'AI var' diyebilmek için seçme") doğrudan tutarlı.

**M/N sorularının cevabı:** LLM'in en dar savunulabilir görevi — opsiyonel free-text'i mevcut yapılandırılmış kategorilerden birine (veya "eşleşmiyor/yeni tema" bayrağına) eşlemek, hiçbir çelişki-çözme veya karar-verme yetkisi olmadan. LLM olmadan (kural/keyword tabanlı) güçlü bir sistem kurulabilir — 2B'nin fine-tuned-small-model bulgusu ve bu fazın "Tasarım 1'de veri hacmi LLM'in avantajını gerekçelendirmiyor" sonucu birleşince, **evet, LLM olmadan başlamak daha savunulabilir**.

**Kanıt seviyesi:** Var — doğrulandı (2B+Cleanup A'nın sentezi, bu fazda yeni birincil kaynak aranmadı — talimat gereği).

---

## 14. Taxonomy Discovery vs Fixed Taxonomy

**Bulunan, promptta beklenenden daha olgun bir literatür — ama NotifyMe ölçeğinin çok üzerinde.** "Interactive Taxonomy Development with Hybrid Methods" (Qu, Gopinathan, Akbar & Alonso, 2026, DOI 10.1145/3786304.3787912), InsightNet (ACL/EMNLP-Industry 2023, arXiv 2405.07195) ve BEATS (arXiv 2606.04909) — e-ticaret/müşteri-geri-bildirimi bağlamında, topic-modeling + LLM kümeleme ile **binlerce-milyonlarca** serbest-metin yorumdan yeni taksonomi düğümleri otomatik keşfeden, insan-onaylı (human-in-the-loop) üretim sistemleri. InsightNet 10K yorumdan ~200 yeni kategori keşfetmiş (%20'si taksonomide yoktu).

**NotifyMe'ye uygulanabilirlik: açıkça future work.** Bu sistemler embedding-tabanlı kümeleme, çok sayıda annotator, üretim-ölçeği veri gerektiriyor — NotifyMe'nin tek-kullanıcı erken aşamasında (muhtemelen onlarca free-text girişi, binlerce değil) bu altyapı orantısız. **Ama kavramsal ilke basit bir yaklaşıklıkla taşınabilir:** "Diğer" kategorisi seçildiğinde eşlik eden free-text'i **manuel olarak periyodik gözden geçirme** (aylık/dönemlik) — eğer aynı tema tekrar tekrar çıkıyorsa, yeni bir yapılandırılmış kategori adayı olarak işaretlenir. Bu, açık-kodlama (open coding)/tematik-analiz'in (nitel araştırma metodolojisi, kullanıcının kendi önerdiği) **insan-elle, düşük-hacimli** bir versiyonu — otomatik pipeline değil, ama akademik olarak meşru bir yöntem (grounded theory'nin temel prensibi).

**Kanıt seviyesi:** Var — doğrulandı ki otomatik taksonomi-genişletme olgun bir alan; NotifyMe ölçeğinde tam otomasyon önerilmiyor, manuel-periyodik inceleme öneriliyor (future work'e yakın ama Tasarım 1'de "süreç" olarak, araç olarak değil, uygulanabilir).

---

## 15. Privacy / Data Minimization

Serbest-metin alanlarının hassas bilgi (sağlık, ilişki, psikolojik durum) taşıma riski, EMA etik literatüründe **"informational risk"** olarak resmi bir kategori (Roth, Rossi, Goldshear ve ark., *Substance Use & Misuse* 2017, DOI 10.1080/10826084.2016.1264969) — "kimliklendirilmiş bir bireyle ilgili bilginin ifşasından kaynaklanan zarar potansiyeli", psikolojik/fiziksel/sosyal risklerden **ayrı** bir kategori olarak tanımlanıyor. Bu literatür ağırlıklı olarak yüksek-riskli popülasyonlarda (uyuşturucu kullanımı, intihar riski) çalışılmış — NotifyMe'nin genel-amaçlı üretkenlik bağlamına **doğrudan genellenmiyor**, ama ilke aktarılabilir: bir alanın "opsiyonel" olması, riski otomatik olarak ortadan kaldırmıyor — kullanıcı yine de kendiliğinden hassas bilgi yazabilir (promptun kendi örnekleri: sağlık, ilişki, iş).

**Data minimization ilkesiyle bağlantı (hukuki danışmanlık verilmiyor, sadece mühendislik ilkesi):** Android geliştirici güvenlik rehberi (endüstri standardı, akademik değil ama teknik olarak sağlam) LLM'e gönderilen veride "yalnızca görevi yerine getirmek için kesinlikle gerekli olanın" toplanmasını öneriyor — bu, §13'teki "LLM sadece dar bir sınıflandırma görevi yapar" kararıyla doğrudan uyumlu: LLM'e gönderilen metin, sınıflandırma için gerekli minimum bağlamla sınırlı tutulmalı, kalıcı olarak LLM sağlayıcısında saklanmamalı/loglanmamalı (uygulama detayı, bu raporun kapsamı dışı).

**Free-text'in değeri (§12) ek maliyete değer mi?** Bu soru, genel bir "evet/hayır" ile cevaplanamaz — **maliyet düşük tutulabilir** (opsiyonel, ayrı-adım konumlandırma §12, sınırlı LLM erişimi §13, periyodik/manuel inceleme §14 — otomatik büyük-ölçekli analiz değil) ve **fayda ölçülmüş** (Reja'nın %63'ü) olduğu için, mevcut tasarım kısıtlarıyla (opsiyonel + minimal-erişim) **dengelenmiş** kabul edilebilir — ama bu bir mühendislik yargısı, literatürden çıkan kesin bir eşik değil.

**Kanıt seviyesi:** Var — doğrulandı ki "informational risk" ayrı, meşru bir risk kategorisi (dolaylı transfer, yüksek-risk popülasyon literatüründen); NotifyMe'ye özgü risk/fayda dengesi mühendislik yargısı.

---

## 16. Adaptation Connection

Zincir (MEASURED OUTCOME → FEEDBACK TRIGGER → USER CAUSE → UNCERTAINTY CHECK → ADAPT/NO_INTERVENTION/ASK_USER → USER ACCEPT/REJECT/MODIFY) bu fazın bulgularıyla **tutarlı** ve Cleanup A ile **doğrudan uyumlu**: FEEDBACK TRIGGER adımı §7-9'daki reject-option/bilgi-kazancı mantığını kullanır; USER CAUSE adımı §4-5-10-11'deki taksonomi+OTHER/UNSURE+single-choice kararlarını uygular; free-text/LLM (§12-13) bu zincirin **CAUSE→UNCERTAINTY CHECK** arasına, sadece etiketleme amaçlı, düşük-yetki bir ek girdi olarak eklenir — Authority Inversion riski nedeniyle asla UNCERTAINTY CHECK veya ADAPT kararının kendisini yönetemez. **Spesifik cause→adaptasyon eşleştirmeleri (§5) çoğunlukla mühendislik hipotezi** kalıyor — bu fazda bu durumu değiştiren yeni bir kanıt bulunmadı (2B'nin kendi sonucu tekrar doğrulanıyor, derinleştirilmedi).

---

## 17. Evaluation

Aşama 2D'nin Claim→Evidence mantığı burada tekrar üretilmedi (STOP RULE), sadece bu fazın kendi çıktılarına uygulandı: **Taksonomi için** — category coverage, "Diğer" oranı, "Emin değilim" oranı sentetik/pilot veriyle izlenebilir (Evet, ölçülür), ama "taksonomi doğru mu" iddiası (bir kategorinin "gerçek" nedeni yansıttığı) **kanıtlanamaz** (2B'nin self-serving-bias uyarısıyla aynı sınır). **Feedback UX için** — response rate, completion time, abandonment küçük bir pilotla ölçülebilir (Evet), Luebker'in metodolojisi (break-off/item-missing oranı) doğrudan bir şablon sağlıyor. **LLM için** — eğer eklenirse (§13, Tasarım 1'de önerilmiyor), 2B'nin zaten önerdiği (100-250 elle etiketlenmiş örnek, Kappa/macro-F1, keyword-baseline karşılaştırması) burada tekrar üretilmedi, geçerliliğini koruyor.

---

## 18. Candidate Models

Nihai model seçilmiyor (talimat gereği) — üç aday, Cleanup A'nın Model A/B/C isimlendirmesiyle **çakışmaması için** farklı harflendirildi.

### MODEL X — Minimal Structured
Sadece anlamlı sapmada tetiklenen, **tek-seçim** (single-choice) 4-6 kategorilik CAUSE listesi (2x2 Weiner iskelet + task-difficulty + Diğer + Emin değilim) + **free-text yok**.
- **User flow:** outcome zaten görünür (status alanından) → sapma varsa tek soru, kategori seç, bitir.
- **Taxonomy:** 6 kategori (§4), sabit.
- **Trigger:** §7'deki reject-option mantığı, sadece meaningful/persistent deviation.
- **Free-text:** Yok.
- **LLM role:** Yok.
- **Adaptation input:** Doğrudan CAUSE→RESPONSE matrisi (2B §14).
- **Burden:** En düşük.
- **Privacy:** En düşük risk (yapılandırılmış veri, hassas serbest-metin yok).
- **Evaluation:** Deterministic + küçük pilot (response rate).
- **Implementation complexity:** Düşük.
- **Scientific defensibility:** Orta — taksonomi mühendislik-hipotezi ama şeffaf, free-text'in kaçırdığı kategoriler (§12, %63'lük Reja bulgusu) kaybediliyor, bu açıkça bir sınır.
- **Tasarım 1 feasibility:** Yüksek.

### MODEL Y — Structured + Optional Context (önerilen orta yol)
Model X + **opsiyonel, ayrı-adım** (gömülü değil, Luebker'in bulgusu) free-text alanı, **sadece saklanır, işlenmez** (LLM/kural yok) — C sorusundaki "B" seçeneğine karşılık gelir.
- **User flow:** kategori seçildikten sonra, ayrı bir ekranda "eklemek istediğin bir şey var mı? (opsiyonel)".
- **Taxonomy:** Model X ile aynı + "Diğer" seçildiğinde free-text **teşvik edilir** (zorunlu değil).
- **Trigger:** Model X ile aynı.
- **Free-text:** Var, opsiyonel, ayrı-adım, sadece kaydedilir.
- **LLM role:** Yok (bu sürümde) — periyodik **manuel** inceleme (§14) ile "Diğer" temaları taksonomi revizyonuna girdi sağlar.
- **Adaptation input:** Model X ile aynı; free-text sadece insan (geliştirici) tarafından, offline okunur — canlı karar mekanizmasına girmez.
- **Burden:** Düşük-orta (ayrı-adım tasarımı Luebker'in ölçtüğü maliyeti minimize ediyor).
- **Privacy:** Orta (serbest-metin var ama LLM/3.parti işleme yok, yalnızca yerel/geliştirici tarafından okunur).
- **Evaluation:** Model X + "Diğer" oranı, free-text doldurma oranı izlenir.
- **Implementation complexity:** Düşük-orta.
- **Scientific defensibility:** Yüksek — hem §4'ün "taksonomi eksik olacak" gerçeğini kabul ediyor hem §12'nin ölçülmüş maliyet/fayda dengesini (ayrı-adım, opsiyonel) doğru uyguluyor, hem Authority Inversion riskini (LLM yok) tamamen bertaraf ediyor.
- **Tasarım 1 feasibility:** Yüksek-orta.

### MODEL Z — LLM-Augmented
Model Y + free-text'in **dar** bir LLM bileşeniyle (sadece mevcut kategorilerden birine eşleme veya "yeni tema" bayrağı, §13) otomatik ön-işlenmesi.
- **User flow:** Model Y ile aynı, kullanıcıya görünmez fark.
- **Taxonomy:** Model Y + LLM'in önerdiği "yeni tema adayları" periyodik olarak taksonomiye eklenebilir (§14'ün hafifletilmiş versiyonu).
- **Trigger:** Model Y ile aynı.
- **Free-text:** Var, LLM ile otomatik etiketlenir (yapılandırılmış kategoriye eşleme veya "eşleşmiyor").
- **LLM role:** Dar, hakem değil (§13, §16) — asla ADAPT/NO_INTERVENTION kararını etkilemez, sadece taksonomi-bakım/raporlama girdisi.
- **Adaptation input:** Model Y ile aynı (LLM çıktısı adaptasyon kararına girmez, sadece geliştirici-görünür raporlamaya).
- **Burden:** Kullanıcı için Model Y ile aynı (görünmez işleme).
- **Privacy:** En yüksek risk — free-text 3. parti LLM API'sine gönderiliyorsa (yerel model değilse) §15'teki data-minimization ilkesi ihlal riski.
- **Evaluation:** 2B'nin LLM-evaluation gereksinimleri (100-250 etiketli örnek, Kappa) — bu hacme Tasarım 1'de ulaşmak gerçekçi değil, **evaluation'ın kendisi zayıf kalır**.
- **Implementation complexity:** Orta-yüksek (API entegrasyonu, prompt tasarımı, evaluation seti).
- **Scientific defensibility:** Düşük-orta — 2B'nin "200-500 örnek doygunluk" bulgusu ve bu fazın "veri hacmi gerekçelendirmiyor" sonucu göz önüne alınınca, LLM'in katma değeri **Tasarım 1 ölçeğinde kanıtlanamaz**, "AI kullanmak için AI kullanmak" riski taşıyor.
- **Tasarım 1 feasibility:** Düşük — **önerilmiyor**, Model Y'nin manuel-inceleme versiyonu aynı faydayı (taksonomi bakımı) çok daha düşük maliyet/riskle sağlıyor.

**Nihai seçim yapılmıyor (talimat gereği)** ama **Model Y en dengeli ve en savunulabilir aday**; Model Z'nin Tasarım 1 ölçeğinde gerekçelendirilemediği açıkça belirtiliyor (Cleanup A'nın Model C'sine paralel bir "açıkça gerçekçi değil" sonucu).

---

## 19. Red Team

| # | Varsayım | Kanıt | Karşı-kanıt | Belirsizlik | Risk | NotifyMe'ye etkisi |
|---|---|---|---|---|---|---|
| 1 | Kullanıcı gerçek failure cause'u bilir | — | 2B: self-serving bias d=0.96 (tekrar üretilmedi, referans) | Düşük | **ÇOK YÜKSEK** | Taksonomi cevapları objektif veriyle çapraz okunmalı (Cleanup A) |
| 2 | Daha fazla kategori daha iyi veri verir | Zengin ayrım = detay | §5: coarse-category teoremi — kararı değiştirmeyen ayrım maliyet, fayda yok; §4: 4-7 arası öneri | Orta | **ORTA** | 4-6 kategoriyle sınırlı tutulmalı |
| 3 | Her cause farklı adaptation gerektirir | 2B'nin CAUSE→RESPONSE matrisi | §5: bazı cause'lar (motivasyon/odaklanamadım) aynı yanıta (NO_INTERVENTION) gidebilir — o zaman birleştirilmeli | Orta | **ORTA** | Matris + coarse-category testiyle kategori sayısı gözden geçirilmeli |
| 4 | Her başarısız task sonrası feedback sorulmalıdır | Sezgisel | §8: JITAI resource-efficiency + JMIR 2026 careless-responding riski — ikisi de tersini gösteriyor | Düşük | **YÜKSEK** | Sadece meaningful deviation'da sor (Model X/Y) |
| 5 | Immediate feedback her zaman weekly feedback'ten iyidir | EMA recall-bias literatürü (2B) genel olarak destekliyor | Bu fazda doğrudan test edilmedi — genelleme aktarılıyor, NotifyMe'ye özgü değil | Yüksek | **DÜŞÜK-ORTA** | 2B'nin genel sonucu (momentary > retrospective) burada da geçerli varsayılıyor, doğrulanmadı |
| 6 | Tek cause seçmek yeterlidir | §11: cognitive-load düşük | Çok-nedenli durumlar (promptun kendi örneği) kaybedilir | Yüksek | **ORTA** | Single-choice + free-text'e devretme (Model Y) dengeleyici |
| 7 | Multi-select her zaman daha doğrudur | Zengin veri | §11: doğrudan kanıt bulunamadı, cognitive-load literatürü tersini ima ediyor | Yüksek | **DÜŞÜK-ORTA** | Multi-select Tasarım 1'de önerilmiyor |
| 8 | "Other" kötü taxonomy göstergesidir | Sezgisel | §10: Bradburn 1983 — "Diğer" zaten nadiren seçiliyor (<%5), düşük oran normaldir, kapsam-tamlığı garantisi olarak değerli | Düşük | **DÜŞÜK** | "Diğer" oranı tek başına taksonomi kalitesi metriği olarak kullanılmamalı |
| 9 | "I don't know" değersiz cevaptır | — | §10: koşullu — düşük-bilgili durumda faydalı, ama kör "iyi" varsayımı da yanlış (Krosnick satisficing) | Orta | **ORTA** | UNSURE dahil edilmeli ama veri-kalitesi göstergesi olarak abartılmamalı |
| 10 | Free-text structured category'den daha zengindir, dolayısıyla daha iyidir | §12: Reja'nın %63'lük bulgusu zenginliği destekliyor | §12: Luebker'in 3.7 item-missing/yanıt maliyeti — "daha zengin" "daha iyi" ile eş değil, maliyet-fayda dengesi gerekli | Düşük | **ORTA** | Free-text opsiyonel+ayrı-adım (maliyeti düşürerek) dahil edilmeli, zorunlu değil |
| 11 | Free-text varsa LLM gerekir | Yaygın varsayım | §13: manuel/kural-tabanlı işleme (Model Y) aynı temel faydayı (saklama+periyodik inceleme) LLM'siz sağlıyor | Düşük | **ORTA-YÜKSEK** | Model Z Tasarım 1'de önerilmiyor |
| 12 | LLM classification rule baseline'dan otomatik olarak iyidir | — | 2B: fine-tuned-small > zero-shot LLM, küçük veri setinde; bu fazda 200-500 örnek eşiğine NotifyMe'nin ulaşamayacağı teyit edildi | Düşük | **YÜKSEK eğer varsayılırsa** | LLM'in üstünlüğü Tasarım 1 ölçeğinde kanıtlanamaz |
| 13 | LLM kullanmak Tasarım 1'i otomatik olarak teknik olarak güçlendirir | Yaygın varsayım | Cleanup A + bu faz: LLM'in Authority Inversion riski + veri-hacmi yetersizliği — güçlendirme yerine risk ekleyebilir | Düşük | **YÜKSEK eğer varsayılırsa** | "AI var" hedef değil (talimatın kendi son uyarısı) |
| 14 | Feedback vermemek kullanıcının ilgisiz olduğunu gösterir | Sezgisel | Cleanup A §16 (MNAR literatürü): sessizlik bir sinyal olabilir ama kesin değil, "muhtemelen zor gün" gibi düşük-güvenle yorumlanmalı | Yüksek | **ORTA** | Feedback vermeme nötr sayılmamalı ama kesin de varsayılmamalı |
| 15 | Cause→adaptation mapping bilimsel olarak doğrudan kanıtlanmıştır | 2B'nin JITAI tailoring-variable çerçevesi (genel destek) | 2B §14: spesifik eşleştirmeler büyük ölçüde mühendislik varsayımı — bu fazda değişmedi | Düşük | **YÜKSEK eğer iddia edilirse** | Matris "engineering hypothesis" olarak açıkça etiketlenmeli (§16) |
| 16 | Taxonomy'nin ilk sürümü kusursuz olmalıdır | — | §4: BCT Taxonomy'nin kendisi bile aylar süren iteratif süreçle kuruldu; §14: dinamik-keşif (manuel-periyodik) mekanizması zaten "ilk sürüm kusursuz değil" varsayımıyla tasarlandı | Düşük | **DÜŞÜK** | İlk taksonomi açıkça "v1, revize edilecek" olarak konumlandırılmalı |

---

## 20. Phase 3 Decision Table

**A.** En savunulabilir çekirdek: Weiner'ın locus×controllability 2x2'si + task-difficulty + Diğer + Emin değilim (§4).
**B.** Kesin bilimsel sayı yok; 4-7 arası genel eğilim, NotifyMe'nin mikro-etkileşim bağlamında **düşük uç (4-6)** tercih ediliyor (§4, §5).
**C.** Single-choice, çok-nedenli durumlar free-text'e devredilir (§11).
**D.** Evet, OTHER gerekli — düşük maliyetli, kapsam-tamlığı garantisi (§10).
**E.** Koşullu evet, ama "veri kalitesini otomatik iyileştirir" varsayımıyla değil (§10).
**F.** Hayır, her task sonrası sorulmamalı (§8-9, JITAI + JMIR 2026 çift kanıtlı).
**G.** Meaningful/persistent deviation'da (§7) — sayısal eşik literatürden gelmiyor, mühendislik parametresi.
**H.** Bu fazda doğrudan test edilmedi; 2B'nin genel EMA-momentary-bias bulgusu (immediate > çok-gecikmeli) aktarılıyor, doğrulanmadı.
**I.** Bilgi-kazancı temelli bastırma (§8-9, JITA-EMA/Ask-Less-Learn-More ilkesi) — "son N günde aynı cevap → düşük-yüklü confirmation veya sorma".
**J.** Evet, gerekli — Reja'nın %63'lük yeni-kategori bulgusu (§12), ama zorunlu değil.
**K.** Evet, opsiyonel + **ayrı-adım** (gömülü değil — Luebker'in ölçtüğü maliyet farkı, §12).
**L.** Tasarım 1'in ilk sürümünde hayır (§13) — veri hacmi (200-500 örnek eşiği, 2B) yok, Authority Inversion riski (Cleanup A) var.
**M.** Eğer eklenirse: sadece free-text'i yapılandırılmış kategoriye/"yeni tema"ya eşleyen dar bir bileşen, hiçbir çelişki-çözme/karar yetkisi olmadan (§13, §16).
**N.** Evet — kural/keyword-tabanlı + manuel periyodik inceleme (Model Y) aynı temel faydayı (taksonomi bakımı) sağlıyor (§13-14, §18).
**O.** Evidence-based: outcome≠cause ayrımı, self-serving-bias uyarısı, tailoring-variable genel çerçevesi (2B). Engineering hypothesis: spesifik CAUSE→RESPONSE hücreleri (2B §14, bu fazda coarse-category teoremiyle kısmen güçlendirildi ama ampirik doğrulanmadı, §5).
**P.** Category coverage/Diğer-oranı/Unsure-oranı + response-rate/completion-time/abandonment (Luebker'in metodolojisi) ile — 2D'nin Claim→Evidence sınırları içinde (§17).
**Q.** Model X (Minimal) ve Model Y (Structured+Optional Context, önerilen) — Model Z (LLM-Augmented) Tasarım 1 ölçeğinde gerekçelendirilemediği için taşınması önerilmiyor (§18).

---

## 21. Future Work / Limitations

Bu üç kararı (taksonomi, timing, free-text/LLM) doğrudan değiştirmeyen, bu fazda derinlemesine araştırılmayan sorular (STOP RULE gereği):

- **Task-difficulty'nin 2x2'ye nasıl tam oturacağı** (3 boyutlu model mi, ayrı 5. kategori mi) — 2B'de açık bırakıldı, bu fazda da çözülmedi (§3).
- **Immediate vs daily/weekly feedback timing'in NotifyMe'ye özgü ampirik testi** — 2B'nin genel EMA bulgusu aktarılıyor ama doğrulanmadı (§7, Red Team #5).
- **Multi-select vs single-choice'ın NotifyMe-benzeri bir uygulamada doğrudan karşılaştırması** — adanmış literatür bulunamadı (§11).
- **Ampirik kategori-birleştirme testi** (seçilme oranı + davranış-korelasyonu, §5) — NotifyMe'de veri toplanmadan yapılamaz, ürün olgunlaştıkça (kategori kullanım istatistikleri biriktikçe) yapılmalı.
- **"Diğer" free-text'inin periyodik manuel incelemesi için somut bir eşik/süreç** (kaç girişte bir gözden geçirilecek, kim yapacak) — Tasarım 1'de bir süreç kararı, bu fazda önerilmedi.
- **Data minimization'ın Türkiye-spesifik hukuki gereksinimleri** — bu rapor hukuki danışmanlık vermiyor, mühendislik ilkesi (§15) düzeyinde kaldı.

---

## 22. Sources / Search Queries / Weak Sources

**Kullanılan arama sorguları (bu fazda, 7):**
1. taxonomy design closed-ended response categories mutually exclusive actionable behavior change intervention
2. ecological momentary assessment prompt reduction adaptive skip repeated same answer question suppression habituation
3. open-ended versus closed categories added value survey research information content comparison
4. "don't know" "not sure" response option survey data quality nonresponse forced choice satisficing
5. privacy risk sensitive disclosure free text journaling app self-tracking data minimization optional field
6. qualitative free text self-report data privacy risk re-identification sensitive disclosure ecological momentary assessment ethics
7. decision-relevant categories merge collapse response options no difference in action value of information tailoring
8. emergent category discovery from open-ended user feedback iterative taxonomy refinement thematic analysis product design

**Yüksek-güven kaynaklar:** Michie ve ark. 2013 (*Annals of Behavioral Medicine*, DOI 10.1007/s12160-013-9486-6); Schneider ve ark. 2023 (*Behavior Research Methods*, DOI 10.3758/s13428-023-02083-8); Li ve ark. 2024 (ACM IMWUT, DOI 10.1145/3699735); Luebker 2020 (DOI 10.12758/mda.2020.09); Neuert, Meitinger & Behr 2021 (DOI 10.1177/00491241211031271); Elkjær & Wlezien 2024 (DOI 10.1017/psrm.2024.42); Kuha ve ark. 2017 (DOI 10.1080/01621459.2017.1323640); Tsai, Wind & Estrada 2024 (DOI 10.1080/15366367.2023.2288791); Roth ve ark. 2017 (DOI 10.1080/10826084.2016.1264969).

**Orta-güven / pratisyen-ağırlıklı kaynaklar (akademik değil ama teknik olarak kullanışlı, açıkça etiketlendi):** Android Developers güvenlik rehberi (§15, endüstri kaynağı, peer-review yok); GitHub/pratisyen journaling-app örnekleri (§15 aramasında dönen, kullanılmadı — düşük kalite, rapora dahil edilmedi); Census Bureau 2025 çalışma raporu (rsm2025-05, kurumsal ama henüz hakemli yayın değil).

**Doğrulanamayan/zayıf kaynaklar:** arXiv 1606.07529 ("optimality of coarse categories") — preprint, hakemli yayın durumu bu oturumda teyit edilmedi, ama karar-teorisi alanında iyi bilinen bir sonucu formalize ediyor gibi görünüyor, dikkatle kullanıldı. Qu ve ark. 2026 (DOI 10.1145/3786304.3787912) — çok yeni (2026), atıf sayısı doğrulanamadı.

**Kaynak uydurma yok, tüm DOI'ler metinden ayrıştırıldı; tam-metin erişilemeyen kaynaklar (çoğu, Exa "highlights" üzerinden okundu) yukarıda belirtildiği gibi işaretlendi.**

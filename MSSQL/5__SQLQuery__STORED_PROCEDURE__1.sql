
--          STORED PROCEDURE (SAKLI YORDAM)

--    C++  ve  C#  programlarýndaki  'VOID'  kavramýna benzer bir yapýdýr.

--    Saklý yordamlar belli bir iþlevi yerine getirmek için kullanýlan kod parçacýklarýdýr.

--    Veritabanýnda CRUD gibi iþlemlerde, her seferinde kodu tekrar yazmamýz ve derlememiz gerekmektedir. Durum böyle
-- olunca hem zaman hem de derleme açýsýndan perormans kaybý olmaktadýr.
-- Bu gibi durumlarda Saklý Yordam (Store Procedure), programlamada kullanýlan ifadelere göre kod yazmamýzý saðlar.
-- Böylece her seferinde ayný iþlemleri yapma gereksinimi duymadan zamandan tasarruf etmiþ oluruz. Örnek verecek
-- olursak, veritabanýnda belli tarihler aralýðýnda müþteriye ait sipariþleri listemelek istediðimiz, SELECT SQL
-- kodunu yazmak yerine sadece tarih aralýðý ve müþteri numarasý verilerek listeme gerçekleþtirilmesi örnek olarak
-- verilebilir.

--    Saklý Yordam, giriþ (input) parametreleri alarak, çaðrýldýðýnda çýktý (output) deðeri döndürür.
--    Veritabanýnda iþlemler gerçekleþtirebileceðimiz BEGIN…END, IF ELSE, WHILE, LOOP, REPEAT, BREAK, CONTINUE, CASE
-- gibi ifadeler ile kullanýlabilir.
--    Bir defa derledikten sonra, tekrar derlemeye gerek kalmaz. Veritabanýnda derlenmiþ bir execution plan halinde
-- saklanýr.
--    Hata kontrolü yapmak için TRY-CATCH yapýsý ile birlikte kullanýlabilir.
--    'User-defined (UDF)' fonksiyonlara benzer. Ancak temel fark, 'UDF'’ler diðer SQL ifadeleri ile çaðrýlýrken,
-- Saklý Yordamlar 'CALL' ifadesi kullanýlarak çaðrýlýr.


--          Nerelerde Kullanýlýr ?
--    Tekrar kullanýlabilirliði saðlamak istediðimizde kullanýlýr. Modülerlik saðlayarak, bir defa oluþturulan
-- fonksiyonnu istediðimiz kadar çaðýrabiliriz.
--    Daha hýzlý yürütme (execution) istediðimizde kullanýlýr. Çünkü kod ilk çalýþtýrýldýðýnda derlenir, daha sonra
-- sadece hafýzada saklanan execution plan halini kullanarak, tekrar derlenme ve optimizeye ihtiyaç duymamaktadýr.
--    Að trafiðini azaltmak istediðimizde kullanýlýr. Saklý Yordam SQL ifadelerini að ortamýna çoklu göndermek yerine,
-- toplu olarak çalýþtýrabilir. Böylece trafiði azaltýp performans artýlýr.
--    Daha iyi veri güvenliði saðlar. Kullanýcýlarýn saklý yordam ifadelerini doðrudan çalýþtýrma izni olmadan, Saklý
-- Yordam’da izin verilerek güvenlik saðlanýr.


--          Yeni Bir Stored Procedure Oluþturma (CREATE PROCEDURE)
-- (1)
--    Yeni bir Saklý Yordam oluþturmak istediðimizde ,  "CREATE PROCEDURE"  komutu ve sonrasýnda Yordam ismi yazýlýr ,
-- sonrasýnda ;  "@"  iþareti ile , kullanýlacak parametreler tanýmlanýr. Saklý Yordam ismi ve parametreler
-- tanýmlandýktan sonra ,  "AS"  ifadesiyle devam edilip  "BEGIN"  ve  "END"  ifadeleri arasýnda Saklý Yordam'da
-- yapýlmak istenen sorgu yazýlýr.

-- (2)
--    "Stored Procedure" oluþturmak için baþka bir yöntem daha vardýr. Solda , öncelikle üzerinde çalýþmak istediðimiz
-- Data Sete geliyoruz. Orada  'Programmability'  klasörüne týklýyoruz. Sonrasýnda da  'Stored Procedures'  klasörüne
-- Sað týklayarak  'New'  butonundan sonra ortaya çýkan  'Stored Procedure'  butonuna týklýyoruz...
-- Bu butonlara týkladýðýmýzda , Hazýr 'Stored Procedure' Taslaðý için yeni bir çalýþma sayfasý oluþacaktýr...



--          Saklý Yordam Çalýþtýrma (EXECUTE Store Procedure)
--    Oluþturduðumuz Saklý Yordamý çalýþtýrmak istediðimizde  "EXEC"  komutunu kullanýrýz.


--          Saklý Yordam Güncelleme (ALTER Store Procedure)
--    Daha önce oluþturduðumuz Saklý Yordam üzerinde deðiþiklik yapmak istediðimizde ,  "ALTER"  ifadesi kullanýlýr.
-- "ALTER PROCEDURE"  ifadesinden sonra güncellemek istediðimiz Saklý Yordam ismi ve güncelleme sorgusu yazýlýr.


--          Saklý Yordam Silme (DROP Store Procedure)
--    Kullanýlmayan Saklý Yordam yapýsýnýn silinmesi istendiðinde ,  "DROP"  ifadesi kullanýllýr. "DROP PROCEDURE"
-- ifadesinden sonra droplamak istenilen Saklý Yordamýn ismi yazýlýr. Sorgu çalýþtýrýldýðýnda yordamýn silinmesi
-- gerçekleþir.


--          ENCRYPTED Saklý Yordam (ENCRYPTED Store Procedure)
--    Saklý Yordamýn düzenlenebilirliðini kapatmak için þifreleme iþlemi uygulanýr. Þifrelenen Saklý Yordam üzerinde
-- artýk kendimiz dahi deðiþiklik yapamayýz. Bu nedenle , Þifreli Saklý Sordam oluþtururken kodlarýnýn da yedeðini
-- bir yerde saklamamýz ileride deðiþiklik yapmak istediðimizde gerekli olabilir. Þifreli Saklý Yordam , Normal Saklý
-- Yordam oluþturur gibi ancak ilaveten , parametrelerden sonra  "WITH ENCRYPTION"  ifadesi eklenerek oluþturulur.


--          RECOMPILE Saklý Yordam (RECOMILE Store Procedure)
--    Oluþturulan Saklý Yordamlar genelde  'Plan Cache'’de  saklanýr. Ancak ,  "RECOMPILE"  ifadesiyle oluþturulan
-- Saklý Yordamlar  'Plan Cache'’de  saklanmaz , her çalýþtýrýldýðýnda yeniden oluþturulur. Alýnan parametrelere göre
-- deðiþik  'Query Plan'’lar  oluþturuluyorsa , bu tür Saklý Yordam kullanýlabilir. Böylece her çalýþtýrýldýðýnda
-- yeniden  'Query Plan'  oluþturulur. "RECOMPILE Saklý Yordam" , Normal Saklý Yordam oluþturur gibi ancak ilaveten ,
-- parametrelerden sonra  "WITH RECOMPILE"  ifadesi eklenerek oluþturulur.



--          -ÖRNEK-
--    Mesela bir kullanýcý kaydýný sildirdi ve biz de o kullanýcýnýn kiþisel bilgilerini silip anonim hale getirmek
-- istiyoruz. Bunun için ne yapmalýyýz ?
--    Mesela "11076" Customer Key'li kullanýcý kaydýný sildirdi. Önce bu kullanýcýyý görelim , daha sonra da
-- anonimleþtirme iþlemini gerçekleþtirelim... ::


DECLARE @CustomerKey VARCHAR(50) = 11076
SELECT [CustomerKey]
      ,[Prefix]
      ,[FirstName]
      ,[LastName]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[EmailAddress]
      ,[AnnualIncome]
      ,[TotalChildren]
      ,[EducationLevel]
      ,[Occupation]
      ,[HomeOwner]
FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
WHERE [CustomerKey] = @CustomerKey


--    ** unknown == Bilinmez , Bilinmeyen , Bilinmiyor , Tanýnmýyor. **


--    Anonimleþtirme Güncellemesi ::

DECLARE @CustomerKey VARCHAR(50) = 11076
UPDATE [AdventureWorks1].[dbo].[AdventureWorks_Customers]
SET [FirstName] = 'Unknown'  ,  [LastName] = 'Unknown'  ,  [EmailAddress] = 'Unknown'  ,  [BirthDate] = GETDATE()
WHERE [CustomerKey] = @CustomerKey


--    Güncelleþtirme Notlarý ::

----    NOTE  :  UPDATE (GÜNCELLEME) yaparken 10 defa düþünün 1 defa yapýn !  Geriye dönüþ çok zor !
----    NOTE  :  "UPDATE" komutundan sonra , güncelleme yapmak istediðimiz Tablonun ismini yazýyoruz.
----    NOTE  :  "SET" komutundan sonra , hangi deðer güncellenecekse o deðer veya deðerleri yazýyoruz.
----    NOTE  :  "WHERE" komutundan sonra , neye göre güncelleme yapacaðýmýzý yazýyoruz.


--    Ayrýca HAZIR Güncelleme Kodlarýna da ulaþabiliriz... Bunun için ; Soldaki , Güncelleme yapmak istediðimiz
-- Tabloya Sað týklýyoruz (Mesela , 'AdventureWorks_Customers' tablosu). Sonrasýnda "Script Table as"  butonuna
-- týklýyoruz. Oradan da hangi iþlemi gerçekleþtirmek istiyorsak ona týklýyoruz , biz Güncelleme istediðimiz için
-- "UPDATE To"  butonuna týklayacaðýz. En son da  "New Quary Editor Window" butonuna týklayarak , Güncelleme
-- yapacaðýmýz Tablo için hazýr Güncelleme Kodlarýna ulaþmýþ oluyoruz...

--    Ulaþtýðýmýz Hazýr Güncelleme Kod Taslaðýný kopyalayýp buraya yapýþtýracaðýz... Gereksiz olan kolon isimlerini de
-- direkt sileceðiz... "DECLARE" komutu ekleyeceðiz... "WHERE" komutunu da düzenleyeceðiz... ::

DECLARE @CustomerKey VARCHAR(50) = 11075

UPDATE [dbo].[AdventureWorks_Customers]
   SET
       [Prefix] = 'Unknown'
      ,[FirstName] = 'Unknown'
      ,[LastName] = 'Unknown'
      ,[BirthDate] = GETDATE()
      ,[EmailAddress] = 'Unknown'
 WHERE [CustomerKey] = @CustomerKey


----    NOTE  :  Mesela bazý Tablolarda ; Telefon Numarasý , Kimlik Numarasý , ... gibi bilgi 'kolonlarý' vardýr. Böyle
----    bilgilerin tutulduðu Tablolar da muhakkak baþka tablolara Baðýmlýdýrlar... Böyle bilgilerin tutulduðu
----    "Kolonlar" da ; Sol tarafta , ilgili Tablonun içindeki 'Columns' klasörünün içerisinde ,  "Anahtar Kilidi"
----    emojisi ile gösterilir...

----    NOTE  :  Baðýmlýlýklarý görmek için de ; bakmak istediðimiz Tabloya Sað týklayarak , 'View Dependencies'
----    butonuna týklarýz. Buna týkladýðýmýzda ; bir Tablodaki 'Kolonun' , baþka hangi Tablo veya Tablolar ile baðýmlý
----    olduðunu görürüz...

----    NOTE  :  Bu Baðýmlý olan Kolonlarda anonimleþtirme iþlemi yapmak için farklý bir iþlem yapmamýza gerek yoktur.
----    Yine yukarýda yaptýðýmýz iþlemlere benzer þekilde çalýþabiliriz...
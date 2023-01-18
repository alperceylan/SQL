
--    Aþaðýda yazdýðýmýz Sorgu bloðu , Veri Setimizdeki kullanýcýlarýn 'Burçlarýný' bulduðumuz bir bloktur...

--    ** horoscope == Burç. **



--    Birden çok kiþi bir arada çalýþýyoruz. Bu durumda muhtemelen hepimiz benzer mimaride sorgular yazacaðýz.
-- Eðer ki bazý kompleks sorgularý bir kere yazýp sonrasýnda bunlarýn sonuçlarýný bir yere yazdýrýp kullanmak
-- istiyorsak , bir analiz yapmak istiyorsak veya bunu önce bir TABLO'ya basýp sonrasýnda analiz yapmak istiyorsak ;
-- bunlar için birden fazla metod kullanýrýz... ::::::::::



-- (1)
--    Eðer ki o sorguya , tam þu anda ve bir kerelik ulaþmak istiyorsak , yani ileride , hiçbir þekline ihtiyacýmýz
-- olmayacaksa , sadece  "INTO"  komutunu kullanýrýz... Bu sorguya herkes eriþebilir... :

  ----    NOTE  :  'INTO' komutunu , 'FROM' komutundan hemmen önce kullanmamýz gerekiyor... Yani , bir üstündeki
  ----    satýrda kullanmalýyýz.

SELECT TOP (1000) [CustomerKey] , [Prefix] , [FirstName] , [LastName] , [BirthDate] ,
	CASE 
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000321' AS DATETIME) AND CAST('19000419' AS DATETIME) THEN 'Ares'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000420' AS DATETIME) AND CAST('19000520' AS DATETIME) THEN 'Taurus'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000521' AS DATETIME) AND CAST('19000620' AS DATETIME) THEN 'Gemini'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000621' AS DATETIME) AND CAST('19000722' AS DATETIME) THEN 'Cancer'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000723' AS DATETIME) AND CAST('19000822' AS DATETIME) THEN 'Leo'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000823' AS DATETIME) AND CAST('19000922' AS DATETIME) THEN 'Virgo'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000923' AS DATETIME) AND CAST('19001022' AS DATETIME) THEN 'Libra'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001023' AS DATETIME) AND CAST('19001121' AS DATETIME) THEN 'Scorpio'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001122' AS DATETIME) AND CAST('19001221' AS DATETIME) THEN 'Sagittarius'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19010101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001222' AS DATETIME) AND CAST('19010119' AS DATETIME) THEN 'Capricorn'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000120' AS DATETIME) AND CAST('19000219' AS DATETIME) THEN 'Aquarius'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000220' AS DATETIME) AND CAST('19000320' AS DATETIME) THEN 'Pisces'
	END AS [Horoscope]
	INTO ITUmindset_INTO     -- <-----
  FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
  WHERE YEAR([BirthDate]) > 1940

  ----    NOTE  :  Bu komut ile Soldaki , içinde çalýþtýðýmýz Veri Setinin (AdventureWorks1) içerisindeki - 'Tables'
  ----    bloðunun içerisinde , 'INTO' komutu ile oluþturduðumuz Fiziksel Tabloyu görebiliriz...

  ----    NOTE  :  Bu 'INTO' komutunun bu þekilde kullanýmýnýn avantajý ; bir kereye mahsus oluþturulmuþ bir Tablo
  ----    olduðu için , güncel bir veri deðiþimi olduðunda ondan etkilenmez... Bundan dolayý rahatlýkla üzerinde
  ----    deðiþiklikler yapabiliriz...

  ----    NOTE  :  Bir baþka avantajý da ; ekip olarak bu Tablo veya Tablolara hepimiz eriþebiliriz... Ama bu tablolar
  ----    güncel bir durumda deðildirler...

  ----    NOTE  :  Bu 'INTO' komutunun bu þekilde kullanýmýnýn dezavantajý da ; bu iþlemi birkaç defa yaptýðýmýzda ,
  ----    diskte her biri yer kaplayacaktýr ve programý yavaþlatýr. Ayný zamanda Tablo kirliliði de oluþabilir...




-- (2)
--    Eðer tek baþýmýza bir Data Set üzerinde çalýþýyorsak ve kimsenin bu çalýþmayý görmesini istemiyorsak veya
-- kimsenin görmesine gerek yoksa da ;  "INTO"  komutundan sonra  "#" (hashtag)  ekleyerek devam ediyoruz...
--    Yani 'TEMP TABLE' haline getirmiþ oluyoruz... Ve bu þekilde bu Tablo ; Soldaki  "Databases"  klasörünün
-- içerisinde  "System Databases"  klasörünün içerisindeki  "tempdb"  deposunun içerisindeki  "Temporary Tables"
-- içerisinde saklanýyor... :

  SELECT TOP (1000) [CustomerKey] , [Prefix] , [FirstName] , [LastName] , [BirthDate] ,
	CASE 
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000321' AS DATETIME) AND CAST('19000419' AS DATETIME) THEN 'Ares'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000420' AS DATETIME) AND CAST('19000520' AS DATETIME) THEN 'Taurus'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000521' AS DATETIME) AND CAST('19000620' AS DATETIME) THEN 'Gemini'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000621' AS DATETIME) AND CAST('19000722' AS DATETIME) THEN 'Cancer'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000723' AS DATETIME) AND CAST('19000822' AS DATETIME) THEN 'Leo'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000823' AS DATETIME) AND CAST('19000922' AS DATETIME) THEN 'Virgo'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000923' AS DATETIME) AND CAST('19001022' AS DATETIME) THEN 'Libra'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001023' AS DATETIME) AND CAST('19001121' AS DATETIME) THEN 'Scorpio'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001122' AS DATETIME) AND CAST('19001221' AS DATETIME) THEN 'Sagittarius'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19010101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001222' AS DATETIME) AND CAST('19010119' AS DATETIME) THEN 'Capricorn'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000120' AS DATETIME) AND CAST('19000219' AS DATETIME) THEN 'Aquarius'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000220' AS DATETIME) AND CAST('19000320' AS DATETIME) THEN 'Pisces'
	END AS [Horoscope]
	INTO #ITUmindset_INTO     -- <-----
  FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
  WHERE YEAR([BirthDate]) > 1940

  ----    NOTE  :  Mesela , bu yukarýdaki Sorguyu tamamen comment içerisine alarak tekrar çalýþtýrýp , sonra da tekrar
  -- aþaðýdaki gii SELECT yazýp bu  "hashtag"'li  Tabloyu çaðýrdýðýmýzda , istediðimiz gibi iþlemler yapabiliyoruz...
  -- Mesela aþaðýda sadece , Soyadý  'YANG'  olan kullanýcýlarý gösterelim ::

  SELECT * FROM #ITUmindset_INTO where LastName = 'YANG'

  ----    CRITICAL NOTE  :  Bu uygulamanýn dezavantajý ; 'Database Administrator (DBA)' çalýþanlarý bunu yapmamýzý
  ----    istemezler. Çünkü bu tabloyu silmeyi unutursak ,  "tempdb"  deposunda yoðun bir þiþme olabilir... Bunun için
  ----    bütün iþlemleri yaptýktan sonra  'DROP TABLE'  komutunu kullanarak bu Tabloyu silmemiz gerekiyor...
  ----    Hatta 'Temp Table' oluþturuyorsak , bu yukarýdaki kodu yazmadan önce de DROP TABLE kullanabiliriz...

  DROP TABLE #ITUmindset_INTO


  ----    NOTE  :  Bu 'INTO' komutunun "hashtag" ile kullanýmýnda ; baþka bir kiþi bu Tabloyu göremediði gibi biz de ,
  ---- baþka bir sayfada dahi bu Tabloyu göremeyiz... Sadece ve sadece KOD satýrýný yazdýðýmýz sayfanýn içerisinde
  ---- kullanabiliriz...




-- (3)
--    Diyelim ki , sorgumuzun herkesin kullanabileceði bir yapýda olmasýný istiyoruz. Ayný zamanda sorgunun sonuçlarý
-- deðiþtikçe de , gelsin kendisi deðiþsin yani güncellensin istiyoruz... Bunun için ise "Views" oluþturmalýyýz...

--    "View" dediðimiz þey ; verileri Fiziksel bir Tabloda deðil de 'Sanal' bir Tabloda tutan yapýlardýr...

--    Bunu yapmak için de ; Soldaki Veri Setimizin içerisine gelip (AdventureWorks1) ,  "Views"'e  Sað týklayýp , 
-- "New View"'e  basmamýz gerekiyor...
-- Sonrasýnda oradan bir Tablo seçip baðlayabiliriz... Ama biz seçmeyip , yazdýðýmýz sorguyu kopyalayýp  "View"'in
-- içerisindeki  "SELECT - FROM"  kýsmýna yapýþtýracaðýz... Sonrasýnda da ; yukarýsýndaki boþluða Mousenin Sol tuþu
-- ile bir defa týkladýðýmýzda , Tablo veya Tablolarý görebiliyor olacaðýz...

--    Bu "View" sürecini kullanarak ; görsel olarak Tablolar arasýndaki iliþkileri ve baðlantýlarý görebilir , daha iyi
-- analiz edebiliriz...

--    Bu yarattýðýmýz "View"'i kaydedebiliriz... Ve kaydettikten sonra da Soldaki "Views" klasörünün içerisine gidip ,
-- yarattýðýmýz 'View''e Sað týklayarak çalýþtýrabiliriz...
-- Ve Çalýþtýrdýktan sonra da gördüðümüz gibi ; FROM'dan sonra , Veri Setimizin içerisinde Tablo ismi deðil de
-- yarattýðýmýz 'View''in ismi yazýyor...

  ----    NOTE  :  Avantajý ; arka-plandaki datalar güncellendikçe sisteme baðlý olan herkes , en güncel halini
  ----    görebilir.

  ----    NOTE  :  Dezavantajý ; yavaþtýr. Çok kompleks sorgularý çalýþtýrýrken çok zaman kaybý olabilir... Ama aþþýrý
  ----    kompleks bir sorgunuz yoksa da kullanýlmasý avantajdýr... Daha kolay analizler yapabiliriz...
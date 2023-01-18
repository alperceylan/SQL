
--    A�a��da yazd���m�z Sorgu blo�u , Veri Setimizdeki kullan�c�lar�n 'Bur�lar�n�' buldu�umuz bir bloktur...

--    ** horoscope == Bur�. **



--    Birden �ok ki�i bir arada �al���yoruz. Bu durumda muhtemelen hepimiz benzer mimaride sorgular yazaca��z.
-- E�er ki baz� kompleks sorgular� bir kere yaz�p sonras�nda bunlar�n sonu�lar�n� bir yere yazd�r�p kullanmak
-- istiyorsak , bir analiz yapmak istiyorsak veya bunu �nce bir TABLO'ya bas�p sonras�nda analiz yapmak istiyorsak ;
-- bunlar i�in birden fazla metod kullan�r�z... ::::::::::



-- (1)
--    E�er ki o sorguya , tam �u anda ve bir kerelik ula�mak istiyorsak , yani ileride , hi�bir �ekline ihtiyac�m�z
-- olmayacaksa , sadece  "INTO"  komutunu kullan�r�z... Bu sorguya herkes eri�ebilir... :

  ----    NOTE  :  'INTO' komutunu , 'FROM' komutundan hemmen �nce kullanmam�z gerekiyor... Yani , bir �st�ndeki
  ----    sat�rda kullanmal�y�z.

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

  ----    NOTE  :  Bu komut ile Soldaki , i�inde �al��t���m�z Veri Setinin (AdventureWorks1) i�erisindeki - 'Tables'
  ----    blo�unun i�erisinde , 'INTO' komutu ile olu�turdu�umuz Fiziksel Tabloyu g�rebiliriz...

  ----    NOTE  :  Bu 'INTO' komutunun bu �ekilde kullan�m�n�n avantaj� ; bir kereye mahsus olu�turulmu� bir Tablo
  ----    oldu�u i�in , g�ncel bir veri de�i�imi oldu�unda ondan etkilenmez... Bundan dolay� rahatl�kla �zerinde
  ----    de�i�iklikler yapabiliriz...

  ----    NOTE  :  Bir ba�ka avantaj� da ; ekip olarak bu Tablo veya Tablolara hepimiz eri�ebiliriz... Ama bu tablolar
  ----    g�ncel bir durumda de�ildirler...

  ----    NOTE  :  Bu 'INTO' komutunun bu �ekilde kullan�m�n�n dezavantaj� da ; bu i�lemi birka� defa yapt���m�zda ,
  ----    diskte her biri yer kaplayacakt�r ve program� yava�lat�r. Ayn� zamanda Tablo kirlili�i de olu�abilir...




-- (2)
--    E�er tek ba��m�za bir Data Set �zerinde �al���yorsak ve kimsenin bu �al��may� g�rmesini istemiyorsak veya
-- kimsenin g�rmesine gerek yoksa da ;  "INTO"  komutundan sonra  "#" (hashtag)  ekleyerek devam ediyoruz...
--    Yani 'TEMP TABLE' haline getirmi� oluyoruz... Ve bu �ekilde bu Tablo ; Soldaki  "Databases"  klas�r�n�n
-- i�erisinde  "System Databases"  klas�r�n�n i�erisindeki  "tempdb"  deposunun i�erisindeki  "Temporary Tables"
-- i�erisinde saklan�yor... :

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

  ----    NOTE  :  Mesela , bu yukar�daki Sorguyu tamamen comment i�erisine alarak tekrar �al��t�r�p , sonra da tekrar
  -- a�a��daki gii SELECT yaz�p bu  "hashtag"'li  Tabloyu �a��rd���m�zda , istedi�imiz gibi i�lemler yapabiliyoruz...
  -- Mesela a�a��da sadece , Soyad�  'YANG'  olan kullan�c�lar� g�sterelim ::

  SELECT * FROM #ITUmindset_INTO where LastName = 'YANG'

  ----    CRITICAL NOTE  :  Bu uygulaman�n dezavantaj� ; 'Database Administrator (DBA)' �al��anlar� bunu yapmam�z�
  ----    istemezler. ��nk� bu tabloyu silmeyi unutursak ,  "tempdb"  deposunda yo�un bir �i�me olabilir... Bunun i�in
  ----    b�t�n i�lemleri yapt�ktan sonra  'DROP TABLE'  komutunu kullanarak bu Tabloyu silmemiz gerekiyor...
  ----    Hatta 'Temp Table' olu�turuyorsak , bu yukar�daki kodu yazmadan �nce de DROP TABLE kullanabiliriz...

  DROP TABLE #ITUmindset_INTO


  ----    NOTE  :  Bu 'INTO' komutunun "hashtag" ile kullan�m�nda ; ba�ka bir ki�i bu Tabloyu g�remedi�i gibi biz de ,
  ---- ba�ka bir sayfada dahi bu Tabloyu g�remeyiz... Sadece ve sadece KOD sat�r�n� yazd���m�z sayfan�n i�erisinde
  ---- kullanabiliriz...




-- (3)
--    Diyelim ki , sorgumuzun herkesin kullanabilece�i bir yap�da olmas�n� istiyoruz. Ayn� zamanda sorgunun sonu�lar�
-- de�i�tik�e de , gelsin kendisi de�i�sin yani g�ncellensin istiyoruz... Bunun i�in ise "Views" olu�turmal�y�z...

--    "View" dedi�imiz �ey ; verileri Fiziksel bir Tabloda de�il de 'Sanal' bir Tabloda tutan yap�lard�r...

--    Bunu yapmak i�in de ; Soldaki Veri Setimizin i�erisine gelip (AdventureWorks1) ,  "Views"'e  Sa� t�klay�p , 
-- "New View"'e  basmam�z gerekiyor...
-- Sonras�nda oradan bir Tablo se�ip ba�layabiliriz... Ama biz se�meyip , yazd���m�z sorguyu kopyalay�p  "View"'in
-- i�erisindeki  "SELECT - FROM"  k�sm�na yap��t�raca��z... Sonras�nda da ; yukar�s�ndaki bo�lu�a Mousenin Sol tu�u
-- ile bir defa t�klad���m�zda , Tablo veya Tablolar� g�rebiliyor olaca��z...

--    Bu "View" s�recini kullanarak ; g�rsel olarak Tablolar aras�ndaki ili�kileri ve ba�lant�lar� g�rebilir , daha iyi
-- analiz edebiliriz...

--    Bu yaratt���m�z "View"'i kaydedebiliriz... Ve kaydettikten sonra da Soldaki "Views" klas�r�n�n i�erisine gidip ,
-- yaratt���m�z 'View''e Sa� t�klayarak �al��t�rabiliriz...
-- Ve �al��t�rd�ktan sonra da g�rd���m�z gibi ; FROM'dan sonra , Veri Setimizin i�erisinde Tablo ismi de�il de
-- yaratt���m�z 'View''in ismi yaz�yor...

  ----    NOTE  :  Avantaj� ; arka-plandaki datalar g�ncellendik�e sisteme ba�l� olan herkes , en g�ncel halini
  ----    g�rebilir.

  ----    NOTE  :  Dezavantaj� ; yava�t�r. �ok kompleks sorgular� �al��t�r�rken �ok zaman kayb� olabilir... Ama a���r�
  ----    kompleks bir sorgunuz yoksa da kullan�lmas� avantajd�r... Daha kolay analizler yapabiliriz...
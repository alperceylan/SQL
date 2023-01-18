
------------------- FUNCTIONS (FONKSÝYONLAR) -------------------

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile iþlem yaptýðýmýz için, Birebirlik bir
													-- deðer döndüðünü biliyoruz.
		FROM AdventureWorks_Sales_2017  AS S



----	NOTE  :	 Hazýr "String" Fonksiyonlarý , Solda Sýrasý ile :
----	Databases - Veri Setimiz(ITUmindset) - Programmability - Functions - System Functions - String Functions
----	içerisindedir.

----	NOTE  :	 Bir Fonksiyon Yaratmak Ýçin de MSSQL ekranýnda Yukarýda Sýrasý ile :
----	View - Template Browser - Function -


--    FUNCTION :: Bir veya birden fazla parametre alýp bize sonuç dönen yapýlara FONKSÝYON denir.

--    SCALAR - VALUED FUNCTION :: Bir veya birden fazla parametre alýp bize sadece BÝR deðer dönen yapýlara
-- SCALAR - VALUED FUNCTION denir.

--    INLINE TABLE - VALUED FUNCTUON ::  Eðer Fonksiyonumuz 1'e N'lik , N'e 1'lik veya N'e N'lik bir TABLO sonucu
-- dönüyorsa buna INLINE FUNCTION denir.

--    MULTI - STATEMENT TABLE - VALUED FUNCTION :: Eðer bir sorgu sonucumuz yoksa , içeride hesaplamalar yapýp
-- deðiþkenleri bir Tabloya atýp sanal bir Tablo ile döndürüyorsa buna da MULTI - STATEMENT FUNCTION denir.

----    NOTE  :  Solda ; Databases - Veri Setimiz(AdventureWorks1) - Programmability - Functions -
----    Scalar-valued Functions'a gelip sað týkladýðýmýzda , 'New Scalar-valued Function' imlecini görürüz. Buna
----    týkladýðýmýzda bize yazmamýz gereken Template , yeni bir çalýþma sayfasýnda gönderiliyor...

--    ** template == Þablon. **

----    NOTE  :  Fonksiyonlarda ; deðiþtirme , silme , güncelleme , ... gibi iþlemler yoktur. Fonksiyonlarýn tek amacý
----    var ; parametreyi aldýktan sonra , datanýn hesaplanýp bir çýktý vermesidir...

----    NOTE  :  Deðiþtirme , Silme , Güncelleme , ... gibi iþlemler için  'STORED PROCEDURE (Saklý Yordam)'
----    kullanacaðýz...

----    NOTE  :  Bir KOD bloðunu tamamen Comment (Yorum) bloðu haline getirmek için ; TÜM bloðu seçip ,
----    'CTRL + k + c' tuþlarýna basmak gerekiyor...


--    NOTE  :  Mesela bu yaptýðýmýz adýmlarý nasýl takip edebiliriz ? Hangi adýmda ne olduðunu nasýl görebiliriz ?
--    Bunun için  "BREAK POINT"  koymamýz gerekiyor...

------------------- FUNCTIONS (FONKS�YONLAR) -------------------

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile i�lem yapt���m�z i�in, Birebirlik bir
													-- de�er d�nd���n� biliyoruz.
		FROM AdventureWorks_Sales_2017  AS S



----	NOTE  :	 Haz�r "String" Fonksiyonlar� , Solda S�ras� ile :
----	Databases - Veri Setimiz(ITUmindset) - Programmability - Functions - System Functions - String Functions
----	i�erisindedir.

----	NOTE  :	 Bir Fonksiyon Yaratmak ��in de MSSQL ekran�nda Yukar�da S�ras� ile :
----	View - Template Browser - Function -


--    FUNCTION :: Bir veya birden fazla parametre al�p bize sonu� d�nen yap�lara FONKS�YON denir.

--    SCALAR - VALUED FUNCTION :: Bir veya birden fazla parametre al�p bize sadece B�R de�er d�nen yap�lara
-- SCALAR - VALUED FUNCTION denir.

--    INLINE TABLE - VALUED FUNCTUON ::  E�er Fonksiyonumuz 1'e N'lik , N'e 1'lik veya N'e N'lik bir TABLO sonucu
-- d�n�yorsa buna INLINE FUNCTION denir.

--    MULTI - STATEMENT TABLE - VALUED FUNCTION :: E�er bir sorgu sonucumuz yoksa , i�eride hesaplamalar yap�p
-- de�i�kenleri bir Tabloya at�p sanal bir Tablo ile d�nd�r�yorsa buna da MULTI - STATEMENT FUNCTION denir.

----    NOTE  :  Solda ; Databases - Veri Setimiz(AdventureWorks1) - Programmability - Functions -
----    Scalar-valued Functions'a gelip sa� t�klad���m�zda , 'New Scalar-valued Function' imlecini g�r�r�z. Buna
----    t�klad���m�zda bize yazmam�z gereken Template , yeni bir �al��ma sayfas�nda g�nderiliyor...

--    ** template == �ablon. **

----    NOTE  :  Fonksiyonlarda ; de�i�tirme , silme , g�ncelleme , ... gibi i�lemler yoktur. Fonksiyonlar�n tek amac�
----    var ; parametreyi ald�ktan sonra , datan�n hesaplan�p bir ��kt� vermesidir...

----    NOTE  :  De�i�tirme , Silme , G�ncelleme , ... gibi i�lemler i�in  'STORED PROCEDURE (Sakl� Yordam)'
----    kullanaca��z...

----    NOTE  :  Bir KOD blo�unu tamamen Comment (Yorum) blo�u haline getirmek i�in ; T�M blo�u se�ip ,
----    'CTRL + k + c' tu�lar�na basmak gerekiyor...


--    NOTE  :  Mesela bu yapt���m�z ad�mlar� nas�l takip edebiliriz ? Hangi ad�mda ne oldu�unu nas�l g�rebiliriz ?
--    Bunun i�in  "BREAK POINT"  koymam�z gerekiyor...
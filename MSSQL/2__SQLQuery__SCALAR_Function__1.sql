

--    Hangi m��terinin ka� sipari� verdi�ini bulabilece�imiz bir fonksiyon yazal�m :::::::

----    NOTE  :  Burada kulland���m�z SCALAR FUNCTION , birebir sonu� verir...


CREATE FUNCTION fx_ITU_VIII_Scalar_1		--   <--- Fonksiyonun ismi.
(
	--    Add the parameters for the function here :
	--    Parametre olarak (Input olarak) bu fonksiyon ne alacak? Ve Tipi ne olacak? ::
	@CustomerKey varchar(50)
)

--    Sonu� ne d�necek ? (Scalar-valued Function oldu�u i�in , sadece B�R tane sonu� d�necek.) ::
RETURNS int
AS
BEGIN
	--    Burada da bo�luklar� doldurmam�z gerekiyor ::::

	--    Declare the return variable here :
	DECLARE @Result int

	SET @Result = 0    --   <--- 'NULL' de�er d�nd���nde , onun yerine '0' de�erini d�ns�n istiyoruz.

	--    Add the T-SQL statements to compute the return value here :
	--    Bire birlik bir de�er d�nd���n� bildi�imiz i�in , 'Result' de�erini atamam�z gerekiyor... :

	-- (1)
	SET @Result =
	(
		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile i�lem yapt���m�z i�in, Bire birlik bir
													-- de�er d�nd���n� biliyoruz.
		FROM AdventureWorks_Customers AS C
				INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
		WHERE C.[CustomerKey] = @CustomerKey
		GROUP BY C.[CustomerKey]
	)

	--    OR
	-- (2)
	--SELECT
	--	@Result = COUNT(S.[ProductKey])
	--FROM AdventureWorks_Customers AS C
	--		INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
	--WHERE C.[CustomerKey] = @CustomerKey
	--GROUP BY C.[CustomerKey]

	--    Yukar�da ilk ba�ta ;  "SET @Result = 0"  yazmam�z�n yerine , burada a�a��daki gibi de yazabilirdik... :
	--SET @Result = IIF(@Result IS NULL , 0 , @Result)

	--   Return the result of the function  (Bu '@Result' de�erini geri d�nd�rmemiz gerekiyor. Fonksiyonlar her zaman
	-- geri d�n�� [Return] yapar.) :
			RETURN @Result

END
GO



--    Comment'siz temiz halini yazal�m :

CREATE FUNCTION fx_ITU_VIII_Scalar_1
(
	@CustomerKey varchar(50)
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	SET @Result = 0
	SET @Result =
	(
		SELECT
			COUNT(S.[ProductKey]) AS ProductCount
		FROM AdventureWorks_Customers AS C
				INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
		WHERE C.[CustomerKey] = @CustomerKey
		GROUP BY C.[CustomerKey]
	)
			RETURN @Result
END
GO



----    NOTE  :  Bu fonksiyonu �al��t�rd�ktan sonra ; soldaki "Scalar-valued Functions" klas�r�ne gelip , orada bu
----    yaratt���m�z fonksiyonun olup olmad���na bakabiliriz...

----    NOTE  :  Bu bir fonksiyon olarak solda durdu�u i�in , ba�ka �al��anlarla ortak eri�imimiz olsayd� ,
----    ba�kalar� da kullanabileceklerdi...

----    NOTE  :  Bu fonksiyonu �al��t�rmak istiyorsak ; soldaki "Scalar-valued Functions" klas�r�nde fonksiyonumuzu
----    bulup - Sa� t�klay�p - "Script Function as"'a t�klay�p - "SELECT to"'ya t�klay�p - "New Query Editor Window"'a
----    t�klayabiliriz... Ve yeni bir �al��ma penceresinde fonksiyonumuz a��l�r...

----    NOTE  :  Bir KOD blo�unu tamamen Comment (Yorum) blo�u haline getirmek i�in ; T�M blo�u se�ip ,
----    'CTRL + k + c' tu�lar�na basmak gerekiyor...
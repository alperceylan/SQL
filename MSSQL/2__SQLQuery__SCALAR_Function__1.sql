

--    Hangi müþterinin kaç sipariþ verdiðini bulabileceðimiz bir fonksiyon yazalým :::::::

----    NOTE  :  Burada kullandýðýmýz SCALAR FUNCTION , birebir sonuç verir...


CREATE FUNCTION fx_ITU_VIII_Scalar_1		--   <--- Fonksiyonun ismi.
(
	--    Add the parameters for the function here :
	--    Parametre olarak (Input olarak) bu fonksiyon ne alacak? Ve Tipi ne olacak? ::
	@CustomerKey varchar(50)
)

--    Sonuç ne dönecek ? (Scalar-valued Function olduðu için , sadece BÝR tane sonuç dönecek.) ::
RETURNS int
AS
BEGIN
	--    Burada da boþluklarý doldurmamýz gerekiyor ::::

	--    Declare the return variable here :
	DECLARE @Result int

	SET @Result = 0    --   <--- 'NULL' deðer döndüðünde , onun yerine '0' deðerini dönsün istiyoruz.

	--    Add the T-SQL statements to compute the return value here :
	--    Bire birlik bir deðer döndüðünü bildiðimiz için , 'Result' deðerini atamamýz gerekiyor... :

	-- (1)
	SET @Result =
	(
		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile iþlem yaptýðýmýz için, Bire birlik bir
													-- deðer döndüðünü biliyoruz.
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

	--    Yukarýda ilk baþta ;  "SET @Result = 0"  yazmamýzýn yerine , burada aþaðýdaki gibi de yazabilirdik... :
	--SET @Result = IIF(@Result IS NULL , 0 , @Result)

	--   Return the result of the function  (Bu '@Result' deðerini geri döndürmemiz gerekiyor. Fonksiyonlar her zaman
	-- geri dönüþ [Return] yapar.) :
			RETURN @Result

END
GO



--    Comment'siz temiz halini yazalým :

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



----    NOTE  :  Bu fonksiyonu çalýþtýrdýktan sonra ; soldaki "Scalar-valued Functions" klasörüne gelip , orada bu
----    yarattýðýmýz fonksiyonun olup olmadýðýna bakabiliriz...

----    NOTE  :  Bu bir fonksiyon olarak solda durduðu için , baþka çalýþanlarla ortak eriþimimiz olsaydý ,
----    baþkalarý da kullanabileceklerdi...

----    NOTE  :  Bu fonksiyonu çalýþtýrmak istiyorsak ; soldaki "Scalar-valued Functions" klasöründe fonksiyonumuzu
----    bulup - Sað týklayýp - "Script Function as"'a týklayýp - "SELECT to"'ya týklayýp - "New Query Editor Window"'a
----    týklayabiliriz... Ve yeni bir çalýþma penceresinde fonksiyonumuz açýlýr...

----    NOTE  :  Bir KOD bloðunu tamamen Comment (Yorum) bloðu haline getirmek için ; TÜM bloðu seçip ,
----    'CTRL + k + c' tuþlarýna basmak gerekiyor...
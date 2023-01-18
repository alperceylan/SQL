
--          Haz�r STORED PROCEDURE Tasla�� ile �al��ma ::

--    "Stored Procedure" olu�turmak i�in ; Solda , �ncelikle �zerinde �al��mak istedi�imiz Data Sete geliyoruz. Orada
-- 'Programmability'  klas�r�ne t�kl�yoruz. Sonras�nda da  'Stored Procedures'  klas�r�ne Sa� t�klayarak  'New'
-- butonundan sonra ortaya ��kan  'Stored Procedure'  butonuna t�kl�yoruz... Bu butonlara t�klad���m�zda ; Haz�r
-- 'Stored Procedure' Tasla�� i�in , �u anda i�inde bulundu�umuz sayfa gibi yeni bir �al��ma sayfas� olu�acakt�r...


CREATE PROCEDURE sp_ITU_VIII_Get_Anonymzed_1
	-- Add the parameters for the stored procedure here :
	@CustomerKey VARCHAR(50)
AS
BEGIN

	UPDATE [AdventureWorks1].[dbo].[AdventureWorks_Customers]
	SET [FirstName] = 'Unknown'  ,  [LastName] = 'Unknown'  ,  [EmailAddress] = 'Unknown'  ,  [BirthDate] = GETDATE()
	WHERE [CustomerKey] = @CustomerKey

	UPDATE [dbo].[AdventureWorks_Customers]
    SET
       [Prefix] = 'Unknown'
      ,[FirstName] = 'Unknown'
      ,[LastName] = 'Unknown'
	  ,[Gender] = 'Unknown'
      ,[BirthDate] = GETDATE()
      ,[EmailAddress] = 'Unknown'
	WHERE [CustomerKey] = @CustomerKey
	
END
GO

----    NOTE  :  'F5' tu�una basarak veya yukar�daki 'Execute' butonuna basarak �al��t�r�yoruz ve sonras�nda Soldaki
----    'Programmability'  i�erisindeki  'Stored Procedures'  klas�r�n� REFRESH ettikten sonra , olu�turdu�umuz
----    Stored Procedure'yi g�r�yoruz...
----    Bu yaratt���m�z Stored Procedure'yi a�mak i�in de ; �zerine gelip Sa� t�klay�p ,  'Script Stored Procedure as'
----    butonuna t�klay�p sonras�nda ,  'EXECUTE To'  butonuna t�kl�yoruz ve sonras�nda da  'New Query Editor Window'
----    butonuna t�kl�yoruz.

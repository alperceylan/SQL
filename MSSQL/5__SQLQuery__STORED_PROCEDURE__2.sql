
--          Hazýr STORED PROCEDURE Taslaðý ile Çalýþma ::

--    "Stored Procedure" oluþturmak için ; Solda , öncelikle üzerinde çalýþmak istediðimiz Data Sete geliyoruz. Orada
-- 'Programmability'  klasörüne týklýyoruz. Sonrasýnda da  'Stored Procedures'  klasörüne Sað týklayarak  'New'
-- butonundan sonra ortaya çýkan  'Stored Procedure'  butonuna týklýyoruz... Bu butonlara týkladýðýmýzda ; Hazýr
-- 'Stored Procedure' Taslaðý için , þu anda içinde bulunduðumuz sayfa gibi yeni bir çalýþma sayfasý oluþacaktýr...


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

----    NOTE  :  'F5' tuþuna basarak veya yukarýdaki 'Execute' butonuna basarak çalýþtýrýyoruz ve sonrasýnda Soldaki
----    'Programmability'  içerisindeki  'Stored Procedures'  klasörünü REFRESH ettikten sonra , oluþturduðumuz
----    Stored Procedure'yi görüyoruz...
----    Bu yarattýðýmýz Stored Procedure'yi açmak için de ; üzerine gelip Sað týklayýp ,  'Script Stored Procedure as'
----    butonuna týklayýp sonrasýnda ,  'EXECUTE To'  butonuna týklýyoruz ve sonrasýnda da  'New Query Editor Window'
----    butonuna týklýyoruz.

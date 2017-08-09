-- Für bereits entschiedene Geschlechter die Anrede in Personal definieren

use ImperialESP
go

-- Anreden für die Frauen definieren

update dbo.Personal Set [Anrede_FK] = 2
where Personal_PK in (select Personal_PK
					  from [Schulung].[Geschlechtertrennung] as A
                      where Not [MannFrau] is Null and [MannFrau] = 1)


-- Anreden für die Männer definieren

update dbo.Personal Set [Anrede_FK] = 1
where Personal_PK in (select Personal_PK
					  from [Schulung].[Geschlechtertrennung] as A
                      where Not [MannFrau] is Null and [MannFrau] = 0)
-- a)
ALTER TABLE księgowość.pracownicy 
ALTER COLUMN telefon TYPE VARCHAR;

UPDATE księgowość.pracownicy
SET telefon = CONCAT('(+48) ', telefon);
--SET telefon = '(+48) ' || telefon;

-- b)
UPDATE księgowość.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon FROM 1 FOR 9), 
'-', SUBSTRING(telefon FROM 10 FOR 9), '-', SUBSTRING(telefon FROM 13));

-- c) Wyświetl dane pracownika, którego nazwisko jest najdłuższe, używając dużych liter
SELECT UPPER(imie) as imie, UPPER(nazwisko) as nazwisko
FROM księgowość.pracownicy
ORDER BY LENGTH(nazwisko) DESC
LIMIT 1;

-- d) Wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5 
SELECT imie, nazwisko, MD5(CAST(kwota AS VARCHAR)) as zakodowana_pensja
FROM księgowość.pracownicy
JOIN księgowość.wynagrodzenia ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
JOIN księgowość.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji;

-- e) Wyświetl pracowników, ich pensje oraz premie.
SELECT imie, nazwisko, pensje.kwota as pensja, premie.kwota as premia
FROM księgowość.wynagrodzenia
LEFT JOIN księgowość.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
LEFT JOIN księgowość.premie ON wynagrodzenia.id_premii = premie.id_premii
LEFT JOIN księgowość.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji;

-- f)
ALTER TABLE księgowość.pracownicy 
ALTER COLUMN imie TYPE VARCHAR
ALTER COLUMN nazwisko TYPE VARCHAR
ALTER COLUMN adres TYPE VARCHAR;


SELECT CONCAT('Pracownik ', pracownicy.imie,' ', pracownicy.nazwisko, ', w dniu ', 
			  wynagrodzenia.data, ' otrzymał pensję całkowitą na kwotę ',
			  COALESCE(pensje.kwota+ premie.kwota), ' , gdzie wynagrodzenie zasadnicze wynosiło: ',
			  pensje.kwota, ' , premia: ', premie.kwota, ' , liczba nadgodzin: ', COALESCE(liczba_godzin- 160))
FROM księgowość.wynagrodzenia
LEFT JOIN księgowość.premie ON wynagrodzenia.id_premii = premie.id_premii
JOIN księgowość.pracownicy ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
JOIN księgowość.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
LEFT JOIN księgowość.godziny ON wynagrodzenia.id_godziny = godziny.id_godziny;





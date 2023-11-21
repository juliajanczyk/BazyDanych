CREATE SCHEMA księgowość;
CREATE TABLE IF NOT EXISTS księgowość.pracownicy (
	id_pracownika int PRIMARY KEY,
	imie char(50) NOT NULL,
	nazwisko char(50) NOT NULL,
	adres char(50),
	telefon	int
);
-- VARCHAR!!!!!!!! powinien byc
CREATE TABLE IF NOT EXISTS księgowość.godziny (
	id_godziny int PRIMARY KEY,
	data date,
	liczba_godzin int NOT NULL,
	id_pracownika int,
	CONSTRAINT pracownicy_fkey
	FOREIGN KEY (id_pracownika)
	REFERENCES księgowość.pracownicy(id_pracownika)
);

CREATE TABLE IF NOT EXISTS  księgowość.pensje (
	id_pensji int PRIMARY KEY,
	stanowisko char(200),
	kwota  money NOT NULL
);

CREATE TABLE IF NOT EXISTS księgowość.premie (
	id_premii int PRIMARY KEY,
	rodzaj char(200),
	kwota  money 
);

CREATE TABLE IF NOT EXISTS księgowość.wynagrodzenia (
	id_wynagrodzenia int PRIMARY KEY,
	data date,
	id_pracownika int,
	id_godziny int,
	id_pensji int,
	id_premii int,
	CONSTRAINT pracownicy_fkey
		FOREIGN KEY (id_pracownika)
			REFERENCES księgowość.pracownicy(id_pracownika),
	CONSTRAINT godziny_fkey
		FOREIGN KEY (id_godziny)
			REFERENCES księgowość.godziny(id_godziny),
	CONSTRAINT pensje_fkey
		FOREIGN KEY (id_pensji)
			REFERENCES księgowość.pensje(id_pensji),
	CONSTRAINT premie_fkey
		FOREIGN KEY (id_premii)
			REFERENCES księgowość.premie(id_premii)
);

INSERT INTO księgowość.pracownicy( id_pracownika, imie, nazwisko, adres, telefon  )
VALUES
(1, 'Jan', 'Kowalski', 'Krakowska 10', 123456789),
(2, 'Julia', 'Lewak', 'Dworna 45', 585418187),
(3, 'Klara', 'Bąk', 'Rzemieślnicza 83a', 798579456),
(4, 'Beata', 'Kopeć', 'Ogrodowa 54', 48759642),
(5, 'Kornel', 'Domański', 'Szkolna 67', 784315788),
(6, 'Magdalena', 'Owczarek', 'Cmentarna 147', 453721895),
(7, 'Aleksandra', 'Sadowska', 'Grunwaldzka 89A/3', 138754089),
(8, 'Wiesław', 'Świątek', 'Kasztanowa 91', 475185147),
(9, 'Zdzisław', 'Kania', 'Jarzębinowa 3', 397464818),
(10, 'Bartłomiej', 'Mróz', 'Gruszkowa 35B', 211544569);

INSERT INTO księgowość.godziny( id_godziny, data, liczba_godzin, id_pracownika )
VALUES
(1, '2-10-2023', 170, 1),
(2, '13-10-2023', 173, 2),
(3, '7-10-2023', 160, 3),
(4, '23-10-2023', 165, 4),
(5, '1-10-2023', 169, 5),
(6, '30-10-2023', 171, 6),
(7, '24-10-2023', 184, 7),
(8, '5-10-2023', 188, 8),
(9, '9-10-2023', 164, 9),
(10, '16-10-2023', 167, 10);

INSERT INTO księgowość.pensje( id_pensji, stanowisko, kwota )
VALUES
(1, 'Księgowy', 3565),
(2, 'Asystent Dyrektora', 5355),
(3, 'Kierownik Recepcji', 1222),
(4, 'Sekretarka', 4512),
(5, 'Sekretarz Redakcji', 1952),
(6, 'Specjalista ds. Baz danych', 3485),
(7, 'Kierownik biura', 3524),
(8, 'Asystent Handlowy', 4590),
(9, 'Główna Księowa', 4622),
(10, 'Dyrektor', 6526);

INSERT INTO księgowość.premie( id_premii, rodzaj, kwota )
VALUES
(1, 'Uznaniowa', 1215),
(2, 'Urodzinowa', 710),
(3, 'Świąteczna', 564),
(4, 'Za frekwencję', 687),
(5, 'Uznaniowa', 752),
(6, 'Świąteczna', 155),
(7, 'Regulaminowa', 710),
(8, 'Regulaminowa', 268),
(9, 'Świąteczna', 1215),
(10, 'Urodzinowa', 854);


INSERT INTO księgowość.wynagrodzenia ( id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '2-10-2023', 1, 1, 1, 1),
(2, '13-10-2023', 2, 2, 2, 2),
(3, '7-10-2023', 3, 3, 3, 3),
(4, '23-10-2023', 4, 4, 4, 4),
(5, '1-10-2023', 5, 5, 5, 5),
(6, '30-10-2023', 6, 6, 6, 6),
(7, '24-10-2023', 7, 7, 7, 7),
(8, '5-10-2023', 8, 8, 8, 8),
(9, '9-10-2023', 9, 9, 9, 9),
(10, '16-10-2023', 10, 10, 10, 10);

-- a)
SELECT id_pracownika, nazwisko FROM księgowość.pracownicy; 

-- b)
SELECT id_pracownika FROM księgowość.pracownicy 
JOIN księgowość.pensje ON id_pracownika=id_pensji
WHERE kwota > 1000::money;
--? '1000'::money

-- c)
SELECT id_pracownika FROM księgowość.pracownicy 
JOIN księgowość.pensje ON id_pracownika=id_pensji
JOIN księgowość.premie ON id_premii=id_pracownika
WHERE pensje.kwota > 2000::money AND premie.kwota IS NULL; 
-- pracownicy ktorych pensja > 2000 i brak premii

-- d)
SELECT * FROM księgowość.pracownicy WHERE LEFT(imie,1)='J';
-- pierwsza litera w 'imie' = 'J'

--SELECT * FROM księgowość.pracownicy WHERE imie LIKE 'J%'

-- e)
SELECT * FROM księgowość.pracownicy 
WHERE (imie::varchar) ILIKE '%a' AND nazwisko ILIKE '%n%';
-- imie konczy sie na a nazwisko zawiera n
-- imie::varchar bo jak char to wypełnia reszte zerami
-- lub (imie::varchar LIKE '%a') AND (nazwisko LIKE '%n%')

-- f)
SELECT imie, nazwisko, coalesce(liczba_godzin- 160) AS nadgodziny  FROM księgowość.pracownicy 
LEFT JOIN księgowość.godziny ON pracownicy.id_pracownika=godziny.id_pracownika;
--left bo chcemy kazdego pracownika nawet jak nie ma nadgodzin

-- g)
SELECT imie, nazwisko FROM księgowość.pracownicy 
JOIN księgowość.pensje ON id_pracownika=id_pensji -- join bo chcemy spełniajace wranauek
WHERE pensje.kwota < 3000::money AND pensje.kwota > 1500::money;
-- przedział 1500-3000

--???
--JOIN księgowość.wynagrodzenia ON wynagrodzenia.id_pracownika=pracownicy.id_pracownika
--JOIN księgowość.pensje ON wynagrodzenia.id_pracownika=wynagrodzenia.id_pensji

-- h)
SELECT imie, nazwisko FROM księgowość.pracownicy 
JOIN księgowość.godziny ON godziny.id_pracownika = pracownicy.id_pracownika
JOIN księgowość.premie ON księgowość.premie.id_premii = księgowość.godziny.id_godziny
WHERE ( liczba_godzin > 160 ) AND (premie.kwota = 0::money);
-- pracowali w nadgodzinach czyli czas pracy > 160 AND  premia=0

-- i)
SELECT * FROM księgowość.pracownicy
LEFT JOIN księgowość.pensje ON księgowość.pracownicy.id_pracownika=księgowość.pensje.id_pensji
ORDER BY pensje.kwota ASC ;-- sortujemy po pensji rosnaco
-- rosnaco ASC 
-- malejaco DESC

-- j)
SELECT * FROM księgowość.pracownicy
LEFT JOIN księgowość.pensje ON pracownicy.id_pracownika = pensje.id_pensji -- księgowość.pensje.id_pensji ??
LEFT JOIN księgowość.premie ON pracownicy.id_pracownika = premie.id_premii
ORDER BY księgowość.pensje.kwota, księgowość.premie.kwota DESC ;--malejaco 
-- sortujemy wg pensji i premii

-- k)
SELECT stanowisko, COUNT(*) AS tyle_jest_pracownikow --count podlicza ilosc pracowników 
FROM księgowość.pensje --na podstawie tabeli pensje
GROUP BY stanowisko; -- grupuje wg stanowisko

-- l)
SELECT
ROUND(AVG(kwota::numeric),2) AS placa_srednia,-- średnia zaokraglam round(sredni, 2 - miejsca po przecinku)
MIN(kwota::numeric) AS placa_minimalna, -- minimalna
MAX(kwota::numeric) AS placa_maksymalna -- maksymalna
FROM księgowość.pensje
WHERE (stanowisko = 'Dyrektor') OR (stanowisko = 'Asystent Dyrektora'); -- dwa stanowiska zeby liczyło średnia

-- m)

-- suma wszytskich wynagrodzen
SELECT SUM(kwota) AS suma FROM księgowość.pensje;

-- suma wszytskich wynagrodzen razem z premiami
SELECT SUM(pensje.kwota) + SUM(premie.kwota) AS suma_wynagrodzen
FROM księgowość.pensje
LEFT JOIN JOIN księgowość.premie ON księgowość.premie.id_premii = księgowość.pensje.id_pensje;

--FROM księgowość.wynagrodzenia -- lacze tabelki poprzez  tab wynagrodzenia (?)
--LEFT JOIN księgowość.pensje ON księgowość.pensje.id_pensji = księgowość.wynagrodzenia.id_pensji
--LEFT JOIN księgowość.premie ON księgowość.premie.id_premii = księgowość.wynagrodzenia.id_premii;

-- n)

-- bez premii
SELECT stanowisko, SUM(kwota) FROM księgowość.pensje 
GROUP BY stanowisko; --   wynagrodzenie dla stanowisk

--WHERE stanowisko = 'Księgowy' --  wynagrodzenie dla danego stanowiska (?)

-- z premia
SELECT stanowisko, SUM(pensje.kwota) + SUM(premie.kwota) AS suma_wynagrodzen

--FROM księgowość.wynagrodzenia -- lacze tabelki poprzez tab wynagrodzenia
--LEFT JOIN księgowość.pensje ON księgowość.pensje.id_pensji = księgowość.wynagrodzenia.id_pensji
--LEFT JOIN księgowość.premie ON księgowość.premie.id_premii = księgowość.wynagrodzenia.id_premii
GROUP BY stanowisko; -- suma wynagrodzen dla kazdego stanowsika

--WHERE stanowisko = 'Księgowy' -- suma wynagrodzen dla danego stanowiska

-- o)
-- liczba przyznanych premii 
SELECT COUNT(premie.kwota), stanowisko FROM księgowość.wynagrodzenia 
LEFT JOIN księgowość.pensje ON pensje.id_pensji = wynagrodzenia.id_pensji
LEFT JOIN księgowość.premie ON premie.id_premii = wynagrodzenia.id_premii
-- SELECT COUNT(premie.kwota), stanowisko FROM księgowość.premie  -- lub to
-- LEFT księgowość.pensje ON pensje.id_pensji = premie.id_premii
WHERE księgowość.premie.kwota!=0::money
GROUP BY stanowisko; -- liczba premii dla kazdego stanowiska

-- p) usuwanie pracownikow
DELETE FROM księgowość.pracownicy
USING księgowość.pensje
WHERE pensje.kwota < 1200::money;



CREATE SCHEMA rozliczenia;
CREATE TABLE rozliczenia.pracownicy (
	id_pracownika int PRIMARY KEY,
	imie char(20) NOT NULL,
	nazwisko char(20) NOT NULL,
	adres char(20),
	telefon	numeric
);
CREATE TABLE  rozliczenia.godziny (
	id_godziny int PRIMARY KEY,
	data date,
	liczba_godzin  int NOT NULL,
	id_pracownika	int
);
CREATE TABLE  rozliczenia.pensje (
	id_pensji int PRIMARY KEY,
	stanowisko char(20),
	kwota  money NOT NULL,
	id_premii	int
);
CREATE TABLE  rozliczenia.premie (
	id_premii int PRIMARY KEY,
	rodzaj char(20),
	kwota  money NOT NULL
);
ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT fk_pracownicy
	FOREIGN KEY (id_pracownika)
		REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT fk_premie
	FOREIGN KEY (id_premii)
		REFERENCES rozliczenia.premie(id_premii);

INSERT INTO rozliczenia.pracownicy( imie, nazwisko, adres, telefon  )//?????????
VALUES
('Jan', 'Kowalski', 'Krakowska 10', 123456789),
('Julia', 'Lewak', 'Dworna 45', 585418187),
('Klara', 'B¹k', 'Rzemieœlnicza 83a', 798579456),
('Beata', 'Kopeæ', 'Ogrodowa 54', 48759642),
('Kornel', 'Domañski', 'Szkolna 67', 784315788),
('Magdalena', 'Owczarek', 'Cmentarna 147', 453721895),
('Aleksandra', 'Sadowska', 'Grunwaldzka 89A/3', 138754089),
('Wies³aw', 'Œwi¹tek', 'Kasztanowa 91', 475185147),
('Zdzis³aw', 'Kania', 'Jarzêbinowa 3', 397464818),
('Bart³omiej', 'Mróz', 'Gruszkowa 35B', 211544569);


INSERT INTO rozliczenia.pracownicy( id_pracownika, imie, nazwisko, adres, telefon  )
VALUES
(1, 'Jan', 'Kowalski', 'Krakowska 10', 123456789),
(2, 'Julia', 'Lewak', 'Dworna 45', 585418187),
(3, 'Klara', 'B¹k', 'Rzemieœlnicza 83a', 798579456),
(4, 'Beata', 'Kopeæ', 'Ogrodowa 54', 48759642),
(5, 'Kornel', 'Domañski', 'Szkolna 67', 784315788),
(6, 'Magdalena', 'Owczarek', 'Cmentarna 147', 453721895),
(7, 'Aleksandra', 'Sadowska', 'Grunwaldzka 89A/3', 138754089),
(8, 'Wies³aw', 'Œwi¹tek', 'Kasztanowa 91', 475185147),
(9, 'Zdzis³aw', 'Kania', 'Jarzêbinowa 3', 397464818),
(10, 'Bart³omiej', 'Mróz', 'Gruszkowa 35B', 211544569);


INSERT INTO rozliczenia.godziny( id_godziny, data, liczba_godzin, id_pracownika )
VALUES
(1, '2-10-2023', 8, 1),
(2, '13-10-2023',4, 2),
(3, '7-10-2023', 7, 3),
(4, '23-10-2023', 8, 4),
(5, '1-10-2023', 5, 5),
(6, '30-10-2023', 4, 6),
(7, '24-10-2023', 8, 7),
(8, '5-10-2023', 7, 8),
(9, '9-10-2023', 6, 9),
(10, '16-10-2023', 3, 10);

INSERT INTO rozliczenia.pensje( id_pensji, stanowisko, kwota, id_premii )
VALUES
(1, 'Ksiêgowy', 3565, 1),
(2, 'Asystent Dyrektora', 5355, 2),
(3, 'Kierownik Recepcji', 1222, 3),
(4, 'Sekretarka', 4512, 4),
(5, 'Sekretarz Redakcji', 1952, 5),
(6, 'Specjalista ds. Baz danych', 3485, 6),
(7, 'Kierownik biura', 3524, 7),
(8, 'Asystent Handlowy', 4590, 8),
(9, 'G³ówna Ksiêowa', 4622, 9),
(10, 'Dyrektor', 6526, 10);

INSERT INTO rozliczenia.premie( id_premii, rodzaj, kwota )
VALUES
(1, 'Uznaniowa', 1215),
(2, 'Urodzinowa', 710),
(3, 'Œwi¹teczna', 564),
(4, 'Za frekwencjê', 687),
(5, 'Uznaniowa', 752),
(6, 'Œwi¹teczna', 155),
(7, 'Regulaminowa', 710),
(8, 'Regulaminowa', 268),
(9, 'Œwi¹teczna', 1215),
(10, 'Urodzinowa', 854);

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

?? DATEPART
SELECT
    EXTRACT(DOW FROM data) AS dzien_tygodnia,
    EXTRACT(MONTH FROM data) AS miesiac
FROM rozliczenia.godziny;


SELECT DATE_PART('dow', data) AS dzien_yygodnia, 
DATE_PART('month',data) AS miesiac 
FROM rozliczenia.godziny;



ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto money;


UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.88;




create database usaElection;

use usaElection;

CREATE TABLE candidate (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    party varchar(50) NOT NULL UNIQUE,
    age INT,
    profile TEXT NOT NULL
);

CREATE TABLE state (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(50) NOT NULL UNIQUE,
    Pvote int NOT NULL,
    ECvote int NOT NULL
);

CREATE TABLE vos (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    vote int NOT NULL,
    stateId int NOT NULL,
    candidateId int NOT NULL,
    FOREIGN KEY (stateId) REFERENCES state(id),
    FOREIGN KEY (candidateId) REFERENCES candidate(id)
);


insert into candidate
values (null, 'Donald Trump', 'Repulican', 78,'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcRifo-ClOZnpj-ZxEAokMYvr7pHRdDoHvLcV89JMrOOv9o3bhxo7qxuCnQ_cFJ-w7n7hX9vFXlgMONiloLE');
insert into candidate
values (null, 'Kamala Harris', 'Democratic', 60, 'data:image/png;base64,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');
insert into candidate
values (null, 'Jill Stein', 'Green', 74, 'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcQBAA1AOMj3T1BNbXZZhIsAzNWg49vf9kU_HHuQG972W5obhVPq16mgvpfvqROcYWmEsXofcYN1-DY4J-68');
insert into candidate
values (null, 'Robert Kennedy', 'Independent', 70, 'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQ2WCY3bleNj8r0gdp52lP3UiMpF6LIWAGV_8yrmOROLNl_Hk8Dq5g6foc3Z2sEqjKY7dZc90IJvNeSXg2u');
insert into candidate
values (null, 'Chase Oliver', 'Libertarian', 39, 'https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcTS-pN9D52-yXDXqg5Bc0mfCHXZWyYouwBoQ1qNo6-vZcEd-4hsNDsS8dgSu6xWeuYfpyS9pxOIJ0DvItT6');

INSERT INTO state (name, pvote, ecvote) VALUES ('Delaware', 973764, 3);
INSERT INTO state (name, pvote, ecvote) VALUES ('Pennsylvania', 9288994, 19);
INSERT INTO state (name, pvote, ecvote) VALUES ('New Jersey', 6338228, 14);
INSERT INTO state (name, pvote, ecvote) VALUES ('Georgia', 7414745, 16);
INSERT INTO state (name, pvote, ecvote) VALUES ('Connecticut', 2736479, 7);
INSERT INTO state (name, pvote, ecvote) VALUES ('Massachusetts', 4984888, 11);
INSERT INTO state (name, pvote, ecvote) VALUES ('Maryland', 4327553, 10);
INSERT INTO state (name, pvote, ecvote) VALUES ('South Carolina', 3980380, 9);
INSERT INTO state (name, pvote, ecvote) VALUES ('New Hampshire', 1006017, 4);
INSERT INTO state (name, pvote, ecvote) VALUES ('Virginia', 6345307, 13);
INSERT INTO state (name, pvote, ecvote) VALUES ('New York', 13429114, 28);
INSERT INTO state (name, pvote, ecvote) VALUES ('North Carolina', 7521348, 16);
INSERT INTO state (name, pvote, ecvote) VALUES ('Rhode Island', 789465, 4);
INSERT INTO state (name, pvote, ecvote) VALUES ('Vermont', 470252, 3);
INSERT INTO state (name, pvote, ecvote) VALUES ('Kentucky', 3461234, 8);
INSERT INTO state (name, pvote, ecvote) VALUES ('Tennessee', 5084643, 11);
INSERT INTO state (name, pvote, ecvote) VALUES ('Ohio', 8774882, 17);
INSERT INTO state (name, pvote, ecvote) VALUES ('Louisiana', 3385478, 8);
INSERT INTO state (name, pvote, ecvote) VALUES ('Indiana', 4882108, 11);
INSERT INTO state (name, pvote, ecvote) VALUES ('Mississippi', 2207892, 6);
INSERT INTO state (name, pvote, ecvote) VALUES ('Illinois', 9757585, 19);
INSERT INTO state (name, pvote, ecvote) VALUES ('Alabama', 3937312, 9);
INSERT INTO state (name, pvote, ecvote) VALUES ('Maine', 1086892, 4);
INSERT INTO state (name, pvote, ecvote) VALUES ('Missouri', 4630695, 10);
INSERT INTO state (name, pvote, ecvote) VALUES ('Arkansas', 2193168, 6);
INSERT INTO state (name, pvote, ecvote) VALUES ('Michigan', 7950674, 15);
INSERT INTO state (name, pvote, ecvote) VALUES ('Florida', 14624199, 30);
INSERT INTO state (name, pvote, ecvote) VALUES ('Texas', 21270847, 40);
INSERT INTO state (name, pvote, ecvote) VALUES ('Iowa', 2382184, 6);
INSERT INTO state (name, pvote, ecvote) VALUES ('California', 25074530, 54);
INSERT INTO state (name, pvote, ecvote) VALUES ('Minnesota', 4123456, 10);
INSERT INTO state (name, pvote, ecvote) VALUES ('Oregon', 3175693, 7);
INSERT INTO state (name, pvote, ecvote) VALUES ('Kansas', 2192447, 6);
INSERT INTO state (name, pvote, ecvote) VALUES ('West Virginia', 1373303, 4);
INSERT INTO state (name, pvote, ecvote) VALUES ('Nevada', 2528451, 6);
INSERT INTO state (name, pvote, ecvote) VALUES ('Nebraska', 1453262, 5);
INSERT INTO state (name, pvote, ecvote) VALUES ('Colorado', 4231672, 10);
INSERT INTO state (name, pvote, ecvote) VALUES ('North Dakota', 553426, 3);
INSERT INTO state (name, pvote, ecvote) VALUES ('South Dakota', 666789, 3);
INSERT INTO state (name, pvote, ecvote) VALUES ('Montana', 943123, 4);
INSERT INTO state (name, pvote, ecvote) VALUES ('Washington', 6304567, 12);
INSERT INTO state (name, pvote, ecvote) VALUES ('Idaho', 1567405, 4);
INSERT INTO state (name, pvote, ecvote) VALUES ('Wyoming', 478843, 3);
INSERT INTO state (name, pvote, ecvote) VALUES ('Utah', 2735847, 6);
INSERT INTO state (name, pvote, ecvote) VALUES ('Oklahoma', 2957021, 7);
INSERT INTO state (name, pvote, ecvote) VALUES ('New Mexico', 1447313, 5);
INSERT INTO state (name, pvote, ecvote) VALUES ('Arizona', 5353124, 11);
INSERT INTO state (name, pvote, ecvote) VALUES ('Alaska', 638601, 3);
INSERT INTO state (name, pvote, ecvote) VALUES ('Hawaii', 1144953, 4);

INSERT INTO vos
values (null, 5207102, 23, 2);

INSERT INTO vos
values (null, 3493556, 23, 1);
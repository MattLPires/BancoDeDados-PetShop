create database petshop;
use petshop;

create table Cliente(
	codCliente int auto_increment primary key,
    nome_cli varchar(50),
    CPF_cli int,
    telefone_cli int,
    endereco_cli varchar(50)
);

create table Funcionario(
	codFunc int auto_increment primary key,
    nome_func varchar(50),
    CPF_func int,
    telefone_func int
);

create table Animal(
	codAnimal int auto_increment primary key,
    codDono int not null,
    nome_animal varchar(50),
    sexo enum('F', 'M'),
    raça varchar(15),
    tipo varchar(10),
    porte_cm decimal(5,2),
	constraint codDono foreign key (codDono) references Cliente(codCliente)
);

create table Produto(
	codProd int auto_increment primary key,
    nome_prod varchar(35),
    marca varchar(10),
	valor_prod decimal(5,2),
    pesoLiquido decimal(5,2)
);

create table Serviço(
	codServ int auto_increment primary key,
    tipo varchar(20),
    valor_serv decimal(5,2)
);

create table Pedido(
	codPed int auto_increment primary key,
    data_ped int,
    cod_func int not null,
    cod_cli int not null,
    constraint cod_cli foreign key (cod_cli) references Cliente(codCliente),
    constraint cod_func foreign key (cod_func) references Funcionario(codFunc)
);

create table Itens_Ped(
	cod_ped int not null,
    cod_prod int not null,
    constraint cod_ped foreign key (cod_ped) references Pedido(codPed),
    constraint cod_prod foreign key (cod_prod) references Produto(codProd)
);

create table Serv_Ped(
	cod_ped int not null,
    cod_serv int not null,
	cod_animal int not null,
	constraint cod_ped foreign key (cod_ped) references Pedido(codPed),
    constraint cod_animal foreign key (cod_animal) references Animal(codAnimal),
    constraint cod_serv foreign key (cod_serv) references Serviço(codServ)
);

/* SELECT PARA CONSULTAR CLIENTE E FUNCIONARIO PARA CADA PEDIDO */
SELECT codPed as 'Codigo do Pedido', Cliente.nome_cli as 'Nome do Cliente', Funcionario.nome_func as 'Nome do Funcionario' FROM Pedido
inner join Cliente
inner join Funcionario
where Pedido.cod_cli = Cliente.codCliente and Funcionario.codFunc = Pedido.cod_func;

/* SELECT PARA CONSULTAR PRODUTOS COMPRADOS EM DETERMINADO PEDIDO */
SELECT cod_ped as 'Codigo do Pedido', Produto.nome_prod as 'Produto Comprado' FROM Itens_Ped
inner join Produto
inner join Pedido
where Itens_Ped.cod_ped = 1 and Produto.codProd = Itens_Ped.cod_prod;

/* SELECT PARA CONSULTAR O VALOR TOTAL DO PEDIDO */
SELECT cod_ped as 'Codigo do Pedido', Serviço.tipo as 'Serviço Prestado' FROM Serv_Ped
inner join Serviço
inner join Pedido
where Serv_Ped.cod_ped = 1 and Serviço.codServ = Serv_Ped.cod_serv;

/* SELECT PARA CONSULTAR O NOME DOS PETS E SEUS RESPECTIVOS DONOS */
SELECT codAnimal as 'Codigo do Animal', nome_animal as 'Nome do Animal', Cliente.nome_cli as 'Nome do Dono' FROM Animal
inner join Cliente
where Cliente.codCliente = Animal.codDono;
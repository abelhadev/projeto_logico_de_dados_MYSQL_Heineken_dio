CREATE DATABASE Ecommerce;
USE Ecommerce;

CREATE TABLE Clients(
	IdClients INT auto_increment primary key,
    Pname varchar(10),
    Mnit  char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Adress varchar(30),
    constraint unique_cpf_client unique (CPF)
);

CREATE TABLE Product(
	IdProduct INT auto_increment primary key,
    Pname varchar(10),
    Classification bool,
    Category enum('Eletônicos', 'Brinquedos', 'Papelaria', 'Roupas'),
    Adress varchar(30),
    Review float,
    Size varchar(10),
    constraint unique_cpf_client unique (CPF)
);

CREATE TABLE Orders( 
	IdOrders INT auto_increment primary key,
    IdOrdersClient INT,
    StatusOrders enum('Cancelado','Confirmado','Em processamento', 'Aguardando Pagamento') not null,
    OrdersDescription varchar(255),
    SendValue float default 10,
    CashPayment bool default false,
    constraint fk_orders_client foreign key (IdOrdersClient) references Clients(IdClients)
);

CREATE TABLE Payments(
    IdClients INT,
    IdPayments INT,
    PaymentType enum('Cartão de Crédio', 'Cartão de Débito', 'PIX', 'Boleto'),
    LimitAvaiable float,
    primary key (IdClients, IdPayments)
);

CREATE TABLE RegistredPaymentsMethods(
	IdRegistredPayments INT,
    IdPayments INT,
	CardNumer varchar(30),
    NameInTheCard varchar(50),
    TypeOfcard enum('Crédito', 'Débito'),
    primary key (IdPayments, IdRegistredPayments)
);

CREATE TABLE ProductStorage(
	IdProductStorage INT auto_increment primary key,
    StorageLocation varchar(250),
    Quantity INT default 0
);

CREATE TABLE Supplier(
	IdSupplier INT auto_increment primary key,
    StorageLocation varchar(50),
    SocialName varchar(255) not null,
    CNPJ INT(15) not null,
    Contact varchar(20),
    constraint unique_supplier unique(CNPJ)
);
desc Supplier;
CREATE TABLE Seller(
	IdSeller INT auto_increment primary key,
	Adress varchar(20),
    SocialName varchar(50),
    FantasyName varchar(50),
    CNPJ INT(15) not null,
	constraint unique_cpf_seller unique (CPF),
    constraint unique_cnpj_seller unique (CNPJ)
);

CREATE TABLE ProductSeller(
	IdPSeller INT auto_increment primary key,
    IdProduct INT,
    ProductQuantity INT default 1,
    primary key(IdPSeller, IdProduct),
    constraint fk_product_seller foreign key (IdPSeller) references Seller (IdSeller),
    constraint fk_product_product foreign key (IdProduct) references Product (IdProduct)
);

show tables;

INSERT into Clients(Pname, Mnit, Lname, CPF, Adress)
	values ('Maria', 'O', 'Silva', '22244588800', 'CEP 00 777 000'),
		   ('Marte', 'M', 'Orlando', '55544465400', 'CEP 55 222 111');
 
Insert into Orders (StatusOrders, Ordersdescription)
	values ('Em Processamento', 'Pacote de Arroz'),
		   ('Confirmado', 'Livro de Geometria Analítica'),
           ('Confirmado', 'Micro-ondas');
desc Clients;

SELECT * FROM Clients;
SELECT * FROM Orders;
-- Quantos Pedidos foram confirmados?
SELECT * FROM Orders WHERE StatusOrders = 'Confirmado';
-- Quantos pedidos foram de livros de Geometria Analítica?
SELECT * FROM Orders WHERE StatusOrders = 'Confirmado' HAVING Ordersdescription = 'Livro de Geometria Analítica';
-- Lista ordenada por ID
SELECT * From Clients ORDER BY IdClients;
SELECT * FROM Clients CROSS JOIN Orders;

INSERT INTO RegistredPaymentsMethods (CardNumer, NameInTheCard)
	values (Null, Null),
           (Null,Null);
           
ALTER TABLE Orders
	ADD COLUMN TrackingCode INT default Null;
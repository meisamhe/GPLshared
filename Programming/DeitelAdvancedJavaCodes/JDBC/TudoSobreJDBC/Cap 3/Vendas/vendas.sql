# MySQL
#
# Host: localhost    Database: vendas
#--------------------------------------------------------
# Server version	3.23.41

#
# Tabela 'vendedor'
#

CREATE TABLE vendedor (
  cpf_vendedor varchar(11) NOT NULL default '',
  nom_vendedor varchar(80) NOT NULL default '',
  PRIMARY KEY (cpf_vendedor)
);

INSERT INTO vendedor VALUES ('11111111111','Fernando Anselmo');
INSERT INTO vendedor VALUES ('22222222222','Duke');
INSERT INTO vendedor VALUES ('33333333333','Você da Silva');

#
# Tabela 'mercadoria'
#

CREATE TABLE mercadoria (
  cod_mercadoria int(4) NOT NULL default '0',
  des_mercadoria varchar(80) default NULL,
  prc_item float default NULL,
  PRIMARY KEY  (cod_mercadoria)
);

INSERT INTO mercadoria VALUES (1,'Paçoca São João', 0.50);
INSERT INTO mercadoria VALUES (2,'Amedoin Tio Oliveira', 1.20);
INSERT INTO mercadoria VALUES (3,'Pé-de-Moleque', 0.20);
INSERT INTO mercadoria VALUES (4,'Doce de Batata-Doce', 1.00);

#
# Tabela 'pedido'
#

CREATE TABLE pedido (
  Num_Pedido int(4) NOT NULL default '0',
  Cpf_Vendedor char(11) default NULL,
  Dat_Venda date default NULL,
  PRIMARY KEY  (Num_Pedido)
);

#
# Tabela 'itempedido'
#
CREATE TABLE itempedido (
  Num_Pedido int(4) NOT NULL default '0',
  Num_Item_Pedido int(4) NOT NULL default '0',
  Cod_Mercadoria int(4) default NULL,
  Qtd_Vendida int(4) default NULL,
  PRIMARY KEY  (Num_Pedido,Num_Item_Pedido)
);
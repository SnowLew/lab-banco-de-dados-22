/* criar tabela clientes, produtos, venda */
/* venda e produtos (n,n) */
/* venda e clientes (n,1) */

    drop table if exists cliente cascade;
    drop table if exists produto cascade;
    drop table if exists venda cascade;
    drop table if exists venda_produto cascade;

    create table produto (
        prod_id serial primary key,
        prod_name varchar(255),
        prod_preco double precision
    );

    create table cliente(
        cliente_id serial primary key,
        cliente_nome varchar(255)
    );


    create table venda (
        venda_id serial primary key,
        cliente_venda integer,
        constraint cliente_fk foreign key (cliente_venda) references cliente (cliente_id)
    );

    /* tabela de ligacao n,n * entre produto e venda */
    create table prouto_venda (
        prod_id integer,
        venda_id integer,
        quantidade integer,
        primary key (prod_id, venda_id),
        constraint produto_fk foreign key (prod_id) references produto (prod_id),
        constraint venda_fk foreign key (venda_id) references venda (venda_id)
    );

insert into produto (prod_name, prod_preco) values ('Uva', 10);
insert into produto (prod_name, prod_preco) values ('Maçã', 5);
insert into produto (prod_name, prod_preco) values ('Banana', 3);
insert into produto (prod_name, prod_preco) values ('Pera', 8);
insert into produto (prod_name, prod_preco) values ('Melancia', 7);

insert into cliente (cliente_nome) values ('João');
insert into cliente (cliente_nome) values ('Maria');
insert into cliente (cliente_nome) values ('Pedro');

insert into venda(cliente_venda) values (1);
insert into venda(cliente_venda) values (2);
insert into venda(cliente_venda) values (3);

insert into prouto_venda (prod_id, venda_id, quantidade) values (1, 1, 1);
insert into prouto_venda (prod_id, venda_id, quantidade) values (2, 2, 2);
insert into prouto_venda (prod_id, venda_id, quantidade) values (3, 3, 3);

select cliente_id, c.cliente_nome, prod_name, (quantidade * prod_preco) as total from venda
    inner join prouto_venda pv on venda.venda_id = pv.venda_id
    inner join produto p on pv.prod_id = p.prod_id
    inner join cliente c on venda.cliente_venda = c.cliente_id
    where (quantidade * prod_preco) = (
        select max(pv.quantidade * p.prod_preco) from venda v
        inner join prouto_venda pv on v.venda_id = pv.venda_id
        inner join produto p on pv.prod_id = p.prod_id
    );
--Faturamento Mensal
select 
Round(SUM(payments.payment_value),2) as Faturamento,
strftime('%Y-%m' ,orders.order_purchase_t) as Data_Venda
from payments
inner JOIN orders
on orders.order_id = payments.order_id
GROUP BY Data_Venda
order by Data_Venda

-- Ticket Médio
select 
round(avg(Valor_Pedido),2) as Ticket_Médio
from
(
  sELECT
  payments.order_id as Id_Pedido,
  round(sum(payments.payment_value),2) as Valor_Pedido
  from payments
  GROUP by payments.order_id
 )

-- Categorias que mais vendem
select 
  products.product_category as Categoria_Produto,
  COUNT(*) as Quantidade
from items
INNER join products
on items.product_id = products.product_id
GROUP by Categoria_Produto
order by Quantidade desc;

-- Categorias que mais faturam
select
  products.product_category as Categoria_Produtos,
  Round(Sum(items.price),2) as Faturamento
from products
INNER join items
on products.product_id = items.product_id
GROUP by Categoria_Produtos
Order by Faturamento desc

-- Estados que mais compram
select
    customers.customer_state as Estado,
    count(*) as Quantidade
from customers
INNER JOIN orders
on customers.customer_id = orders.customer_id
GROUP by Estado
Order By Quantidade desc

-- Vendedores que mais faturam
SELECT
  items.seller_id as Id_Vendedor,
  round(sum(items.price),2) as Faturamento
from items
GROUP by Id_Vendedor
Order by Faturamento Desc
limit 5

-- Prazo médio de entrega
select
Round(Avg(julianday(orders.order_delivered) - julianday(orders.order_purchase_t)),0) as Média_Entrega_Dia
from orders

-- Produtos com mais atrasos
select 
  items.product_id as Id_Produto,
  round(Avg(julianday(orders.order_delivered) - julianday(orders.order_estimated)),0) as Dias_Atraso
from orders
INNER join items
on orders.order_id = items.order_id
where orders.order_delivered > orders.order_estimated
GROUP by Id_Produto
order by Dias_Atraso Desc
limit 5

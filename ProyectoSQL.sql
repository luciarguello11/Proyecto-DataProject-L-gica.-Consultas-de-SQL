-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select "actor_id", concat("first_name",' ',"last_name") as "nombre_completo"
from "actor"
where "actor_id" between 30 and 40;


-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select *
from "film"
where "language_id" = "original_language_id"; -- No hay ningún resultado

-- 5. Ordena las películas por duración de forma ascendente.
select *
from "film"
order by "length" asc;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select "first_name","last_name"
from "actor"
where "last_name" = 'ALLEN';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select "rating", count("film_id")
from "film"
group by "rating";

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select "title","rating","length"
from "film"
where "rating" = 'PG-13'
and "length" > 180
order by "length" asc;

-- 9.Encuentra la variabilidad de lo que costaría reemplazar las películas
select variance("replacement_cost")
from "film";

-- 10.Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max(length) as "mayor_duracion",
min(length) as "menor_duracion"
from "film";

-- 11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select "p"."rental_id" , "r"."rental_date", "p"."amount"
from "rental" as "r"
inner join "payment" as "p" on "p"."rental_id" ="r"."rental_id"
order by "rental_date" desc
limit 1 offset 2;

-- 12.Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select "title","rating","length"
from "film"
where "rating" <> 'NC-17'
and "rating" <> 'G' 
order by "length" asc;

-- 13.	Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select "rating", avg("length")
from "film"
group by "rating";

-- 14.	Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title","length"
from "film"
where "length" > 180;

-- 15.	¿Cuánto dinero ha generado en total la empresa?
select sum("amount") as "total"
from "payment";

-- 16.	Muestra los 10 clientes con mayor valor de id.
select "customer_id","first_name","last_name"
from "customer"
order by "customer_id" desc
limit 10;

-- 17.	Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select "f"."title", "a"."first_name", "a"."last_name"
from "film" as "f"
inner join "film_actor" as "fa" on "f"."film_id" = "fa"."film_id"
inner join "actor" as "a" on "a"."actor_id" = "fa"."actor_id"
where "f"."title" = 'EGG IGBY';

-- 18.	Selecciona todos los nombres de las películas únicos.
select distinct("title")
from "film";

-- 19.	Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select "c"."name", "f"."title", "f"."length"
from "film" as "f"
inner join "film_category" as "fc" on "fc"."film_id" = "f"."film_id"
inner join "category" as "c" on "c"."category_id" = "fc"."category_id"
where "c"."name" = 'Comedy'
and "f"."length" > 180;

-- 20.	Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
with promedio as (select "c"."name", avg("f"."length") as "promedio_duracion"
from "film" as "f"
inner join "film_category" as "fc" on "fc"."film_id" = "f"."film_id"
inner join "category" as "c" on "c"."category_id" = "fc"."category_id"
group by "c"."name")
select * from promedio
where "promedio_duracion" > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
select avg("rental_duration")
from film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select "actor_id",
concat("first_name",' ',"last_name") as "nombre_completo"
from actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select "rental_date", count("rental_id") as "alquileres_diarios"
from "rental"
group by "rental_date"
order by "alquileres_diarios" desc;

select cast("rental_date" as date) as "fecha",
count("rental_id") as "alquileres_diarios"
from "rental"
group by cast("rental_date" as date) 
order by "alquileres_diarios" desc;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT "title", "length"
FROM film
WHERE "length" > (SELECT AVG("length") FROM "film")
ORDER BY "length" DESC;

-- 25. Averigua el número de alquileres registrados por mes.
select extract(month from "rental_date") as "mes", count("rental_id")
from "rental"
group by "mes"
order by "mes" asc;

-- 26.	Encuentra el promedio, la desviación estándar y varianza del total pagado.
select 
avg("amount") as "promedio",
stddev("amount") as "desv_est",
variance("amount") as "varianza"
from "payment";

-- 27.	¿Qué películas se alquilan por encima del precio medio?
SELECT "title", "rental_rate"
FROM "film"
WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film")
ORDER BY "rental_rate" DESC;

-- 28.	Muestra el id de los actores que hayan participado en más de 40 películas.

select "a"."actor_id" as "id",
"a"."first_name" as "nombre", 
"a"."last_name" as "apellido",
count("fa"."film_id") as "num_peliculas"
from "film" as "f"
inner join "film_actor" as "fa" on "f"."film_id" = "fa"."film_id"
inner join "actor" as "a" on "a"."actor_id" = "fa"."actor_id"
group by "a"."actor_id", "a"."first_name", "a"."last_name"
having count("fa"."film_id") > 40
order by "num_peliculas" desc;


-- 29.	Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
with "pelis" as (select "f"."film_id" as "id_peli", "f"."title" as "titulo",
"i"."inventory_id" as "id_inventario"
from "film" as "f"
inner join "inventory" as "i" on "f"."film_id" = "i"."film_id")
select "titulo", count("id_inventario") as "cantidad"
from "pelis"
group by "titulo"
order by "cantidad" desc;

-- 30.	Obtener los actores y el número de películas en las que ha actuado.
with "actores" as (select "f"."title" as "titulo", concat("a"."first_name",' ', "a"."last_name") as "actor"
from "film" as "f"
inner join "film_actor" as "fa" on "f"."film_id" = "fa"."film_id"
inner join "actor" as "a" on "a"."actor_id" = "fa"."actor_id")
select "actor", count("titulo") as "num_pelis"
from "actores"
group by "actor"
order by "num_pelis" desc;

-- 31.	Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select "f"."title" as "pelicula", "a"."first_name", "a"."last_name"
from "film" as "f"
left join "film_actor" as "fa" on "f"."film_id" = "fa"."film_id"
left join "actor" as "a" on "a"."actor_id" = "fa"."actor_id"
order by "f"."title" asc;

-- 32.	Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select concat("a"."first_name",' ', "a"."last_name") as "actor","f"."title" as "pelicula"
from "film_actor" as "fa"
left join "actor" as "a" on "fa"."actor_id" = "a"."actor_id"
left join "film" as "f" on "f"."film_id" = "fa"."film_id";

-- 33.	Obtener todas las películas que tenemos y todos los registros de alquiler.
select "f"."title" as "pelicula",
"f"."rental_duration" as "duracion_alquiler",
"f"."rental_rate" as "precio_alquiler",
"r"."rental_id" as "alquiler_id",
"r"."rental_date" AS "fecha_alquiler",
"r"."return_date" AS "fecha_devolucion",
"i"."inventory_id" AS "copia_id",
COALESCE("r"."customer_id"::text, 'nunca_alquilada') AS "estado_cliente"
from "film" as "f"
left join "inventory" as "i" on "f"."film_id" = "i"."film_id"
left join "rental" as "r" on "r"."inventory_id" = "i"."inventory_id"
order by "pelicula" asc, "r"."rental_date" desc;

-- 34.	Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
with "alquileres" as (select "c"."customer_id" as "id_cliente",concat("c"."first_name",' ', "c"."last_name") as "cliente",
"p"."amount" as "gastado"
from "customer" as "c"
inner join "payment" as "p" on "c"."customer_id" = "p"."customer_id")
select "id_cliente","cliente", sum("gastado") as "total_gastado"
from "alquileres"
group by "id_cliente","cliente"
order by "total_gastado" desc
limit 5;


-- 35.	Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select "actor_id",
"first_name" as "Nombre","last_name" as "Apellido"
from actor
where "first_name" = 'JOHNNY' ;

-- 36.	Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select "actor_id",
"first_name" as "Nombre","last_name" as "Apellido"
from actor
where "first_name" = 'JOHNNY' ;

-- 37.	Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min("actor_id"), max("actor_id")
from "actor";

-- 38.	Cuenta cuántos actores hay en la tabla “actor”.
select count("actor_id") as "num_actores"
from "actor";

-- 39.	Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "actor_id",
"first_name" as "Nombre","last_name" as "Apellido"
from actor
order by "Apellido" asc;

-- 40.	Selecciona las primeras 5 películas de la tabla “film”.
select *
from "film"
limit 5;

-- 41.	Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
with "actores" as (select "actor_id",
"first_name" as "Nombre","last_name" as "Apellido"
from actor)
select "Nombre", count(*) as "veces_nombre"
from "actores"
group by "Nombre"
order by "veces_nombre" desc;

-- 42.	Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select "r"."rental_id", "r"."rental_date", "c"."first_name", "c"."last_name"
from "rental" as "r"
inner join "customer" as "c" on "c"."customer_id" = "r"."customer_id";

-- 43.	Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
select "c"."first_name", "c"."last_name", "r"."rental_id", "r"."rental_date"
from "customer" as "c"
left join "rental" as "r" on "c"."customer_id" = "r"."customer_id"
order by "first_name" asc;

-- 44.	Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select * 
from "film"
cross join "category"; -- Si tiene valor dado que nos muestra la categoria de la película

-- 45.	Encuentra los actores que han participado en películas de la categoría 'Action'.

select distinct concat("a"."first_name",' ', "a"."last_name") as "actor","f"."title" as "titulo",
"c"."name"
from "actor" as "a"
inner join "film_actor" as "fa" on "fa"."actor_id" = "a"."actor_id"
inner join "film" as "f" on "fa"."film_id" = "f"."film_id"
inner join "film_category" as "fc" on "fc"."film_id" ="f"."film_id"
inner join "category" as "c" on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Action'
order by "actor";

select distinct concat("a"."first_name",' ', "a"."last_name") as "actor"
from "actor" as "a"
inner join "film_actor" as "fa" on "fa"."actor_id" = "a"."actor_id"
inner join "film" as "f" on "fa"."film_id" = "f"."film_id"
inner join "film_category" as "fc" on "fc"."film_id" ="f"."film_id"
inner join "category" as "c" on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Action'
group by "actor"
order by "actor"
;
-- 46.	Encuentra todos los actores que no han participado en películas.
SELECT 
    "a"."actor_id",
    "a"."first_name" AS "Nombre",
    "a"."last_name" AS "Apellido"
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
WHERE "fa"."film_id" IS NULL; 

-- 47.	Selecciona el nombre de los actores y la cantidad de películas en la que han participado.
select distinct concat("a"."first_name",' ', "a"."last_name") as "actor",count(distinct("f"."title"))
from "actor" as "a"
inner join "film_actor" as "fa" on "fa"."actor_id" = "a"."actor_id"
inner join "film" as "f" on "fa"."film_id" = "f"."film_id"
group by concat("a"."first_name",' ', "a"."last_name")
order by count desc;

-- 48.	Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW actor_num_peliculas AS
SELECT 
    "a"."first_name" AS "nombre", 
    "a"."last_name" AS "apellido", 
    COUNT("fa"."film_id") AS "total_peliculas"
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
GROUP BY "a"."actor_id", "a"."first_name", "a"."last_name";
SELECT * FROM actor_num_peliculas
WHERE total_peliculas > 20
ORDER BY total_peliculas DESC;


-- 49.	Calcula el número total de alquileres realizados por cada cliente.
with "total_alquileres" as (select "c"."customer_id" as "id_cliente",
"c"."first_name" as "nombre",
"c"."last_name" as "apellido",
"r"."rental_id" as "id_alquiler"
from "customer" as "c"
inner join "rental" as "r" on "c"."customer_id" = "r"."customer_id")
select "nombre","apellido", count("id_alquiler") as "alquileres_hechos"
from "total_alquileres"
group by "nombre","apellido"
order by "alquileres_hechos" desc;



-- 50.	Calcula la duración total de las películas en la categoría 'Action'.
with "action" as (select "c"."name" as "categoria", "f"."title" as "titulo", "f"."length" as "duracion"
from "film" as "f"
inner join "film_category" as "fc" on "fc"."film_id" = "f"."film_id"
inner join "category" as "c" on "c"."category_id" = "fc"."category_id"
where "c"."name" = 'Action')
select "categoria",
sum("duracion") as "total"
from "action"
group by "categoria";

-- 51.	Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE "cliente_rentas_temporal" AS
SELECT 
    "customer_id", 
    COUNT(*) AS "total_alquileres"
FROM "rental"
GROUP BY "customer_id";


--52.	Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE "peliculas_alquiladas" AS
SELECT 
    "f"."film_id", 
    "f"."title" AS "titulo", 
    COUNT("r"."rental_id") AS "total_alquileres"
FROM "film" AS "f"
INNER JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id"
INNER JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
GROUP BY "f"."film_id", "f"."title"
HAVING COUNT("r"."rental_id") >= 10;

--53.	Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select "f"."film_id", "f"."title",concat("c"."first_name",' ',"c"."last_name") as "cliente",
"r"."rental_date","r"."return_date"
from "film" as "f"
left join "inventory" as "i" on "f"."film_id" = "i"."film_id"
left join "rental" as "r" on "r"."inventory_id" = "i"."inventory_id"
left join "customer" as "c" on "r"."customer_id" = "c"."customer_id"
where "c"."first_name" = 'TAMMY'
and "c"."last_name" = 'SANDERS'
and "r"."return_date" is null
order by "f"."title" asc;



--54.	Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
with "actores" as (select distinct "a"."first_name" as "nombre","a"."last_name" as "apellido" ,"f"."title" as "titulo",
"c"."name" as "categoria"
from "actor" as "a"
inner join "film_actor" as "fa" on "fa"."actor_id" = "a"."actor_id"
inner join "film" as "f" on "fa"."film_id" = "f"."film_id"
inner join "film_category" as "fc" on "fc"."film_id" ="f"."film_id"
inner join "category" as "c" on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Sci-Fi'
order by "a"."last_name" asc)
select "nombre", "apellido"
from "actores"
group by "nombre", "apellido";

--55.	Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. 
-- Ordena los resultados alfabéticamente por apellido.
select distinct "a"."first_name" AS "nombre", 
"a"."last_name" AS "apellido" 
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
INNER JOIN "film" AS "f" ON "fa"."film_id" = "f"."film_id"
INNER JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id"
INNER JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
WHERE "r"."rental_date" > (
	SELECT MIN("r2"."rental_date")
    FROM "rental" AS "r2"
    INNER JOIN "inventory" AS "i2" ON "r2"."inventory_id" = "i2"."inventory_id"
    INNER JOIN "film" AS "f2" ON "i2"."film_id" = "f2"."film_id"
    WHERE "f2"."title" = 'SPARTACUS CHEAPER'
)
ORDER BY "a"."last_name" ASC;


--56.	Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

with "actores" as (select distinct "a"."first_name" as "nombre","a"."last_name" as "apellido" ,"f"."title" as "titulo",
"c"."name" as "categoria"
from "actor" as "a"
inner join "film_actor" as "fa" on "fa"."actor_id" = "a"."actor_id"
inner join "film" as "f" on "fa"."film_id" = "f"."film_id"
inner join "film_category" as "fc" on "fc"."film_id" ="f"."film_id"
inner join "category" as "c" on "fc"."category_id" = "c"."category_id"
where "c"."name" <> 'Music'
order by "a"."last_name" asc)
select "nombre", "apellido"
from "actores"
group by "nombre", "apellido";

--57.	Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select "f"."title", ("return_date"::date - "rental_date"::date) as "duracion_alquiler"
from "film" as "f"
left join "inventory" as "i" on "f"."film_id" = "i"."film_id"
left join "rental" as "r" on "r"."inventory_id" = "i"."inventory_id"
where ("return_date"::date - "rental_date"::date) > 8
order by "duracion_alquiler" desc;


--58.	Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

select "c"."name" as "categoria", "f"."title" as "titulo"
from "film" as "f"
inner join "film_category" as "fc" on "fc"."film_id" = "f"."film_id"
inner join "category" as "c" on "c"."category_id" = "fc"."category_id"
where "c"."name" = 'Animation'


--59.	Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select "f"."title","f"."length" 
from "film" as "f"
where "f"."length" = (
	select "f2"."length"
    from "film" AS "f2"
    where "f2"."title" = 'DANCING FEVER'
)
order by "f"."length" asc;

--60.	Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select 
    "c"."first_name" as "nombre", 
    "c"."last_name" as "apellido"
from "customer" as "c"
inner join "rental" as "r" on "c"."customer_id" = "r"."customer_id"
inner join "inventory" as "i" on "r"."inventory_id" = "i"."inventory_id"
inner join "film" as "f" on "i"."film_id" = "f"."film_id"
group by "c"."customer_id", "c"."first_name", "c"."last_name"
having COUNT(distinct "f"."film_id") >= 7
order by "c"."last_name" asc;

--61.	Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select "c"."name" as "categoria", count("r"."rental_id") as "total_alquileres"
from "film" as "f"
inner join "film_category" as "fc" on "fc"."film_id" = "f"."film_id"
inner join "category" as "c" on "c"."category_id" = "fc"."category_id"
inner join "inventory" as "i" on "i"."film_id" = "f"."film_id"
inner join "rental" as "r" on "i"."inventory_id" = "r"."inventory_id" 
group by "c"."name"
order by "total_alquileres" desc;

--62.	Encuentra el número de películas por categoría estrenadas en 2006.
select "c"."name" as "categoria", count("f"."title") as "total_peliculas"
from "film" as "f"
inner join "film_category" as "fc" on "fc"."film_id" = "f"."film_id"
inner join "category" as "c" on "c"."category_id" = "fc"."category_id"
where "f"."release_year" = 2006
group by "c"."name"
order by "total_peliculas" desc;

--63.	Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat("s"."first_name", ' ', "s"."last_name") AS "trabajador",
"st"."store_id" AS "id_tienda"
from "staff" as "s"
cross join "store" as "st";


--64.	Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select 
    "c"."customer_id", 
    "c"."first_name" as "nombre", 
    "c"."last_name" as "apellido", 
    count("r"."rental_id") as "total_alquileres"
from "customer" as "c"
left join "rental" as "r" on "c"."customer_id" = "r"."customer_id"
group by "c"."customer_id", "c"."first_name", "c"."last_name"
order by "total_alquileres" desc;

/* 2. Muestra los nombres de todas las películas con una clasificación por  edades de ‘Rʼ. */

select "title" as titulo_pelicula , "rating" as clasificacion
from "film" 
where  "rating" = 'R';

/* 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 
y 40. */

select "actor_id" , CONCAT(first_name, ' ', last_name) AS Nombre_Completo_Actor
from  "actor"
where  "actor_id" between 30 AND 40 ;

/* 4. Obtén las películas cuyo idioma coincide con el idioma original. */

select "original_language_id" , "title" as titulo_pelicula
from  "film"
where "language_id" = "original_language_id" ;

/* 5. Ordena las películas por duración de forma ascendente. */

select "title" as titulo_pelicula, "length"  as duracion
from "film"
order by "length" asc;

/* 6.  Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su 
apellido. */

select "first_name" as nombre , "last_name" as apellido
from "actor" 
where  "last_name" like '%ALLEN%';

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla 
“filmˮ y muestra la clasificación junto con el recuento. */

select "rating" as "clasificacion" , count ("film_id") as "cantidad_peliculas"
from "film"
group by "rating" ;

/* 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una 
duración mayor a 3 horas en la tabla film. */

select "title" as "titulo_pelicula",
       "rating" as "clasificacion",
       "length" as "duracion"
from "film"
where "rating" = 'PG-13' or "length" > 180 ;

/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas. */


select variance ("replacement_cost") as "variabilidad_reemplazo"
from "film";

/* 10.  Encuentra la mayor y menor duración de una película de nuestra BBDD. */

select max ("length") as "duracion_maxima",
       min ("length") as "duracion_minima"
from "film" ;

/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día. */

select p."amount" as "costo_antepenultimo",
       r."rental_date" as "dia_alquiler"
from "rental" r
inner join "payment" p on r."rental_id" = p."rental_id"
order by r."rental_date" desc
limit 1 offset 2;

/* 12.   Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-
 17ʼ ni ‘Gʼ en cuanto a su clasificación. */

select "title" as "titulo_pelicula" , "rating" as " clasificacion"
from  "film"
where "rating" not in ('NC-17', 'G') ;

/* 13.  Encuentra el promedio de duración de las películas para cada 
clasificación de la tabla film y muestra la clasificación junto con el 
promedio de duración. */

select "rating" as "clasificacion",
   avg("length") as "promedio_duracion"
from  "film"
group by "rating" ;

/* 14.  Encuentra el título de todas las películas que tengan una duración mayor 
a 180 minutos. */

select "title" as "titulo_Pelicula", "length" as "duracion"
from "film"
where "length" > 180 ;

/* ¿Cuánto dinero ha generado en total la empresa? */

select sum("amount") as "total_generado"
from "payment";

/* 16. Muestra los 10 clientes con mayor valor de id. */

select "customer_id",
 concat("first_name", ' ' ,"last_name") as "nombre_clientes"
from "customer"
order by "customer_id" desc
limit 10 ;

/* 17. Encuentra el nombre y apellido de los actores que aparecen en la 
película con título ‘Egg Igbyʼ */

select  concat( a."first_name",' ', a."last_name") as nombre_actores , f."title"
from "actor" a
inner join "film_actor" fa on a."actor_id" = fa."actor_id"
inner join "film" f on fa."film_id" = f."film_id"
where f."title" = 'EGG IGBY' ;

/* 18. Selecciona todos los nombres de las películas únicos.  */

select distinct "title" as nombre_peliculas
from "film" ;


/* 19. Encuentra el título de las películas que son comedias y tienen una 
duración mayor a 180 minutos en la tabla “filmˮ. */

select f."title" as "titulo_pelicula" , c."name" as "categoria" , f."length" as duracion
from "film" f
inner join "film_category" fc 
        on f."film_id" = fc."film_id"
inner join "category" c on fc."category_id" = c."category_id"
where c."name" = 'Comedy' and f."length" > 180;

/* 20.  Encuentra las categorías de películas que tienen un promedio de 
duración superior a 110 minutos y muestra el nombre de la categoría 
junto con el promedio de duración. */

select c."name" as "categoria", avg(f."length") as "promedio_duracion"
from "film" f
inner join "film_category" fc 
        on f."film_id" = fc."film_id"
inner join "category" c
        on fc."category_id" = c."category_id"
group by c."name"
having avg(f."length") > 110;


/* 21. ¿Cuál es la media de duración del alquiler de las películas? */

select avg("rental_duration") as "media_duracion_alquiler"
from "film";

/* 22. Crea una columna con el nombre y apellidos de todos los actores y 
actrices. */

select concat("first_name", ' ', "last_name") as nombre_actores
from "actor";

/* 23. Números de alquiler por día, ordenados por cantidad de alquiler de 
forma descendente. */

select 
    date ("rental_date") as "dia",
    count (*) as "cantidad_alquileres"
from "rental"
group by date("rental_date")
order by "cantidad_alquileres" desc;

/* 24.  Encuentra las películas con una duración superior al promedio. */

select 
    "title" as "titulo_pelicula",
    "length" as "duracion"
from "film"
where "length" > (select avg("length") from "film");


/* 25. Averigua el número de alquileres registrados por mes. */

select
    extract (year from "rental_date") as "año",
    extract (month from "rental_date") as "mes",
    count (*) as "cantidad_alquileres"
    
from "rental"
group by 
    extract(year from "rental_date"),
    extract(month from "rental_date")
order by "año", "mes";

/* 26.  Encuentra el promedio, la desviación estándar y varianza del total 
pagado. */

select 
    avg("amount") as "promedio_total",
    stddev("amount") as "desviacion_estandar",
    variance("amount") as "varianza"
from "payment";

/* 27. ¿Qué películas se alquilan por encima del precio medio? */

select "title" as "titulo_pelicula","rental_rate" as "tarifa_alquiler"
from "film"
where "rental_rate" > (select avg("rental_rate") from "film") ;

/* 28. Muestra el id de los actores que hayan participado en más de 40 
películas. */

select "actor_id"
from "film_actor"
group by "actor_id"
having count(*) > 40;

/* 29. Obtener todas las películas y, si están disponibles en el inventario, 
mostrar la cantidad disponible. */

select 
  f."title" as "titulo_de_pelicula",
  count(i."inventory_id") as "cantidad_disponible"
from "film" f
left join "inventory" i on f."film_id" = i."film_id"
left join "rental" r on i."inventory_id" = r."inventory_id" 
           and r."return_date" is null
where r."rental_id" is null
group by f."title"
order by "cantidad_disponible" desc;

/* 30. Obtener los actores y el número de películas en las que ha actuado. */

select 
    concat(a."first_name", ' ' , a."last_name") as "nombre_actor",
    count(*) as "numero_de_peliculas"
from "film_actor" fa
inner join "actor" a 
        on fa."actor_id" = a."actor_id"
group by a."first_name", a."last_name"
order by "numero_de_peliculas" desc;

/* 31. Obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados. */

select 
    f."title" as "titulo_pelicula",
    concat(a."first_name" , ' ' , a."last_name") as "nombre_actor"
from "film" f
left join "film_actor" fa 
        on f."film_id" = fa."film_id"
left join "actor" a 
        on fa."actor_id" = a."actor_id"
order by f."title" ;

/* 32. Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película. */

select 
    concat(a."first_name" , ' ' , a."last_name") as "nombre_actor",
    f."title" as "titulo_pelicula"
from "actor" a
left join "film_actor" fa 
       on a."actor_id" = fa."actor_id"
left join "film" f 
       on fa."film_id" = f."film_id"
order by a."last_name", a."first_name";

/* 33. Obtener todas las películas que tenemos y todos los registros de 
alquiler. */

select 
    f."title"as "titulo_pelicula",
    r."rental_id",
    r."rental_date" as "rentado",
    r."return_date" as "devuelto"
from "film" f
full join "inventory" i 
       on f."film_id" = i."film_id"
full join "rental" r
       on i."inventory_id" = r."inventory_id"
order by f."title", r."rental_date";

/* 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros. */

select 
  c."customer_id" as "id",
  c."first_name" as "nombre", 
  c."last_name" as "apellido", 
  sum(p."amount") as "total_pagado"
from "customer" c
inner join "payment" p on c."customer_id" = p."customer_id"
group by c."customer_id", c."first_name", c."last_name"
order by "total_pagado" desc
limit 5;

/* 35. Selecciona todos los actores cuyo primer nombre es 'Johnny' */

select 
    "actor_id" as "id",
    "first_name" as "nombre",
    "last_name" as " apellido"
from "actor"
where "first_name" = 'JOHNNY';

/* 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como 
Apellido. */

select 
    "actor_id" as "id",
    "first_name" as "nombre",
    "last_name" as "apellido"
from "actor";

/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor. */

select 
    min("actor_id") as "id_mas_bajo",
    max("actor_id") as "id_mas_alto"
from  "actor";

/* 38. Cuenta cuántos actores hay en la tabla “actorˮ. */

select 
    count("actor_id") as "total_actores"
from "actor";

/* 39. Selecciona todos los actores y ordénalos por apellido en orden 
ascendente. */

select 
    "first_name" as "nombre",
    "last_name" as "apellido"
from "actor"
order by "last_name" asc;

/* 40. Selecciona las primeras 5 películas de la tabla “filmˮ. */

select  "title" as "titulo_pelicula"
from  "film"
limit 5;

/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el 
mismo nombre. ¿Cuál es el nombre más repetido? */

select 
    "first_name" as "nombre",
    count(*) as "cantidad"
from "actor"
group by "first_name"
order by "cantidad" desc
limit 1;

/* 42. Encuentra todos los alquileres y los nombres de los clientes que los 
realizaron.  */

select 
    r."rental_id",
    r."rental_date",
    c."first_name" as "nombre",
    c."last_name" as "apellido"
from "rental" r
inner join "customer" c
        on r."customer_id" = c."customer_id"
order by r."rental_date";

/* 43.  Muestra todos los clientes y sus alquileres si existen, incluyendo 
aquellos que no tienen alquileres. */

select 
    c."customer_id",
    c."first_name" as "nombre",
    c."last_name" as "apellido",
    r."rental_id",
    r."rental_date"
from "customer" c
left join "rental" r 
       on c."customer_id" = r."customer_id"
order by c."customer_id";

/* 44.  Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor 
esta consulta? ¿Por qué? Deja después de la consulta la contestación. */ 

select 
    f."title" as "titulo_pelicula",
    c."name" as "categoria"
from  "film" f
cross join "category" c;

/* No aporta ningun valor, al menos no directamente , habría que usar joins con la tabla intermedia "film_category". */

/* 45.  Encuentra los actores que han participado en películas de la categoría 
'Action'. */

select 
    a."first_name" as "nombre",
    a."last_name" as "apellido",
    c."name" as "categoria"
from "actor" a
inner join "film_actor" fa 
        on a."actor_id" = fa."actor_id"
inner join "film" f 
        on fa."film_id" = f."film_id"
inner join "film_category" fc 
        on f."film_id" = fc."film_id"
inner join "category" c 
        on fc."category_id" = c."category_id"
where c."name" = 'Action'
order by a."last_name", a."first_name";

/* 46 Encuentra todos los actores que no han participado en películas */

select 
    a."first_name" as "nombre",
    a."last_name" as "apellido"
from "actor" a
left join "film_actor" fa 
       on a."actor_id" = fa."actor_id"
where fa."film_id" is null
order by a."last_name", a."first_name";

/* 47. Selecciona el nombre de los actores y la cantidad de películas en las 
que han participado. */

select 
  a."actor_id" as "id",
  a."first_name" as "nombre", 
  a."last_name" as "apellido", 
  count(fa."film_id") as "cantidad_peliculas"
from "actor" a
inner join "film_actor" fa 
        on a."actor_id" = fa."actor_id"
group by a."actor_id", a."first_name", a."last_name"
order by "cantidad_peliculas" desc;

/* 48  Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres 
de los actores y el número de películas en las que han participado.*/

create view "actor_num_peliculas" as
select 
  a."actor_id" as "id",
  a."first_name" as "nombre", 
  a."last_name" as "apellido", 
  count(fa."film_id") as "cantidad_peliculas"
from "actor" a
inner join "film_actor" fa on a."actor_id" = fa."actor_id"
group by a."actor_id", a."first_name", a."last_name";

select *
from actor_num_peliculas anp 


/* 49 Calcula el número total de alquileres realizados por cada cliente */

select 
    c."customer_id" as "id",
    c."first_name" as "nombre",
    c."last_name" as "apellido",
    count(r."rental_id") as "numero_de_alquileres"
from "customer" c
left join "rental" r 
       on c."customer_id" = r."customer_id"
group by c."customer_id", c."first_name", c."last_name"
order by "numero_de_alquileres" desc;

/* 50. Calcula la duración total de las películas en la categoría 'Action'  */

select 
    sum(f."length") as "duracion_total"
from "film" f
inner join "film_category" fc on f."film_id" = fc."film_id"
inner join "category" c on fc."category_id" = c."category_id"
where c."name" = 'Action';

/* 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para 
almacenar el total de alquileres por cliente. */

create temporary table "cliente_rentas_temporal" as
select 
    c."customer_id",
    c."first_name" as "nombre",
    c."last_name" as "apellido",
    count(r."rental_id") as "numero_de_alquileres"
from "customer" c
left join "rental" r 
       on c."customer_id" = r."customer_id"
group by c."customer_id", c."first_name", c."last_name";

select *
from cliente_rentas_temporal

/* 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las 
películas que han sido alquiladas al menos 10 veces. */

create temporary table "peliculas_alquiladas" as
select 
    f."film_id",
    f."title" as "titulo",
    count(r."rental_id") as "cantidad_de_alquileres"
from "rental" r
inner join "inventory" i 
        on r."inventory_id" = i."inventory_id"
inner join "film" f 
        on i."film_id" = f."film_id"
group by f."film_id", f."title"
having count(r."rental_id") >= 10;


select *
from peliculas_alquiladas


/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente 
con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena 
los resultados alfabéticamente por título de película. */

select 
    f."title" as "titulo_pelicula"
from "rental" r
inner join "customer" c 
        on r."customer_id" = c."customer_id"
inner join "inventory" i 
        on r."inventory_id" = i."inventory_id"
inner join "film" f 
        on i."film_id" = f."film_id"
where 
    c."first_name" = 'TAMMY' and 
    c."last_name" = 'SANDERS' and
    r."return_date" is null
order by f."title" asc;

/* 54. Encuentra los nombres de los actores que han actuado en al menos una 
película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados 
alfabéticamente por apellido. */

select 
    a."first_name" as "nombre",
    a."last_name" as "apellido",
    c."name" as "categoria"
from "actor" a
inner join "film_actor" fa 
        on a."actor_id" = fa."actor_id"
inner join "film_category" fc 
        on fa."film_id" = fc."film_id"
inner join "category" c 
        on fc."category_id" = c."category_id"
where c."name" = 'Sci-Fi'
order by a."last_name" asc;

/* 55.  Encuentra el nombre y apellido de los actores que han actuado en 
películas que se alquilaron después de que la película ‘Spartacus 
Cheaperʼ se alquilara por primera vez. Ordena los resultados 
alfabéticamente por apellido. */

select 
 a."first_name" as "nombre",
    a."last_name" as "apellido"
from "actor" a
inner join "film_actor" fa 
        on a."actor_id" = fa."actor_id"
inner join "film" f 
        on fa."film_id" = f."film_id"
inner join "inventory" i 
        on f."film_id" = i."film_id"
inner join "rental" r 
        on i."inventory_id" = r."inventory_id"
where r."rental_date" > (
    select min(rental_date)
    from "rental" r2
    inner join "inventory" i2 
            on r2."inventory_id" = i2."inventory_id"
    inner join "film" f2 
            on i2."film_id" = f2."film_id"
    where f2."title" = 'SPARTACUS CHEAPER')
group by a."actor_id", a."first_name", a."last_name"
order by a."last_name", a."first_name";

/* 56.  Encuentra el nombre y apellido de los actores que no han actuado en 
ninguna película de la categoría ‘Musicʼ. */

select 
    a."first_name" as "nombre",
    a."last_name" as "apellido"
from "actor" a
where a."actor_id" not in (
        select fa."actor_id"
        from "film_actor" fa
        inner join "film_category" fc 
                on fa."film_id" = fc."film_id"
        inner join "category" c 
                on fc."category_id" = c."category_id"
        where c."name" = 'Music')
order by a."last_name" asc;

/* 57. Encuentra el título de todas las películas que fueron alquiladas por más 
de 8 días. */

select distinct  f."title"
from "rental" r
inner join "inventory" i 
        on r."inventory_id" = i."inventory_id"
inner join "film" f 
        on i."film_id" = f."film_id"
where r."return_date" - r."rental_date" > interval '8 days';

/* 58. Encuentra el título de todas las películas que son de la misma categoría 
que ‘Animationʼ.*/

select f."title" , c."name"
from "film" f
inner join "film_category" fc 
        on f."film_id" = fc."film_id"
inner join "category" c 
        on fc."category_id" = c."category_id"
where c."name" = 'Animation';

/* 59. Encuentra los nombres de las películas que tienen la misma duración 
que la película con el título ‘Dancing Feverʼ. Ordena los resultados 
alfabéticamente por título de película. */

select f."title", f."length"
from "film" f
where  f."length" = (
        select "length"
        from "film"
        where "title" = 'DANCING FEVER')
order by f."title" asc;

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7 
películas distintas. Ordena los resultados alfabéticamente por apellido.*/

select 
    c."customer_id",
    c."first_name" as "nombre",
    c."last_name" as "apellido",
    count(distinct f."film_id") as "peliculas_diferentes"
from "customer" c
inner join "rental" r 
        on c."customer_id" = r."customer_id"
inner join "inventory" i 
        on r."inventory_id" = i."inventory_id"
inner join "film" f 
        on i."film_id" = f."film_id"
group by c."customer_id", c."first_name", c."last_name"
having count(distinct f."film_id") >= 7
order by c."last_name" asc;

/* 61. Encuentra la cantidad total de películas alquiladas por categoría y 
muestra el nombre de la categoría junto con el recuento de alquileres. */

select 
    c."name" as "categoria",
    count(r."rental_id") as "cantidad_alquileres"
from "rental" r
inner join "inventory" i 
        on r."inventory_id" = i."inventory_id"
inner join "film" f 
        on i."film_id" = f."film_id"
inner join "film_category" fc 
        on f."film_id" = fc."film_id"
inner join "category" c 
on fc."category_id" = c."category_id"
group by c."name"
order by "cantidad_alquileres" desc;

/* 62. Encuentra el número de películas por categoría estrenadas en 2006 */

select 
    c."name" as "categoria",
    count(f."film_id") as "peliculas_2006"
from "film" f
inner join "film_category" fc 
        on f."film_id" = fc."film_id"
inner join "category" c 
        on fc."category_id" = c."category_id"
where f."release_year" = 2006
group by c."name"
order by "peliculas_2006" desc;


/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas 
que tenemos. */

select 
    concat("first_name" , ' ' , s."last_name") as "empleado",
    t."store_id" as "tienda"
from 
    "staff" s
cross join 
    "store" t
order by 
    "empleado", "tienda";

/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de 
películas alquiladas.  */

select 
    c."customer_id" as "id_cliente",
    c."first_name" as "nombre",
    c."last_name" as "apellido",
    count(r."rental_id") as "peliculas_alquiladas"
from "customer" c
inner join "rental" r 
        on c."customer_id" = r."customer_id"
group by c."customer_id", c."first_name", c."last_name"
order by "peliculas_alquiladas" desc;



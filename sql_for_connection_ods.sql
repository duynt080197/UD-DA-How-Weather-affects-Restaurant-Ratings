use schema PROJECT2_DATABASE.ODS;

/*a query for the connection between yelp review with climate temperature and precipitation through 'date' key*/

select r.review_id, r.stars, r.date, t.min, t.max, t.normal_min, t.normal_max, p.precipitation, p.precipitation_normal
from review as r
join temperature as t
on r.date = t.date
join precipitation as p
on r.date = p.date;
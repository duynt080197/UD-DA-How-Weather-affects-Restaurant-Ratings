select f.business_id, f.date, t.precipitation_normal, t.precipitation, t.min, t.max, t.normal_min, t.normal_max, avg(r.stars) as rating
from fact_table as f
join business as b
on f.business_id = b.business_id 
join review as r
on r.business_id = b.business_id
join daily_temp_pre as t
on f.date = t.date
group by f.business_id, f.date, t.precipitation_normal, t.precipitation, t.min, t.max, t.normal_min, t.normal_max;
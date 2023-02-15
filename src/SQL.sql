select seq, id, ref, step, depth, title, content, wdate, del, readcount
from
(select row_number()over(order by ref desc, step asc) as rnum,
		seq, id, ref, step, depth, title, content, wdate, del, readcount
from bbs
-- 검색
order by ref desc, step asc) a
where rnum >= 1 and rnum <= 10;




select * from bbs;
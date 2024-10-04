-- 1. 내가 진행중, 진행 완료한 미션 모아서 보는 쿼리 (페이징 포함)
select um.status, m.point, s.name, m.missionText, m.deadline
from mission as m 
inner join user_mission as um
on m.id = um.mission_id
inner join shop as s
on m.shop_id = s.id
where um.user_id = 1 and um.status in ('진행중', '진행 완료')
order by m.deadline desc limit 10, 0;


-- 2. 리뷰 작성하는 쿼리 (사진 배제)
insert into review (id, user_id, shop_id, content, rating) value (1, 1, 1, '맛 없는데 은근 끌리네요. 5점을 드릴테니, 다음에 서비스 주세요', 5.0);
  /**
    id가 bigint 시 auto_increment로 설정되어 있어서, id를 직접 입력하지 않아도 됨. 
    => 그런데 왜 id의 기본값을 설정해야하는가?
  */  

-- 2-1. 리뷰 페이지 화면 쿼리 (최신순)
select r.user_id, r.rating, r.createdAt, r.content, u.name 
from review as r
left join user as u
on r.user_id = u.id
where r.shop_id = 1
order by r.createdAt desc;

-- 3. 홈화면 쿼리 (현재 선택된 지역에서 도전이 가능한 미션 목록, 페이징 포함)
insert into area (id, name) value (1, '용현동'); 
insert into shop (id, area_id, name, rating) value (2, 1, 'dd', 5);
insert into mission (id, shop_id, missionText, deadline, point) value (1, 2, '디진다돈까스 초 안에 먹기', 20240223, 4);

select m.id, m.missionText, m.deadline, m.point, s.name
from mission as m
inner join shop as s
on m.shop_id = s.id 
where s.area_id = 1
order by m.deadline desc limit 10, 0; 
/*
  10개씩 페이징, skip - 0부터 시작 (n -1 * 10)
*/ 

-- 4. 마이페이지 화면 쿼리
select u.name, u.email, u.phone, u.point 
from user as u
where name = 'nickname012';
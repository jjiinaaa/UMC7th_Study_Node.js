-- 1. 내가 진행중, 진행 완료한 미션 모아서 보는 쿼리 (페이징 포함)
select m.id, s.name, um.status, m.point, m.missionText
from mission as m 
inner join user_mission as um
on m.id = um.mission_id
inner join shop as s
on m.shop_id = s.id
where member_id = 1
and um.status in ('진행 중, 진행 완료') /* in 사용하지 않고 별개의 쿼리문 나누는 것이 확장성이나 사용도가 많음. */ 
and mission.id < 10 /* cursor 값 */
order by m.id desc limit 10, 0;


-- 2. 리뷰 작성하는 쿼리 (사진 배제)
insert into review (id, user_id, shop_id, content, rating createdAt) value (1, 1, 1, '맛 없는데 은근 끌리네요. 5점을 드릴테니, 다음에 서비스 주세요', 5.0, now());
  /**
    id가 bigint 시 auto_increment로 설정되어 있어서, id를 직접 입력하지 않아도 됨. 
    default 값을 반드시 지정하면, 자동 증가되어 입력됨.
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

select m.id, s.name, m.point, m.missionText, datediff(m.deadline, now()) as d_day
from mission as m
inner join shop as s
on m.shop_id = s.id
inner join area as a
on s.area_id = a.id 
where a.name = '용현동'
and m.deadline > now()
and m.id < 10 /* cursor 값 */
and m.id not in (select mission_id from user_mission where user_id = 1) /* 사용자가 이미 수행한 미션 제외 */
order by m.id desc 
limit 10, 0; 
/*
  10개씩 페이징, skip - 0부터 시작 (n -1 * 10)
*/ 
/*
  - DATEDIFF() 구문

  SELECT DATEDIFF('구분자','Start_Date','End_Date')

  DATEDIFF()는 총 3개의 인수가 있는데 Start_Date와 End_Date는 차이를 구할 두개의 날짜값을 넣는곳이고
  '구분자'는 어떤 차이를 구할지 정해주는 부분이다.
  예를 들어 두 날짜 사이의 날짜 차이를 구하고 싶으면 'day' 혹은 'dd'등을 넣어주면 된다.

  - 예제) 2018년의 날짜구하기

  SELECT DATEDIFF(dd,'2018-01-01','2018-12-31') + 1

  결과 : 365
  위와같이 구분값을 dd로 넣어주면 된다.

  ※ 자주하는 실수인데 한 달 일수를 구하는데 31일 - 1일을 하면 30일이 된다.
*/


-- 4. 마이페이지 화면 쿼리
select u.id, u.name, u.email, u.phone, u.point 
from user as u
where u.id = 1;
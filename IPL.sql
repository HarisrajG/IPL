create database IPL_Data;
use IPL_Data;
drop table deliveries;

select* from deliveries;
select*from matches;

#top 5 players with most no.of.man of match
select player_of_match,count(*) as Award_count from matches 
group by player_of_match order by count(*) desc
limit 5;

#matches won

select season, winner,count(*) as match_winner from matches
group by winner ,season;

#avg strick_rate
select avg(strike_rate) as avg_strikerate
from(
select (sum(total_runs)/count(ball))*100 as strike_rate
from deliveries group by batsman) as batsman_stats;

#Q$
select  batting_first,count(*) as matches_won
from (
select case when win_by_runs>0 then team1
else team2
end as batting_first
from matches where winner!='Tie') as batting_first_team
group by batting_first;

select bowling_first , count(*) as matches_won
from ( 
select case when win_by_wickets>0 then team1
else team2
end as bowling_first
from matches where winner!='Tie') as bowling_first_team
group by bowling_first;

#q5
select batsman,(sum(total_runs)/count(ball))*100 as stike_rate from deliveries
group by batsman having sum(total_runs)>=200
order by stike_rate desc limit 1;


#Q6
select batsman , count(* ) from deliveries 
where  player_dismissed is not null and bowler ='SL Malinga' group by batsman;

#Q7 
select batsman, avg(case when batsman_runs = 4 or batsman_runs =6 
then 1 else 0 end ) * 100 as avg_boundries_percent from deliveries group by batsman;

#Q8
select season,batting_team , avg(case when batsman_runs = 4 or batsman_runs =6 
then 1 else 0 end ) * 100 as avg_boundries_percent from deliveries inner join matches on deliveries.match_id = matches.id
 group by batting_team,season;
 
 #Q9
select match_id,bowling_team , sum(extra_runs) as extras
from deliveries group by bowling_team,match_id ;

#Q10
select match_id , bowler, count(*)as wickets_taken from deliveries 
where player_dismissed is not null 
group by match_id , bowler 
order by wickets_taken desc
limit 1; 

#Q12 
select m.city , case when m.team1=m.winner then m.team1  
when m.team2 = m.winner then m.team2 else 'Draw' end as winning_team,
count(*) as wins 
from matches as m
join deliveries as d on d.match_id = m.id 
group by m.city , winning_team;


#Q13
select season , toss_winner , count(*) as no_of_times_toss_won from matches
group by season , toss_winner;

#Q14
select player_of_match, count(*) from matches
group by player_of_match
order by count(*)desc;

#Q16
select batting_team,max(sum(total_runs)) as higest_total from deliveries
order by higest_total;




 
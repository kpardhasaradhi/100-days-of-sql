
select t as team_name,
       count(1) as matches_played,
       sum(no_of_wins) as no_of_matches_won,
       count(1) - sum(no_of_wins) as no_of_matches_lost
from (
    select team_1 as t,
           case when Winner = team_1 then 1 else 0 end as no_of_wins
    from icc_world_cup
    union all
    select team_2 as t,
           case when Winner = team_2 then 1 else 0 end as no_of_wins
    from icc_world_cup
) t
group by team_name
order by no_of_matches_won desc;

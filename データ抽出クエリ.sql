-- 作成したテーブルから、以下のデータを抽出するクエリを作成します。

/* 1. よく見られているエピソードを知りたいです。
エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください。 */
SELECT e.episode_title, ep.view_count
  FROM episodes AS e
  JOIN episode_programs AS ep 
    ON e.episode_id = ep.episode_id
 GROUP BY e.episode_id, ep.view_count
 ORDER BY ep.view_count DESC
 LIMIT 3;


/* 2.よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。
エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください。 */
SELECT p.program_title,
       s.season_no,
       e.episode_no,
       e.episode_title,
       ep.view_count
  FROM programs AS p
  JOIN episode_programs AS ep 
    ON p.program_id = ep.program_id
  JOIN episodes AS e 
    ON ep.episode_id = e.episode_id
  LEFT JOIN seasons AS s 
    ON e.season_id = s.season_id
 GROUP BY p.program_id, e.episode_id, ep.view_count
 ORDER BY view_count DESC
 LIMIT 3;


/* 3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。
本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。
なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします。 */
SELECT c.channel_name,
       p.from_time,
       p.to_time,
       s.season_no,
       e.episode_no,
       e.episode_title,
       e.episode_detail
  FROM programs AS p
  JOIN channels AS c 
    ON p.channel_id = c.channel_id
  JOIN episode_programs AS ep 
    ON p.program_id = ep.program_id
  JOIN episodes AS e 
    ON ep.episode_id = e.episode_id
  LEFT JOIN seasons AS s 
    ON e.season_id = s.season_id
 WHERE e.release_date = '2023-01-07';


/* 4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。
ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください。 */
SELECT p.from_time,
       p.to_time,
       s.season_no,
       e.episode_no,
       e.episode_title,
       e.episode_detail
  FROM programs AS p
  JOIN channels AS c 
    ON p.channel_id = c.channel_id
  JOIN episode_programs AS ep 
    ON p.program_id = ep.program_id
  JOIN episodes AS e 
    ON ep.episode_id = e.episode_id
  LEFT JOIN seasons AS s 
    ON e.season_id = s.season_id
 WHERE p.channel_id = 5
   AND e.release_date BETWEEN '2023-01-07' AND '2023-01-14';


/* 5. （advanced）直近一週間で最も見られた番組が知りたいです。
直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください。 */
SELECT p.program_title,
       SUM(ep.view_count) AS total_view_count
  FROM programs AS p
  JOIN episode_programs AS ep 
    ON p.program_id = ep.program_id
  JOIN episodes AS e 
    ON ep.episode_id = e.episode_id
 WHERE e.release_date BETWEEN '2022-12-31' AND '2023-01-07'
 GROUP BY p.program_id
 ORDER BY total_view_count DESC
 LIMIT 2;


/* 6. （advanced）ジャンルごとの番組の視聴数ランキングを知りたいです。
番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。
ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。 */
  
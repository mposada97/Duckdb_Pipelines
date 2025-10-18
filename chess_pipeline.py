import dlt
from chess import source

pipeline = dlt.pipeline(
pipeline_name="chess_pipeline",
destination="duckdb",
dataset_name="main"
)

data = source(
    players=[
        "magnuscarlsen", "vincentkeymer",
        "dommarajugukesh", "rpragchess",
        "mposada97", "atchu1609","gothamchess"
    ],
    start_month="2025/09",
    end_month="2025/09",
)


info = pipeline.run((data.with_resources("players_profiles", "players_games"))
print(info)
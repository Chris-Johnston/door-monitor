import sqlite3

def get_db():
    # TODO: use a proper database to fix concurrency
    return sqlite3.connect('/app/data/database.db', check_same_thread=False, detect_types=sqlite3.PARSE_DECLTYPES, timeout=5000)

def init_db():
    with get_db() as DB:
        cur = DB.cursor()
        # log of sensor state readings
        cur.execute(
            """
            CREATE TABLE IF NOT EXISTS log
            (id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            state BOOLEAN,
            cause TEXT,
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
            """
        )
        # table containing webhook settings
        cur.execute(
            """
            CREATE TABLE IF NOT EXISTS webhooks
            (id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            endpointUrl TEXT,
            authorizationHeader TEXT,
            enabled BOOLEAN,
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
            """
        )
        DB.commit()

init_db()

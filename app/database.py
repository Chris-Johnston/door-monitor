import sqlite3
DB = sqlite3.connect('/app/data/database.db', check_same_thread=False, detect_types=sqlite3.PARSE_DECLTYPES)

def init_db():
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

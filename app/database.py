import sqlite3
# TODO set this up for docker
DB = sqlite3.connect('history.db', check_same_thread=False)

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
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)
        """
    )
    DB.commit()

init_db()

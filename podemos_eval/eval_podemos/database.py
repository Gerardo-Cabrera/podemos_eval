import sqlalchemy as db


class Database:
    #engine = db.create_engine('postgresql://eval:password@localhost/podemos_eval')

    def __init__(self):
        #self.connection = self.engine.connect()
        #self.connection = db.create_engine('postgresql://eval:password@localhost/podemos_eval').connect()
        #self.prueba = self.connection.execute('SELECT * FROM podemos_eval."Clientes";')
        #print(self.prueba.objects.all())
        pass

    def connection(self):
        engine = db.create_engine('postgresql://eval:password@localhost/podemos_eval')
        return engine.connect()

    def fetchByQuery(self, table):
        print("Tabla: " + table)
        connection = Database.connection("")
        #fetch_query = self.connection.execute(f'SELECT * FROM podemos_eval."{table}"')
        fetch_query = connection.execute(f'SELECT * FROM podemos_eval."{table}"')
        print(fetch_query)
        #for data in fetch_query.fetchall():
        #    print(data)
        return fetch_query.fetchall()

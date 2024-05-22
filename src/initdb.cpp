#include "initdb.h"
#include <QDir>

InitDb::InitDb(QObject* parent) : QObject(parent)
{
    QString dbName = "immo.db";
    QString dbPath = QDir::currentPath() + "/" + dbName;
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    QSqlQuery query;

    db.setDatabaseName(dbPath);

    if (!db.open()) {
        qDebug() << "Error: Couldn't open database";
        return;
    }
    else {
        qDebug() << "Database Found:" << db.databaseName();
    }

    query.prepare(SQL_AGENTS_TABLE);
    if (!query.exec()) {
        qDebug() << "Error creating agents table:" << query.lastError().text();
        return;
    }

    query.prepare(SQL_NODES_TABLE);
    if (!query.exec()) {
        qDebug() << "Error creating nodes table:" << query.lastError().text();
        return;
    }
}

void InitDb::initDb()
{
    QSqlQuery query;

    query.prepare(SQL_INSERT_AGENT);

    query.bindValue(":host", "localhost");
    query.bindValue(":label", "Agent 1");
    query.bindValue(":tag", "tag1");
    query.bindValue(":grpc_port", 50051);
    query.bindValue(":grpc_username", "user1");
    query.bindValue(":grpc_password", "pass1");

    if (!query.exec())
    {
        qDebug() << "Error inserting agents:" << query.lastError().text();
    }
    int agentId = query.lastInsertId().toInt();
    qDebug() << "Agent ID:" << agentId;

    query.prepare(SQL_INSERT_NODE);

    query.bindValue(":name", "table");
    query.bindValue(":agentID", agentId);
    query.bindValue(":clientID", "14633310");
    query.bindValue(":is_online", 1);

    if (!query.exec())
    {
        qDebug() << "Error inserting nodes:" << query.lastError().text();
    }

}

const char* InitDb::SQL_AGENTS_TABLE = "CREATE TABLE IF NOT EXISTS agents (id INTEGER PRIMARY KEY AUTOINCREMENT, "
"host TEXT, label TEXT, tag TEXT, grpc_port INTEGER, grpc_username TEXT, grpc_password TEXT)";

const char* InitDb::SQL_INSERT_AGENT = "INSERT INTO agents (host, label, tag, grpc_port, grpc_username, grpc_password) "
"VALUES (:host, :label, :tag, :grpc_port, :grpc_username, :grpc_password)";

const char* InitDb::SQL_NODES_TABLE = "CREATE TABLE IF NOT EXISTS nodes (id INTEGER PRIMARY KEY AUTOINCREMENT, "
"name TEXT, agentID INTEGER, clientID TEXT UNIQUE, is_online INTEGER)";

const char* InitDb::SQL_INSERT_NODE = "INSERT INTO nodes (name, agentID, clientID, is_online) "
"VALUES (:name, :agentID, :clientID, :is_online)";